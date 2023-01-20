module Frontend exposing (app)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game, MasteryUnlocks)
import IdleGame.Notification as Notification exposing (Notification)
import IdleGame.Tabs as Tabs
import IdleGame.Timer
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.MasteryCheckpoints
import IdleGame.Views.MasteryUnlocks
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import Json.Decode as D
import Json.Decode.Pipeline exposing (..)
import Json.Encode as E
import Lamdera
import Process
import Task
import Time exposing (Posix)
import Time.Extra
import Toast
import Types exposing (..)
import Url exposing (Url)


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = view
        }


delay : Int -> msg -> Cmd msg
delay ms msg =
    Task.perform (always msg) (Process.sleep <| toFloat ms)


init : Url -> Nav.Key -> ( FrontendModel, Cmd FrontendMsg )
init url key =
    ( { key = key
      , tray = Toast.tray
      , isDrawerOpen = False
      , activeTab = ChoresTab
      , isVisible = True
      , activeModal = Nothing

      --   , activeModal = Just ChoreMasteryCheckpointsModal
      , saveGameTimer = IdleGame.Timer.create 1000
      , gameState = Nothing
      }
    , Cmd.none
      -- , Cmd.batch
      --     [ delay 0 (AddToast "hello, world")
      --     , delay 1000 (AddToast "hello, world 2")
      --     , delay 2000 (AddToast "hello, world 3")
      --     ]
    )



-- Update


updateGameToTime : Posix -> ( Posix, Game, List Notification ) -> ( Posix, Game, List Notification )
updateGameToTime nowPos ( oldTick, game, notifications ) =
    let
        tickDuration =
            IdleGame.Timer.tickDuration

        nextTickPos =
            Time.Extra.add Time.Extra.Millisecond tickDuration Time.utc oldTick

        nextTick =
            nextTickPos
                |> Time.posixToMillis

        now =
            Time.posixToMillis nowPos

        shouldTick =
            now >= nextTick

        isLastTick =
            -- The tickDuration * 2 is deliberate here. The tickDuration is about == an animation frame so without the (* 2) you will see it occassionally skip a notification when the frame and tick don't line up right
            nextTick + (tickDuration * 2) > now
    in
    if shouldTick then
        -- Note: be careful with the next line causing a stack overflow. It is written in a particular way to allow Tail-call elimination and should stay that way.
        -- Additional reading: https://jfmengels.net/tail-call-optimization/
        let
            ( newGame, tickNotifications ) =
                IdleGame.Game.tick game

            newNotifications =
                -- We don't want to show a mountain of notifications when calculating many ticks back to back
                if isLastTick then
                    notifications ++ tickNotifications

                else
                    notifications
        in
        updateGameToTime nowPos ( nextTickPos, newGame, newNotifications )

    else
        ( oldTick, game, notifications )


setCurrentTime : Posix -> GameState -> GameState
setCurrentTime now gameState =
    { gameState | currentTime = now }


setGameState : Maybe GameState -> FrontendModel -> FrontendModel
setGameState newGameState model =
    { model | gameState = newGameState }


mapGame : (Game -> Game) -> FrontendModel -> FrontendModel
mapGame fn model =
    { model | gameState = Maybe.map (\gameState -> { gameState | game = fn gameState.game }) model.gameState }


setIsVisible : Bool -> FrontendModel -> FrontendModel
setIsVisible isVisible model =
    { model | isVisible = isVisible }


setActiveModal : Maybe Modal -> FrontendModel -> FrontendModel
setActiveModal activeModal model =
    { model | activeModal = activeModal }


createTimePassesModal : GameState -> Maybe Modal
createTimePassesModal gameState =
    let
        { currentTime, lastTick, game } =
            gameState

        ( newTick, newGame, _ ) =
            updateGameToTime currentTime ( lastTick, game, [] )

        timePassed =
            Time.posixToMillis newTick
                - Time.posixToMillis lastTick
                |> Time.millisToPosix
    in
    IdleGame.Game.getTimePassesData game newGame
        |> Maybe.map (TimePassesModal timePassed)


setActiveTab : Tab -> FrontendModel -> FrontendModel
setActiveTab tab model =
    { model | activeTab = tab }


setIsDrawerOpen : Bool -> FrontendModel -> FrontendModel
setIsDrawerOpen isOpen model =
    { model | isDrawerOpen = isOpen }


