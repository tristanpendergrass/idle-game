module IdleGame.Game_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import Fuzz exposing (Fuzzer)
import Html.Attributes exposing (download)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Event exposing (..)
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
import Types exposing (..)


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


expectResource : Int -> Resource -> (Game -> Expectation)
expectResource amount kind =
    .resources >> getByResource kind >> Expect.equal amount


hasResource : Int -> Resource -> (Game -> Bool)
hasResource amount kind =
    .resources >> getByResource kind >> (==) amount


expectXp : Xp -> Skill -> (Game -> Expectation)
expectXp amount skill =
    .xp >> getBySkill skill >> Expect.equal amount


hasXp : Xp -> Skill -> (Game -> Bool)
hasXp amount skill =
    .xp >> getBySkill skill >> (==) amount


defaultGame : Game
defaultGame =
    Game.createProd (Random.initialSeed 0)


testEffects : String -> { initialGame : Game, effects : List Effect, count : Int, check : Result EffectErr { game : Game, toasts : List Toast } -> Expectation } -> Test
testEffects name { initialGame, effects, count, check } =
    Test.Random.check
        name
        (Game.applyEffects (Game.getAllMods initialGame) effects count initialGame)
        check


testEffectsDistribution :
    String
    ->
        { initialGame : Game
        , effects : List Effect
        , count : Int
        , distribution : Distribution (Result EffectErr Game.ApplyEffectsValue)
        }
    -> Test
testEffectsDistribution name { initialGame, effects, count, distribution } =
    Test.fuzzWith
        { runs = 100
        , distribution = distribution
        }
        (Fuzz.fromGenerator (Game.applyEffects (Game.getAllMods initialGame) effects count initialGame))
        name
        (\_ -> Expect.pass)


applyEffectsTest : Test
applyEffectsTest =
    -- TODO: test tail call optimization in applyEffects
    describe "applyEffects"
        [ describe "GainCoin"
            [ testEffects "can get a coin"
                { initialGame = defaultGame
                , effects = [ Effect.gainCoin (Coin.int 5) ]
                , count = 1
                , check = expectOk (expectCoin (Coin.int 5))
                }
            , testEffects "can get a coin with count of 5"
                { initialGame = defaultGame
                , effects = [ Effect.gainCoin (Coin.int 5) ]
                , count = 5
                , check = expectOk (expectCoin (Coin.int 25))
                }
            , testEffects "can add and remove coin"
                { initialGame = defaultGame
                , effects =
                    [ Effect.gainCoin (Coin.int 5)
                    , Effect.gainCoin (Coin.int -4)
                    ]
                , count = 1
                , check = expectOk (expectCoin (Coin.int 1))
                }
            , testEffects "cannot go below zero coin"
                { initialGame = defaultGame
                , effects = [ Effect.gainCoin (Coin.int -5) ]
                , count = 1
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            , testEffects "cannot go below zero coin and order matters"
                { initialGame = defaultGame
                , effects =
                    [ Effect.gainCoin (Coin.int 5)
                    , Effect.gainCoin (Coin.int -6)
                    , Effect.gainCoin (Coin.int 2)
                    ]
                , count = 1
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            ]

        -- , describe "GainXp"
        --     [ testEffects "can get Xp for Anatomy"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.gainXp (Xp.int 5) Anatomy ]
        --         , count = 1
        --         , check = expectOk (expectXp (Xp.int 5) Chores)
        --         }
        --     , testEffects "can get Xp for Hexes"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.gainXp (Xp.int 5) Hexes ]
        --         , count = 1
        --         , check = expectOk (expectXp (Xp.int 5) Hexes)
        --         }
        --     , testEffects "can get Xp for Chores with count of 5"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.gainXp (Xp.int 5) Chores ]
        --         , count = 5
        --         , check = expectOk (expectXp (Xp.int 25) Chores)
        --         }
        --     ]
        -- , describe "GainResource"
        --     [ testEffects "can get resources"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.gainResource 1 EmptyBottle ]
        --         , count = 1
        --         , check = expectOk (expectResource 1 EmptyBottle)
        --         }
        --     , testEffects
        --         "can get resources with count of 5"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.gainResource 1 EmptyBottle ]
        --         , count = 5
        --         , check = expectOk (expectResource 5 EmptyBottle)
        --         }
        --     , testEffects "cannot go below 0 of a resource"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.spendResource 1 EmptyBottle ]
        --         , count = 1
        --         , check = expectErr (Expect.equal EffectErr.NegativeAmount)
        --         }
        --     , testEffectsDistribution "doubling chance of 50% works"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.gainResourceWithDoubling 1 EmptyBottle (Percent.float 0.5) ]
        --         , count = 1
        --         , distribution =
        --             Test.expectDistribution
        --                 [ ( Test.Distribution.atLeast 45
        --                   , "has 1 of resource"
        --                   , hasOk (hasResource 1 EmptyBottle)
        --                   )
        --                 , ( Test.Distribution.atLeast 45
        --                   , "has 2 of resource"
        --                   , hasOk (hasResource 2 EmptyBottle)
        --                   )
        --                 , ( Test.Distribution.zero
        --                   , "has something else"
        --                   , hasOk
        --                         (hasNoneOf
        --                             [ hasResource 1 EmptyBottle
        --                             , hasResource 2 EmptyBottle
        --                             ]
        --                         )
        --                   )
        --                 ]
        --         }
        --     , testEffectsDistribution "doubling chance of 50% works with count of 5"
        --         { initialGame = defaultGame
        --         , effects = [ Effect.gainResourceWithDoubling 1 EmptyBottle (Percent.float 0.5) ]
        --         , count = 5
        --         , distribution =
        --             Test.expectDistribution
        --                 [ ( Test.Distribution.atLeast 45
        --                   , "has 5 of resource"
        --                   , hasOk (hasResource 5 EmptyBottle)
        --                   )
        --                 , ( Test.Distribution.atLeast 45
        --                   , "has 10 of resource"
        --                   , hasOk (hasResource 10 EmptyBottle)
        --                   )
        --                 , ( Test.Distribution.zero
        --                   , "has something else"
        --                   , hasOk
        --                         (hasNoneOf
        --                             [ hasResource 5 EmptyBottle
        --                             , hasResource 10 EmptyBottle
        --                             ]
        --                         )
        --                   )
        --                 ]
        --         }
        --     ]
        -- , describe "variable effects"
        --     [ testEffectsDistribution "can have a 50% chance to gain a resource"
        --         { initialGame = defaultGame
        --         , effects =
        --             [ Effect.gainWithProbability (Percent.float 0.5)
        --                 [ Effect.gainResource 1 EmptyBottle ]
        --             ]
        --         , count = 1
        --         , distribution =
        --             Test.expectDistribution
        --                 [ ( Test.Distribution.atLeast 45
        --                   , "has 0 of resource"
        --                   , hasOk (hasResource 0 EmptyBottle)
        --                   )
        --                 , ( Test.Distribution.atLeast 45
        --                   , "has 1 of resource"
        --                   , hasOk (hasResource 1 EmptyBottle)
        --                   )
        --                 , ( Test.Distribution.zero
        --                   , "has more than 1 reasource"
        --                   , hasOk
        --                         (hasNoneOf
        --                             [ hasResource 0 EmptyBottle
        --                             , hasResource 1 EmptyBottle
        --                             ]
        --                         )
        --                   )
        --                 ]
        --         }
        --     ]
        ]
