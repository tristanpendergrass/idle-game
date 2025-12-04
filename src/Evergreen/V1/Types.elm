module Evergreen.V1.Types exposing (..)

import AssocList
import BiDict.Assoc
import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation
import Duration
import Evergreen.V1.EmailAddress
import Evergreen.V1.Id
import Evergreen.V1.IdleGame.Coin
import Evergreen.V1.IdleGame.Kinds
import Evergreen.V1.IdleGame.OneTime
import Evergreen.V1.IdleGame.Snapshot
import Evergreen.V1.IdleGame.Tab
import Evergreen.V1.IdleGame.Timer
import Evergreen.V1.IdleGame.Xp
import Evergreen.V1.Percent
import Evergreen.V1.Postmark
import Evergreen.V1.Route
import Http
import Lamdera
import List.Nonempty
import Random
import Time
import Url


type alias AuthenticatedUser =
    { emailAddress : Evergreen.V1.EmailAddress.EmailAddress
    }


type alias UnauthenticatedUser =
    {}


type AuthenticationStatus
    = Authenticated AuthenticatedUser
    | AuthenticationPending Evergreen.V1.EmailAddress.EmailAddress UnauthenticatedUser
    | NotAuthenticated UnauthenticatedUser


type alias BackendUser =
    { id : Evergreen.V1.Id.Id Evergreen.V1.Id.UserId
    , lastConnectionTime : Time.Posix
    , authentication : AuthenticationStatus
    }


type alias ServerInfo =
    { users : AssocList.Dict (Evergreen.V1.Id.Id Evergreen.V1.Id.UserId) BackendUser
    , sessions : BiDict.Assoc.BiDict Lamdera.SessionId (Evergreen.V1.Id.Id Evergreen.V1.Id.UserId)
    , connections : AssocList.Dict Lamdera.SessionId (List.Nonempty.Nonempty Lamdera.ClientId)
    }


type alias LoadingFrontend =
    { key : Browser.Navigation.Key
    , route : Evergreen.V1.Route.Route
    , routeToken : Evergreen.V1.Route.Token
    , isVisible : Bool
    , maybeServerInfo : Maybe ServerInfo
    }


type LoginStatus
    = NotLoggedIn UnauthenticatedUser
    | LoginStatusPending
    | LoggedIn AuthenticatedUser


type alias FrontendUser =
    { id : Evergreen.V1.Id.Id Evergreen.V1.Id.UserId
    , loginStatus : LoginStatus
    }


type alias Game =
    { seed : Random.Seed
    , xp : Evergreen.V1.IdleGame.Kinds.SkillRecord Evergreen.V1.IdleGame.Xp.Xp
    , mxp : Evergreen.V1.IdleGame.Kinds.ActivityRecord Evergreen.V1.IdleGame.Xp.Xp
    , activity : Maybe ( Evergreen.V1.IdleGame.Kinds.Activity, Evergreen.V1.IdleGame.Timer.Timer )
    , coin : Evergreen.V1.IdleGame.Coin.Coin
    , resources : Evergreen.V1.IdleGame.Kinds.ResourceRecord Int
    , ownedShopUpgrades : Evergreen.V1.IdleGame.Kinds.ShopUpgradeRecord Bool
    , oneTimeStatuses : Evergreen.V1.IdleGame.OneTime.OneTimeRecord Bool
    , spellAssignments : Evergreen.V1.IdleGame.Kinds.ActivityRecord (Maybe Evergreen.V1.IdleGame.Kinds.Resource)
    , activeTab : Evergreen.V1.IdleGame.Tab.Tab
    }


type MainMenuRoute
    = MainMenuAnonymousPlay


type alias MainMenuFrontend =
    { key : Browser.Navigation.Key
    , route : Evergreen.V1.Route.Route
    , routeToken : Evergreen.V1.Route.Token
    , isVisible : Bool
    , emailFormValue : String
    , user : FrontendUser
    , games : List ( Evergreen.V1.Id.Id Evergreen.V1.Id.GameId, Evergreen.V1.IdleGame.Snapshot.Snapshot Game )
    , maybeServerInfo : Maybe ServerInfo
    , mainMenuRoute : MainMenuRoute
    }


type Tag
    = SkillTag Evergreen.V1.IdleGame.Kinds.Skill
    | ActivityTag Evergreen.V1.IdleGame.Kinds.Activity
    | ActivityCompleteTag


type alias Effect =
    { effect : EffectType
    , tags : List Tag
    , oneTimeStatus : Evergreen.V1.IdleGame.OneTime.OneTimeStatus
    }


type alias GainResourceParams =
    { base : Int
    , doublingChance : Evergreen.V1.Percent.Percent
    , resource : Evergreen.V1.IdleGame.Kinds.Resource
    }


