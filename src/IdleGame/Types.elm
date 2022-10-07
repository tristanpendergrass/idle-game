module IdleGame.Types exposing (..)

-- Model


type Tab
    = Inventory
    | Mining
    | Smithing
    | Meditation
    | Combat


type alias Model =
    { activeTab : Tab
    }



-- Update


type Msg
    = NoOp
