module Frontend exposing (app)

import AssocList as Dict exposing (Dict)
import Browser exposing (Document, UrlRequest(..))
import Browser.Dom
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation
import Config
import Duration exposing (Duration)
import EmailAddress exposing (EmailAddress)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Extra exposing (..)
import Id exposing (GameId, Id, UserId)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.CombatWrapper
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mocks
import IdleGame.Mod as Mod exposing (EffectMod)
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
import IdleGame.Views.MainMenu as MainMenu
import IdleGame.Views.ModalWrapper
import IdleGame.Views.ShopResourceModal
import IdleGame.Views.SyllabusModal
import IdleGame.Views.TimePasses
import IdleGame.Views.Utils as ViewUtils
import Json.Decode as D
import Json.Decode.Pipeline exposing (..)
import Lamdera
import List.Extra
import List.Nonempty as Nonempty exposing (Nonempty(..))
import Process
import Quantity exposing (Quantity)
import Random
import Result.Extra
import Route
import ServerInfo
import Svg.Attributes exposing (restart)
import Task
import Time exposing (Posix)
import Time.Extra
import ToastQueue
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


init : Url -> Browser.Navigation.Key -> ( FrontendModel, Cmd FrontendMsg )
init url key =
    let
        ( route, token ) =
            Route.decode url
                |> Maybe.withDefault ( Route.RootRoute, Route.NoToken )

        loginCmd : Cmd FrontendMsg
        loginCmd =
            case token of
                Route.NoToken ->
                    Cmd.none

                Route.LoginToken tokenVal ->
                    Lamdera.sendToBackend (LoginWithTokenRequest tokenVal)

        initialModel : FrontendModel
        initialModel =
            Loading
                { key = key
                , route = route
                , routeToken = token
                , isVisible = True
                , maybeServerInfo = Nothing
                }

        -- LoadedMainMenu
        --     { key = key
        --     , loginStatus = NotLoggedIn { showLogin = False }
        --     , games = []
        --     }
        -- LoadedInGame
        -- { key = key
        -- , loginStatus = NotLoggedIn { showLogin = False }
        -- , route = route
        -- , routeToken = token
        -- , lastFastForwardDuration = Nothing
        -- , showDebugPanel = False
        -- , tray = Toast.tray
        -- , isDrawerOpen = False
        -- , activeTab = Config.flags.defaultTab
        -- , preview = Nothing
        -- , activityExpanded = False
        -- , isVisible = True
        -- , activeModal = Nothing -- Note: editing this won't change the value of modal shown on opening because it's set in the time passes handler
        -- , saveGameTimer = Timer.create
        -- , gameState = NoGameSelected
        -- , pointerState = Nothing
        -- , activeAcademicTestCategory = Quiz
        -- , maybeServerInfo = Nothing
        -- }
    in
    ( initialModel
    , Cmd.batch
        [ Task.perform HandleGetViewportResult Browser.Dom.getViewport
        , loginCmd
        ]
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
                        Preview ( a, _ ) ->
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


setIsVisible : Bool -> { a | isVisible : Bool } -> { a | isVisible : Bool }
setIsVisible isVisible model =
    { model | isVisible = isVisible }


setActiveModal : Maybe Modal -> InGameFrontend -> InGameFrontend
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


setTab : Tab -> InGameFrontend -> InGameFrontend
setTab tab model =
    { model | activeTab = tab }


setIsDrawerOpen : Bool -> InGameFrontend -> InGameFrontend
setIsDrawerOpen isOpen model =
    { model | isDrawerOpen = isOpen }


mapGame : (Game -> Game) -> InGameFrontend -> InGameFrontend
mapGame fn model =
    case model.gameState of
        Playing _ ->
            let
                ( gameId, oldSnapshot ) =
                    Nonempty.head model.games

                newGame : Game
                newGame =
                    fn (Snapshot.getValue oldSnapshot)

                newSnapshot : Snapshot Game
                newSnapshot =
                    Snapshot.map (\_ -> newGame) oldSnapshot

                newGames : Nonempty ( Id GameId, Snapshot Game )
                newGames =
                    Nonempty.replaceHead ( gameId, newSnapshot ) model.games
            in
            { model | games = newGames }

        _ ->
            model


setSaveGameTimer : Timer -> InGameFrontend -> InGameFrontend
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
standardTick : Snapshot.Tick ( Game, List Toast, Bool )
standardTick =
    let
        mapGameAndToasts : Duration -> ( Game, List Toast, Bool ) -> ( Game, List Toast, Bool )
        mapGameAndToasts duration ( oldGame, oldToasts, _ ) =
            let
                { game, toasts, bustCache } =
                    Game.tick duration oldGame
            in
            ( game, oldToasts ++ toasts, bustCache )
    in
    Snapshot.createTick (Duration.milliseconds 15) mapGameAndToasts


{-| A performant tick for using when you need to progress the game quickly and don't care about animation at all.

The tradeoffs are:
a) with a larger interval between ticks there's a higher chance that e.g. a timer completes twice in one tick. This potentially causes inaccuracy when
calculating bonuses the player earned after actions completing

b) animations won't look right if the tick duration is longer than an animation frame in the browser which this one could be depending on Duration passed.

This tick also discards the toasts generated by Game.tick.