update : FrontendMsg -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOp ->
            noOp

        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            noOp

        AddToast content ->
            Toast.expireIn 3000 content
                -- Toast.persistent content
                -- Number passed to withExistTransition should match the transition duration of class "toast" in index.css
                |> Toast.withExitTransition 700
                |> Toast.add model.tray
                |> Toast.tuple ToastMsg model

        ToastMsg tmsg ->
            let
                ( tray, newTmesg ) =
                    Toast.update tmsg model.tray
            in
            ( { model | tray = tray }, Cmd.map ToastMsg newTmesg )

        InitializeGameWithTime serverGameState now ->
            let
                newGameState =
                    model.gameState
                        -- Note: only setting the gameState in case its local value is Nothing because we only want this to be for initialization
                        |> Maybe.withDefault (setCurrentTime now serverGameState)
            in
            ( model
                |> setGameState (Just newGameState)
            , Cmd.none
            )

        ToggleActiveChore toggleId ->
            ( model
                |> mapGame (IdleGame.Game.toggleActiveChore toggleId)
            , Cmd.none
            )

        SetDrawerOpen newValue ->
            ( model
                |> setIsDrawerOpen newValue
            , Cmd.none
            )

        HandleAnimationFrame now ->
            case model.gameState of
                Nothing ->
                    noOp

                Just gameState ->
                    if model.isVisible then
                        let
                            ( newTick, newGame, notifications ) =
                                updateGameToTime now ( gameState.lastTick, gameState.game, [] )

                            newGameState =
                                { gameState | currentTime = now, lastTick = newTick, game = newGame }

                            delta =
                                Time.posixToMillis now - Time.posixToMillis gameState.currentTime

                            ( newSaveGameTimer, saveGameTimerTriggered ) =
                                IdleGame.Timer.increment delta model.saveGameTimer

                            shouldSaveGame =
                                saveGameTimerTriggered > 0

                            saveGameCmd =
                                if shouldSaveGame then
                                    [ Lamdera.sendToBackend (Save newGameState) ]

                                else
                                    []

                            notificationCmds =
                                if model.isVisible then
                                    List.map (Notification.toToast >> AddToast >> delay 0) notifications

                                else
                                    []
                        in
                        ( { model
                            | gameState = Just newGameState
                            , saveGameTimer = newSaveGameTimer
                          }
                        , Cmd.batch <| saveGameCmd ++ notificationCmds
                        )

                    else
                        ( { model | gameState = Just { gameState | currentTime = now } }, Cmd.none )

        HandleVisibilityChange visibility ->
            case model.gameState of
                Nothing ->
                    noOp

                Just gameState ->
                    if visibility == Browser.Events.Visible then
                        let
                            newActiveModal =
                                case createTimePassesModal gameState of
                                    Just timePassesModal ->
                                        Just timePassesModal

                                    Nothing ->
                                        model.activeModal
                        in
                        ( model
                            |> setActiveModal newActiveModal
                            |> setIsVisible True
                        , Cmd.none
                        )

                    else
                        ( model
                            |> setIsVisible False
                        , Cmd.none
                        )

        CloseModal ->
            ( model
                |> setActiveModal Nothing
            , Cmd.none
            )

        OpenMasteryCheckpointsModal ->
            ( model
                |> setActiveModal (Just ChoreMasteryCheckpointsModal)
            , Cmd.none
            )

        OpenMasteryUnlocksModal ->
            ( model
                |> setActiveModal (Just ChoreItemUnlocksModal)
            , Cmd.none
            )

        SetActiveTab tab ->
            ( model
                |> setActiveTab tab
                |> setIsDrawerOpen False
            , Cmd.none
            )


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        InitializeGame gameState ->
            ( model, Task.perform (InitializeGameWithTime gameState) Time.now )


subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onVisibilityChange HandleVisibilityChange
        ]


view : FrontendModel -> Document FrontendMsg
view model =
    let
        css =
            -- There's an experimental technique to include styles in header instead of body https://dashboard.lamdera.app/docs/html-head
            -- We're not using it for now because it's experimental but might be useful if we want to eliminate the flicker from the css loading in
            [ node "link" [ rel "stylesheet", href "/output.css" ] []
            ]
    in
    { title = "Idle Game"
    , body =
        case model.gameState of
            Nothing ->
                css

            Just { game } ->
                css
                    ++ [ Toast.render viewToast model.tray toastConfig ]
                    ++ [ div [ class "bg-base-100 drawer drawer-mobile" ]
                            [ input
                                [ id "drawer"
                                , type_ "checkbox"
                                , class "drawer-toggle"
                                , checked model.isDrawerOpen
                                , onCheck SetDrawerOpen
                                ]
                                []
                            , IdleGame.Views.Content.renderContent game model.activeTab
                            , IdleGame.Views.Drawer.renderDrawer game model.activeTab
                            ]
                       ]
                    ++ (case model.activeModal of
                            Nothing ->
                                []

                            Just (TimePassesModal timePassed timePassesData) ->
                                let
                                    children =
                                        IdleGame.Views.TimePasses.render timePassed timePassesData
                                in
                                [ IdleGame.Views.ModalWrapper.create children
                                    |> IdleGame.Views.ModalWrapper.withBorderColor "border-primary"
                                    |> IdleGame.Views.ModalWrapper.render
                                ]

                            Just ChoreMasteryCheckpointsModal ->
                                let
                                    children =
                                        IdleGame.Views.MasteryCheckpoints.render { mxp = game.choresMxp, checkpoints = IdleGame.Game.choreMasteryPoolCheckpoints }
                                in
                                [ IdleGame.Views.ModalWrapper.create children
                                    |> IdleGame.Views.ModalWrapper.withBorderColor "border-secondary"
                                    |> IdleGame.Views.ModalWrapper.render
                                ]

                            Just ChoreItemUnlocksModal ->
                                let
                                    children =
                                        IdleGame.Views.MasteryUnlocks.render { masteryUnlocks = IdleGame.Game.choreMasteryUnlocks }
                                in
                                [ IdleGame.Views.ModalWrapper.create children
                                    |> IdleGame.Views.ModalWrapper.withBorderColor "border-secondary"
                                    |> IdleGame.Views.ModalWrapper.render
                                ]
                       )
    }


viewToast : List (Html.Attribute FrontendMsg) -> Toast.Info String -> Html FrontendMsg
viewToast attributes toast =
    Html.div
        attributes
        [ Html.text toast.content ]


toastConfig : Toast.Config FrontendMsg
toastConfig =
    Toast.config ToastMsg
        |> Toast.withTrayAttributes [ style.tray ]
        |> Toast.withAttributes [ style.toast.base ]
        |> Toast.withTransitionAttributes [ style.toast.fadeOut ]
        |> Toast.withFocusAttributes [ style.toast.active ]


style =
    { tray = class "toast-tray"
    , toast =
        { base = class "toast"
        , fadeOut = class "toast--fade-out"
        , spaced = class "toast--spaced"
        , active = class "toast--active"
        , closeButton = class "toast__close"
        }
    }
