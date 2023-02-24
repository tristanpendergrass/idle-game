module Evergreen.V6.Types exposing (..)

import Browser
import Browser.Events
import Browser.Navigation
import Dict
import Evergreen.V6.IdleGame.Game
import Evergreen.V6.IdleGame.GameTypes
import Evergreen.V6.IdleGame.ShopItems
import Evergreen.V6.IdleGame.Snapshot
import Evergreen.V6.IdleGame.Tab
import Evergreen.V6.IdleGame.Timer
import Lamdera
import Random
import Time
import Toast
import Url


type Modal
    = TimePassesModal Time.Posix Evergreen.V6.IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Time.Posix
    | HaveStartAndEnd Time.Posix Time.Posix


type alias FastForwardState =
    { original : Evergreen.V6.IdleGame.Snapshot.Snapshot Evergreen.V6.IdleGame.Game.Game
    , current : Evergreen.V6.IdleGame.Snapshot.Snapshot Evergreen.V6.IdleGame.Game.Game
    , previousIntervalTimer : PreviousIntervalTimer
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V6.IdleGame.Snapshot.Snapshot Evergreen.V6.IdleGame.Game.Game)
    | FastForward FastForwardState


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V6.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , activeTab : Evergreen.V6.IdleGame.Tab.Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V6.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , showTimePasses : Bool
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V6.IdleGame.Snapshot.Snapshot Evergreen.V6.IdleGame.Game.Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V6.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveTab Evergreen.V6.IdleGame.Tab.Tab
    | HandleShopItemClick Evergreen.V6.IdleGame.ShopItems.Kind
    | ToggleActiveChore Evergreen.V6.IdleGame.GameTypes.ChoreKind
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Float
    | ToggleTimePasses Bool


type ToBackend
    = Save (Evergreen.V6.IdleGame.Snapshot.Snapshot Evergreen.V6.IdleGame.Game.Game)


type BackendMsg
    = HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = InitializeGame (Evergreen.V6.IdleGame.Snapshot.Snapshot Evergreen.V6.IdleGame.Game.Game)
