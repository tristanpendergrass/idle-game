module IdleGame.Types exposing (..)

import FeatherIcons
import IdleGame.Tabs exposing (Tabs)



-- Model


type alias Tab =
    { title : String
    , icon : FeatherIcons.Icon
    }


type alias Model =
    { tabs : Tabs
    }



-- Update


type Msg
    = NoOp
