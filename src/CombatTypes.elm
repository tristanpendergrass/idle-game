module CombatTypes exposing (..)

{-| TECHNICAL EXPLORATION - NOT CURRENTLY IN USE

This combat system was a technical exploration but is not currently integrated
into the game. It was removed from the active codebase because the Move type
(a function: State -> Random.Generator ...) cannot be serialized by Lamdera's
wire protocol.

Related files preserved for future reference:

  - src/CombatTypes.elm (this file) - Type definitions
  - src/IdleGame/Combat.elm - Core combat logic
  - src/IdleGame/CombatWrapper.elm - UI wrapper and Elm Architecture integration
  - src/IdleGame/Combat\_test.elm - Tests

To reintegrate, the function-based Move type would need to be replaced with a
data-based representation (e.g., a union type like `type MoveKind = SwingMove Int | BlockMove Int`)
that can be serialized, with an interpreter function that generates the Random.Generator at runtime.

-}

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


type alias Config =
    { leftMoves : List Move
    , rightMoves : List Move
    }
