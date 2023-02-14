module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Events
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import IdleGame.Chore as Chore
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
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


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Posix
    | HaveStartAndEnd Posix Posix


type FrontendGameState
    = Initializing
    | Playing (Snapshot Game)
    | FastForward { original : Snapshot Game, current : Snapshot Game, previousIntervalTimer : PreviousIntervalTimer }


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , tray : Toast.Tray Toast
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
    | AddToast Toast
    | HandleFastForward Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveTab Tab
    | HandleShopItemClick ShopItems.Kind
      -- Chores
    | ToggleActiveChore ChoreKind


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
