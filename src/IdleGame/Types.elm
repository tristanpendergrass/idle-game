module IdleGame.Types exposing (..)

import Browser.Events
import FeatherIcons
import IdleGame.Chores exposing (Chore)
import IdleGame.Tabs exposing (Tabs)
import Time



-- Model


type alias Tab =
    { title : String
    , icon : FeatherIcons.Icon
    }


type alias Model =
    { tabs : Tabs
    , showWelcomeBackModal : Bool
    , now : Int

    -- Chores tab
    , skillXp : Int
    , masteryXp : Int
    , chores : List Chore
    }



-- Update


type Msg
    = NoOp
    | WithTime (Time.Posix -> Msg)
    | HandleAnimationFrame Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseWelcomeBackModal
      -- Chores
    | ToggleActiveChore IdleGame.Chores.Id Time.Posix
