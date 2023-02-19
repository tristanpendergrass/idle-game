module Frontend exposing (app)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation as Nav
import DebugConfig
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Bag
import IdleGame.Views.Chores
import IdleGame.Views.Content
import IdleGame.Views.DebugPanel
import IdleGame.Views.Drawer
import IdleGame.Views.FastForward
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.MasteryCheckpoints
import IdleGame.Views.MasteryUnlocks
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import IdleGame.Views.Utils
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
      , activeTab = Tab.Chores
      , isVisible = True
      , activeModal = Nothing
      , saveGameTimer = Timer.create
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


sleepTime : Float
sleepTime =
    1


fastForwardTime : Int
fastForwardTime =
    1000 * 60 * 10


getFastForwardPoint : Posix -> Posix
getFastForwardPoint =
    Time.Extra.add Time.Extra.Millisecond fastForwardTime Time.utc


{-| A standard tick for using to progress the game in an animation frame.
-}
standardTick : Snapshot.Tick ( Game, List Toast )
standardTick =
    Snapshot.createTick 15
        (\duration ( oldGame, oldToasts ) ->
            let
                ( newGame, newToasts ) =
                    IdleGame.Game.tick duration oldGame
            in
            ( newGame, oldToasts ++ newToasts )
        )


{-| A performant tick for using when you need to progress the game quickly and don't care about animation at all.

The tradeoffs are:
a) with a larger interval between ticks there's a higher chance that e.g. a timer completes twice in one tick. This potentially causes inaccuracy when
calculating bonuses the player earned after actions completing

b) animations won't look right if the tick duration is longer than an animation frame in the browser whic this one is

This tick also discards the notifications of Game.tick.

