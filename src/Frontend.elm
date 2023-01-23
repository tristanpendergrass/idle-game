module Frontend exposing (app)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game, MasteryUnlocks)
import IdleGame.Notification as Notification exposing (Notification)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Timer
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.MasteryCheckpoints
import IdleGame.Views.MasteryUnlocks
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import Json.Decode.Pipeline exposing (..)
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
      , gameState = Initializing
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


setIsVisible : Bool -> FrontendModel -> FrontendModel
setIsVisible isVisible model =
    { model | isVisible = isVisible }


setActiveModal : Maybe Modal -> FrontendModel -> FrontendModel
setActiveModal activeModal model =
    { model | activeModal = activeModal }


createTimePassesModal : Snapshot Game -> Maybe Modal
createTimePassesModal snapshot =
    let
        { currentTime, lastTick, game } =
            snapshot

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


setGameState : FrontendGameState -> FrontendModel -> FrontendModel
setGameState gameState model =
    { model | gameState = gameState }


mapGame : (Game -> Game) -> FrontendModel -> FrontendModel
mapGame fn model =
    case model.gameState of
        Playing snapshot ->
            snapshot
                |> Snapshot.map fn
                |> (\newSnapshot -> { model | gameState = Playing newSnapshot })

        _ ->
            model


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
                -- NOTE: Number passed to withExistTransition should match the transition duration of class "toast" in index.css
                |> Toast.withExitTransition 700
                |> Toast.add model.tray
                |> Toast.tuple ToastMsg model

        ToastMsg tmsg ->
            let
                ( tray, newTmesg ) =
                    Toast.update tmsg model.tray
            in
            ( { model | tray = tray }, Cmd.map ToastMsg newTmesg )

        HandleInitialize serverSnapshot ->
            -- TODO: remove second param from this type, it's not needed after refactor
            case model.gameState of
                Initializing ->
                    ( model
                        |> setGameState (FastForward { original = serverSnapshot, current = serverSnapshot })
                    , Task.perform HandleFastForward Time.now
                    )

                _ ->
                    -- If we receive an InitializeGame message from backend while already initialized we ignore it
                    noOp

        HandleFastForward now ->
            --
            Debug.todo ""

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
                Initializing ->
                    -- Backend has not yet sent an initialization message so no work to do.
                    noOp

                FastForward { original, current } ->
                    -- During FastForward there's a recursive set of Cmds updating the snapshot, no work needs to be done in animationFrame explicitly
                    noOp

                Playing snapshot ->
                    if not model.isVisible then
                        -- If the app is not visible we shouldn't do any work
                        noOp

                    else
                        let
                            ( newTick, newGame, notifications ) =
                                updateGameToTime now ( snapshot.lastTick, snapshot.game, [] )

                            newGameState =
                                { snapshot | currentTime = now, lastTick = newTick, game = newGame }

                            delta =
                                Time.posixToMillis now - Time.posixToMillis (Snapshot.getTime newGameState)

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

                            newSnapshot =
                                Debug.todo ""
                        in
                        ( { model
                            | gameState = Playing newSnapshot
                            , saveGameTimer = newSaveGameTimer
                          }
                        , Cmd.batch <| saveGameCmd ++ notificationCmds
                        )

        -- HandleVisibilityChangeWithTime visibility now ->
        HandleVisibilityChange visibility ->
            case model.maybeGame of
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

        HandleInitialize snapshot ->
            ( model, Task.perform (HandleInitialize snapshot) Time.now )


subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onVisibilityChange HandleVisibilityChange
        ]


viewToast : List (Html.Attribute FrontendMsg) -> Toast.Info String -> Html FrontendMsg
viewToast attributes toast =
    Html.div
        attributes
        [ Html.text toast.content ]


toastConfig : Toast.Config FrontendMsg
toastConfig =
    Toast.config ToastMsg
        -- attributes applied to the toast tray
        |> Toast.withTrayAttributes [ class "toast-tray" ]
        -- attributes applied to the toasts
        |> Toast.withAttributes [ class "toast" ]
        |> Toast.withTransitionAttributes [ class "toast--fade-out" ]


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
        case model.maybeGame of
            Nothing ->
                css

            Just snapshot ->
                let
                    game =
                        Snapshot.getValue snapshot
                in
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
