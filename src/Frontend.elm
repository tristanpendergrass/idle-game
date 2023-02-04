module Frontend exposing (app)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game, MasteryUnlocks)
import IdleGame.Notification as Notification exposing (Notification)
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Bag
import IdleGame.Views.Chores
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.MasteryCheckpoints
import IdleGame.Views.MasteryUnlocks
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import IdleGame.ZIndexes exposing (zIndexes)
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
      , activeTab = Tab.Bag
      , isVisible = True
      , activeModal = Nothing
      , saveGameTimer = Timer.create 1000
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


setIsVisible : Bool -> FrontendModel -> FrontendModel
setIsVisible isVisible model =
    { model | isVisible = isVisible }


setActiveModal : Maybe Modal -> FrontendModel -> FrontendModel
setActiveModal activeModal model =
    { model | activeModal = activeModal }


createTimePassesModal : Snapshot Game -> Snapshot Game -> Maybe Modal
createTimePassesModal oldSnap newSnap =
    let
        oldGame =
            Snapshot.getValue oldSnap

        newGame =
            Snapshot.getValue newSnap

        timePassed =
            Snapshot.getTimeDifference oldSnap newSnap
    in
    IdleGame.Game.getTimePassesData oldGame newGame
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


setSaveGameTimer : Timer -> FrontendModel -> FrontendModel
setSaveGameTimer timer model =
    { model | saveGameTimer = timer }


tickDuration : Int
tickDuration =
    15


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

        HandleFastForward now ->
            case model.gameState of
                FastForward { original, current } ->
                    let
                        tick =
                            Snapshot.createTick tickDuration (IdleGame.Game.tick >> Tuple.first)

                        nextInterval =
                            Time.Extra.add Time.Extra.Minute 10 Time.utc (Snapshot.getTime current)
                    in
                    -- We want to only part of the work then suspend for a short period so the app doesn't freeze up
                    -- The amount of work to do is arbitrarily set at 10 minutes and the sleep period at 1 ms, which seems to work
                    -- Can play with these numbers in future if not satisfactory
                    -- Test with CPU slowdown 6x!! It really shows the weakness and why we might want an adaptive strategy in the future!
                    if Time.posixToMillis nextInterval < Time.posixToMillis now then
                        -- run calculation part ways then sleep
                        let
                            newSnap =
                                Snapshot.tickUntil tick nextInterval current
                        in
                        ( model
                            |> setGameState
                                (FastForward { original = original, current = newSnap })
                        , Task.perform HandleFastForward (Process.sleep 1 |> Task.andThen (\_ -> Time.now))
                        )

                    else
                        -- run calculation to completion
                        let
                            newSnap =
                                Snapshot.tickUntil tick now current
                        in
                        ( model
                            |> setGameState
                                (Playing newSnap)
                            |> setActiveModal (createTimePassesModal original newSnap)
                        , Cmd.none
                        )

                _ ->
                    -- Shouldn't normally happen
                    noOp

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

        HandleAnimationFrameDelta delta ->
            case model.gameState of
                Playing snapshot ->
                    let
                        ( newTimer, saveGameTimerTriggered ) =
                            -- Note the rounding from (floor delta). Our save game timer will not happen exactly as often as it's supposed to and that's alright I guess...
                            Timer.increment (floor delta) model.saveGameTimer

                        shouldSaveGame =
                            saveGameTimerTriggered > 0

                        saveGameCmd =
                            if shouldSaveGame then
                                [ Lamdera.sendToBackend (Save snapshot) ]

                            else
                                []
                    in
                    ( model
                        |> setSaveGameTimer newTimer
                    , Cmd.batch <| saveGameCmd
                    )

                _ ->
                    noOp

        HandleAnimationFrame now ->
            case model.gameState of
                Initializing ->
                    -- Backend has not yet sent an initialization message so no work to do.
                    noOp

                FastForward _ ->
                    -- During FastForward there's a recursive set of Cmds updating the snapshot, no work needs to be done in animationFrame explicitly
                    noOp

                Playing snapshot ->
                    if not model.isVisible then
                        -- If the app is not visible we shouldn't do any work
                        noOp

                    else
                        let
                            tick =
                                Snapshot.createTick tickDuration
                                    (\( g, n ) ->
                                        let
                                            ( ng, nn ) =
                                                IdleGame.Game.tick g
                                        in
                                        ( ng, n ++ nn )
                                    )

                            oldSnapshot : Snapshot ( Game, List Notification )
                            oldSnapshot =
                                snapshot
                                    |> Snapshot.map (\g -> ( g, [] ))

                            updatedSnapshot : Snapshot ( Game, List Notification )
                            updatedSnapshot =
                                oldSnapshot
                                    |> Snapshot.tickUntil tick now

                            ( _, notifications ) =
                                Snapshot.getValue updatedSnapshot

                            newGameState =
                                updatedSnapshot
                                    |> Snapshot.map Tuple.first

                            notificationCmds =
                                List.map (Notification.toToast >> AddToast >> delay 0) notifications
                        in
                        ( { model
                            | gameState = Playing newGameState
                          }
                        , Cmd.batch <| notificationCmds
                        )

        HandleVisibilityChange visibility ->
            if visibility == Browser.Events.Visible then
                case model.gameState of
                    Initializing ->
                        ( model
                            |> setIsVisible True
                        , Cmd.none
                        )

                    FastForward _ ->
                        ( model
                            |> setIsVisible True
                        , Cmd.none
                        )

                    Playing snapshot ->
                        ( model
                            |> setIsVisible True
                            |> setGameState (FastForward { original = snapshot, current = snapshot })
                        , Task.perform HandleFastForward Time.now
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

        HandleShopItemClick item ->
            ( model
                |> mapGame
                    (\game ->
                        let
                            price =
                                ShopItems.getPrice item

                            canAfford =
                                price <= game.gold

                            dontOwnItemYet =
                                not (ShopItems.hasItem item game.shopItems)
                        in
                        if canAfford && dontOwnItemYet then
                            { game | gold = game.gold - price, shopItems = ShopItems.addItem item game.shopItems }

                        else
                            game
                    )
            , Cmd.none
            )


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        InitializeGame serverSnapshot ->
            case model.gameState of
                Initializing ->
                    ( model
                        |> setGameState (FastForward { original = serverSnapshot, current = serverSnapshot })
                    , Task.perform HandleFastForward Time.now
                    )

                _ ->
                    -- If we receive an InitializeGame message from backend while already initialized we ignore it
                    noOp


subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onAnimationFrameDelta HandleAnimationFrameDelta
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
        |> Toast.withTrayAttributes [ class "toast-tray", zIndexes.toast ]
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
        case model.gameState of
            Initializing ->
                css

            FastForward _ ->
                css
                    ++ [ div
                            [ class "w-screen h-screen flex flex-col gap-2 items-center justify-center"
                            ]
                            [ div [] [ text "Fast Forwarding..." ]
                            , progress [ class "progress progress-primary w-56" ] []
                            ]
                       ]

            Playing snapshot ->
                let
                    game =
                        Snapshot.getValue snapshot

                    bottomRightMenu =
                        case model.activeTab of
                            Tab.Bag ->
                                Just IdleGame.Views.Bag.renderBottomRight

                            Tab.Chores ->
                                Just IdleGame.Views.Chores.renderBottomRight

                            _ ->
                                Nothing
                in
                css
                    ++ (case bottomRightMenu of
                            Just content ->
                                [ content ]

                            Nothing ->
                                []
                       )
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
