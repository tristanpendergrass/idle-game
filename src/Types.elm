module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Events
import Browser.Navigation exposing (Key)
import FeatherIcons
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes
import IdleGame.Tabs exposing (Tabs)
import IdleGame.Timer
import Time exposing (Posix)
import Url exposing (Url)



-- TODO: Move Modal to another file?


type Modal
    = TimePassesModal IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , currentTime : Posix
    , tabs : Tabs
    , isVisible : Bool
    , activeModal : Maybe Modal
    , game : Game
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = NoOp
    | UrlClicked UrlRequest
    | UrlChanged Url
    | HandleAnimationFrame Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
      -- Chores
    | ToggleActiveChore IdleGame.GameTypes.ChoreType


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