type ReducedBy
    = ReducedByFlat Evergreen.V1.IdleGame.Kinds.Resource
    | ReducedByPercent Evergreen.V1.IdleGame.Kinds.Resource Evergreen.V1.Percent.Percent


type alias SpendResourceParams =
    { base : Int
    , resource : Evergreen.V1.IdleGame.Kinds.Resource
    , preservationChance : Evergreen.V1.Percent.Percent
    , reducedBy : Maybe ReducedBy
    }


type alias SellResourceParams =
    { base : Int
    , resource : Evergreen.V1.IdleGame.Kinds.Resource
    }


type alias GainXpParams =
    { base : Evergreen.V1.IdleGame.Xp.Xp
    , percentIncrease : Evergreen.V1.Percent.Percent
    , skill : Evergreen.V1.IdleGame.Kinds.Skill
    }


type alias GainMxpParams =
    { percentIncrease : Evergreen.V1.Percent.Percent
    , activity : Evergreen.V1.IdleGame.Kinds.Activity
    }


type alias GainCoinParams =
    { base : Evergreen.V1.IdleGame.Coin.Coin
    , percentIncrease : Evergreen.V1.Percent.Percent
    }


type EffectType
    = EffectNoOp
    | VariableSuccess
        { successProbability : Evergreen.V1.Percent.Percent
        , successEffects : List Effect
        , failureEffects : List Effect
        }
    | OneOf Effect (List Effect)
    | GainResource GainResourceParams
    | SpendResource SpendResourceParams
    | SellResource SellResourceParams
    | GainXp GainXpParams
    | GainMxp GainMxpParams
    | GainCoin GainCoinParams


type alias Cache =
    Evergreen.V1.IdleGame.Kinds.ActivityRecord
        { effects : List Effect
        , duration : Duration.Duration
        }


type alias FastForwardState =
    { original : Evergreen.V1.IdleGame.Snapshot.Snapshot ( Game, Cache )
    , current : Evergreen.V1.IdleGame.Snapshot.Snapshot ( Game, Cache )
    , whenItStarted : Time.Posix
    }


type FrontendInGameState
    = Playing
        { gameplayCache : Cache
        , viewCache : Cache
        }
    | FastForward FastForwardState


type Toast
    = GainedCoin Evergreen.V1.IdleGame.Coin.Coin
    | GainedResource Int Evergreen.V1.IdleGame.Kinds.Resource
    | SoldResource Int Evergreen.V1.IdleGame.Kinds.Resource Evergreen.V1.IdleGame.Coin.Coin
    | NegativeAmountErr
    | TestAlreadyCompleted
    | TestNotUnlocked


type ToastQueueItem
    = ToastQueueItem Toast Time.Posix


type alias ToastQueue =
    List ToastQueueItem


type Preview
    = Preview ( Evergreen.V1.IdleGame.Kinds.Activity, List Effect, Duration.Duration )


type alias TimePassesXpGain =
    { originalXp : Evergreen.V1.IdleGame.Xp.Xp
    , currentXp : Evergreen.V1.IdleGame.Xp.Xp
    , skill : Evergreen.V1.IdleGame.Kinds.Skill
    }


type alias ResourceDiff =
    Evergreen.V1.IdleGame.Kinds.ResourceRecord Int


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V1.IdleGame.Coin.Coin
    , resourcesDiff : ResourceDiff
    }


type Modal
    = TimePassesModal Duration.Duration Time.Posix TimePassesData
    | ShopResourceBuyModal Int Evergreen.V1.IdleGame.Kinds.Resource Evergreen.V1.IdleGame.Coin.Coin
    | ShopResourceSellModal Int Evergreen.V1.IdleGame.Kinds.Resource Evergreen.V1.IdleGame.Coin.Coin
    | SyllabusModal Evergreen.V1.IdleGame.Kinds.Skill


type ScreenWidth
    = ScreenXs
    | ScreenSm
    | ScreenMd
    | ScreenLg
    | ScreenXl
    | Screen2xl


