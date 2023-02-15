module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Events
import Browser.Navigation
import Dict
import Evergreen.V1.IdleGame.Game
import Evergreen.V1.IdleGame.GameTypes
import Evergreen.V1.IdleGame.ShopItems
import Evergreen.V1.IdleGame.Snapshot
import Evergreen.V1.IdleGame.Tab
import Evergreen.V1.IdleGame.Timer
import Lamdera
import Random
import Time
import Toast
import Url


type Modal
    = TimePassesModal Time.Posix Evergreen.V1.IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Time.Posix
    | HaveStartAndEnd Time.Posix Time.Posix


type FrontendGameState
    = Initializing
    | Playing (Evergreen.V1.IdleGame.Snapshot.Snapshot Evergreen.V1.IdleGame.Game.Game)
    | FastForward
        { original : Evergreen.V1.IdleGame.Snapshot.Snapshot Evergreen.V1.IdleGame.Game.Game
        , current : Evergreen.V1.IdleGame.Snapshot.Snapshot Evergreen.V1.IdleGame.Game.Game
        , previousIntervalTimer : PreviousIntervalTimer
        }


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , tray : Toast.Tray Evergreen.V1.IdleGame.GameTypes.Toast
    , isDrawerOpen : Bool
    , activeTab : Evergreen.V1.IdleGame.Tab.Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Evergreen.V1.IdleGame.Timer.Timer
    , gameState : FrontendGameState
    }


type alias SessionGameMap =
    Dict.Dict Lamdera.SessionId (Evergreen.V1.IdleGame.Snapshot.Snapshot Evergreen.V1.IdleGame.Game.Game)


type alias BackendModel =
    { sessionGameMap : SessionGameMap
    , seed : Random.Seed
    }


type FrontendMsg
    = NoOp
    | UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ToastMsg Toast.Msg
    | AddToast Evergreen.V1.IdleGame.GameTypes.Toast
    | HandleFastForward Time.Posix
    | HandleAnimationFrame Time.Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveTab Evergreen.V1.IdleGame.Tab.Tab
    | HandleShopItemClick Evergreen.V1.IdleGame.ShopItems.Kind
    | ToggleActiveChore Evergreen.V1.IdleGame.GameTypes.ChoreKind


type ToBackend
    = NoOpToBackend
    | Save (Evergreen.V1.IdleGame.Snapshot.Snapshot Evergreen.V1.IdleGame.Game.Game)


type BackendMsg
    = NoOpBackendMsg
    | HandleConnect Lamdera.SessionId Lamdera.ClientId
    | HandleConnectWithTime Lamdera.SessionId Lamdera.ClientId Time.Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Evergreen.V1.IdleGame.Snapshot.Snapshot Evergreen.V1.IdleGame.Game.Game)
