module Types exposing (..)

import AssocList as Dict exposing (Dict)
import AssocSet as Set exposing (Set)
import BiDict.Assoc exposing (BiDict)
import Browser exposing (UrlRequest)
import Browser.Dom
import Browser.Events
import Browser.Navigation exposing (Key)
import Duration exposing (Duration)
import EmailAddress exposing (EmailAddress)
import Http
import Id exposing (GameId, Id, LoginToken, UserId)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.OneTime as OneTime
import IdleGame.Resource as Resource
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer exposing (Timer)
import IdleGame.Xp as Xp exposing (Xp)
import Lamdera exposing (ClientId, SessionId)
import List.Nonempty exposing (Nonempty)
import Postmark
import Random
import Route exposing (Route)
import Time exposing (Posix)
import Url exposing (Url)


type alias TimePassesResourceGain =
    { amount : Int
    , title : String
    }


type alias TimePassesResourceLoss =
    { amount : Int
    , title : String
    }


type alias TimePassesXpGain =
    { originalXp : Xp
    , currentXp : Xp
    , skill : Skill
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Coin
    , resourcesDiff : Resource.Diff
    }


type alias Game =
    { seed : Random.Seed
    , xp : SkillRecord Xp
    , mxp : ActivityRecord Xp
    , activity : Maybe ( Activity, Timer )
    , coin : Coin
    , resources : ResourceRecord Int
    , ownedShopUpgrades : ShopUpgradeRecord Bool
    , oneTimeStatuses : OneTime.OneTimeRecord Bool
    }


type Modal
    = TimePassesModal Duration Posix TimePassesData
    | ShopResourceModal Int Resource Coin
    | SyllabusModal Skill


type alias FastForwardState =
    { original : Snapshot Game
    , current : Snapshot Game
    , whenItStarted : Posix -- the time when fast forward began, to calculate how long it takes
    }


type FrontendInGameState
    = Playing Cache
    | FastForward FastForwardState


type Preview
    = Preview ( Activity, List Effect )


type alias PointerState =
    { longPress : Maybe ( Timer, Float, FrontendMsg ) -- If defined the long press has a timer, a Float duration (in ms), and a FrontendMsg to send when the timer fires
    , click : FrontendMsg -- The click message to send when the pointer is released if a long press isn't detected
    }


type LocationFilter
    = LocationAll
    | LocationMonsters
    | LocationQuests


type FrontendModel
    = Loading LoadingFrontend
    | MainMenu MainMenuFrontend
    | InGame InGameFrontend


type alias LoadingFrontend =
    { key : Key
    , route : Route
    , routeToken : Route.Token
    , isVisible : Bool
    , maybeServerInfo : Maybe ServerInfo
    }


{-| See AuthenticationStatus comment for differences between that and LoginStatus
-}
type LoginStatus
    = NotLoggedIn UnauthenticatedUser
    | LoginStatusPending -- The user is either waiting for registration email or login email flow to resolve
    | LoggedIn AuthenticatedUser


type
    MainMenuRoute
    -- = MainMenuGatekeeper -- Asks you whether you want to log in or start an unauthenticated game
    -- | MainMenuLogin -- Asks you to log in
    -- | MainMenuGameList -- Lists your games lets you start a new one
    = MainMenuAnonymousPlay


type alias MainMenuFrontend =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , route : Route
    , routeToken : Route.Token
    , isVisible : Bool
    , emailFormValue : String -- This is only relevant when the user is unauthenticated
    , user : FrontendUser
    , games : List ( Id GameId, Snapshot Game )
    , maybeServerInfo : Maybe ServerInfo
    , mainMenuRoute : MainMenuRoute
    }


type alias InGameFrontend =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , user : FrontendUser -- n.b. could be Authenticated or Unauthenticated
    , route : Route
    , routeToken : Route.Token
    , isVisible : Bool
    , games : Nonempty ( Id GameId, Snapshot Game ) -- Since we're "In Game", there will always be at least one game and it will always be the head of the Nonempty
    , gameState : FrontendInGameState
    , maybeServerInfo : Maybe ServerInfo
    , lastFastForwardDuration : Maybe Duration -- Used to display fast forward times for debugging and optimization
    , showDebugPanel : Bool
    , toastQueue : ToastQueue
    , isDrawerOpen : Bool
    , activeTab : Tab
    , preview : Maybe Preview
    , activityExpanded : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Timer
    , pointerState : Maybe PointerState -- Tracks the state of the pointer (mouse or touch) for long press detection
    }


getGame : InGameFrontend -> Snapshot Game
getGame inGameFrontend =
    let
        ( _, game ) =
            List.Nonempty.head inGameFrontend.games
    in
    game


setGame : Snapshot Game -> InGameFrontend -> InGameFrontend
setGame newSnapshot model =
    let
        ( gameId, _ ) =
            List.Nonempty.head model.games
    in
    { model | games = List.Nonempty.replaceHead ( gameId, newSnapshot ) model.games }


setToastQueue : ToastQueue -> InGameFrontend -> InGameFrontend
setToastQueue newToastQueue model =
    { model | toastQueue = newToastQueue }



-- Backend


type alias ServerInfo =
    { users : Dict (Id UserId) BackendUser
    , sessions : BiDict SessionId (Id UserId)
    , connections : Dict SessionId (Nonempty ClientId)
    }


