module CombatTypes exposing (..)

import Random



{--| EntityAbsolute: either the Player, or the monster they're fighting. Later, could also refer to members of either side's party.
EntityRelative: either Self, or Opponent, for now. Might be things like "nearest enemy" later.
Mutation: an action that affects the entity, such as damage or block. No random outcomes, no affecting multiple entities.
Move: something like "I do 1-3 damage to the enemy". It can have a random outcome, and specifies its effect by a list of
Mutations paired with the relative entity.
-}


type Mutation
    = Damage Int
    | Block Int


type alias Params =
    { leftMaxHealth : Int
    , rightMaxHealth : Int
    , leftMoves : List Move
    , rightMoves : List Move
    }


type alias EntityState =
    { health : Int
    , block : Int
    }


type alias State =
    { leftState : EntityState
    , rightState : EntityState
    , moveIndex : Int
    , log : List Mutation
    }


type CombatResult
    = Continue
    | LeftWins
    | RightWins
    | Draw


type EntityAbsolute
    = Left
    | Right


type EntityRelative
    = Self
    | Opponent


type alias Move =
    State -> Random.Generator (List ( Mutation, EntityRelative ))


type Msg
    = StartNewCombat
    | NextStep


type alias Model =
    { state : State
    }
