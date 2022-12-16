module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Events
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import FeatherIcons
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes
import IdleGame.Tabs exposing (Tabs)
import IdleGame.Timer exposing (Timer)
import Lamdera exposing (ClientId, SessionId)
import Time exposing (Posix)
import Url exposing (Url)



-- TODO: Move Modal to another file?


type Modal
    = TimePassesModal Posix IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal


type alias GameState =
    { currentTime : Posix
    , lastTick : Posix
    , game : Game
    }


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , tabs : Tabs
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Timer
    , gameState : Maybe GameState
    }


type alias SessionGameMap =
    Dict SessionId GameState


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    }


type FrontendMsg
    = NoOp
    | UrlClicked UrlRequest
    | UrlChanged Url
    | UpdateGameStateWithTime GameState Posix
    | HandleAnimationFrame Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
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
    | UpdateGameState GameState
