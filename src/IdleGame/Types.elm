module IdleGame.Types exposing (..)

import Browser.Events
import FeatherIcons
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes
import IdleGame.Tabs exposing (Tabs)
import IdleGame.Timer
import Time exposing (Posix)



-- Model


type alias Tab =
    { title : String
    , icon : FeatherIcons.Icon
    }


type Modal
    = TimePassesModal IdleGame.Game.TimePassesData
    | ChoreMasteryCheckpointsModal


type alias Model =
    { tabs : Tabs
    , isVisible : Bool
    , activeModal : Maybe Modal
    , game : Game
    }



-- Update


type Msg
    = NoOp
    | WithTime (Posix -> Msg)
    | HandleAnimationFrame Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility Posix
    | CloseModal
      -- Chores
    | ToggleActiveChore IdleGame.GameTypes.ChoreType
