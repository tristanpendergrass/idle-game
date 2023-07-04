module Frontend exposing (app)

import Browser exposing (Document, UrlRequest(..))
import Browser.Dom
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation as Nav
import Config
import Duration exposing (Duration)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Extra exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Chore as Chore
import IdleGame.Combat as Adventuring
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity
import IdleGame.Views.Adventuring
import IdleGame.Views.Content
import IdleGame.Views.DebugPanel as DebugPanel
import IdleGame.Views.DetailViewContent
import IdleGame.Views.DetailViewWrapper
import IdleGame.Views.Drawer
import IdleGame.Views.FastForward
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.MasteryCheckpoints
import IdleGame.Views.MasteryUnlocks
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import IdleGame.Views.Utils as ViewUtils
import Json.Decode.Pipeline exposing (..)
import Lamdera
import Process
import Quantity exposing (Quantity)
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
init _ key =
    ( { key = key
      , showDebugPanel = False
      , tray = Toast.tray
      , isDrawerOpen = False
      , activeTab = Config.flags.defaultTab
      , isVisible = True
      , activeModal = Nothing
      , saveGameTimer = Timer.create
      , gameState = Initializing
      , activityExpanded = Config.flags.defaultDetailViewExpanded
      , preview = Nothing
      }
    , Cmd.none
    )



-- Update


getDetailViewState : Maybe ( Activity, Timer ) -> Maybe Preview -> Bool -> IdleGame.Views.DetailViewWrapper.State ( Activity, Timer ) Preview
getDetailViewState maybeActivity maybePreview activityExpanded =
    case ( maybeActivity, maybePreview ) of
        ( Nothing, Nothing ) ->
            IdleGame.Views.DetailViewWrapper.Blank

        ( Just activity, Nothing ) ->
            if activityExpanded then
                IdleGame.Views.DetailViewWrapper.ActivityExpanded activity

            else
                IdleGame.Views.DetailViewWrapper.ActivityCollapsed activity

        ( Nothing, Just preview ) ->
            IdleGame.Views.DetailViewWrapper.Preview preview

        ( Just activity, Just preview ) ->
            -- Slightly complicated by the fact that we might be trying to preview the same thing as the activity
            let
                previewActivity : Activity
                previewActivity =
                    case preview of
                        Preview a ->
                            a
            in
            if Tuple.first activity == previewActivity then
                if activityExpanded then
                    IdleGame.Views.DetailViewWrapper.ActivityExpanded activity

                else
                    IdleGame.Views.DetailViewWrapper.ActivityCollapsed activity

            else if activityExpanded then
                IdleGame.Views.DetailViewWrapper.ActivityExpanded activity

            else
                IdleGame.Views.DetailViewWrapper.PreviewWithActivity preview activity


setIsVisible : Bool -> FrontendModel -> FrontendModel
setIsVisible isVisible model =
    { model | isVisible = isVisible }


