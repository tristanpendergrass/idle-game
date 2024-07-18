module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation
import Dict
import Duration
import Evergreen.V1.IdleGame.Coin
import Evergreen.V1.IdleGame.Effect
import Evergreen.V1.IdleGame.GameTypes
import Evergreen.V1.IdleGame.Kinds
import Evergreen.V1.IdleGame.OneTime
import Evergreen.V1.IdleGame.Resource
import Evergreen.V1.IdleGame.Snapshot
import Evergreen.V1.IdleGame.Tab
import Evergreen.V1.IdleGame.Timer
import Evergreen.V1.IdleGame.Xp
import Lamdera
import Random
import Time
import Toast
import Url


type Preview
    = Preview Evergreen.V1.IdleGame.Kinds.Activity


type alias TimePassesXpGain =
    { originalXp : Evergreen.V1.IdleGame.Xp.Xp
    , currentXp : Evergreen.V1.IdleGame.Xp.Xp
    , skill : Evergreen.V1.IdleGame.Kinds.Skill
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V1.IdleGame.Coin.Coin
    , resourcesDiff : Evergreen.V1.IdleGame.Resource.Diff
    }


type Modal
    = TimePassesModal Duration.Duration Time.Posix TimePassesData
    | ShopResourceModal Int Evergreen.V1.IdleGame.Kinds.Resource Evergreen.V1.IdleGame.Coin.Coin
    | SyllabusModal Evergreen.V1.IdleGame.Kinds.Skill


type alias Game =
    { seed : Random.Seed
    , xp : Evergreen.V1.IdleGame.Kinds.SkillRecord Evergreen.V1.IdleGame.Xp.Xp
    , mxp : Evergreen.V1.IdleGame.Kinds.ActivityRecord Evergreen.V1.IdleGame.Xp.Xp
    , activity : Maybe ( Evergreen.V1.IdleGame.Kinds.Activity, Evergreen.V1.IdleGame.Timer.Timer )
    , coin : Evergreen.V1.IdleGame.Coin.Coin
    , resources : Evergreen.V1.IdleGame.Kinds.ResourceRecord Int
    , ownedShopUpgrades : Evergreen.V1.IdleGame.Kinds.ShopUpgradeRecord Bool
    , testCompletions : Evergreen.V1.IdleGame.Kinds.AcademicTestRecord Bool
    , oneTimeStatuses : Evergreen.V1.IdleGame.OneTime.OneTimeRecord Bool
    }


type alias Cache =
    Evergreen.V1.IdleGame.Kinds.ActivityRecord (List Evergreen.V1.IdleGame.Effect.Effect)


type alias FastForwardState =
    { original : Evergreen.V1.IdleGame.Snapshot.Snapshot Game
    , current : Evergreen.V1.IdleGame.Snapshot.Snapshot Game
    , whenItStarted : Time.Posix
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V1.IdleGame.Snapshot.Snapshot Game) Cache
    | FastForward FastForwardState


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
    | InitializeGameHelp (Evergreen.V1.IdleGame.Snapshot.Snapshot Game) Time.Posix
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
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration
    | AddTimeHelp Duration.Duration Time.Posix
    | HandleShopResourceClick Evergreen.V1.IdleGame.Kinds.Resource
    | HandleOneLessButtonClick
    | HandleOneMoreButtonClick
    | HandleMinButtonClick
    | HandleMaxButtonClick
    | HandleShopResourceQuantityChange String
    | HandleShopResourceBuyClick
    | HandleTestingCenterTabClick Evergreen.V1.IdleGame.Kinds.AcademicTestCategory
    | HandleTestCompletionClick Evergreen.V1.IdleGame.Kinds.AcademicTest
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V1.IdleGame.GameTypes.Toast
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


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , lastFastForwardDuration : Maybe Duration.Duration
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V1.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , activeTab : Evergreen.V1.IdleGame.Tab.Tab
    , preview : Maybe Preview
    , activityExpanded : Bool
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V1.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , pointerState : Maybe PointerState
    , activeAcademicTestCategory : Evergreen.V1.IdleGame.Kinds.AcademicTestCategory
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V1.IdleGame.Snapshot.Snapshot Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V1.IdleGame.Snapshot.Snapshot Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V1.IdleGame.Snapshot.Snapshot Game)
