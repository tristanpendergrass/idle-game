module IdleGame.Combat_test exposing (..)

import CombatTypes exposing (..)
import Expect exposing (..)
import IdleGame.Combat exposing (step)
import Random
import Test exposing (..)



-- A Move that always does 10 damage to the opponent


alwaysDamage10 : Move
alwaysDamage10 _ =
    Random.constant [ ( Damage 10, Opponent ) ]


suite : Test
suite =
    describe "Combat.step"
        [ test "step with Damage 10 from both sides reduces health by 10 each" <|
            \_ ->
                let
                    params =
                        { leftMaxHealth = 100
                        , rightMaxHealth = 100
                        , leftMoves = [ alwaysDamage10 ]
                        , rightMoves = [ alwaysDamage10 ]
                        }

                    state =
                        { leftState = { health = 100, block = 0 }
                        , rightState = { health = 100, block = 0 }
                        , moveIndex = 0
                        , log = []
                        }

                    gen =
                        step params state

                    ( resultState, _ ) =
                        Random.step gen (Random.initialSeed 42)
                in
                Expect.equal resultState
                    { leftState = { health = 90, block = 0 }
                    , rightState = { health = 90, block = 0 }
                    , moveIndex = 0
                    , log = []
                    }
        ]
