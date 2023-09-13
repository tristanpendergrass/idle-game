module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Events
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import Duration exposing (Duration)
import IdleGame.Chore as Chore
import IdleGame.Combat as Adventuring
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Kinds.Monsters exposing (Monster)
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer exposing (Timer)
import IdleGame.Views.Utils as ViewUtils
import Lamdera exposing (ClientId, SessionId)
import Random
import Time exposing (Posix)
import Toast
import Url exposing (Url)


type Modal
    = TimePassesModal Posix IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal
    | ChoreItemUnlocksModal
    | ShopResourceModal Int Resource.Kind


type PreviousIntervalTimer
    = NotStarted
    | HaveStart Posix
    | HaveStartAndEnd Posix Posix


type alias FastForwardState =
    { original : Snapshot Game
    , current : Snapshot Game
    , previousIntervalTimer : PreviousIntervalTimer
    }


type FrontendGameState
    = Initializing
    | Playing (Snapshot Game)
    | FastForward FastForwardState


type Preview
    = Preview Activity


type alias PointerState =
    { longPress : Maybe ( Timer, Float, FrontendMsg ) -- If defined the long press has a timer, a Float duration (in ms), and a FrontendMsg to send when the timer fires
    , click : FrontendMsg -- The click message to send when the pointer is released if a long press isn't detected
    }


type Mode
    = Skill
    | Combat


type alias FrontendModel =
    { key : Key -- used by Browser.Navigation for things like pushUrl
    , showDebugPanel : Bool
    , tray : Toast.Tray Toast
    , isDrawerOpen : Bool
    , mode : Mode
    , activeSkillTab : Tab
    , activeCombatTab : Tab
    , isVisible : Bool
    , activeModal : Maybe Modal
    , saveGameTimer : Timer
    , gameState : FrontendGameState
    , preview : Maybe Preview -- Thing we're previewing in the detail view
    , activityExpanded : Bool -- If the activity in game exists and preview does not exist this Bool is used to show or hide the detail view in mobile/tablet screen size
    , pointerState : Maybe PointerState
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
      -- Detail View
    | SwitchMode Mode
    | ClosePreview
    | ExpandActivity
    | CollapseActivity
    | CollapseDetailView
    | ExpandDetailView
    | ToastMsg Toast.Msg
    | AddToast Toast
    | HandleFastForward Posix
    | HandleAnimationFrame Posix
    | HandleAnimationFrameDelta Float
    | SetDrawerOpen Bool
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseModal
    | OpenMasteryCheckpointsModal
    | OpenMasteryUnlocksModal
    | SetActiveSkillTab Tab
    | SetActiveCombatTab Tab
    | HandleShopItemClick ShopItems.Kind
    | HandleShopResourceClick Resource.Kind
    | HandleShopResourceQuantityChange String
    | HandleShopResourcePurchase
    | HandlePointerDown PointerState
    | HandlePointerUp
    | HandlePointerCancel
      -- Adventuring
    | StartFight
    | StopFight
    | HandlePlayerMoveSelect Int Adventuring.PlayerMove
      -- Activities
    | HandleMonsterClick { screenWidth : ViewUtils.ScreenWidth } Monster
    | HandleActivityClick { screenWidth : ViewUtils.ScreenWidth } Activity
    | HandlePreviewClick Activity
    | HandlePlayClick Activity
    | HandleStopClick Activity
      -- Debug Panel
    | OpenDebugPanel
    | CloseDebugPanel
    | AddTime Duration


type ToBackend
    = NoOpToBackend
    | Save (Snapshot Game)


type BackendMsg
    = NoOpBackend
    | HandleConnect SessionId ClientId
    | HandleConnectWithTime SessionId ClientId Posix


type ToFrontend
    = NoOpToFrontend
    | InitializeGame (Snapshot Game)
