module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Events
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import FeatherIcons
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes
import IdleGame.Timer exposing (Timer)
import Lamdera exposing (ClientId, SessionId)
import Random
import Time exposing (Posix)
import Url exposing (Url)



-- TODO: Move Modal to another file?


type Modal
    = TimePassesModal Posix IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal


type alias GameState =
    { currentTime : Posix
    , lastTick : Posix
    , game : Game
    }


type Tab
    = BagTab
    | ChoresTab


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , isDrawerOpen : Bool
    , activeTab : Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Timer
    , gameState : Maybe GameState
    }


type alias SessionGameMap =
    Dict SessionId GameState


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type FrontendMsg
    = NoOp
    | UrlClicked UrlRequest
    | UrlChanged Url
    | InitializeGameWithTime GameState Posix
    | HandleAnimationFrame Time.Posix
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
    | Save GameState


type BackendMsg
    = NoOpBackendMsg
    | HandleConnect SessionId ClientId
    | HandleConnectWithTime SessionId ClientId Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame GameState