-}
performantTick : Duration -> Snapshot.Tick Game
performantTick duration =
    Snapshot.createTick duration
        (\d oldGame ->
            let
                { game } =
                    Game.tick d oldGame
            in
            game
        )


setPreview : Maybe Preview -> InGameFrontend -> InGameFrontend
setPreview maybePreview model =
    { model | preview = maybePreview }


setActivityExpanded : Bool -> InGameFrontend -> InGameFrontend
setActivityExpanded activityExpanded model =
    { model | activityExpanded = activityExpanded }


getActivity : InGameFrontend -> Maybe ( Activity, Timer )
getActivity model =
    (Snapshot.getValue (getGame model)).activity


setActivity : Maybe ( Activity, Timer ) -> InGameFrontend -> InGameFrontend
setActivity newActivity =
    mapGame (Game.setActivity newActivity)


updatePointerLoaded : Float -> InGameFrontend -> ( FrontendModel, Cmd FrontendMsg )
updatePointerLoaded delta inGameFrontend =
    case inGameFrontend.pointerState of
        Nothing ->
            ( InGame inGameFrontend, Cmd.none )

        Just { click, longPress } ->
            case longPress of
                Nothing ->
                    ( InGame inGameFrontend, Cmd.none )

                Just ( timer, floatDuration, longPressMsg ) ->
                    let
                        ( newTimer, completions ) =
                            Timer.increment (Duration.milliseconds floatDuration) (Duration.milliseconds delta) timer
                    in
                    if completions > 0 then
                        updateInGame longPressMsg { inGameFrontend | pointerState = Nothing }

                    else
                        ( InGame
                            { inGameFrontend
                                | pointerState =
                                    Just
                                        { click = click
                                        , longPress = Just ( newTimer, floatDuration, longPressMsg )
                                        }
                            }
                        , Cmd.none
                        )


setGameState : FrontendInGameState -> InGameFrontend -> InGameFrontend
setGameState gameState model =
    { model | gameState = gameState }


update : FrontendMsg -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
update msg model =
    case model of
        Loading _ ->
            ( model, Cmd.none )

        MainMenu mainMenu ->
            updateMainMenu msg mainMenu

        InGame loaded ->
            updateInGame msg loaded


updateMainMenu : FrontendMsg -> MainMenuFrontend -> ( FrontendModel, Cmd FrontendMsg )
updateMainMenu msg mainMenuFrontend =
    let
        noOp : ( FrontendModel, Cmd FrontendMsg )
        noOp =
            ( MainMenu mainMenuFrontend, Cmd.none )
    in
    case msg of
        HandleCreateGameClick ->
            ( MainMenu mainMenuFrontend, Lamdera.sendToBackend CreateGameRequest )

        HandleCreateUserClick ->
            case mainMenuFrontend.user.loginStatus of
                NotLoggedIn _ ->
                    case EmailAddress.fromString mainMenuFrontend.emailFormValue of
                        Just emailAddress ->
                            let
                                newLoginStatus : LoginStatus
                                newLoginStatus =
                                    LoginStatusPending

                                oldFrontendUser : FrontendUser
                                oldFrontendUser =
                                    mainMenuFrontend.user

                                newFrontendUser : FrontendUser
                                newFrontendUser =
                                    { oldFrontendUser | loginStatus = newLoginStatus }
                            in
                            ( MainMenu { mainMenuFrontend | user = newFrontendUser }
                            , Lamdera.sendToBackend (RegisterEmailRequest mainMenuFrontend.route emailAddress)
                            )

                        _ ->
                            noOp

                _ ->
                    noOp

        HandleLogInClick ->
            case mainMenuFrontend.user.loginStatus of
                NotLoggedIn _ ->
                    case EmailAddress.fromString mainMenuFrontend.emailFormValue of
                        Just emailAddress ->
                            let
                                newLoginStatus : LoginStatus
                                newLoginStatus =
                                    LoginStatusPending

                                oldFrontendUser : FrontendUser
                                oldFrontendUser =
                                    mainMenuFrontend.user

                                newFrontendUser : FrontendUser
                                newFrontendUser =
                                    { oldFrontendUser | loginStatus = newLoginStatus }
                            in
                            ( MainMenu { mainMenuFrontend | user = newFrontendUser }
                            , Lamdera.sendToBackend (LoginWithEmailRequest mainMenuFrontend.route emailAddress)
                            )

                        _ ->
                            noOp

                _ ->
                    noOp

        -- | HandleStartGameClick { index : Int } -- Only relevant when MainMenuState has user games
        -- | HandleEmailInput String
        HandleStartGameClick args ->
            ( MainMenu mainMenuFrontend, Task.perform (HandleStartGameClickWithTime args) Time.now )

        HandleStartGameClickWithTime { index } now ->
            case List.Extra.getAt index mainMenuFrontend.games of
                Just activeGameAndSnapshot ->
                    let
                        restOfGames : List ( Id GameId, Snapshot Game )
                        restOfGames =
                            List.Extra.removeAt index mainMenuFrontend.games

                        inGameGames : Nonempty ( Id GameId, Snapshot Game )
                        inGameGames =
                            Nonempty activeGameAndSnapshot restOfGames

                        game : Snapshot Game
                        game =
                            Nonempty.head inGameGames |> Tuple.second

                        isVisible : Bool
                        isVisible =
                            mainMenuFrontend.isVisible

                        newInGameFrontend : InGameFrontend
                        newInGameFrontend =
                            { key = mainMenuFrontend.key
                            , user = mainMenuFrontend.user
                            , route = mainMenuFrontend.route
                            , routeToken = mainMenuFrontend.routeToken
                            , isVisible = isVisible
                            , games = inGameGames
                            , gameState = FastForward { original = game, current = game, whenItStarted = now }
                            , maybeServerInfo = mainMenuFrontend.maybeServerInfo
                            , lastFastForwardDuration = Nothing
                            , showDebugPanel = False
                            , toastQueue = ToastQueue.create
                            , isDrawerOpen = False
                            , activeTab = Config.flags.defaultTab
                            , preview = Nothing
                            , activityExpanded = False
                            , activeModal = Nothing
                            , saveGameTimer = Timer.create
                            , pointerState = Nothing
                            , combat = IdleGame.CombatWrapper.init
                            }
                    in
                    -- set game and fast forward
                    ( InGame newInGameFrontend, Task.perform HandleFastForward Time.now )

                Nothing ->
                    noOp

        HandleEmailInput emailFormValue ->
            ( MainMenu { mainMenuFrontend | emailFormValue = emailFormValue }, Cmd.none )

        HandleLogoutClick ->
            ( MainMenu mainMenuFrontend, Lamdera.sendToBackend LogoutRequest )

        _ ->
            ( MainMenu mainMenuFrontend, Cmd.none )


