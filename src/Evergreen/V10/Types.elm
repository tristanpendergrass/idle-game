module Evergreen.V10.Types exposing (..)

import Browser
import Browser.Events
import Browser.Navigation
import Dict
import Duration
import Evergreen.V10.IdleGame.Combat
import Evergreen.V10.IdleGame.Game
import Evergreen.V10.IdleGame.GameTypes
import Evergreen.V10.IdleGame.ShopItems
import Evergreen.V10.IdleGame.Snapshot
import Evergreen.V10.IdleGame.Tab
import Evergreen.V10.IdleGame.Timer
import Lamdera
import Random
import Time
import Toast
import Url


type Modal
    = TimePassesModal Time.Posix Evergreen.V10.IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Time.Posix
    | HaveStartAndEnd Time.Posix Time.Posix


type alias FastForwardState =
    { original : Evergreen.V10.IdleGame.Snapshot.Snapshot Evergreen.V10.IdleGame.Game.Game
    , current : Evergreen.V10.IdleGame.Snapshot.Snapshot Evergreen.V10.IdleGame.Game.Game
    , previousIntervalTimer : PreviousIntervalTimer
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V10.IdleGame.Snapshot.Snapshot Evergreen.V10.IdleGame.Game.Game)
    | FastForward FastForwardState


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V10.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , activeTab : Evergreen.V10.IdleGame.Tab.Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V10.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , showTimePasses : Bool
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V10.IdleGame.Snapshot.Snapshot Evergreen.V10.IdleGame.Game.Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V10.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveTab Evergreen.V10.IdleGame.Tab.Tab
    | HandleShopItemClick Evergreen.V10.IdleGame.ShopItems.Kind
    | StartFight
    | StopFight
    | HandlePlayerMoveSelect Int Evergreen.V10.IdleGame.Combat.PlayerMove
    | HandleMonsterSelect Evergreen.V10.IdleGame.Combat.MonsterKind
    | ToggleActiveChore Evergreen.V10.IdleGame.GameTypes.ChoreKind
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration
    | ToggleTimePasses Bool


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V10.IdleGame.Snapshot.Snapshot Evergreen.V10.IdleGame.Game.Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V10.IdleGame.Snapshot.Snapshot Evergreen.V10.IdleGame.Game.Game)
