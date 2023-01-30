module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Events
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import FeatherIcons
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer exposing (Timer)
import Lamdera exposing (ClientId, SessionId)
import Random
import Time exposing (Posix)
import Toast
import Url exposing (Url)


type Modal
    = TimePassesModal Posix IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal


type FrontendGameState
    = Initializing
    | Playing (Snapshot Game)
    | FastForward { original : Snapshot Game, current : Snapshot Game }


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , tray : Toast.Tray String
    , isDrawerOpen : Bool
    , activeTab : Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Timer
    , gameState : FrontendGameState
    }


type alias SessionGameMap =
    Dict SessionId (Snapshot Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type FrontendMsg
    = NoOp
    | UrlClicked UrlRequest
    | UrlChanged Url
    | ToastMsg Toast.Msg
    | AddToast String
    | HandleFastForward Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveTab Tab
      -- Chores
    | ToggleActiveChore IdleGame.GameTypes.ChoreType


type ToBackend
    = NoOpToBackend
    | Save (Snapshot Game)


type BackendMsg
    = NoOpBackendMsg
    | HandleConnect SessionId ClientId
    | HandleConnectWithTime SessionId ClientId Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Snapshot Game)
