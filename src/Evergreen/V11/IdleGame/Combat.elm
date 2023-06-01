module Evergreen.V11.IdleGame.Combat exposing (..)


type PlayerMove
    = Punch
    | Firebolt
    | Barrier


type MonsterMove
    = Claw


type MonsterKind
    = Charmstone
    | Silkling
    | Stalker


type alias State =
    { playerMoves : List PlayerMove
    , monsterMoves : List MonsterMove
    , monster : MonsterKind
    , playerHealth : Int
    , monsterHealth : Int
    , nextMoveIndex : Int
    }