updateInGame : FrontendMsg -> InGameFrontend -> ( FrontendModel, Cmd FrontendMsg )
updateInGame msg inGameFrontend =
    let
        noOp =
            ( InGame inGameFrontend, Cmd.none )
    in
    case msg of
        NoOp ->
            noOp

        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    let
                        route =
                            Route.decode url
                                |> Maybe.map Tuple.first
                                |> Maybe.withDefault Route.RootRoute
                    in
                    ( InGame { inGameFrontend | route = route }
                    , Browser.Navigation.pushUrl inGameFrontend.key (Route.encode route)
                    )

                External url ->
                    ( InGame inGameFrontend, Browser.Navigation.load url )

        UrlChanged url ->
            let
                route =
                    Route.decode url
                        |> Maybe.map Tuple.first
                        |> Maybe.withDefault Route.RootRoute
            in
            ( InGame { inGameFrontend | route = route }
            , Cmd.none
            )

        -- InitializeGame serverSnapshot now ->
        --     let
        --         adjustedServerSnapshot : Snapshot Game
        --         adjustedServerSnapshot =
        --             Snapshot.dEBUG_addTime (Quantity.negate Config.flags.extraFastForwardTime) serverSnapshot
        --     in
        --     case model.gameState of
        --         NoGameSelected ->
        --             ( model
        --                 |> setGameState
        --                     (FastForward
        --                         { original = adjustedServerSnapshot
        --                         , current = adjustedServerSnapshot
        --                         , whenItStarted = now
        --                         }
        --                     )
        --             , Task.perform HandleFastForward Time.now
        --             )
        --         _ ->
        HandleGoToMainMenuClick ->
            let
                mainMenuRoute : MainMenuRoute
                mainMenuRoute =
                    MainMenuAnonymousPlay

                mainMenuFrontend : MainMenuFrontend
                mainMenuFrontend =
                    { key = inGameFrontend.key
                    , route = inGameFrontend.route
                    , routeToken = inGameFrontend.routeToken
                    , isVisible = inGameFrontend.isVisible
                    , emailFormValue = ""
                    , user = inGameFrontend.user
                    , games = Nonempty.toList inGameFrontend.games
                    , maybeServerInfo = inGameFrontend.maybeServerInfo
                    , mainMenuRoute = mainMenuRoute
                    }
            in
            ( MainMenu mainMenuFrontend
            , Cmd.none
            )

        OpenDebugPanel ->
            ( InGame { inGameFrontend | showDebugPanel = True }
              -- We added this sleep + focus commands here to try to give focus to the debug panel after it's opened.
              -- It doesn't work for some reason but keeping it here in case I ever figure out why not.
            , Process.sleep 100
                |> Task.andThen (\_ -> Browser.Dom.focus DebugPanel.panelId)
                |> Task.attempt (\_ -> NoOp)
            )

        ClosePreview ->
            ( InGame
                (inGameFrontend
                    |> setPreview Nothing
                )
            , Cmd.none
            )

        CollapseActivity ->
            ( InGame
                (inGameFrontend
                    |> setActivityExpanded False
                )
            , Cmd.none
            )

        ExpandActivity ->
            ( InGame
                (inGameFrontend
                    |> setActivityExpanded True
                )
            , Cmd.none
            )

        CollapseDetailView ->
            ( InGame
                (inGameFrontend
                    |> setActivityExpanded False
                )
            , Cmd.none
            )

        ExpandDetailView ->
            ( InGame
                (inGameFrontend
                    |> setActivityExpanded True
                )
            , Cmd.none
            )

        CloseDebugPanel ->
            ( InGame { inGameFrontend | showDebugPanel = False }, Cmd.none )

        AddToast toast now ->
            ( InGame { inGameFrontend | toastQueue = ToastQueue.addToast toast now inGameFrontend.toastQueue }, Cmd.none )

        HandleFastForward now ->
            case inGameFrontend.gameState of
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
                                Snapshot.tickUntil (performantTick timeToAdd) nextInterval current
                        in
                        ( InGame
                            (inGameFrontend
                                |> setGameState
                                    (FastForward { original = original, current = newSnap, whenItStarted = whenItStarted })
                            )
                        , Task.perform HandleFastForward (Process.sleep sleepTime |> Task.andThen (\_ -> Time.now))
                        )

                    else
                        -- run calculation to completion
                        let
                            newSnapshot : Snapshot Game
                            newSnapshot =
                                Snapshot.tickUntil (performantTick (Duration.minutes 1)) now current

                            newGame : Game
                            newGame =
                                Snapshot.getValue newSnapshot

                            newCache : Cache
                            newCache =
                                getCache newGame

                            newModal =
                                if Config.flags.debugTimePasses then
                                    Just IdleGame.Mocks.timePassesModal

                                else
                                    createTimePassesModal (Duration.milliseconds (toFloat (Time.posixToMillis now - Time.posixToMillis whenItStarted))) original newSnapshot
                        in
                        ( InGame
                            (inGameFrontend
                                |> setGameState (Playing newCache)
                                |> setGame newSnapshot
                                |> setActiveModal newModal
                            )
                        , Cmd.none
                        )

                _ ->
                    -- Shouldn't normally happen
                    noOp

        HandleSyllabusClick skill ->
            ( InGame
                (inGameFrontend
                    |> setActiveModal (Just (SyllabusModal skill))
                )
            , Cmd.none
            )

        HandleActivityClick { screenWidth } kind ->
            let
                currentActivity : Maybe ( Activity, Timer )
                currentActivity =
                    getActivity inGameFrontend

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
                ( InGame
                    (inGameFrontend
                        |> setActivity newActivity
                        |> setActivityExpanded (not clickingActiveActivity)
                    )
                , Cmd.none
                )

            else
                ( InGame
                    (inGameFrontend
                        |> setActivity newActivity
                        |> setActivityExpanded False
                    )
                , Cmd.none
                )

        HandlePreviewClick activity ->
            case inGameFrontend.gameState of
                Playing cachedActivityEffects ->
                    let
                        currentActivity : Maybe ( Activity, Timer )
                        currentActivity =
                            (Snapshot.getValue (getGame inGameFrontend)).activity

                        clickingActiveActivity : Bool
                        clickingActiveActivity =
                            case currentActivity of
                                Just ( k, _ ) ->
                                    k == activity

                                Nothing ->
                                    False
                    in
                    ( InGame
                        (inGameFrontend
                            |> setPreview (Just (Preview ( activity, getByActivity activity cachedActivityEffects )))
                            |> setActivityExpanded
                                (if clickingActiveActivity then
                                    True

                                 else
                                    False
                                )
                        )
                    , Cmd.none
                    )

                _ ->
                    noOp

        HandlePlayClick kind ->
            ( InGame
                (inGameFrontend
                    |> setActivity (Just ( kind, Timer.create ))
                    |> setPreview Nothing
                    |> setActivityExpanded True
                )
            , Cmd.none
            )

        HandleStopClick kind ->
            case inGameFrontend.gameState of
                Playing cachedActivityEffects ->
                    ( InGame
                        (inGameFrontend
                            |> setActivity Nothing
                            |> setPreview (Just (Preview ( kind, getByActivity kind cachedActivityEffects )))
                        )
                    , Cmd.none
                    )

                _ ->
                    noOp

        SetDrawerOpen newValue ->
            ( InGame
                (inGameFrontend
                    |> setIsDrawerOpen newValue
                )
            , Cmd.none
            )

        HandleAnimationFrameDelta delta ->
            case inGameFrontend.gameState of
                Playing _ ->
                    let
                        ( newTimer, saveGameTimerTriggered ) =
                            Timer.increment (Duration.seconds 1) (Duration.milliseconds delta) inGameFrontend.saveGameTimer

                        shouldSaveGame : Bool
                        shouldSaveGame =
                            saveGameTimerTriggered > 0

                        ( gameId, snapshot ) =
                            Nonempty.head inGameFrontend.games

                        saveGameCmd : List (Cmd FrontendMsg)
                        saveGameCmd =
                            if shouldSaveGame then
                                [ Lamdera.sendToBackend (SaveGame gameId snapshot) ]

                            else
                                []

                        modelWithSaveTimer : InGameFrontend
                        modelWithSaveTimer =
                            inGameFrontend
                                |> setSaveGameTimer newTimer

                        ( modelWithUpdatedPointer, pointerCmds ) =
                            updatePointerLoaded delta modelWithSaveTimer
                    in
                    ( modelWithUpdatedPointer, Cmd.batch <| saveGameCmd ++ [ pointerCmds ] )

                _ ->
                    noOp

        HandleAnimationFrame now ->
            case inGameFrontend.gameState of
                FastForward _ ->
                    -- During FastForward there's a recursive set of Cmds updating the snapshot, no work needs to be done in animationFrame explicitly
                    noOp

                Playing cache ->
                    if not inGameFrontend.isVisible then
                        -- If the app is not visible we shouldn't do any work
                        noOp

                    else
                        let
                            oldSnapshot : Snapshot ( Game, List Toast, Bool )
                            oldSnapshot =
                                getGame inGameFrontend
                                    |> Snapshot.map (\g -> ( g, [], False ))

                            updatedSnapshot : Snapshot ( Game, List Toast, Bool )
                            updatedSnapshot =
                                oldSnapshot
                                    |> Snapshot.tickUntil standardTick now

                            ( newGame, toasts, gameDidChange ) =
                                Snapshot.getValue updatedSnapshot

                            notificationCmds : List (Cmd FrontendMsg)
                            notificationCmds =
                                List.map (\toast -> Task.perform (AddToast toast) Time.now) toasts

                            newCache : Cache
                            newCache =
                                if gameDidChange then
                                    getCache newGame

                                else
                                    cache

                            newSnapshot : Snapshot Game
                            newSnapshot =
                                Snapshot.map (\_ -> newGame) updatedSnapshot

                            newGameState : FrontendInGameState
                            newGameState =
                                Playing newCache
                        in
                        ( InGame
                            (inGameFrontend
                                |> setGameState newGameState
                                |> setGame newSnapshot
                                |> setToastQueue (ToastQueue.updateToastQueue now inGameFrontend.toastQueue)
                            )
                        , Cmd.batch notificationCmds
                        )

        HandleVisibilityChange visibility ->
            ( InGame inGameFrontend, Task.perform (HandleVisibilityChangeHelp visibility) Time.now )

        HandleVisibilityChangeHelp visibility now ->
            if Config.flags.suppressVisibilityChanges then
                noOp

            else if visibility == Browser.Events.Visible then
                case inGameFrontend.gameState of
                    FastForward _ ->
                        ( InGame
                            (inGameFrontend
                                |> setIsVisible True
                            )
                        , Cmd.none
                        )

                    Playing _ ->
                        let
                            oldSnapshot : Snapshot Game
                            oldSnapshot =
                                getGame inGameFrontend
                        in
                        ( InGame
                            (inGameFrontend
                                |> setIsVisible True
                                |> setGameState (FastForward { original = oldSnapshot, current = oldSnapshot, whenItStarted = now })
                            )
                        , Task.perform HandleFastForward Time.now
                        )

            else
                ( InGame
                    (inGameFrontend
                        |> setIsVisible False
                    )
                , Cmd.none
                )

        CloseModal ->
            ( InGame
                (inGameFrontend
                    |> setActiveModal Nothing
                )
            , Cmd.none
            )

        HandleTabClick tab ->
            ( InGame
                (inGameFrontend
                    |> setTab tab
                    |> setIsDrawerOpen False
                )
            , Cmd.none
            )

        HandleShopUpgradeClick kind ->
            ( inGameFrontend
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
                |> InGame
            , Cmd.none
            )

        HandleShopResourceOpenBuyClick resource ->
            case (getResourceStats resource).buyPrice of
                Just price ->
                    ( InGame
                        { inGameFrontend
                            | activeModal = Just (ShopResourceBuyModal 1 resource price)
                        }
                    , Cmd.none
                    )

                Nothing ->
                    noOp

        HandleShopResourceOpenSellClick resource ->
            case (getResourceStats resource).sellPrice of
                Just price ->
                    ( InGame
                        { inGameFrontend | activeModal = Just (ShopResourceSellModal 1 resource price) }
                    , Cmd.none
                    )

                Nothing ->
                    noOp

        HandleShopResourceBuySubmit ->
            case inGameFrontend.activeModal of
                Just (ShopResourceBuyModal quantity resource _) ->
                    case inGameFrontend.gameState of
                        Playing _ ->
                            let
                                oldSnapshot : Snapshot Game
                                oldSnapshot =
                                    getGame inGameFrontend

                                oldGame : Game
                                oldGame =
                                    Snapshot.getValue oldSnapshot

                                purchaseResult : Result EffectErr Game.ApplyEffectsValue
                                purchaseResult =
                                    Game.attemptPurchaseResource quantity resource oldGame
                            in
                            case purchaseResult of
                                Ok res ->
                                    let
                                        newGame : Game
                                        newGame =
                                            res.game

                                        newCache : Cache
                                        newCache =
                                            getCache newGame

                                        toasts : List Toast
                                        toasts =
                                            res.toasts

                                        newModel : InGameFrontend
                                        newModel =
                                            { inGameFrontend | gameState = Playing newCache }
                                                |> setActiveModal Nothing
                                                |> setGame (Snapshot.map (\_ -> newGame) oldSnapshot)

                                        notificationCmds : List (Cmd FrontendMsg)
                                        notificationCmds =
                                            List.map (\toast -> Task.perform (AddToast toast) Time.now) toasts
                                    in
                                    ( InGame newModel, Cmd.batch notificationCmds )

                                Err _ ->
                                    -- We disable the buy button in this case so shouldn't normally reach this spot
                                    noOp

                        _ ->
                            noOp

                _ ->
                    noOp

        HandleShopResourceQuantityChange string ->
            case inGameFrontend.activeModal of
                Just (ShopResourceBuyModal _ resource price) ->
                    let
                        maybeQuantity : Maybe Int
                        maybeQuantity =
                            String.toInt string
                    in
                    case maybeQuantity of
                        Just quantity ->
                            ( InGame
                                { inGameFrontend
                                    | activeModal = Just (ShopResourceBuyModal quantity resource price)
                                }
                            , Cmd.none
                            )

                        Nothing ->
                            noOp

                _ ->
                    noOp

        HandlePointerDown pointerState ->
            ( InGame { inGameFrontend | pointerState = Just pointerState }, Cmd.none )

        HandlePointerUp ->
            case inGameFrontend.pointerState of
                Nothing ->
                    ( InGame { inGameFrontend | pointerState = Nothing }, Cmd.none )

                Just { click } ->
                    updateInGame click { inGameFrontend | pointerState = Nothing }

        HandlePointerCancel ->
            ( InGame { inGameFrontend | pointerState = Nothing }, Cmd.none )

        AddTime amount ->
            ( InGame inGameFrontend, Task.perform (AddTimeHelp amount) Time.now )

        AddTimeHelp amount now ->
            case inGameFrontend.gameState of
                Playing _ ->
                    let
                        oldSnapshot : Snapshot Game
                        oldSnapshot =
                            getGame inGameFrontend

                        current : Snapshot Game
                        current =
                            Snapshot.dEBUG_addTime (Quantity.negate amount) oldSnapshot

                        fastForwardState : FastForwardState
                        fastForwardState =
                            { original = current, current = current, whenItStarted = now }
                    in
                    ( InGame
                        (inGameFrontend
                            |> setGameState (FastForward fastForwardState)
                        )
                    , Task.perform HandleFastForward Time.now
                    )

                _ ->
                    noOp

        HandleOneLessButtonClick ->
            case inGameFrontend.activeModal of
                Just (ShopResourceBuyModal quantity resource price) ->
                    ( InGame
                        { inGameFrontend
                            | activeModal = Just (ShopResourceBuyModal (Basics.max 1 (quantity - 1)) resource price)
                        }
                    , Cmd.none
                    )

                Just (ShopResourceSellModal quantity resource price) ->
                    ( InGame
                        { inGameFrontend
                            | activeModal = Just (ShopResourceSellModal (Basics.max 1 (quantity - 1)) resource price)
                        }
                    , Cmd.none
                    )

                _ ->
                    noOp

        HandleOneMoreButtonClick ->
            case inGameFrontend.activeModal of
                Just (ShopResourceBuyModal quantity resource price) ->
                    ( InGame
                        { inGameFrontend
                            | activeModal = Just (ShopResourceBuyModal (quantity + 1) resource price)
                        }
                    , Cmd.none
                    )

                Just (ShopResourceSellModal quantity resource price) ->
                    ( InGame
                        { inGameFrontend
                            | activeModal = Just (ShopResourceSellModal (quantity + 1) resource price)
                        }
                    , Cmd.none
                    )

                _ ->
                    noOp

        HandleMinButtonClick ->
            case inGameFrontend.activeModal of
                Just (ShopResourceBuyModal _ resource price) ->
                    ( InGame
                        { inGameFrontend
                            | activeModal = Just (ShopResourceBuyModal 1 resource price)
                        }
                    , Cmd.none
                    )

                Just (ShopResourceSellModal quantity resource price) ->
                    ( InGame
                        { inGameFrontend
                            | activeModal = Just (ShopResourceSellModal 1 resource price)
                        }
                    , Cmd.none
                    )

                _ ->
                    noOp

        HandleMaxButtonClick ->
            case inGameFrontend.activeModal of
                Just (ShopResourceBuyModal _ resource price) ->
                    case inGameFrontend.gameState of
                        Playing _ ->
                            let
                                oldSnapshot : Snapshot Game
                                oldSnapshot =
                                    getGame inGameFrontend

                                game : Game
                                game =
                                    Snapshot.getValue oldSnapshot

                                maxPurchase : Int
                                maxPurchase =
                                    Game.getMaxPurchase price game
                                        |> Basics.max 1
                            in
                            ( InGame
                                { inGameFrontend
                                    | activeModal = Just (ShopResourceBuyModal maxPurchase resource price)
                                }
                            , Cmd.none
                            )

                        _ ->
                            noOp

                Just (ShopResourceSellModal quantity resource price) ->
                    case inGameFrontend.gameState of
                        Playing _ ->
                            let
                                oldSnapshot : Snapshot Game
                                oldSnapshot =
                                    getGame inGameFrontend

                                game : Game
                                game =
                                    Snapshot.getValue oldSnapshot

                                maxPurchase : Int
                                maxPurchase =
                                    getByResource resource game.resources
                                        |> Basics.max 1
                            in
                            ( InGame
                                { inGameFrontend
                                    | activeModal = Just (ShopResourceSellModal maxPurchase resource price)
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
            ( InGame
                (inGameFrontend
                    |> setActivityExpanded expandedValue
                )
            , Cmd.none
            )

        AddCoins amount ->
            case inGameFrontend.gameState of
                Playing _ ->
                    let
                        oldSnapshot : Snapshot Game
                        oldSnapshot =
                            getGame inGameFrontend

                        oldGame : Game
                        oldGame =
                            Snapshot.getValue oldSnapshot

                        newCoin : Coin
                        newCoin =
                            Quantity.plus oldGame.coin (Coin.int amount)

                        newGame : Game
                        newGame =
                            { oldGame | coin = newCoin }

                        newSnapshot : Snapshot Game
                        newSnapshot =
                            Snapshot.map (\_ -> newGame) oldSnapshot

                        newCache : Cache
                        newCache =
                            getCache newGame

                        toast : Toast
                        toast =
                            GainedCoin (Coin.int amount)
                    in
                    ( InGame
                        (inGameFrontend
                            |> setGameState (Playing newCache)
                            |> setGame newSnapshot
                        )
                    , Task.perform (AddToast toast) Time.now
                    )

                _ ->
                    noOp

        CombatMsg combatMsg ->
            let
                ( newCombat, cmd ) =
                    IdleGame.CombatWrapper.update combatMsg inGameFrontend.combat
            in
            ( InGame { inGameFrontend | combat = newCombat }, cmd )

        _ ->
            noOp


toMainMenuFromInGame : { inGameFrontend : InGameFrontend, games : List ( Id GameId, Snapshot Game ) } -> FrontendModel
toMainMenuFromInGame { inGameFrontend, games } =
    MainMenu
        { key = inGameFrontend.key
        , route = inGameFrontend.route
        , routeToken = inGameFrontend.routeToken
        , isVisible = inGameFrontend.isVisible
        , emailFormValue = ""
        , user = inGameFrontend.user
        , games = games
        , maybeServerInfo = inGameFrontend.maybeServerInfo
        , mainMenuRoute = MainMenuAnonymousPlay
        }


attemptSelectByFn : (t -> Bool) -> List t -> Maybe ( t, List t )
attemptSelectByFn fn =
    List.Extra.select >> List.Extra.find (\( x, _ ) -> fn x)


updateInGameFromBackend : ToFrontend -> InGameFrontend -> ( FrontendModel, Cmd FrontendMsg )
updateInGameFromBackend msg inGameFrontend =
    let
        noOp : ( FrontendModel, Cmd FrontendMsg )
        noOp =
            ( InGame inGameFrontend, Cmd.none )
    in
    case msg of
        NoOpToFrontend ->
            noOp

        SetUserAndGames ( frontendUser, serverGamesList ) ->
            let
                activeGameId : Id GameId
                activeGameId =
                    Nonempty.head inGameFrontend.games |> Tuple.first

                isActiveGame : ( Id GameId, Snapshot Game ) -> Bool
                isActiveGame ( gameId, _ ) =
                    gameId == activeGameId
            in
            case attemptSelectByFn isActiveGame serverGamesList of
                Just ( activeGame, restGames ) ->
                    ( InGame { inGameFrontend | games = Nonempty activeGame restGames, user = frontendUser }, Cmd.none )

                Nothing ->
                    -- In thise case the server sent back a list of games not including the active game.
                    -- Not sure why this would happen but only sensible thing to do is return to MainMenu.
                    ( toMainMenuFromInGame { inGameFrontend = inGameFrontend, games = serverGamesList }, Cmd.none )

        GiveServerInfo serverInfo ->
            ( InGame { inGameFrontend | maybeServerInfo = Just serverInfo }, Cmd.none )


updateMainMenuFromBackend : ToFrontend -> MainMenuFrontend -> ( FrontendModel, Cmd FrontendMsg )
updateMainMenuFromBackend msg mainMenuFrontend =
    let
        noOp : ( FrontendModel, Cmd FrontendMsg )
        noOp =
            ( MainMenu mainMenuFrontend, Cmd.none )
    in
    case msg of
        NoOpToFrontend ->
            noOp

        SetUserAndGames ( user, games ) ->
            ( MainMenu { mainMenuFrontend | user = user, games = games }, Cmd.none )

        GiveServerInfo serverInfo ->
            ( MainMenu { mainMenuFrontend | maybeServerInfo = Just serverInfo }, Cmd.none )


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    case model of
        Loading loadingFrontend ->
            case msg of
                SetUserAndGames ( user, games ) ->
                    case games of
                        firstGame :: restGames ->
                            -- Auto-load the player into their first game
                            let
                                inGameGames : Nonempty ( Id GameId, Snapshot Game )
                                inGameGames =
                                    Nonempty firstGame restGames

                                game : Snapshot Game
                                game =
                                    Tuple.second firstGame

                                newInGameFrontend : InGameFrontend
                                newInGameFrontend =
                                    { key = loadingFrontend.key
                                    , user = user
                                    , route = loadingFrontend.route
                                    , routeToken = loadingFrontend.routeToken
                                    , isVisible = loadingFrontend.isVisible
                                    , games = inGameGames
                                    , gameState = FastForward { original = game, current = game, whenItStarted = Time.millisToPosix 0 }
                                    , maybeServerInfo = loadingFrontend.maybeServerInfo
                                    , lastFastForwardDuration = Nothing
                                    , showDebugPanel = False
                                    , toastQueue = ToastQueue.create
                                    , isDrawerOpen = False
                                    , activeTab = Config.flags.defaultTab
                                    , preview = Nothing
                                    , activityExpanded = False
                                    , activeModal = Nothing
                                    , saveGameTimer = Timer.create
                                    , pointerState = Nothing
                                    , combat = IdleGame.CombatWrapper.init
                                    }
                            in
                            ( InGame newInGameFrontend, Task.perform HandleFastForward Time.now )

                        [] ->
                            -- No games, so go to MainMenu as usual
                            ( MainMenu
                                { key = loadingFrontend.key
                                , route = loadingFrontend.route
                                , routeToken = loadingFrontend.routeToken
                                , isVisible = loadingFrontend.isVisible
                                , emailFormValue = ""
                                , user = user
                                , games = games
                                , maybeServerInfo = loadingFrontend.maybeServerInfo
                                , mainMenuRoute = MainMenuAnonymousPlay
                                }
                            , Cmd.none
                            )

                GiveServerInfo serverInfo ->
                    ( Loading { loadingFrontend | maybeServerInfo = Just serverInfo }, Cmd.none )

                _ ->
                    -- Shouldn't happen
                    ( model, Cmd.none )

        MainMenu mainMenuFrontend ->
            updateMainMenuFromBackend msg mainMenuFrontend

        InGame inGameFrontend ->
            updateInGameFromBackend msg inGameFrontend


subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onAnimationFrameDelta HandleAnimationFrameDelta
        , Browser.Events.onVisibilityChange HandleVisibilityChange
        ]


toastToHtml : Toast -> Html FrontendMsg
toastToHtml notification =
    let
        baseClass : Html.Attribute msg
        baseClass =
            class "alert"

        successClass : Html.Attribute msg
        successClass =
            class "alert-success"

        errClass : Html.Attribute msg
        errClass =
            class "alert-error"

        warningClass : Html.Attribute msg
        warningClass =
            class "alert-warning"
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

        Just (ShopResourceBuyModal amount resource price) ->
            let
                children =
                    IdleGame.Views.ShopResourceModal.renderBuyModal game amount ( resource, price )
            in
            IdleGame.Views.ModalWrapper.create children
                |> IdleGame.Views.ModalWrapper.withBorderColor "border-primary"
                |> IdleGame.Views.ModalWrapper.render

        Just (ShopResourceSellModal amount resource price) ->
            let
                children =
                    IdleGame.Views.ShopResourceModal.renderSellModal game amount ( resource, price )
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


renderBottomRightItems : InGameFrontend -> Html FrontendMsg
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
        , case model of
            Loading _ ->
                div [] []

            MainMenu _ ->
                div [] []

            InGame frontend ->
                DebugPanel.render frontend
        , case model of
            Loading _ ->
                div [] [ text "Loading" ]

            MainMenu mainMenuFrontend ->
                case mainMenuFrontend.route of
                    Route.ServerInfoRoute ->
                        ServerInfo.render mainMenuFrontend.maybeServerInfo

                    Route.RootRoute ->
                        MainMenu.render mainMenuFrontend

            InGame frontend ->
                case frontend.route of
                    Route.ServerInfoRoute ->
                        ServerInfo.render frontend.maybeServerInfo

                    Route.RootRoute ->
                        case frontend.gameState of
                            FastForward _ ->
                                IdleGame.Views.FastForward.render

                            Playing cache ->
                                let
                                    snapshot : Snapshot Game
                                    snapshot =
                                        getGame frontend

                                    game : Game
                                    game =
                                        Snapshot.getValue snapshot

                                    detailViewState : IdleGame.Views.DetailViewWrapper.State ( Activity, Timer ) Preview
                                    detailViewState =
                                        getDetailViewState game.activity frontend.preview frontend.activityExpanded

                                    extraBottomPadding : Bool
                                    extraBottomPadding =
                                        case detailViewState of
                                            IdleGame.Views.DetailViewWrapper.PreviewWithActivity _ _ ->
                                                True

                                            _ ->
                                                False

                                    renderActivity : ( Activity, Timer ) -> Html FrontendMsg
                                    renderActivity ( activity, timer ) =
                                        IdleGame.Views.DetailViewContent.renderContent (IdleGame.Views.DetailViewContent.DetailViewActivity ( ( activity, getByActivity activity cache ), timer )) extraBottomPadding game

                                    renderPreview : Preview -> Html FrontendMsg
                                    renderPreview preview =
                                        IdleGame.Views.DetailViewContent.renderContent (IdleGame.Views.DetailViewContent.DetailViewPreview preview) extraBottomPadding game

                                    renderStatusBar : ( Activity, Timer ) -> Html FrontendMsg
                                    renderStatusBar activity =
                                        IdleGame.Views.DetailViewContent.renderStatusBar activity

                                    activeTab : Tab
                                    activeTab =
                                        frontend.activeTab

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
                                    [ ToastQueue.render toastToHtml frontend.toastQueue
                                    , div [ class "bg-base-100 drawer lg:drawer-open" ]
                                        [ input
                                            [ id "drawer"
                                            , type_ "checkbox"
                                            , class "drawer-toggle"
                                            , checked frontend.isDrawerOpen
                                            , onCheck SetDrawerOpen
                                            ]
                                            []
                                        , IdleGame.Views.Content.renderContent frontend game cache frontend.activeTab
                                        , IdleGame.Views.Drawer.renderDrawer frontend.isDrawerOpen frontend.activeTab
                                        ]
                                    , IdleGame.Views.DetailViewWrapper.renderFullScreen detailViewWrapperProps
                                    , IdleGame.Views.DetailViewWrapper.renderSidebar detailViewWrapperProps
                                    , renderModal frontend.activeModal game
                                    , renderBottomRightItems frontend
                                    ]
        ]
    }


getCache : Game -> Cache
getCache game =
    let
        mods : List EffectMod
        mods =
            Game.getAllMods game
    in
    Activity.createRecordByFn
        (\activity ->
            let
                activityEffects : List Effect
                activityEffects =
                    Activity.getActivityEffects activity
            in
            List.map
                (\effect ->
                    Tuple.first (Mod.applyModsToEffect mods effect)
                )
                activityEffects
        )
