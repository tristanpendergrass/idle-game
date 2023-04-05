module Evergreen.V7.Types exposing (..)

import Browser
import Browser.Events
import Browser.Navigation
import Dict
import Duration
import Evergreen.V7.IdleGame.Adventuring
import Evergreen.V7.IdleGame.Game
import Evergreen.V7.IdleGame.GameTypes
import Evergreen.V7.IdleGame.ShopItems
import Evergreen.V7.IdleGame.Snapshot
import Evergreen.V7.IdleGame.Tab
import Evergreen.V7.IdleGame.Timer
import Lamdera
import Random
import Time
import Toast
import Url


type Modal
    = TimePassesModal Time.Posix Evergreen.V7.IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Time.Posix
    | HaveStartAndEnd Time.Posix Time.Posix


type alias FastForwardState =
    { original : Evergreen.V7.IdleGame.Snapshot.Snapshot Evergreen.V7.IdleGame.Game.Game
    , current : Evergreen.V7.IdleGame.Snapshot.Snapshot Evergreen.V7.IdleGame.Game.Game
    , previousIntervalTimer : PreviousIntervalTimer
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V7.IdleGame.Snapshot.Snapshot Evergreen.V7.IdleGame.Game.Game)
    | FastForward FastForwardState


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V7.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , activeTab : Evergreen.V7.IdleGame.Tab.Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V7.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , selectedMonster : Evergreen.V7.IdleGame.Adventuring.MonsterKind
    , showTimePasses : Bool
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V7.IdleGame.Snapshot.Snapshot Evergreen.V7.IdleGame.Game.Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V7.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveTab Evergreen.V7.IdleGame.Tab.Tab
    | HandleShopItemClick Evergreen.V7.IdleGame.ShopItems.Kind
    | StartFight
    | StopFight
    | SetPlayerMove Int Evergreen.V7.IdleGame.Adventuring.PlayerMove
    | SetMonster Evergreen.V7.IdleGame.Adventuring.MonsterKind
    | ToggleActiveChore Evergreen.V7.IdleGame.GameTypes.ChoreKind
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration
    | ToggleTimePasses Bool


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V7.IdleGame.Snapshot.Snapshot Evergreen.V7.IdleGame.Game.Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V7.IdleGame.Snapshot.Snapshot Evergreen.V7.IdleGame.Game.Game)