-}
performantTick : Snapshot.Tick Game
performantTick =
    Snapshot.createTick 2000
        (\duration oldGame -> IdleGame.Game.tick duration oldGame |> Tuple.first)


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
                -- Toast.persistent content -- this can be used for testing toast styles to make the toast not disappear
                -- NOTE: Number passed to withExitTransition should match the transition duration of class "toast" in index.css
                |> Toast.withExitTransition 900
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
                FastForward { original, current, previousIntervalTimer } ->
                    let
                        nextInterval =
                            getFastForwardPoint (Snapshot.getTime current)
                    in
                    if Time.posixToMillis nextInterval < Time.posixToMillis now then
                        -- We want to only part of the work then suspend for a short period so the app doesn't freeze up
                        let
                            newSnap =
                                Snapshot.tickUntil performantTick nextInterval current

                            newPreviousIntervalTimer =
                                case previousIntervalTimer of
                                    NotStarted ->
                                        HaveStart now

                                    HaveStart start ->
                                        HaveStartAndEnd start now

                                    HaveStartAndEnd _ end ->
                                        HaveStartAndEnd end now
                        in
                        ( model
                            |> setGameState
                                (FastForward { original = original, current = newSnap, previousIntervalTimer = newPreviousIntervalTimer })
                        , Task.perform HandleFastForward (Process.sleep sleepTime |> Task.andThen (\_ -> Time.now))
                        )

                    else
                        -- run calculation to completion
                        let
                            newSnap =
                                Snapshot.tickUntil performantTick now current
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
                            Timer.increment delta 1000 model.saveGameTimer

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
                                standardTick

                            oldSnapshot : Snapshot ( Game, List Toast )
                            oldSnapshot =
                                snapshot
                                    |> Snapshot.map (\g -> ( g, [] ))

                            updatedSnapshot : Snapshot ( Game, List Toast )
                            updatedSnapshot =
                                oldSnapshot
                                    |> Snapshot.tickUntil tick now

                            ( _, toasts ) =
                                Snapshot.getValue updatedSnapshot

                            newGameState =
                                updatedSnapshot
                                    |> Snapshot.map Tuple.first

                            notificationCmds =
                                List.map (AddToast >> delay 0) toasts
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
                            |> setGameState (FastForward { original = snapshot, current = snapshot, previousIntervalTimer = NotStarted })
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

        HandleShopItemClick kind ->
            ( model
                |> mapGame
                    (\game ->
                        let
                            stats =
                                ShopItems.getStats kind

                            canAfford : Bool
                            canAfford =
                                Counter.getVal stats.price <= Counter.getVal game.coin

                            dontOwnItemYet =
                                not <| ShopItems.isOwned kind game.shopItems
                        in
                        if canAfford && dontOwnItemYet then
                            { game
                                | coin = Counter.subtract game.coin stats.price
                                , shopItems = ShopItems.addItem kind game.shopItems
                            }

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
                    let
                        someTimeAgo : Posix
                        someTimeAgo =
                            -- DEBUG code to force fast forward to take a long time
                            Time.Extra.add Time.Extra.Millisecond (-1 * DebugConfig.flags.extraFastForwardTime) Time.utc (Snapshot.getTime serverSnapshot)

                        someTimeAgoSnapshot =
                            Snapshot.setTime someTimeAgo serverSnapshot
                    in
                    ( model
                        |> setGameState (FastForward { original = someTimeAgoSnapshot, current = someTimeAgoSnapshot, previousIntervalTimer = NotStarted })
                    , Task.perform HandleFastForward Time.now
                    )

                -- Initializing ->
                --     ( model
                --         |> setGameState (FastForward { original = serverSnapshot, current = serverSnapshot })
                --     , Task.perform HandleFastForward Time.now
                --     )
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


viewToast : List (Html.Attribute FrontendMsg) -> Toast.Info Toast -> Html FrontendMsg
viewToast attributes toast =
    Html.div
        attributes
        [ toastToHtml toast.content ]


toastConfig : Toast.Config FrontendMsg
toastConfig =
    Toast.config ToastMsg
        -- attributes applied to the toast tray
        |> Toast.withTrayAttributes [ class "toast-tray", IdleGame.Views.Utils.zIndexes.toast ]
        -- attributes applied to the toasts
        |> Toast.withAttributes [ class "toast" ]
        |> Toast.withExitAttributes [ class "toast--fade-out" ]


toastToHtml : Toast -> Html msg
toastToHtml notification =
    case notification of
        GainedCoin amount ->
            div [ class "flex gap-1 items-center" ]
                [ span [] [ text <| "+" ++ Counter.toString amount ]
                , Icon.coin
                    |> Icon.toHtml
                ]

        GainedResource amount resource ->
            let
                stats =
                    Resource.getStats resource
            in
            div [ class "flex gap-1 items-center" ]
                [ span [] [ text <| "+" ++ IdleGame.Views.Utils.intToString amount ]
                , stats.icon
                    |> Icon.toHtml
                ]


view : FrontendModel -> Document FrontendMsg
view model =
    let
        css =
            -- There's an experimental technique to include styles in header instead of body https://dashboard.lamdera.app/docs/html-head
            -- We're not using it for now because it's experimental but might be useful if we want to eliminate the flicker from the css loading in
            node "link" [ rel "stylesheet", href "/output.css" ] []

        debugPanel =
            IdleGame.Views.DebugPanel.render model
    in
    { title = "Idle Game"
    , body =
        []
            ++ [ css ]
            ++ [ debugPanel ]
            ++ (case model.gameState of
                    Initializing ->
                        []

                    FastForward { previousIntervalTimer } ->
                        let
                            speed : IdleGame.Views.FastForward.Speed
                            speed =
                                case previousIntervalTimer of
                                    NotStarted ->
                                        IdleGame.Views.FastForward.SpeedCalculating

                                    HaveStart _ ->
                                        IdleGame.Views.FastForward.SpeedCalculating

                                    HaveStartAndEnd start end ->
                                        let
                                            diff =
                                                Time.posixToMillis end - Time.posixToMillis start

                                            millisPerMilli =
                                                toFloat fastForwardTime / (toFloat diff - sleepTime)
                                        in
                                        IdleGame.Views.FastForward.Speed millisPerMilli
                        in
                        [ IdleGame.Views.FastForward.render speed ]

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
                        []
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
                                                IdleGame.Views.MasteryUnlocks.render
                                        in
                                        [ IdleGame.Views.ModalWrapper.create children
                                            |> IdleGame.Views.ModalWrapper.withBorderColor "border-secondary"
                                            |> IdleGame.Views.ModalWrapper.render
                                        ]
                               )
               )
    }
