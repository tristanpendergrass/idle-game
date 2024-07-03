module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Dom
import Browser.Events
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.OneTime as OneTime
import IdleGame.Resource as Resource
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer exposing (Timer)
import IdleGame.Xp as Xp exposing (Xp)
import Lamdera exposing (ClientId, SessionId)
import Random
import Time exposing (Posix)
import Toast
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
    , testCompletions : AcademicTestRecord Bool
    , oneTimeStatuses : OneTime.OneTimeRecord Bool
    }


type Modal
    = TimePassesModal Duration Posix TimePassesData
    | ChoreItemUnlocksModal
    | ShopResourceModal Int Resource Coin
    | SyllabusModal Skill


type alias FastForwardState =
    { original : Snapshot Game
    , current : Snapshot Game
    , whenItStarted : Posix -- the time when fast forward began, to calculate how long it takes
    }


type FrontendGameState
    = Initializing
    | Playing (Snapshot Game)
    | FastForward FastForwardState


type Preview
    = Preview Activity


type alias PointerState =
    { longPress : Maybe ( Timer, Float, FrontendMsg ) -- If defined the long press has a timer, a Float duration (in ms), and a FrontendMsg to send when the timer fires
    , click : FrontendMsg -- The click message to send when the pointer is released if a long press isn't detected
    }


type LocationFilter
    = LocationAll
    | LocationMonsters
    | LocationQuests


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , lastFastForwardDuration : Maybe Duration -- Used to display fast forward times for debugging and optimization
    , showDebugPanel : Bool
    , tray : Toast.Tray Toast
    , isDrawerOpen : Bool
    , activeTab : Tab
    , preview : Maybe Preview
    , activityExpanded : Bool
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Timer
    , gameState : FrontendGameState
    , pointerState : Maybe PointerState -- Tracks the state of the pointer (mouse or touch) for long press detection
    , activeAcademicTestCategory : AcademicTestCategory
    }


type alias SessionGameMap =
    Dict SessionId (Snapshot Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


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
    | InitializeGameHelp (Snapshot Game) Posix
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
      -- Testing Center
    | HandleTestingCenterTabClick AcademicTestCategory
    | HandleTestCompletionClick AcademicTest
      -- Other
    | ToastMsg Toast.Msg
    | AddToast Toast
    | HandleFastForward Posix
    | HandleAnimationFrame Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChangeHelp Browser.Events.Visibility Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryUnlocksModal
    | HandleTabClick Tab
    | HandleShopUpgradeClick ShopUpgrade
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
    | HandleGetViewportResult Browser.Dom.Viewport


type ToBackend
    = NoOpToBackend
    | Save (Snapshot Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect SessionId ClientId
    | HandleConnectWithTime SessionId ClientId Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Snapshot Game)
