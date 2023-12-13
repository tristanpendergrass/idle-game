module Evergreen.V17.Types exposing (..)

import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation
import Dict
import Duration
import Evergreen.V17.IdleGame.Coin
import Evergreen.V17.IdleGame.Game
import Evergreen.V17.IdleGame.GameTypes
import Evergreen.V17.IdleGame.Kinds
import Evergreen.V17.IdleGame.Snapshot
import Evergreen.V17.IdleGame.Tab
import Evergreen.V17.IdleGame.Timer
import Evergreen.V17.IdleGame.Views.Utils
import Lamdera
import Random
import Time
import Toast
import Url


type Mode
    = Skilling
    | Adventuring


type Preview
    = Preview Evergreen.V17.IdleGame.Kinds.Activity


type alias ModeState =
    { activeTab : Evergreen.V17.IdleGame.Tab.Tab
    , preview : Maybe Preview
    , activityExpanded : Bool
    }


type Modal
    = TimePassesModal Time.Posix Evergreen.V17.IdleGame.Game.TimePassesData
    | ChoreItemUnlocksModal
    | ShopResourceModal Int Evergreen.V17.IdleGame.Kinds.Resource Evergreen.V17.IdleGame.Coin.Coin


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Time.Posix
    | HaveStartAndEnd Time.Posix Time.Posix


type alias FastForwardState =
    { original : Evergreen.V17.IdleGame.Snapshot.Snapshot Evergreen.V17.IdleGame.Game.Game
    , current : Evergreen.V17.IdleGame.Snapshot.Snapshot Evergreen.V17.IdleGame.Game.Game
    , previousIntervalTimer : PreviousIntervalTimer
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V17.IdleGame.Snapshot.Snapshot Evergreen.V17.IdleGame.Game.Game)
    | FastForward FastForwardState


type alias PointerState =
    { longPress : Maybe ( Evergreen.V17.IdleGame.Timer.Timer, Float, FrontendMsg )
    , click : FrontendMsg
    }


type LocationFilter
    = LocationAll
    | LocationMonsters
    | LocationQuests


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | SwitchMode Mode
    | ClosePreview
    | ExpandActivity
    | CollapseActivity
    | CollapseDetailView
    | ExpandDetailView
    | HandleActivityClick
        { screenWidth : Evergreen.V17.IdleGame.Views.Utils.ScreenWidth
        }
        Evergreen.V17.IdleGame.Kinds.Activity
    | HandlePreviewClick Evergreen.V17.IdleGame.Kinds.Activity
    | HandlePlayClick Evergreen.V17.IdleGame.Kinds.Activity
    | HandleStopClick Evergreen.V17.IdleGame.Kinds.Activity
    | HandleSpellSelect Evergreen.V17.IdleGame.Kinds.Activity String
    | HandleQuestComplete Evergreen.V17.IdleGame.Kinds.Quest
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration
    | HandleShopResourceClick Evergreen.V17.IdleGame.Kinds.Resource
    | HandleOneLessButtonClick
    | HandleOneMoreButtonClick
    | HandleMinButtonClick
    | HandleMaxButtonClick
    | HandleShopResourceQuantityChange String
    | HandleShopResourceBuyClick
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V17.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryUnlocksModal
    | HandleTabClick Evergreen.V17.IdleGame.Tab.Tab Mode
    | HandleShopUpgradeClick Evergreen.V17.IdleGame.Kinds.ShopUpgrade
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
    | HandleLocationFilterClick Evergreen.V17.IdleGame.Kinds.Location LocationFilter
    | HandleGetViewportResult Browser.Dom.Viewport


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V17.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , mode : Mode
    , skillingState : ModeState
    , adventuringState : ModeState
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V17.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , pointerState : Maybe PointerState
    , locationFilters : Evergreen.V17.IdleGame.Kinds.LocationRecord LocationFilter
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V17.IdleGame.Snapshot.Snapshot Evergreen.V17.IdleGame.Game.Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V17.IdleGame.Snapshot.Snapshot Evergreen.V17.IdleGame.Game.Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V17.IdleGame.Snapshot.Snapshot Evergreen.V17.IdleGame.Game.Game)
