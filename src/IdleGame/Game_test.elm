module IdleGame.Game_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import IdleGame.Counter as Counter
import IdleGame.Event exposing (..)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Timer as Timer exposing (Timer)
import Percent exposing (Percent)
import Quantity
import Random
import Test exposing (..)
import Test.Random


expectGame : (Game -> Expectation) -> Result Game.ApplyEffectErr Game.ApplyEffectValue -> Expectation
expectGame check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.game


expectToasts : (List Toast -> Expectation) -> Result Game.ApplyEffectErr Game.ApplyEffectValue -> Expectation
expectToasts check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.toasts


expectAdditionalEffect : (List Effect -> Expectation) -> Result Game.ApplyEffectErr Game.ApplyEffectValue -> Expectation
expectAdditionalEffect check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.additionalEffects


applyEffectsTest : Test
applyEffectsTest =
    todo "Build out test suite for applyEffects, then refactor applyEffects to allow for tail call optimization"


applyEffectTest : Test
applyEffectTest =
    describe "applyEffect"
        [ describe "for GainCoin" <|
            [ let
                effect : Effect
                effect =
                    Game.gainCoin 5

                initialGame : Game
                initialGame =
                    Game.create (Random.initialSeed 0)

                gameAfterAddingCoin : Game.ApplyEffectResultGenerator
                gameAfterAddingCoin =
                    Game.applyEffect effect initialGame

                checkCoin : Result Game.ApplyEffectErr Game.ApplyEffectValue -> Expectation
                checkCoin result =
                    result
                        |> Result.map
                            (\val ->
                                let
                                    gameCoin : Int
                                    gameCoin =
                                        Counter.getValue val.game.coin
                                in
                                Expect.equal gameCoin 5
                            )
                        |> Result.withDefault (Expect.fail "applyEffect returned Err")
              in
              Test.Random.check "applies GainCoin" gameAfterAddingCoin checkCoin
            ]
        ]
