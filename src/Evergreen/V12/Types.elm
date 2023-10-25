module Evergreen.V12.Types exposing (..)

import Browser
import Browser.Events
import Browser.Navigation
import Dict
import Duration
import Evergreen.V12.IdleGame.Game
import Evergreen.V12.IdleGame.GameTypes
import Evergreen.V12.IdleGame.Kinds.Activities
import Evergreen.V12.IdleGame.Resource
import Evergreen.V12.IdleGame.ShopItems
import Evergreen.V12.IdleGame.Snapshot
import Evergreen.V12.IdleGame.Tab
import Evergreen.V12.IdleGame.Timer
import Evergreen.V12.IdleGame.Views.Utils
import Lamdera
import Random
import Time
import Toast
import Url


type Mode
    = Skilling
    | Adventuring


type Preview
    = Preview Evergreen.V12.IdleGame.Kinds.Activities.Activity


type alias ModeState =
    { activeTab : Evergreen.V12.IdleGame.Tab.Tab
    , preview : Maybe Preview
    , activityExpanded : Bool
    }


type Modal
    = TimePassesModal Time.Posix Evergreen.V12.IdleGame.Game.TimePassesData
    | ChoreItemUnlocksModal
    | ShopResourceModal Int Evergreen.V12.IdleGame.Resource.Kind


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Time.Posix
    | HaveStartAndEnd Time.Posix Time.Posix


type alias FastForwardState =
    { original : Evergreen.V12.IdleGame.Snapshot.Snapshot Evergreen.V12.IdleGame.Game.Game
    , current : Evergreen.V12.IdleGame.Snapshot.Snapshot Evergreen.V12.IdleGame.Game.Game
    , previousIntervalTimer : PreviousIntervalTimer
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V12.IdleGame.Snapshot.Snapshot Evergreen.V12.IdleGame.Game.Game)
    | FastForward FastForwardState


type alias PointerState =
    { longPress : Maybe ( Evergreen.V12.IdleGame.Timer.Timer, Float, FrontendMsg )
    , click : FrontendMsg
    }


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
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V12.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryUnlocksModal
    | SetActiveSkillTab Evergreen.V12.IdleGame.Tab.Tab
    | SetActiveCombatTab Evergreen.V12.IdleGame.Tab.Tab
    | HandleShopItemClick Evergreen.V12.IdleGame.ShopItems.Kind
    | HandleShopResourceClick Evergreen.V12.IdleGame.Resource.Kind
    | HandleShopResourceQuantityChange String
    | HandleShopResourcePurchase
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
    | HandleActivityClick
        { screenWidth : Evergreen.V12.IdleGame.Views.Utils.ScreenWidth
        }
        Evergreen.V12.IdleGame.Kinds.Activities.Activity
    | HandlePreviewClick Evergreen.V12.IdleGame.Kinds.Activities.Activity
    | HandlePlayClick Evergreen.V12.IdleGame.Kinds.Activities.Activity
    | HandleStopClick Evergreen.V12.IdleGame.Kinds.Activities.Activity
    | HandleSpellSelect Evergreen.V12.IdleGame.Kinds.Activities.Activity String
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V12.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , mode : Mode
    , skillingState : ModeState
    , adventuringState : ModeState
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V12.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , pointerState : Maybe PointerState
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V12.IdleGame.Snapshot.Snapshot Evergreen.V12.IdleGame.Game.Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V12.IdleGame.Snapshot.Snapshot Evergreen.V12.IdleGame.Game.Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V12.IdleGame.Snapshot.Snapshot Evergreen.V12.IdleGame.Game.Game)
