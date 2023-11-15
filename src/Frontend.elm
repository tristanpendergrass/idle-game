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
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Spell as Spell
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Activity
import IdleGame.Views.Content
import IdleGame.Views.DebugPanel as DebugPanel
import IdleGame.Views.DetailViewContent
import IdleGame.Views.DetailViewWrapper
import IdleGame.Views.DetailViewWrapper2
import IdleGame.Views.Drawer
import IdleGame.Views.FastForward
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.MasteryUnlocks
import IdleGame.Views.ModalWrapper
import IdleGame.Views.ShopResourceModal
import IdleGame.Views.TimePasses
import IdleGame.Views.Utils as ViewUtils
import Json.Decode.Pipeline exposing (..)
import Lamdera
import Process
import Quantity exposing (Quantity)
import Random
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
      , mode = Config.flags.defaultMode
      , skillingState =
            { activeTab = Config.flags.defaultTabSkilling
            , preview = Nothing
            , activityExpanded = Config.flags.defaultDetailViewExpanded
            }
      , adventuringState =
            { activeTab = Config.flags.defaultTabAdventuring
            , preview = Nothing
            , activityExpanded = Config.flags.defaultDetailViewExpanded
            }
      , isVisible = True
      , activeModal = Nothing
      , saveGameTimer = Timer.create
      , gameState = Initializing
      , pointerState = Nothing
      , locationFilters = Location.createRecord LocationAll
      }
    , Cmd.none
    )



-- Update


getDetailViewState : Maybe ( Activity, Timer ) -> Maybe Preview -> Bool -> IdleGame.Views.DetailViewWrapper2.State ( Activity, Timer ) Preview
getDetailViewState maybeActivity maybePreview activityExpanded =
    case ( maybeActivity, maybePreview ) of
        ( Nothing, Nothing ) ->
            IdleGame.Views.DetailViewWrapper2.Blank

        ( Just activity, Nothing ) ->
            if activityExpanded then
                IdleGame.Views.DetailViewWrapper2.ActivityExpanded activity

            else
                IdleGame.Views.DetailViewWrapper2.ActivityCollapsed activity

        ( Nothing, Just preview ) ->
            IdleGame.Views.DetailViewWrapper2.Preview preview

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
                    IdleGame.Views.DetailViewWrapper2.ActivityExpanded activity

                else
                    IdleGame.Views.DetailViewWrapper2.ActivityCollapsed activity

            else if activityExpanded then
                IdleGame.Views.DetailViewWrapper2.ActivityExpanded activity

            else
                IdleGame.Views.DetailViewWrapper2.PreviewWithActivity preview activity


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


setTabSkilling : Tab -> FrontendModel -> FrontendModel
setTabSkilling tab model =
    let
        skillingState : ModeState
        skillingState =
            model.skillingState

        newSkillingState : ModeState
        newSkillingState =
            { skillingState | activeTab = tab }
    in
    { model | skillingState = newSkillingState }


setTabAdventuring : Tab -> FrontendModel -> FrontendModel
setTabAdventuring tab model =
    let
        adventuringState : ModeState
        adventuringState =
            model.adventuringState

        newAdventuringState : ModeState
        newAdventuringState =
            { adventuringState | activeTab = tab }
    in
    { model | adventuringState = newAdventuringState }


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


setPreview : Mode -> Maybe Preview -> FrontendModel -> FrontendModel
setPreview mode =
    let
        setPreviewSkilling : Maybe Preview -> FrontendModel -> FrontendModel
        setPreviewSkilling maybePreview model =
            let
                skillingState : ModeState
                skillingState =
                    model.skillingState

                newSkillingState : ModeState
                newSkillingState =
                    { skillingState | preview = maybePreview }
            in
            { model | skillingState = newSkillingState }

        setPreviewAdventuring : Maybe Preview -> FrontendModel -> FrontendModel
        setPreviewAdventuring maybePreview model =
            let
                adventuringState : ModeState
                adventuringState =
                    model.adventuringState

                newAdventuringState : ModeState
                newAdventuringState =
                    { adventuringState | preview = maybePreview }
            in
            { model | adventuringState = newAdventuringState }
    in
    case mode of
        Skilling ->
            setPreviewSkilling

        Adventuring ->
            setPreviewAdventuring


setActivityExpanded : Mode -> Bool -> FrontendModel -> FrontendModel
setActivityExpanded mode =
    let
        setActivityExpandedSkilling : Bool -> FrontendModel -> FrontendModel
        setActivityExpandedSkilling activityExpanded model =
            let
                skillingState : ModeState
                skillingState =
                    model.skillingState

                newSkillingState : ModeState
                newSkillingState =
                    { skillingState | activityExpanded = activityExpanded }
            in
            { model | skillingState = newSkillingState }

        setActivityExpandedAdventuring : Bool -> FrontendModel -> FrontendModel
        setActivityExpandedAdventuring activityExpanded model =
            let
                adventuringState : ModeState
                adventuringState =
                    model.adventuringState

                newAdventuringState : ModeState
                newAdventuringState =
                    { adventuringState | activityExpanded = activityExpanded }
            in
            { model | adventuringState = newAdventuringState }
    in
    case mode of
        Skilling ->
            setActivityExpandedSkilling

        Adventuring ->
            setActivityExpandedAdventuring


