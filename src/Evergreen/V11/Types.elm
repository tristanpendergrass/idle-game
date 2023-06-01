module Evergreen.V11.Types exposing (..)

import Browser
import Browser.Events
import Browser.Navigation
import Dict
import Duration
import Evergreen.V11.IdleGame.Combat
import Evergreen.V11.IdleGame.Game
import Evergreen.V11.IdleGame.GameTypes
import Evergreen.V11.IdleGame.ShopItems
import Evergreen.V11.IdleGame.Snapshot
import Evergreen.V11.IdleGame.Tab
import Evergreen.V11.IdleGame.Timer
import Lamdera
import Random
import Time
import Toast
import Url


type Modal
    = TimePassesModal Time.Posix Evergreen.V11.IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Time.Posix
    | HaveStartAndEnd Time.Posix Time.Posix


type alias FastForwardState =
    { original : Evergreen.V11.IdleGame.Snapshot.Snapshot Evergreen.V11.IdleGame.Game.Game
    , current : Evergreen.V11.IdleGame.Snapshot.Snapshot Evergreen.V11.IdleGame.Game.Game
    , previousIntervalTimer : PreviousIntervalTimer
    }


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V11.IdleGame.Snapshot.Snapshot Evergreen.V11.IdleGame.Game.Game)
    | FastForward FastForwardState


type Preview
    = PreviewChore Evergreen.V11.IdleGame.GameTypes.ChoreKind


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , showDebugPanel : Bool
    , tray : Toast.Tray Evergreen.V11.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , activeTab : Evergreen.V11.IdleGame.Tab.Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V11.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    , preview : Maybe Preview
    , activityExpanded : Bool
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V11.IdleGame.Snapshot.Snapshot Evergreen.V11.IdleGame.Game.Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ClosePreview
    | ExpandActivity
    | CollapseActivity
    | CollapseDetailView
    | ExpandDetailView
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V11.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveTab Evergreen.V11.IdleGame.Tab.Tab
    | HandleShopItemClick Evergreen.V11.IdleGame.ShopItems.Kind
    | StartFight
    | StopFight
    | HandlePlayerMoveSelect Int Evergreen.V11.IdleGame.Combat.PlayerMove
    | HandleMonsterSelect Evergreen.V11.IdleGame.Combat.MonsterKind
    | HandleChoreClick Evergreen.V11.IdleGame.GameTypes.ChoreKind
    | ToggleActiveChore Evergreen.V11.IdleGame.GameTypes.ChoreKind
    | HandlePlayClick Evergreen.V11.IdleGame.GameTypes.ChoreKind
    | HandlePauseClick Evergreen.V11.IdleGame.GameTypes.ChoreKind
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration.Duration


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V11.IdleGame.Snapshot.Snapshot Evergreen.V11.IdleGame.Game.Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V11.IdleGame.Snapshot.Snapshot Evergreen.V11.IdleGame.Game.Game)
