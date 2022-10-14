module IdleGame.Types exposing (..)

import FeatherIcons
import IdleGame.Tabs exposing (Tabs)



-- Model


type alias Tab =
    { title : String
    , icon : FeatherIcons.Icon
    }


type alias ChoreData =
    { title : String, rewardText : String, skillXpGranted : Int, masteryXpGraned : Int, masteryXp : Int }


type Chore
    = LockedChore
    | UnlockedChore ChoreData { isActive : Bool }


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
