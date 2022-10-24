module IdleGame.Types exposing (..)

import Browser.Events
import FeatherIcons
import IdleGame.Tabs exposing (Tabs)
import Time exposing (Posix)



-- Model


type alias Tab =
    { title : String
    , icon : FeatherIcons.Icon
    }


type alias GameObject =
    { currentTime : Posix
    , wood : Int
    , boatLevel : Int
    , woodcuttingXp : Int
    , boatBuildingXp : Int
    }


type alias Model =
    { tabs : Tabs
    , showWelcomeBackModal : Bool
    , gameObject : GameObject

    -- Chores tab
    -- , skillXp : Int
    -- , masteryXp : Int
    -- , chores : List Chore
    }



-- Update


type Msg
    = NoOp
    | WithTime (Posix -> Msg)
    | HandleAnimationFrame Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseWelcomeBackModal
      -- Chores
    | ToggleActiveChore Int Time.Posix



-- Chores
