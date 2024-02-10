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
import IdleGame.Location as Location
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Spell as Spell
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


type TimePassesDiscovery
    = MonsterDiscovery Monster
    | QuestDiscovery Quest
    | ResourceDiscovery Resource


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , discoveries : List TimePassesDiscovery
    , coinGains : Maybe Coin
    , resourcesDiff : Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


type alias Game =
    { seed : Random.Seed
    , xp : SkillRecord Xp
    , mxp : ActivityRecord Xp
    , locations : LocationRecord Location.State
    , quests : QuestRecord Quest.State
    , choresMxp : Xp
    , activitySkilling : Maybe ( Activity, Timer )
    , activityAdventuring : Maybe ( Activity, Timer )
    , monster : Maybe Monster
    , coin : Coin
    , resources : ResourceRecord Int
    , ownedShopUpgrades : ShopUpgradeRecord Bool
    , combatsWon : Int
    , combatsLost : Int
    , spellSelectors : ActivityRecord (Maybe Spell)
    }


type Modal
    = TimePassesModal Posix TimePassesData
    | ChoreItemUnlocksModal
    | ShopResourceModal Int Resource Coin
    | SyllabusModal Skill


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Posix
    | HaveStartAndEnd Posix Posix


type alias FastForwardState =
    { original : Snapshot Game
    , current : Snapshot Game
    , previousIntervalTimer : PreviousIntervalTimer
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


type Mode
    = Skilling
    | Adventuring


type alias ModeState =
    { activeTab : Tab
    , preview : Maybe Preview
    , activityExpanded : Bool
    }


type LocationFilter
    = LocationAll
    | LocationMonsters
    | LocationQuests


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , showDebugPanel : Bool
    , tray : Toast.Tray Toast
    , isDrawerOpen : Bool
    , mode : Mode
    , skillingState : ModeState
    , adventuringState : ModeState
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Timer
    , gameState : FrontendGameState
    , pointerState : Maybe PointerState -- Tracks the state of the pointer (mouse or touch) for long press detection
    , locationFilters : LocationRecord LocationFilter
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
      -- Detail View
    | SwitchMode Mode
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
    | HandleSpellSelect Activity String
    | HandleQuestComplete Quest
      -- Debug Panel
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration
      -- Shop Resource Purchase modal
    | HandleShopResourceClick Resource -- Opens the modal
    | HandleOneLessButtonClick
    | HandleOneMoreButtonClick
    | HandleMinButtonClick
    | HandleMaxButtonClick
    | HandleShopResourceQuantityChange String
    | HandleShopResourceBuyClick
      -- Other
    | ToastMsg Toast.Msg
    | AddToast Toast
    | HandleFastForward Posix
    | HandleAnimationFrame Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryUnlocksModal
    | HandleTabClick Tab Mode
    | HandleShopUpgradeClick ShopUpgrade
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
    | HandleLocationFilterClick Location LocationFilter
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
