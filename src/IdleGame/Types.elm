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


type alias Model =
    { tabs : Tabs
    , isVisible : Bool
    , showWelcomeBackModal : Bool
    , game : Game
    }



-- Update


type Msg
    = NoOp
    | HandleAnimationFrame Time.Posix
    | HandleVisibilityChange Browser.Events.Visibility
    | CloseWelcomeBackModal
      -- Woodcutting
    | ToggleActiveTree Int