setActiveModal : Maybe Modal -> FrontendModel -> FrontendModel
setActiveModal activeModal model =
    let
        -- This supports the DebugPanel's "Show Time Passes" checkbox
        filteredActiveModal =
            case activeModal of
                Just (TimePassesModal _ _) ->
                    if Config.flags.showTimePasses then
                        activeModal

                    else
                        Nothing

                _ ->
                    activeModal
    in
    { model | activeModal = filteredActiveModal }


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
    Game.getTimePassesData oldGame newGame
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
    Snapshot.createTick (Duration.milliseconds 15)
        (\duration ( oldGame, oldToasts ) ->
            let
                ( newGame, newToasts ) =
                    Game.tick duration oldGame
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
    Snapshot.createTick (Duration.seconds 2)
        (\duration oldGame -> Game.tick duration oldGame |> Tuple.first)


setPreview : Maybe Preview -> FrontendModel -> FrontendModel
setPreview maybePreview model =
    { model | preview = maybePreview }


setActivityExpanded : Bool -> FrontendModel -> FrontendModel
setActivityExpanded activityExpanded model =
    { model | activityExpanded = activityExpanded }


getActivity : FrontendModel -> Maybe ( Activity, Timer )
getActivity model =
    case model.gameState of
        Playing snapshot ->
            (Snapshot.getValue snapshot).activity

        _ ->
            Nothing


setActivity : Maybe ( Activity, Timer ) -> FrontendModel -> FrontendModel
setActivity newActivity =
    mapGame (\game -> Game.setActivity newActivity game)


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

        UrlChanged _ ->
            noOp

        OpenDebugPanel ->
            ( { model | showDebugPanel = True }
              -- We added this sleep + focus commands here to try to give focus to the debug panel after it's opened.
              -- It doesn't work for some reason but keeping it here in case I ever figure out why not.
            , Process.sleep 100
                |> Task.andThen (\_ -> Browser.Dom.focus DebugPanel.panelId)
                |> Task.attempt (\_ -> NoOp)
            )

        ClosePreview ->
            ( model
                |> setPreview Nothing
            , Cmd.none
            )

        CollapseActivity ->
            ( model
                |> setActivityExpanded False
            , Cmd.none
            )

        ExpandActivity ->
            ( model
                |> setActivityExpanded True
            , Cmd.none
            )

        CollapseDetailView ->
            ( { model | activityExpanded = False }, Cmd.none )

        ExpandDetailView ->
            ( { model | activityExpanded = True }, Cmd.none )

        CloseDebugPanel ->
            ( { model | showDebugPanel = False }, Cmd.none )

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

        StartFight ->
            ( model
                |> mapGame Game.startFight
            , Cmd.none
            )

        StopFight ->
            ( model
                |> mapGame Game.stopFight
            , Cmd.none
            )

        HandlePlayerMoveSelect index playerMove ->
            ( model
                |> mapGame (Game.setPlayerMove index playerMove)
            , Browser.Dom.focus IdleGame.Views.Adventuring.fightButtonId
                |> Task.attempt (\_ -> NoOp)
            )

        HandleMonsterSelect monster ->
            ( { model
                | gameState =
                    case model.gameState of
                        Playing snapshot ->
                            snapshot
                                |> Snapshot.map (Game.setMonster monster)
                                |> Playing

                        _ ->
                            model.gameState
              }
            , Browser.Dom.focus IdleGame.Views.Adventuring.fightButtonId
                |> Task.attempt (\_ -> NoOp)
            )

        HandleActivityClick { screenWidth } kind ->
            let
                currentActivity : Maybe ( Activity, Timer )
                currentActivity =
                    getActivity model

                clickingActiveActivity : Bool
                clickingActiveActivity =
                    case currentActivity of
                        Just ( k, _ ) ->
                            k == kind

                        Nothing ->
                            False

                newActivity : Maybe ( Activity, Timer )
                newActivity =
                    if clickingActiveActivity then
                        Nothing

                    else
                        Just ( kind, Timer.create )
            in
            if ViewUtils.screenSupportsRighRail screenWidth then
                ( model
                    |> setActivity newActivity
                    |> setActivityExpanded (not clickingActiveActivity)
                , Cmd.none
                )

            else
                ( model
                    |> setActivity newActivity
                    |> setActivityExpanded False
                , Cmd.none
                )

        HandlePlayClick kind ->
            ( model
                |> setActivity (Just ( kind, Timer.create ))
                |> setPreview Nothing
                |> setActivityExpanded True
            , Cmd.none
            )

        HandleStopClick kind ->
            ( model
                |> mapGame (\game -> Game.setActivity Nothing game)
                |> setPreview (Just (Preview kind))
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
                            Timer.increment (Duration.seconds 1) (Duration.milliseconds delta) model.saveGameTimer

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
                                Counter.getValue stats.price <= Counter.getValue game.coin

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

        AddTime amount ->
            case model.gameState of
                Playing snapshot ->
                    let
                        current =
                            Snapshot.dEBUG_addTime (Quantity.negate amount) snapshot

                        fastForwardState : FastForwardState
                        fastForwardState =
                            { original = current, current = current, previousIntervalTimer = NotStarted }
                    in
                    ( model
                        |> setGameState (FastForward fastForwardState)
                    , Task.perform HandleFastForward Time.now
                    )

                _ ->
                    noOp


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        InitializeGame serverSnapshot ->
            let
                adjustedServerSnapshot : Snapshot Game
                adjustedServerSnapshot =
                    Snapshot.dEBUG_addTime (Quantity.negate Config.flags.extraFastForwardTime) serverSnapshot
            in
            case model.gameState of
                Initializing ->
                    ( model
                        |> setGameState
                            (FastForward
                                { original = adjustedServerSnapshot
                                , current = adjustedServerSnapshot
                                , previousIntervalTimer = NotStarted
                                }
                            )
                    , Task.perform HandleFastForward Time.now
                    )

                _ ->
                    -- If we receive an InitializeGame message from backend while already initialized we ignore it
                    ( model, Cmd.none )


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
        |> Toast.withTrayAttributes
            [ class "t-column gap-2 fixed bottom-[5rem] left-1/2 -translate-x-1/2 w-auto"
            , ViewUtils.zIndexes.toast
            ]
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
                [ span [] [ text <| "+" ++ ViewUtils.intToString amount ]
                , stats.icon
                    |> Icon.toHtml
                ]


renderModal : Maybe Modal -> Game -> Html FrontendMsg
renderModal activeModal game =
    case activeModal of
        Nothing ->
            nothing

        Just (TimePassesModal timePassed timePassesData) ->
            let
                children =
                    IdleGame.Views.TimePasses.render timePassed timePassesData
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-primary"
                |> IdleGame.Views.ModalWrapper.render

        Just ChoreMasteryCheckpointsModal ->
            let
                children =
                    IdleGame.Views.MasteryCheckpoints.render { poolXp = game.choresMxp, checkpoints = Game.choreMasteryPoolCheckpoints }
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-secondary"
                |> IdleGame.Views.ModalWrapper.render

        Just ChoreItemUnlocksModal ->
            let
                children =
                    IdleGame.Views.MasteryUnlocks.render
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-secondary"
                |> IdleGame.Views.ModalWrapper.render


renderBottomRightItems : FrontendModel -> Html FrontendMsg
renderBottomRightItems model =
    div [ class "absolute bottom-[2rem] right-[2rem] flex items-center gap-2", ViewUtils.zIndexes.bottomRightMenu ]
        ((if Config.flags.showDebugPanel then
            [ DebugPanel.renderOpenButton ]

          else
            []
         )
            ++ (case model.activeTab of
                    Tab.Chores ->
                        [ IdleGame.Views.Activity.renderBottomRight ]

                    _ ->
                        []
               )
        )


view : FrontendModel -> Document FrontendMsg
view model =
    let
        css =
            -- There's an experimental technique to include styles in header instead of body https://dashboard.lamdera.app/docs/html-head
            -- We're not using it for now because it's experimental but might be useful if we want to eliminate the flicker from the css loading in
            node "link" [ rel "stylesheet", href "/output.css" ] []
    in
    { title = "Idle Game"
    , body =
        [ css
        , DebugPanel.render model
        , case model.gameState of
            Initializing ->
                nothing

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
                IdleGame.Views.FastForward.render speed

            Playing snapshot ->
                let
                    game =
                        Snapshot.getValue snapshot

                    detailViewState : IdleGame.Views.DetailViewWrapper.State ( Activity, Timer ) Preview
                    detailViewState =
                        getDetailViewState game.activity model.preview model.activityExpanded

                    extraBottomPadding : Bool
                    extraBottomPadding =
                        case detailViewState of
                            IdleGame.Views.DetailViewWrapper.PreviewWithActivity _ _ ->
                                True

                            _ ->
                                False

                    renderActivity : ( Activity, Timer ) -> Html FrontendMsg
                    renderActivity activity =
                        IdleGame.Views.DetailViewContent.renderContent (IdleGame.Views.DetailViewContent.DetailViewActivity activity) extraBottomPadding game

                    renderPreview : Preview -> Html FrontendMsg
                    renderPreview preview =
                        IdleGame.Views.DetailViewContent.renderContent (IdleGame.Views.DetailViewContent.DetailViewPreview preview) extraBottomPadding game

                    renderStatusBar : ( Activity, Timer ) -> Html FrontendMsg
                    renderStatusBar activity =
                        IdleGame.Views.DetailViewContent.renderStatusBar activity
                in
                div [ class "flex h-screen relative" ]
                    [ Toast.render viewToast model.tray toastConfig
                    , div [ class "bg-base-100 drawer drawer-mobile" ]
                        [ input
                            [ id "drawer"
                            , type_ "checkbox"
                            , class "drawer-toggle"
                            , checked model.isDrawerOpen
                            , onCheck SetDrawerOpen
                            ]
                            []
                        , IdleGame.Views.Content.renderContent game model.activeTab
                        , IdleGame.Views.Drawer.renderDrawer model.isDrawerOpen model.activeTab
                        ]
                    , IdleGame.Views.DetailViewWrapper.render
                        { state = detailViewState
                        , renderActivity = renderActivity
                        , renderPreview = renderPreview
                        , renderStatusBar = renderStatusBar
                        , onClosePreview = ClosePreview
                        , onExpandActivity = ExpandActivity
                        , onCollapseActivity = CollapseActivity
                        }

                    -- , IdleGame.Views.DetailView.render game model.preview model.activityExpanded
                    -- , div [ class "w-[40rem] h-full border-l-8 border-base-200 overflow-y-auto overflow-x-hidden" ]
                    --     [ IdleGame.Views.Chores.detailView game ]
                    , renderModal model.activeModal game
                    , renderBottomRightItems model
                    ]
        ]
    }
