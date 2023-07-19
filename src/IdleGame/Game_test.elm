module IdleGame.Game_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import Html.Attributes exposing (download)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter
import IdleGame.Event as Event exposing (..)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Quantity
import Random
import Test exposing (..)
import Test.Random


expectOk : (Game -> Expectation) -> Result Game.ApplyEffectErr Game.ApplyEffectsValue -> Expectation
expectOk check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.game


expectErr : (Game.ApplyEffectErr -> Expectation) -> Result Game.ApplyEffectErr Game.ApplyEffectsValue -> Expectation
expectErr check result =
    case result of
        Err err ->
            check err

        Ok _ ->
            Expect.fail "applyEffect was expected to return Err"


expectToasts : (List Toast -> Expectation) -> Result Game.ApplyEffectErr Game.ApplyEffectsValue -> Expectation
expectToasts check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.toasts


expectCoin : Coin -> (Game -> Expectation)
expectCoin amount =
    .coin >> Expect.equal amount


expectXp : Xp -> Skill.Kind -> (Game -> Expectation)
expectXp amount skill =
    .xp >> Skill.getByKind skill >> Expect.equal amount


initialGame : Game
initialGame =
    Game.create (Random.initialSeed 0)


testEffects : String -> { effects : List Effect, check : Result Game.ApplyEffectErr { game : Game, toasts : List Toast } -> Expectation } -> Test
testEffects name { effects, check } =
    Test.Random.check
        name
        (Game.applyEffects effects initialGame)
        check


applyEffectsTest : Test
applyEffectsTest =
    -- TODO: test tail call optimization in applyEffects
    describe "applyEffects"
        [ testEffects "applies GainCoin"
            { effects = [ Event.gainCoin (Coin.int 5) ]
            , check = expectOk (expectCoin (Coin.int 5))
            }
        , testEffects "applies GainCoin and GainXp"
            { effects =
                [ Event.gainCoin (Coin.int 5)
                , Event.gainXp (Xp.int 5) Skill.Chores
                ]
            , check =
                Expect.all
                    (List.map expectOk
                        [ expectCoin (Coin.int 5)
                        , expectXp (Xp.int 5) Skill.Chores
                        ]
                    )
            }
        , testEffects "can add and remove coin"
            { effects =
                [ Event.gainCoin (Coin.int 5)
                , Event.gainCoin (Coin.int -4)
                ]
            , check = expectOk (expectCoin (Coin.int 1))
            }
        , testEffects "cannot go below zero coin"
            { effects = [ Event.gainCoin (Coin.int -5) ]
            , check = expectErr (Expect.equal Game.EffectErr)
            }
        , testEffects "order matters when subtracting coin"
            { effects =
                [ Event.gainCoin (Coin.int 5)
                , Event.gainCoin (Coin.int -6)
                ]
            , check = expectErr (Expect.equal Game.EffectErr)
            }
        ]