getActivity : FrontendModel -> Maybe ( Activity, Timer )
getActivity model =
    case model.gameState of
        Playing snapshot ->
            case model.mode of
                Skilling ->
                    (Snapshot.getValue snapshot).activitySkilling

                Adventuring ->
                    (Snapshot.getValue snapshot).activityAdventuring

        _ ->
            Nothing


setActivity : Mode -> Maybe ( Activity, Timer ) -> FrontendModel -> FrontendModel
setActivity mode newActivity =
    mapGame
        (\game ->
            case mode of
                Skilling ->
                    Game.setActivitySkilling newActivity game

                Adventuring ->
                    Game.setActivityAdventuring newActivity game
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


updateLocationFilters : (Location.Record LocationFilter -> Location.Record LocationFilter) -> FrontendModel -> FrontendModel
updateLocationFilters fn model =
    { model | locationFilters = fn model.locationFilters }


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

        SwitchMode mode ->
            ( { model | mode = mode }, Cmd.none )

        ClosePreview ->
            ( model
                |> setPreview model.mode Nothing
            , Cmd.none
            )

        CollapseActivity ->
            ( model
                |> setActivityExpanded model.mode False
            , Cmd.none
            )

        ExpandActivity ->
            ( model
                |> setActivityExpanded model.mode True
            , Cmd.none
            )

        CollapseDetailView ->
            ( model
                |> setActivityExpanded model.mode False
            , Cmd.none
            )

        ExpandDetailView ->
            ( model
                |> setActivityExpanded model.mode True
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
                    |> setActivity model.mode newActivity
                    |> setActivityExpanded model.mode (not clickingActiveActivity)
                , Cmd.none
                )

            else
                ( model
                    |> setActivity model.mode newActivity
                    |> setActivityExpanded model.mode False
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
                |> setPreview model.mode (Just (Preview activity))
                |> setActivityExpanded model.mode
                    (if clickingActiveActivity then
                        True

                     else
                        False
                    )
            , Cmd.none
            )

        HandlePlayClick kind ->
            ( model
                |> setActivity model.mode (Just ( kind, Timer.create ))
                |> setPreview model.mode Nothing
                |> setActivityExpanded model.mode True
            , Cmd.none
            )

        HandleStopClick kind ->
            ( model
                |> setActivity model.mode Nothing
                |> setPreview model.mode (Just (Preview kind))
            , Cmd.none
            )

        HandleSpellSelect activity spellTitle ->
            ( model
                |> mapGame
                    (\game ->
                        let
                            maybeSpell : Maybe Spell
                            maybeSpell =
                                Spell.getByTitle spellTitle
                        in
                        Game.selectSpell { activity = activity, maybeSpell = maybeSpell } game
                    )
            , Cmd.none
            )

        HandleQuestComplete quest ->
            -- case model.gameState of
            --     Playing snapshot ->
            --         let
            --             game : Game
            --             game =
            --                 Snapshot.getValue snapshot
            --             purchaseResult : Result EffectErr Game.ApplyEffectsValue
            --             purchaseResult =
            --                 Game.attemptPurchaseResource quantity resource game
            --         in
            --         case purchaseResult of
            --             Ok res ->
            --                 let
            --                     newGame : Game
            --                     newGame =
            --                         res.game
            --                     toasts : List Toast
            --                     toasts =
            --                         res.toasts
            --                     newModel : FrontendModel
            --                     newModel =
            --                         { model | gameState = Playing (Snapshot.map (\_ -> newGame) snapshot) }
            --                             |> setActiveModal Nothing
            --                     notificationCmds : List (Cmd FrontendMsg)
            --                     notificationCmds =
            --                         List.map (AddToast >> delay 0) toasts
            --                 in
            --                 ( newModel, Cmd.batch notificationCmds )
            --             Err _ ->
            --                 -- We disable the buy button in this case so shouldn't normally reach this spot
            --                 noOp
            --     _ ->
            --         noOp
            case model.gameState of
                Playing snapshot ->
                    let
                        game : Game
                        game =
                            Snapshot.getValue snapshot

                        result : Result EffectErr Game.ApplyEffectsValue
                        result =
                            Game.attemptCompleteQuest quest game
                    in
                    case result of
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

                                notificationCmds : List (Cmd FrontendMsg)
                                notificationCmds =
                                    List.map (AddToast >> delay 0) toasts
                            in
                            ( newModel, Cmd.batch notificationCmds )

                        Err _ ->
                            -- We disable the quest complete button in this case so shouldn't normally reach this spot
                            noOp

                _ ->
                    noOp

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

        OpenMasteryUnlocksModal ->
            ( model
                |> setActiveModal (Just ChoreItemUnlocksModal)
            , Cmd.none
            )

        HandleTabClick tab mode ->
            let
                setTab =
                    case mode of
                        Skilling ->
                            setTabSkilling

                        Adventuring ->
                            setTabAdventuring
            in
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
                                not <| ShopUpgrade.getByKind kind game.ownedShopUpgrades
                        in
                        if canAfford && dontOwnItemYet then
                            let
                                newGame : Game
                                newGame =
                                    { game
                                        | coin = Quantity.difference game.coin stats.price
                                        , ownedShopUpgrades = ShopUpgrade.setByKind kind True game.ownedShopUpgrades
                                    }
                            in
                            newGame

                        else
                            game
                    )
            , Cmd.none
            )

        HandleShopResourceClick resource ->
            case (Resource.getStats resource).purchasing of
                Resource.Purchasable price ->
                    ( { model
                        | activeModal = Just (ShopResourceModal 1 resource price)
                      }
                    , Cmd.none
                    )

                Resource.NotPurchasable ->
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

        HandleOneLessButtonClick ->
            case model.activeModal of
                Just (ShopResourceModal quantity resource price) ->
                    ( { model
                        | activeModal = Just (ShopResourceModal (Debug.log "new quantity" <| Basics.max 1 (quantity - 1)) resource price)
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

        HandleLocationFilterClick location filter ->
            let
                updateFilter : LocationFilter -> LocationFilter
                updateFilter oldFilter =
                    if oldFilter == filter then
                        LocationAll

                    else
                        filter
            in
            ( model
                |> updateLocationFilters (Location.updateByKind location updateFilter)
            , Cmd.none
            )


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
                stats : Resource.Stats
                stats =
                    Resource.getStats resource

                plusOrMinus : String
                plusOrMinus =
                    if amount >= 0 then
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

        LostCombat ->
            div [ baseClass, warningClass ]
                [ text "Lost combat" ]

        NegativeAmountErr ->
            div [ baseClass, warningClass ]
                [ text "Missing resources" ]

        QuestAlreadyCompleteErr ->
            div [ baseClass, warningClass ]
                [ text "Quest already complete" ]

        DiscoveredMonster monster ->
            div [ baseClass, successClass ]
                [ text <| "Discovered Monster: " ++ Monster.getLabel monster ]

        DiscoveredResource resource ->
            div [ baseClass, successClass, class "flex gap-1 items-center" ]
                [ span [] [ text <| "Discovered Resource: " ++ (Resource.getStats resource).title ]
                , (Resource.getStats resource).icon
                    |> Icon.toHtml
                ]

        DiscoveredQuest quest ->
            div [ baseClass, successClass ]
                [ text <| "Discovered Quest: " ++ Quest.getLabel quest ]


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

        Just ChoreItemUnlocksModal ->
            let
                children =
                    IdleGame.Views.MasteryUnlocks.render
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-secondary"
                |> IdleGame.Views.ModalWrapper.render

        Just (ShopResourceModal amount resource price) ->
            let
                children =
                    IdleGame.Views.ShopResourceModal.render game amount ( resource, price )
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
            ++ (case model.skillingState.activeTab of
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
                    game : Game
                    game =
                        Snapshot.getValue snapshot

                    detailViewState : IdleGame.Views.DetailViewWrapper2.State ( Activity, Timer ) Preview
                    detailViewState =
                        case model.mode of
                            Skilling ->
                                getDetailViewState game.activitySkilling model.skillingState.preview model.skillingState.activityExpanded

                            Adventuring ->
                                getDetailViewState game.activityAdventuring model.adventuringState.preview model.adventuringState.activityExpanded

                    extraBottomPadding : Bool
                    extraBottomPadding =
                        case detailViewState of
                            IdleGame.Views.DetailViewWrapper2.PreviewWithActivity _ _ ->
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
                        case model.mode of
                            Skilling ->
                                model.skillingState.activeTab

                            Adventuring ->
                                model.adventuringState.activeTab

                    detailViewWrapperProps : IdleGame.Views.DetailViewWrapper2.Props ( Activity, Timer ) Preview FrontendMsg
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
                    , div [ class "bg-base-100 drawer drawer-mobile" ]
                        [ input
                            [ id "drawer"
                            , type_ "checkbox"
                            , class "drawer-toggle"
                            , checked model.isDrawerOpen
                            , onCheck SetDrawerOpen
                            ]
                            []
                        , IdleGame.Views.Content.renderContent model game activeTab
                        , IdleGame.Views.Drawer.renderDrawer model.isDrawerOpen model.mode activeTab
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
                    , IdleGame.Views.DetailViewWrapper2.renderFullScreen detailViewWrapperProps
                    , IdleGame.Views.DetailViewWrapper2.renderSidebar detailViewWrapperProps

                    -- , IdleGame.Views.DetailView.render game model.preview model.activityExpanded
                    -- , div [ class "w-[40rem] h-full border-l-8 border-base-200 overflow-y-auto overflow-x-hidden" ]
                    --     [ IdleGame.Views.Chores.detailView game ]
                    , renderModal model.activeModal game
                    , renderBottomRightItems model
                    ]
        ]
    }
