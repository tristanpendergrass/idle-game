module IdleGame.Types exposing (..)

import Browser.Events
import FeatherIcons
import IdleGame.Game exposing (Game)
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
    | WoodcuttingMasteryCheckpointsModal


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
    | CloseTimePassesModal
      -- Woodcutting
    | ToggleActiveTree Int
