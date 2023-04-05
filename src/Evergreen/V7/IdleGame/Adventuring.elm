module Evergreen.V7.IdleGame.Adventuring exposing (..)


type PlayerMove
    = Punch
    | Firebolt
    | Barrier


type MonsterKind
    = Charmstone
    | Silkling
    | Stalker


type alias State =
    { playerMoves : List PlayerMove
    , monster : MonsterKind
    , playerHealth : Int
    , monsterHealth : Int
    , nextMoveIndex : Int
    }
