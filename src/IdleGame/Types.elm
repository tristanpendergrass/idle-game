module IdleGame.Types exposing (..)

import Browser.Events
import FeatherIcons
import IdleGame.Tabs exposing (Tabs)
import IdleGame.Timer
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

    -- Woodcutting tab
    -- , skillXp : Int
    -- , masteryXp : Int
    , woodcutting : List Woodcutting --
    }



-- Update


type Msg
    = NoOp
    | WithTime (Posix -> Msg)
    | HandleAnimationFrame Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseWelcomeBackModal
      -- Woodcutting
    | ToggleActiveTree Int Time.Posix



-- Woodcutting


type Woodcutting
    = Woodcutting Id WoodcuttingData ActivityStatus


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


type alias Id =
    Int


type alias WoodcuttingData =
    { title : String, rewardText : String, skillXpGranted : Int, masteryXpGranted : Int, masteryXp : Int }
