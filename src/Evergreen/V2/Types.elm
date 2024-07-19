module Evergreen.V2.Types exposing (..)

import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation
import Dict
import Duration
import Evergreen.V2.IdleGame.Coin
import Evergreen.V2.IdleGame.Effect
import Evergreen.V2.IdleGame.GameTypes
import Evergreen.V2.IdleGame.Kinds
import Evergreen.V2.IdleGame.OneTime
import Evergreen.V2.IdleGame.Resource
import Evergreen.V2.IdleGame.Snapshot
import Evergreen.V2.IdleGame.Tab
import Evergreen.V2.IdleGame.Timer
import Evergreen.V2.IdleGame.Xp
import Lamdera
import Random
import Time
import Toast
import Url


type Preview
    = Preview ( Evergreen.V2.IdleGame.Kinds.Activity, List Evergreen.V2.IdleGame.Effect.Effect )


type alias TimePassesXpGain =
    { originalXp : Evergreen.V2.IdleGame.Xp.Xp
    , currentXp : Evergreen.V2.IdleGame.Xp.Xp
    , skill : Evergreen.V2.IdleGame.Kinds.Skill
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Evergreen.V2.IdleGame.Coin.Coin
    , resourcesDiff : Evergreen.V2.IdleGame.Resource.Diff
    }


type Modal
    = TimePassesModal Duration.Duration Time.Posix TimePassesData
    | ShopResourceModal Int Evergreen.V2.IdleGame.Kinds.Resource Evergreen.V2.IdleGame.Coin.Coin
    | SyllabusModal Evergreen.V2.IdleGame.Kinds.Skill


type alias Game =
    { seed : Random.Seed
    , xp : Evergreen.V2.IdleGame.Kinds.SkillRecord Evergreen.V2.IdleGame.Xp.Xp
    , mxp : Evergreen.V2.IdleGame.Kinds.ActivityRecord Evergreen.V2.IdleGame.Xp.Xp
    , activity : Maybe ( Evergreen.V2.IdleGame.Kinds.Activity, Evergreen.V2.IdleGame.Timer.Timer )
    , coin : Evergreen.V2.IdleGame.Coin.Coin
    , resources : Evergreen.V2.IdleGame.Kinds.ResourceRecord Int
    , ownedShopUpgrades : Evergreen.V2.IdleGame.Kinds.ShopUpgradeRecord Bool
    , testCompletions : Evergreen.V2.IdleGame.Kinds.AcademicTestRecord Bool
    , oneTimeStatuses : Evergreen.V2.IdleGame.OneTime.OneTimeRecord Bool
    }


type alias Cache =
    Evergreen.V2.IdleGame.Kinds.ActivityRecord (List Evergreen.V2.IdleGame.Effect.Effect)


type alias FastForwardState =
    { original : Evergreen.V2.IdleGame.Snapshot.Snapshot Game
    , current : Evergreen.V2.IdleGame.Snapshot.Snapshot Game
    , whenItStarted : Time.Posix
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V2.IdleGame.Snapshot.Snapshot Game) Cache
    | FastForward FastForwardState


type ScreenWidth
    = ScreenXs
    | ScreenSm
    | ScreenMd
    | ScreenLg
    | ScreenXl
    | Screen2xl


type alias PointerState =
    { longPress : Maybe ( Evergreen.V2.IdleGame.Timer.Timer, Float, FrontendMsg )
    , click : FrontendMsg
    }


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | InitializeGameHelp (Evergreen.V2.IdleGame.Snapshot.Snapshot Game) Time.Posix
    | ClosePreview
    | ExpandActivity
    | CollapseActivity
    | CollapseDetailView
    | ExpandDetailView
    | HandleSyllabusClick Evergreen.V2.IdleGame.Kinds.Skill
    | HandleActivityClick
        { screenWidth : ScreenWidth
        }
        Evergreen.V2.IdleGame.Kinds.Activity
    | HandlePreviewClick Evergreen.V2.IdleGame.Kinds.Activity
    | HandlePlayClick Evergreen.V2.IdleGame.Kinds.Activity
    | HandleStopClick Evergreen.V2.IdleGame.Kinds.Activity
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration
    | AddTimeHelp Duration.Duration Time.Posix
    | HandleShopResourceClick Evergreen.V2.IdleGame.Kinds.Resource
    | HandleOneLessButtonClick
    | HandleOneMoreButtonClick
    | HandleMinButtonClick
    | HandleMaxButtonClick
    | HandleShopResourceQuantityChange String
    | HandleShopResourceBuyClick
    | HandleTestingCenterTabClick Evergreen.V2.IdleGame.Kinds.AcademicTestCategory
    | HandleTestCompletionClick Evergreen.V2.IdleGame.Kinds.AcademicTest
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V2.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChangeHelp Browser.Events.Visibility Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | HandleTabClick Evergreen.V2.IdleGame.Tab.Tab
    | HandleShopUpgradeClick Evergreen.V2.IdleGame.Kinds.ShopUpgrade
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
    | HandleGetViewportResult Browser.Dom.Viewport


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , lastFastForwardDuration : Maybe Duration.Duration
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V2.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , activeTab : Evergreen.V2.IdleGame.Tab.Tab
    , preview : Maybe Preview
    , activityExpanded : Bool
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V2.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , pointerState : Maybe PointerState
    , activeAcademicTestCategory : Evergreen.V2.IdleGame.Kinds.AcademicTestCategory
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V2.IdleGame.Snapshot.Snapshot Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V2.IdleGame.Snapshot.Snapshot Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V2.IdleGame.Snapshot.Snapshot Game)
