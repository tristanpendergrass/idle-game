module CombatTypes exposing (..)

import Random


type Mutation
    = Damage Int
    | Block Int


type alias CombatParams =
    { leftMaxHealth : Int
    , rightMaxHealth : Int
    }


type alias PlayerState =
    { health : Int
    , block : Int
    }


type alias CombatState =
    { leftState : PlayerState
    , rightState : PlayerState
    , moveIndex : Int
    }


type CombatResult
    = Continue
    | LeftWins
    | RightWins
    | Draw


type Player
    = LeftPlayer
    | RightPlayer


type alias Move =
    CombatParams -> CombatState -> Random.Generator (List ( Mutation, Player ))


type Msg
    = StartNewCombat
    | NextStep


type alias Model =
    { state : CombatState
    }
