module IdleGame.Game_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import Fuzz exposing (Fuzzer)
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
import Test.Distribution
import Test.Random


hasNoneOf : List (Game -> Bool) -> Game -> Bool
hasNoneOf checks game =
    List.all (\check -> not (check game)) checks


expectOk : (Game -> Expectation) -> Result EffectErr Game.ApplyEffectsValue -> Expectation
expectOk check result =
    case result of
        Err _ ->
            Expect.fail "applyEffect returned Err"

        Ok val ->
            check val.game


hasOk : (Game -> Bool) -> Result EffectErr Game.ApplyEffectsValue -> Bool
hasOk check result =
    case result of
        Err _ ->
            False

        Ok val ->
            check val.game


expectErr : (EffectErr -> Expectation) -> Result EffectErr Game.ApplyEffectsValue -> Expectation
expectErr check result =
    case result of
        Err err ->
            check err

        Ok _ ->
            Expect.fail "applyEffect was expected to return Err"


hasErr : (EffectErr -> Bool) -> Result EffectErr Game.ApplyEffectsValue -> Bool
hasErr check result =
    case result of
        Err err ->
            check err

        Ok _ ->
            False


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


hasCoin : Coin -> (Game -> Bool)
hasCoin amount =
    .coin >> (==) amount


expectResource : Int -> Resource.Kind -> (Game -> Expectation)
expectResource amount kind =
    .resources >> Resource.getByKind kind >> Expect.equal amount


hasResource : Int -> Resource.Kind -> (Game -> Bool)
hasResource amount kind =
    .resources >> Resource.getByKind kind >> (==) amount


expectXp : Xp -> Skill.Kind -> (Game -> Expectation)
expectXp amount skill =
    .xp >> Skill.getByKind skill >> Expect.equal amount


hasXp : Xp -> Skill.Kind -> (Game -> Bool)
hasXp amount skill =
    .xp >> Skill.getByKind skill >> (==) amount


initialGame : Game
initialGame =
    Game.create (Random.initialSeed 0)


testEffects : String -> { effects : List Effect, check : Result EffectErr { game : Game, toasts : List Toast } -> Expectation } -> Test
testEffects name { effects, check } =
    Test.Random.check
        name
        (Game.applyEffects effects initialGame)
        check


testEffectsDistribution :
    String
    ->
        { effects : List Effect
        , distribution : Distribution (Result EffectErr Game.ApplyEffectsValue)
        }
    -> Test
testEffectsDistribution name { effects, distribution } =
    Test.fuzzWith
        { runs = 100
        , distribution = distribution
        }
        (Fuzz.fromGenerator (Game.applyEffects effects initialGame))
        name
        (\_ -> Expect.pass)


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
            , testEffectsDistribution "doubling chance of 50% works"
                { effects = [ Event.gainResourceWithDoubling 1 Resource.EmptyBottle 0.5 ]
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 1 of resource"
                          , hasOk (hasResource 1 Resource.EmptyBottle)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 2 of resource"
                          , hasOk (hasResource 2 Resource.EmptyBottle)
                          )
                        , ( Test.Distribution.zero
                          , "has something else"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 1 Resource.EmptyBottle
                                    , hasResource 2 Resource.EmptyBottle
                                    ]
                                )
                          )
                        ]
                }
            ]
        , describe "variable effects"
            [ testEffectsDistribution "can have a 50% chance to gain a resource"
                { effects =
                    [ Event.gainWithProbability 0.5
                        [ Event.gainResource 1 Resource.EmptyBottle ]
                    ]
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 0 of resource"
                          , hasOk (hasResource 0 Resource.EmptyBottle)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 1 of resource"
                          , hasOk (hasResource 1 Resource.EmptyBottle)
                          )
                        , ( Test.Distribution.zero
                          , "has more than 1 reasource"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 0 Resource.EmptyBottle
                                    , hasResource 1 Resource.EmptyBottle
                                    ]
                                )
                          )
                        ]
                }
            ]
        ]