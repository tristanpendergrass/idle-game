module IdleGame.Types exposing (..)

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
      -- Chores
    | ToggleActiveChore IdleGame.Chores.Id Time.Posix