type alias BackendModel =
    -- For approximateTime, we'd like to update it every millisecond but it would generate too many backend events.
    -- Instead we update it periodically (every 15 seconds)
    { approximateTime : Time.Posix
    , secretCounter : Int
    , userGames : Dict (Id UserId) (List (Id GameId))
    , games : Dict (Id GameId) (Snapshot Game)
    , seed : Random.Seed
    , sessions : BiDict SessionId (Id UserId)
    , connections : Dict SessionId (Nonempty ClientId)
    , users : Dict (Id UserId) BackendUser
    , pendingLoginTokens : Dict (Id LoginToken) LoginTokenData
    }


type alias FrontendUser =
    { id : Id UserId
    , loginStatus : LoginStatus
    }


type alias BackendUser =
    { id : Id UserId
    , lastConnectionTime : Time.Posix
    , authentication : AuthenticationStatus
    }


{-| AuthenticationStatus refers to whether the user has provided an email and confirmed it at least once.
This is different from the LoginStatus because a single user might have a different LoginStatus for each client,
but will always have only a single AuthenticationStatus. Therefore the BackendUser has an AuthenticationStatus
and the FrontendUser has a LoginStatus.
-}
type AuthenticationStatus
    = Authenticated AuthenticatedUser
    | AuthenticationPending EmailAddress UnauthenticatedUser
    | NotAuthenticated UnauthenticatedUser


type alias AuthenticatedUser =
    -- Attributes only relevant to an authenticated user. Things common to this and Unauthenticated go on FrontendUser or BackendUser
    { emailAddress : EmailAddress
    }


type alias UnauthenticatedUser =
    -- Attributes only relevant to an unauthenticated user. Things common to this and Authenticated go on FrontendUser or BackendUser
    {}


type
    ScreenWidth
    -- Represents the width of a screen in which the game is displayed
    = ScreenXs -- Screen width < 640px
    | ScreenSm
    | ScreenMd
    | ScreenLg
    | ScreenXl
    | Screen2xl -- Screen width >= 1536px


type FrontendMsg
    = NoOp
    | UrlClicked UrlRequest
    | UrlChanged Url
      -- Main Menu
    | HandleCreateGameClick
    | HandleCreateUserClick
    | HandleLogInClick
    | HandleStartGameClick { index : Int }
    | HandleStartGameClickWithTime { index : Int } Time.Posix -- Only relevant when MainMenuState has user games
    | HandleEmailInput String
    | HandleLogoutClick
      -- InGame meta stuff
    | HandleGoToMainMenuClick
      -- Detail View
    | ClosePreview
    | ExpandActivity
    | CollapseActivity
    | CollapseDetailView
    | ExpandDetailView
      -- Activities
    | HandleSyllabusClick Skill
    | HandleActivityClick { screenWidth : ScreenWidth } Activity
    | HandlePreviewClick Activity
    | HandlePlayClick Activity
    | HandleStopClick Activity
      -- Debug Panel
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration
    | AddTimeHelp Duration Posix
      -- Shop Resource Purchase modal
    | HandleShopResourceClick Resource -- Opens the modal
    | HandleOneLessButtonClick
    | HandleOneMoreButtonClick
    | HandleMinButtonClick
    | HandleMaxButtonClick
    | HandleShopResourceQuantityChange String
    | HandleShopResourceBuyClick
      -- Other
    | AddToast Toast Posix
    | HandleFastForward Posix
    | HandleAnimationFrame Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChangeHelp Browser.Events.Visibility Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | HandleTabClick Tab
    | HandleShopUpgradeClick ShopUpgrade
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
    | HandleGetViewportResult Browser.Dom.Viewport


type ToBackend
    = NoOpToBackend
      -- MainMenu
    | RegisterEmailRequest Route EmailAddress -- Unauthenticated users sense this to cause an authenticating email to be sent
    | LoginWithEmailRequest Route EmailAddress -- Same as RegisterEmailRequest but intended for authenticated users
    | LoginWithTokenRequest (Id LoginToken) -- Sent by the page when it it loaded with login hash in its url
    | LogoutRequest
    | CreateGameRequest
      -- InGame
    | SaveGame (Id GameId) (Snapshot Game)


type alias LoginTokenData =
    { creationTime : Time.Posix, emailAddress : EmailAddress }


type BackendMsg
    = NoOpBackend
    | BackendGotTime Time.Posix -- Updates "approximateTime" field on backend model
    | HandleConnect SessionId ClientId
    | HandleDisconnect SessionId ClientId
    | SentLoginEmail EmailAddress (Result Http.Error Postmark.PostmarkSendResponse)


type ToFrontend
    = NoOpToFrontend
    | SetUserAndGames ( FrontendUser, List ( Id GameId, Snapshot Game ) )
    | GiveServerInfo ServerInfo



-- Cache stuff


type alias Cache =
    ActivityRecord (List Effect)


type Log
    = LogLoginEmail Time.Posix (Result Http.Error Postmark.PostmarkSendResponse) EmailAddress



-- Toast Queue


type ToastQueueItem
    = ToastQueueItem Toast Time.Posix


type alias ToastQueue =
    List ToastQueueItem