type alias PointerState =
    { longPress : Maybe ( Evergreen.V1.IdleGame.Timer.Timer, Float, FrontendMsg )
    , click : FrontendMsg
    }


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | HandleCreateGameClick
    | HandleCreateUserClick
    | HandleLogInClick
    | HandleStartGameClick
        { index : Int
        }
    | HandleStartGameClickWithTime
        { index : Int
        }
        Time.Posix
    | HandleEmailInput String
    | HandleLogoutClick
    | HandleGoToMainMenuClick
    | ClosePreview
    | ExpandActivity
    | CollapseActivity
    | CollapseDetailView
    | ExpandDetailView
    | HandleSyllabusClick Evergreen.V1.IdleGame.Kinds.Skill
    | HandleActivityClick
        { screenWidth : ScreenWidth
        }
        Evergreen.V1.IdleGame.Kinds.Activity
    | HandlePreviewClick Evergreen.V1.IdleGame.Kinds.Activity
    | HandlePlayClick Evergreen.V1.IdleGame.Kinds.Activity
    | HandleStopClick Evergreen.V1.IdleGame.Kinds.Activity
    | HandleSpellAssignmentClick Evergreen.V1.IdleGame.Kinds.Activity Evergreen.V1.IdleGame.Kinds.Resource
    | HandleSpellUnassignClick Evergreen.V1.IdleGame.Kinds.Activity
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration
    | AddTimeHelp Duration.Duration Time.Posix
    | AddCoins Int
    | HandleShopResourceOpenBuyClick Evergreen.V1.IdleGame.Kinds.Resource
    | HandleShopResourceOpenSellClick Evergreen.V1.IdleGame.Kinds.Resource
    | HandleOneLessButtonClick
    | HandleOneMoreButtonClick
    | HandleMinButtonClick
    | HandleMaxButtonClick
    | HandleShopResourceQuantityChange String
    | HandleShopResourceBuySubmit
    | HandleShopResourceSellSubmit
    | AddToast Toast Time.Posix
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChangeHelp Browser.Events.Visibility Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | HandleTabClick Evergreen.V1.IdleGame.Tab.Tab
    | HandleShopUpgradeClick Evergreen.V1.IdleGame.Kinds.ShopUpgrade
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
    | HandleGetViewportResult Browser.Dom.Viewport


type alias InGameFrontend =
    { key : Browser.Navigation.Key
    , user : FrontendUser
    , route : Evergreen.V1.Route.Route
    , routeToken : Evergreen.V1.Route.Token
    , isVisible : Bool
    , games : List.Nonempty.Nonempty ( Evergreen.V1.Id.Id Evergreen.V1.Id.GameId, Evergreen.V1.IdleGame.Snapshot.Snapshot Game )
    , gameState : FrontendInGameState
    , maybeServerInfo : Maybe ServerInfo
    , lastFastForwardDuration : Maybe Duration.Duration
    , showDebugPanel : Bool
    , toastQueue : ToastQueue
    , isDrawerOpen : Bool
    , preview : Maybe Preview
    , activityExpanded : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V1.IdleGame.Timer.Timer
    , pointerState : Maybe PointerState
    }


type FrontendModel
    = Loading LoadingFrontend
    | MainMenu MainMenuFrontend
    | InGame InGameFrontend


type alias LoginTokenData =
    { creationTime : Time.Posix
    , emailAddress : Evergreen.V1.EmailAddress.EmailAddress
    }


type alias BackendModel =
    { approximateTime : Time.Posix
    , secretCounter : Int
    , userGames : AssocList.Dict (Evergreen.V1.Id.Id Evergreen.V1.Id.UserId) (List (Evergreen.V1.Id.Id Evergreen.V1.Id.GameId))
    , games : AssocList.Dict (Evergreen.V1.Id.Id Evergreen.V1.Id.GameId) (Evergreen.V1.IdleGame.Snapshot.Snapshot Game)
    , seed : Random.Seed
    , sessions : BiDict.Assoc.BiDict Lamdera.SessionId (Evergreen.V1.Id.Id Evergreen.V1.Id.UserId)
    , connections : AssocList.Dict Lamdera.SessionId (List.Nonempty.Nonempty Lamdera.ClientId)
    , users : AssocList.Dict (Evergreen.V1.Id.Id Evergreen.V1.Id.UserId) BackendUser
    , pendingLoginTokens : AssocList.Dict (Evergreen.V1.Id.Id Evergreen.V1.Id.LoginToken) LoginTokenData
    }


type ToBackend
    = NoOpToBackend
    | RegisterEmailRequest Evergreen.V1.Route.Route Evergreen.V1.EmailAddress.EmailAddress
    | LoginWithEmailRequest Evergreen.V1.Route.Route Evergreen.V1.EmailAddress.EmailAddress
    | LoginWithTokenRequest (Evergreen.V1.Id.Id Evergreen.V1.Id.LoginToken)
    | LogoutRequest
    | CreateGameRequest
    | SaveGame (Evergreen.V1.Id.Id Evergreen.V1.Id.GameId) (Evergreen.V1.IdleGame.Snapshot.Snapshot Game)


type BackendMsg
    = NoOpBackend
    | BackendGotTime Time.Posix
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleDisconnect Lamdera.SessionId Lamdera.ClientId
    | SentLoginEmail Evergreen.V1.EmailAddress.EmailAddress (Result Http.Error Evergreen.V1.Postmark.PostmarkSendResponse)


type ToFrontend
    = NoOpToFrontend
    | SetUserAndGames ( FrontendUser, List ( Evergreen.V1.Id.Id Evergreen.V1.Id.GameId, Evergreen.V1.IdleGame.Snapshot.Snapshot Game ) )
    | GiveServerInfo ServerInfo
