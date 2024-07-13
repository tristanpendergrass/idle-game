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
import IdleGame.AcademicTest as Test
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (EffectType)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mocks
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.OneTime exposing (OneTimeStatus(..))
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity
import IdleGame.Views.Content
import IdleGame.Views.DebugPanel as DebugPanel
import IdleGame.Views.DetailViewContent
import IdleGame.Views.DetailViewWrapper
import IdleGame.Views.Drawer
import IdleGame.Views.FastForward
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.ModalWrapper
import IdleGame.Views.ShopResourceModal
import IdleGame.Views.SyllabusModal
import IdleGame.Views.TimePasses
import IdleGame.Views.Utils as ViewUtils
import Json.Decode as D
import Json.Decode.Pipeline exposing (..)
import Lamdera
import Process
import Quantity exposing (Quantity)
import Random
import Result.Extra
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
    let
        activityExpanded : Bool
        activityExpanded =
            -- Note: this value is overriden by HandleGetViewportResult immediately after the page loads to the value here doesn't matter so much
            False
    in
    -- { key : Key -- used by Browser.Navigation for things like pushUrl
    -- , lastFastForwardDuration : Maybe Duration -- Used to display fast forward times for debugging and optimization
    -- , showDebugPanel : Bool
    -- , tray : Toast.Tray Toast
    -- , isDrawerOpen : Bool
    -- , skillingState : ModeState
    -- , isVisible : Bool
    -- , activeModal : Maybe Modal
    -- , saveGameTimer : Timer
    -- , gameState : FrontendGameState
    -- , pointerState : Maybe PointerState -- Tracks the state of the pointer (mouse or touch) for long press detection
    -- }
    ( { key = key
      , lastFastForwardDuration = Nothing
      , showDebugPanel = False
      , tray = Toast.tray
      , isDrawerOpen = False
      , activeTab = Config.flags.defaultTab
      , preview = Nothing
      , activityExpanded = activityExpanded
      , isVisible = True
      , activeModal = Nothing -- Note: editing this won't change the value of modal shown on opening because it's set in the time passes handler
      , saveGameTimer = Timer.create
      , gameState = Initializing
      , pointerState = Nothing
      , activeAcademicTestCategory = Quiz
      , cache = Nothing
      }
    , Task.perform HandleGetViewportResult Browser.Dom.getViewport
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
                Just (TimePassesModal _ _ _) ->
                    -- showTimePasses can be set to False for disabling this during development
                    -- debugTimePasses forces it to be shown with debug values
                    if Config.flags.showTimePasses || Config.flags.debugTimePasses then
                        activeModal

                    else
                        Nothing

                _ ->
                    activeModal
    in
    { model | activeModal = filteredActiveModal }


createTimePassesModal : Duration -> Snapshot Game -> Snapshot Game -> Maybe Modal
createTimePassesModal duration oldSnap newSnap =
    let
        oldGame =
            Snapshot.getValue oldSnap

        newGame =
            Snapshot.getValue newSnap

        timePassed =
            Snapshot.getTimeDifference oldSnap newSnap
    in
    Game.getTimePassesData oldGame newGame
        |> Maybe.map (TimePassesModal duration timePassed)


setTab : Tab -> FrontendModel -> FrontendModel
setTab tab model =
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
        Playing snapshot cachedActivityEffects ->
            snapshot
                |> Snapshot.map fn
                |> (\newSnapshot -> { model | gameState = Playing newSnapshot cachedActivityEffects })

        _ ->
            model


setSaveGameTimer : Timer -> FrontendModel -> FrontendModel
setSaveGameTimer timer model =
    { model | saveGameTimer = timer }


sleepTime : Float
sleepTime =
    1


getFastForwardPoint : Posix -> Posix
getFastForwardPoint =
    let
        amountOfTimeToFastForward : Duration
        amountOfTimeToFastForward =
            Duration.hours 1
    in
    Time.Extra.add Time.Extra.Millisecond (floor (Duration.inMilliseconds amountOfTimeToFastForward)) Time.utc


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
tickForDuration : Duration -> Snapshot.Tick Game
tickForDuration duration =
    Snapshot.createTick duration
        (\d oldGame -> Game.tick d oldGame |> Tuple.first)


setPreview : Maybe Preview -> FrontendModel -> FrontendModel
setPreview maybePreview model =
    { model | preview = maybePreview }


setActivityExpanded : Bool -> FrontendModel -> FrontendModel
setActivityExpanded activityExpanded model =
    { model | activityExpanded = activityExpanded }


setActiveAcademicTestCategory : AcademicTestCategory -> FrontendModel -> FrontendModel
setActiveAcademicTestCategory testCategory model =
    { model | activeAcademicTestCategory = testCategory }


getActivity : FrontendModel -> Maybe ( Activity, Timer )
getActivity model =
    case model.gameState of
        Playing snapshot _ ->
            (Snapshot.getValue snapshot).activity

        _ ->
            Nothing


setActivity : Maybe ( Activity, Timer ) -> FrontendModel -> FrontendModel
setActivity newActivity =
    mapGame
        (\game ->
            Game.setActivity newActivity game
        )


updatePointer : Float -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updatePointer delta model =
    case model.pointerState of
        Nothing ->
            ( model, Cmd.none )

        Just { click, longPress } ->
            case longPress of
                Nothing ->
                    ( model, Cmd.none )

                Just ( timer, floatDuration, longPressMsg ) ->
                    let
                        ( newTimer, completions ) =
                            Timer.increment (Duration.milliseconds floatDuration) (Duration.milliseconds delta) timer
                    in
                    if completions > 0 then
                        update longPressMsg { model | pointerState = Nothing }

                    else
                        ( { model
                            | pointerState =
                                Just
                                    { click = click
                                    , longPress = Just ( newTimer, floatDuration, longPressMsg )
                                    }
                          }
                        , Cmd.none
                        )


setGameState : FrontendGameState -> FrontendModel -> FrontendModel
setGameState gameState model =
    { model | gameState = gameState }


setCache : Cache -> FrontendModel -> FrontendModel
setCache cache model =
    { model | cache = cache }


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

        InitializeGameHelp serverSnapshot now ->
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
                                , whenItStarted = now
                                }
                            )
                    , Task.perform HandleFastForward Time.now
                    )

                _ ->
                    -- If we receive an InitializeGame message from backend while already initialized we ignore it
                    ( model, Cmd.none )

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
            ( model
                |> setActivityExpanded False
            , Cmd.none
            )

        ExpandDetailView ->
            ( model
                |> setActivityExpanded True
            , Cmd.none
            )

        CloseDebugPanel ->
            ( { model | showDebugPanel = False }, Cmd.none )

        AddToast content ->
            Toast.expireIn 3000 content
                -- Toast.persistent content -- this can be used for testing toast styles to make the toast not disappear
                -- NOTE: Number passed to withExitTransition should match the transition duration of class "toast" in index.css
                |> Toast.withExitTransition 900
                |> Toast.add model.tray
                |> Toast.tuple ToastMsg model

        HandleTestingCenterTabClick testingCenterTab ->
            ( model
                |> setActiveAcademicTestCategory testingCenterTab
            , Cmd.none
            )

        HandleTestCompletionClick test ->
            case model.gameState of
                Playing snapshot _ ->
                    let
                        game : Game
                        game =
                            Snapshot.getValue snapshot
                    in
                    case Game.attemptCompleteTest test game of
                        Err _ ->
                            noOp

                        Ok applyEffectsValue ->
                            let
                                newCache : Cache
                                newCache =
                                    getCache game

                                newModel : FrontendModel
                                newModel =
                                    model
                                        |> setGameState (Playing (Snapshot.setValue applyEffectsValue.game snapshot) newCache)
                            in
                            ( newModel
                            , Cmd.batch (List.map (AddToast >> delay 0) applyEffectsValue.toasts)
                            )

                _ ->
                    noOp

        ToastMsg tmsg ->
            let
                ( tray, newTmesg ) =
                    Toast.update tmsg model.tray
            in
            ( { model | tray = tray }, Cmd.map ToastMsg newTmesg )

        HandleFastForward now ->
            case model.gameState of
                FastForward { original, current, whenItStarted } ->
                    let
                        timeOfCurrent : Posix
                        timeOfCurrent =
                            Snapshot.getTime current

                        timeLeft : Duration
                        timeLeft =
                            (Time.posixToMillis now - Time.posixToMillis timeOfCurrent)
                                |> toFloat
                                |> Duration.milliseconds

                        isLongerThanDay : Bool
                        isLongerThanDay =
                            timeLeft
                                |> Quantity.greaterThan (Duration.days 1)

                        isLongerThanHour : Bool
                        isLongerThanHour =
                            timeLeft
                                |> Quantity.greaterThan (Duration.hours 1)

                        timeToAdd : Duration
                        timeToAdd =
                            if isLongerThanDay then
                                Duration.days 1

                            else if isLongerThanHour then
                                Duration.hours 1

                            else
                                Duration.minutes 1

                        nextInterval : Posix
                        nextInterval =
                            timeOfCurrent
                                |> Time.Extra.add Time.Extra.Millisecond
                                    (floor (Duration.inMilliseconds timeToAdd))
                                    Time.utc
                    in
                    if Time.posixToMillis nextInterval < Time.posixToMillis now then
                        -- We want to only part of the work then suspend for a short period so the app doesn't freeze up
                        let
                            newSnap : Snapshot Game
                            newSnap =
                                Snapshot.tickUntil (tickForDuration timeToAdd) nextInterval current
                        in
                        ( model
                            |> setGameState
                                (FastForward { original = original, current = newSnap, whenItStarted = whenItStarted })
                        , Task.perform HandleFastForward (Process.sleep sleepTime |> Task.andThen (\_ -> Time.now))
                        )

                    else
                        -- run calculation to completion
                        let
                            newSnap =
                                Snapshot.tickUntil (tickForDuration (Duration.minutes 1)) now current

                            newModal =
                                if Config.flags.debugTimePasses then
                                    Just IdleGame.Mocks.timePassesModal

                                else
                                    createTimePassesModal (Duration.milliseconds (toFloat (Time.posixToMillis now - Time.posixToMillis whenItStarted))) original newSnap
                        in
                        ( model
                            |> setGameState
                                (Playing newSnap)
                            |> setActiveModal newModal
                        , Cmd.none
                        )

                _ ->
                    -- Shouldn't normally happen
                    noOp

        HandleSyllabusClick skill ->
            ( model
                |> setActiveModal (Just (SyllabusModal skill))
            , Cmd.none
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

        HandlePreviewClick activity ->
            let
                currentActivity : Maybe ( Activity, Timer )
                currentActivity =
                    getActivity model

                clickingActiveActivity : Bool
                clickingActiveActivity =
                    case currentActivity of
                        Just ( k, _ ) ->
                            k == activity

                        Nothing ->
                            False
            in
            ( model
                |> setPreview (Just (Preview activity))
                |> setActivityExpanded
                    (if clickingActiveActivity then
                        True

                     else
                        False
                    )
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
                |> setActivity Nothing
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

                        modelWithSaveTimer : FrontendModel
                        modelWithSaveTimer =
                            model
                                |> setSaveGameTimer newTimer

                        ( modelWithUpdatedPointer, pointerCmds ) =
                            updatePointer delta modelWithSaveTimer
                    in
                    ( modelWithUpdatedPointer, Cmd.batch <| saveGameCmd ++ [ pointerCmds ] )

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
                            oldSnapshot : Snapshot ( Game, List Toast )
                            oldSnapshot =
                                snapshot
                                    |> Snapshot.map (\g -> ( g, [] ))

                            updatedSnapshot : Snapshot ( Game, List Toast )
                            updatedSnapshot =
                                oldSnapshot
                                    |> Snapshot.tickUntil standardTick now

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
                        , Cmd.batch notificationCmds
                        )

        HandleVisibilityChange visibility ->
            ( model, Task.perform (HandleVisibilityChangeHelp visibility) Time.now )

        HandleVisibilityChangeHelp visibility now ->
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
                            |> setGameState (FastForward { original = snapshot, current = snapshot, whenItStarted = now })
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

        HandleTabClick tab ->
            ( model
                |> setTab tab
                |> setIsDrawerOpen False
            , Cmd.none
            )

        HandleShopUpgradeClick kind ->
            ( model
                |> mapGame
                    (\game ->
                        let
                            stats : ShopUpgrade.Stats
                            stats =
                                ShopUpgrade.getStats kind

                            canAfford : Bool
                            canAfford =
                                Coin.toInt stats.price <= Coin.toInt game.coin

                            dontOwnItemYet =
                                not <| getByShopUpgrade kind game.ownedShopUpgrades
                        in
                        if canAfford && dontOwnItemYet then
                            let
                                newGame : Game
                                newGame =
                                    { game
                                        | coin = Quantity.difference game.coin stats.price
                                        , ownedShopUpgrades = setByShopUpgrade kind True game.ownedShopUpgrades
                                    }
                            in
                            newGame

                        else
                            game
                    )
            , Cmd.none
            )

        HandleShopResourceClick resource ->
            case (getResourceStats resource).price of
                Just price ->
                    ( { model
                        | activeModal = Just (ShopResourceModal 1 resource price)
                      }
                    , Cmd.none
                    )

                Nothing ->
                    noOp

        HandleShopResourceBuyClick ->
            case model.activeModal of
                Just (ShopResourceModal quantity resource _) ->
                    case model.gameState of
                        Playing snapshot ->
                            let
                                game : Game
                                game =
                                    Snapshot.getValue snapshot

                                purchaseResult : Result EffectErr Game.ApplyEffectsValue
                                purchaseResult =
                                    Game.attemptPurchaseResource quantity resource game
                            in
                            case purchaseResult of
                                Ok res ->
                                    let
                                        newGame : Game
                                        newGame =
                                            res.game

                                        toasts : List Toast
                                        toasts =
                                            res.toasts

                                        newModel : FrontendModel
                                        newModel =
                                            { model | gameState = Playing (Snapshot.map (\_ -> newGame) snapshot) }
                                                |> setActiveModal Nothing

                                        notificationCmds : List (Cmd FrontendMsg)
                                        notificationCmds =
                                            List.map (AddToast >> delay 0) toasts
                                    in
                                    ( newModel, Cmd.batch notificationCmds )

                                Err _ ->
                                    -- We disable the buy button in this case so shouldn't normally reach this spot
                                    noOp

                        _ ->
                            noOp

                _ ->
                    noOp

        HandleShopResourceQuantityChange string ->
            case model.activeModal of
                Just (ShopResourceModal _ resource price) ->
                    let
                        maybeQuantity : Maybe Int
                        maybeQuantity =
                            String.toInt string
                    in
                    case maybeQuantity of
                        Just quantity ->
                            ( { model
                                | activeModal = Just (ShopResourceModal quantity resource price)
                              }
                            , Cmd.none
                            )

                        Nothing ->
                            noOp

                _ ->
                    noOp

        HandlePointerDown pointerState ->
            ( { model | pointerState = Just pointerState }, Cmd.none )

        HandlePointerUp ->
            case model.pointerState of
                Nothing ->
                    ( { model | pointerState = Nothing }, Cmd.none )

                Just { click } ->
                    update click { model | pointerState = Nothing }

        HandlePointerCancel ->
            ( { model | pointerState = Nothing }, Cmd.none )

        AddTime amount ->
            ( model, Task.perform (AddTimeHelp amount) Time.now )

        AddTimeHelp amount now ->
            case model.gameState of
                Playing snapshot ->
                    let
                        current =
                            Snapshot.dEBUG_addTime (Quantity.negate amount) snapshot

                        fastForwardState : FastForwardState
                        fastForwardState =
                            { original = current, current = current, whenItStarted = now }
                    in
                    ( model
                        |> setGameState (FastForward fastForwardState)
                    , Task.perform HandleFastForward Time.now
                    )

                _ ->
                    noOp

        HandleOneLessButtonClick ->
            case model.activeModal of
                Just (ShopResourceModal quantity resource price) ->
                    ( { model
                        | activeModal = Just (ShopResourceModal (Basics.max 1 (quantity - 1)) resource price)
                      }
                    , Cmd.none
                    )

                _ ->
                    noOp

        HandleOneMoreButtonClick ->
            case model.activeModal of
                Just (ShopResourceModal quantity resource price) ->
                    ( { model
                        | activeModal = Just (ShopResourceModal (quantity + 1) resource price)
                      }
                    , Cmd.none
                    )

                _ ->
                    noOp

        HandleMinButtonClick ->
            case model.activeModal of
                Just (ShopResourceModal _ resource price) ->
                    ( { model
                        | activeModal = Just (ShopResourceModal 1 resource price)
                      }
                    , Cmd.none
                    )

                _ ->
                    noOp

        HandleMaxButtonClick ->
            case model.activeModal of
                Just (ShopResourceModal _ resource price) ->
                    case model.gameState of
                        Playing snapshot ->
                            let
                                game : Game
                                game =
                                    Snapshot.getValue snapshot

                                maxPurchase : Int
                                maxPurchase =
                                    Game.getMaxPurchase price game
                            in
                            ( { model
                                | activeModal = Just (ShopResourceModal maxPurchase resource price)
                              }
                            , Cmd.none
                            )

                        _ ->
                            noOp

                _ ->
                    noOp

        HandleGetViewportResult viewport ->
            let
                screenWidth : Float
                screenWidth =
                    viewport.viewport.width

                screenSupportsRightRail : Bool
                screenSupportsRightRail =
                    -- Hardcode the value that we use to determine if right rail is shown. -- It originates from Tailwind's breakpoints
                    screenWidth >= 1280

                expandedValue : Bool
                expandedValue =
                    if screenSupportsRightRail then
                        True

                    else
                        False
            in
            ( model
                |> setActivityExpanded expandedValue
            , Cmd.none
            )


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        InitializeGame serverSnapshot ->
            ( model, Task.perform (InitializeGameHelp serverSnapshot) Time.now )


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
    let
        baseClass : Html.Attribute msg
        baseClass =
            class "px-2 py-1 rounded"

        successClass : Html.Attribute msg
        successClass =
            class "bg-success text-success-content"

        errClass : Html.Attribute msg
        errClass =
            class "bg-error text-error-content"

        warningClass : Html.Attribute msg
        warningClass =
            class "bg-warning text-warning-content"
    in
    case notification of
        GainedCoin amount ->
            let
                plusOrMinus : String
                plusOrMinus =
                    if Coin.toInt amount >= 0 then
                        "+"

                    else
                        "-"

                colorClass : Attribute msg
                colorClass =
                    if Coin.toInt amount >= 0 then
                        successClass

                    else
                        errClass
            in
            div [ baseClass, colorClass, class "flex gap-1 items-center" ]
                [ span [] [ text <| plusOrMinus ++ ViewUtils.intToString (abs (Coin.toInt amount)) ]
                , Icon.coin
                    |> Icon.toHtml
                ]

        GainedResource amount resource ->
            let
                stats : ResourceStats
                stats =
                    getResourceStats resource

                plusOrMinus : String
                plusOrMinus =
                    if amount > 0 then
                        "+"

                    else
                        "-"

                colorClass : Attribute msg
                colorClass =
                    if amount >= 0 then
                        successClass

                    else
                        errClass
            in
            div [ baseClass, colorClass, class "flex gap-1 items-center" ]
                [ span [] [ text <| plusOrMinus ++ ViewUtils.intToString (abs amount) ]
                , stats.icon
                    |> Icon.toHtml
                ]

        NegativeAmountErr ->
            div [ baseClass, warningClass ]
                [ text "Missing resources" ]

        TestAlreadyCompleted ->
            div [ baseClass, warningClass ]
                [ text "Test already completed" ]

        TestNotUnlocked ->
            div [ baseClass, warningClass ]
                [ text "Test locked" ]


renderModal : Maybe Modal -> Game -> Html FrontendMsg
renderModal activeModal game =
    case activeModal of
        Nothing ->
            nothing

        Just (TimePassesModal timeSpentOnFastForward timePassed timePassesData) ->
            let
                children =
                    IdleGame.Views.TimePasses.render timeSpentOnFastForward timePassed timePassesData
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-primary"
                |> IdleGame.Views.ModalWrapper.render

        Just (ShopResourceModal amount resource price) ->
            let
                children =
                    IdleGame.Views.ShopResourceModal.render game amount ( resource, price )
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-primary"
                |> IdleGame.Views.ModalWrapper.render

        Just (SyllabusModal skill) ->
            let
                children =
                    IdleGame.Views.SyllabusModal.render game skill
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-primary"
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
                    Tab.SkillTab _ ->
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
    { title = "Med School Idle"
    , body =
        [ css
        , DebugPanel.render model
        , case model.gameState of
            Initializing ->
                nothing

            FastForward _ ->
                IdleGame.Views.FastForward.render

            Playing snapshot ->
                let
                    game : Game
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

                    activeTab : Tab
                    activeTab =
                        model.activeTab

                    detailViewWrapperProps : IdleGame.Views.DetailViewWrapper.Props ( Activity, Timer ) Preview FrontendMsg
                    detailViewWrapperProps =
                        { state = detailViewState
                        , renderActivity = renderActivity
                        , renderPreview = renderPreview
                        , renderStatusBar = renderStatusBar
                        , onClosePreview = ClosePreview
                        , onExpandActivity = ExpandActivity
                        , onCollapseActivity = CollapseActivity
                        }
                in
                div [ class "flex h-full w-full relative overflow-hidden" ]
                    [ Toast.render viewToast model.tray toastConfig
                    , div [ class "bg-base-100 drawer lg:drawer-open" ]
                        [ input
                            [ id "drawer"
                            , type_ "checkbox"
                            , class "drawer-toggle"
                            , checked model.isDrawerOpen
                            , onCheck SetDrawerOpen
                            ]
                            []
                        , IdleGame.Views.Content.renderContent model game activeTab
                        , IdleGame.Views.Drawer.renderDrawer model.isDrawerOpen activeTab
                        ]

                    -- , IdleGame.Views.DetailViewWrapper.render
                    --     { state = detailViewState
                    --     , renderActivity = renderActivity
                    --     , renderPreview = renderPreview
                    --     , renderStatusBar = renderStatusBar
                    --     , onClosePreview = ClosePreview
                    --     , onExpandActivity = ExpandActivity
                    --     , onCollapseActivity = CollapseActivity
                    --     }
                    , IdleGame.Views.DetailViewWrapper.renderFullScreen detailViewWrapperProps
                    , IdleGame.Views.DetailViewWrapper.renderSidebar detailViewWrapperProps

                    -- , IdleGame.Views.DetailView.render game model.preview model.activityExpanded
                    -- , div [ class "w-[40rem] h-full border-l-8 border-base-200 overflow-y-auto overflow-x-hidden" ]
                    --     [ IdleGame.Views.Chores.detailView game ]
                    , renderModal model.activeModal game
                    , renderBottomRightItems model
                    ]
        ]
    }


sample : String
sample =
    """[
  {
    "Name": "Cellular Function",
    "Level": 1,
    "Duration": 5,
    "Knowledge": 1,
    "Knowledge/s": 0.2
  },
  {
    "Name": "Cardiovascular System",
    "Level": 5,
    "Duration": 5,
    "Knowledge": 3,
    "Knowledge/s": 0.6
  },
  {
    "Name": "Respiratory System",
    "Level": 15,
    "Duration": 5,
    "Knowledge": 5,
    "Knowledge/s": 1
  },
  {
    "Name": "Renal Function",
    "Level": 25,
    "Duration": 5,
    "Knowledge": 10,
    "Knowledge/s": 2
  },
  {
    "Name": "Digestive System",
    "Level": 40,
    "Duration": 5,
    "Knowledge": 12,
    "Knowledge/s": 2.4
  },
  {
    "Name": "Nervous System",
    "Level": 50,
    "Duration": 5,
    "Knowledge": 15,
    "Knowledge/s": 3
  },
  {
    "Name": "Endocrine System",
    "Level": 65,
    "Duration": 5,
    "Knowledge": 20,
    "Knowledge/s": 4
  },
  {
    "Name": "Reproductive System",
    "Level": 75,
    "Duration": 5,
    "Knowledge": 22,
    "Knowledge/s": 4.4
  },
  {
    "Name": "Immune Response",
    "Level": 90,
    "Duration": 5,
    "Knowledge": 25,
    "Knowledge/s": 5
  }
]"""


type alias Topic =
    { name : String, level : Int, duration : Duration, knowledge : Int, knowledgePerSecond : Float }


durationDecoder : D.Decoder Duration
durationDecoder =
    D.map Duration.seconds D.float


topicDecoder : D.Decoder Topic
topicDecoder =
    D.map5 Topic
        (D.field "Name" D.string)
        (D.field "Level" D.int)
        (D.field "Duration" durationDecoder)
        (D.field "Knowledge" D.int)
        (D.field "Knowledge/s" D.float)


topics : Result D.Error (List Topic)
topics =
    D.decodeString (D.list topicDecoder) sample


getCache : Game -> Cache
getCache game =
    let
        mods : List Mod
        mods =
            Game.getAllMods game
    in
    createRecordFn
        (\activity ->
            Game.getEffects
        )
