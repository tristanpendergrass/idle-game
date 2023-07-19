module IdleGame.Game_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import Html.Attributes exposing (download)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Event as Event exposing (..)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Quantity
import Random
import Test exposing (..)
import Test.Random


expectOk : (Game -> Expectation) -> Result EffectErr Game.ApplyEffectsValue -> Expectation
expectOk check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.game


expectErr : (EffectErr -> Expectation) -> Result EffectErr Game.ApplyEffectsValue -> Expectation
expectErr check result =
    case result of
        Err err ->
            check err

        Ok _ ->
            Expect.fail "applyEffect was expected to return Err"


expectToasts : (List Toast -> Expectation) -> Result EffectErr Game.ApplyEffectsValue -> Expectation
expectToasts check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.toasts


expectCoin : Coin -> (Game -> Expectation)
expectCoin amount =
    .coin >> Expect.equal amount


expectResource : Int -> Resource.Kind -> (Game -> Expectation)
expectResource amount kind =
    .resources >> Resource.getByKind kind >> Expect.equal amount


expectXp : Xp -> Skill.Kind -> (Game -> Expectation)
expectXp amount skill =
    .xp >> Skill.getByKind skill >> Expect.equal amount


initialGame : Game
initialGame =
    Game.create (Random.initialSeed 0)


testEffects : String -> { effects : List Effect, check : Result EffectErr { game : Game, toasts : List Toast } -> Expectation } -> Test
testEffects name { effects, check } =
    Test.Random.check
        name
        (Game.applyEffects effects initialGame)
        check


applyEffectsTest : Test
applyEffectsTest =
    -- TODO: test tail call optimization in applyEffects
    describe "applyEffects"
        [ describe "GainCoin"
            [ testEffects "can get a coin"
                { effects = [ Event.gainCoin (Coin.int 5) ]
                , check = expectOk (expectCoin (Coin.int 5))
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
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            , testEffects "cannot go below zero coin and order matters"
                { effects =
                    [ Event.gainCoin (Coin.int 5)
                    , Event.gainCoin (Coin.int -6)
                    , Event.gainCoin (Coin.int 2)
                    ]
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            ]
        , describe "GainXp"
            [ testEffects "can get Xp for Chores"
                { effects = [ Event.gainXp (Xp.int 5) Skill.Chores ]
                , check = expectOk (expectXp (Xp.int 5) Skill.Chores)
                }
            , testEffects "can get Xp for Hexes"
                { effects = [ Event.gainXp (Xp.int 5) Skill.Hexes ]
                , check = expectOk (expectXp (Xp.int 5) Skill.Hexes)
                }
            ]
        , describe "GainResource"
            [ testEffects "can get resources"
                { effects = [ Event.gainResource 1 Resource.EmptyBottle ]
                , check = expectOk (expectResource 1 Resource.EmptyBottle)
                }
            , testEffects "cannot go below 0 of a resource"
                { effects = [ Event.gainResource -1 Resource.EmptyBottle ]
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            ]
        , describe "multiple effects"
            [ testEffects "applies GainCoin and GainXp"
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
            ]
        ]
