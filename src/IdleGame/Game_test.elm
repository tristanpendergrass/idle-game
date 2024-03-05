module IdleGame.Game_test exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import Fuzz exposing (Fuzzer)
import Html.Attributes exposing (download)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter
import IdleGame.Effect as Effect
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


testEffects : String -> { initialGame : Game, effects : List Effect.TaggedEffect, check : Result EffectErr { game : Game, toasts : List Toast } -> Expectation } -> Test
testEffects name { initialGame, effects, check } =
    Test.Random.check
        name
        (Game.applyEffects effects initialGame)
        check


testEffectsDistribution :
    String
    ->
        { initialGame : Game
        , effects : List Effect.TaggedEffect
        , distribution : Distribution (Result EffectErr Game.ApplyEffectsValue)
        }
    -> Test
testEffectsDistribution name { initialGame, effects, distribution } =
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
                { initialGame = defaultGame
                , effects = [ Effect.gainCoin (Coin.int 5) ]
                , check = expectOk (expectCoin (Coin.int 5))
                }
            , testEffects "can add and remove coin"
                { initialGame = defaultGame
                , effects =
                    [ Effect.gainCoin (Coin.int 5)
                    , Effect.gainCoin (Coin.int -4)
                    ]
                , check = expectOk (expectCoin (Coin.int 1))
                }
            , testEffects "cannot go below zero coin"
                { initialGame = defaultGame
                , effects = [ Effect.gainCoin (Coin.int -5) ]
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            , testEffects "cannot go below zero coin and order matters"
                { initialGame = defaultGame
                , effects =
                    [ Effect.gainCoin (Coin.int 5)
                    , Effect.gainCoin (Coin.int -6)
                    , Effect.gainCoin (Coin.int 2)
                    ]
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            ]
        , describe "GainXp"
            [ testEffects "can get Xp for Chores"
                { initialGame = defaultGame
                , effects = [ Effect.gainXp (Xp.int 5) Chores ]
                , check = expectOk (expectXp (Xp.int 5) Chores)
                }
            , testEffects "can get Xp for Hexes"
                { initialGame = defaultGame
                , effects = [ Effect.gainXp (Xp.int 5) Hexes ]
                , check = expectOk (expectXp (Xp.int 5) Hexes)
                }
            ]
        , describe "GainResource"
            [ testEffects "can get resources"
                { initialGame = defaultGame
                , effects = [ Effect.gainResource 1 EmptyBottle ]
                , check = expectOk (expectResource 1 EmptyBottle)
                }
            , testEffects "cannot go below 0 of a resource"
                { initialGame = defaultGame
                , effects = [ Effect.spendResource 1 EmptyBottle ]
                , check = expectErr (Expect.equal EffectErr.NegativeAmount)
                }
            , testEffectsDistribution "doubling chance of 50% works"
                { initialGame = defaultGame
                , effects = [ Effect.gainResourceWithDoubling 1 EmptyBottle (Percent.float 0.5) ]
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 1 of resource"
                          , hasOk (hasResource 1 EmptyBottle)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 2 of resource"
                          , hasOk (hasResource 2 EmptyBottle)
                          )
                        , ( Test.Distribution.zero
                          , "has something else"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 1 EmptyBottle
                                    , hasResource 2 EmptyBottle
                                    ]
                                )
                          )
                        ]
                }
            ]
        , describe "variable effects"
            [ testEffectsDistribution "can have a 50% chance to gain a resource"
                { initialGame = defaultGame
                , effects =
                    [ Effect.gainWithProbability (Percent.float 0.5)
                        [ Effect.gainResource 1 EmptyBottle ]
                    ]
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 0 of resource"
                          , hasOk (hasResource 0 EmptyBottle)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 1 of resource"
                          , hasOk (hasResource 1 EmptyBottle)
                          )
                        , ( Test.Distribution.zero
                          , "has more than 1 reasource"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 0 EmptyBottle
                                    , hasResource 1 EmptyBottle
                                    ]
                                )
                          )
                        ]
                }
            ]
        ]


{-| Test some scenarios related to spell selectors:

  - That a spell that's selected has its effects applied (use Game.selectSpell)
  - That a spell that's selected but not learned has no effects applied
  - That a spell that's selected and used deducts the appropriate scroll
  - That a spell that's selected with no scrolls left has no effects applied

-}
grantScrolls : Game -> Game
grantScrolls game =
    { game | scrolls = spellRecord 1000 }


spellSelectorTest : Test
spellSelectorTest =
    let
        effect : Effect.TaggedEffect
        effect =
            Effect.gainXp (Xp.int 10) Chores
                |> Effect.withTags [ Effect.ActivityTag CleanBigBubba ]
    in
    describe "SpellSelector"
        [ testEffects "Spell has the correct effect"
            { initialGame =
                defaultGame
                    |> Game.selectSpell { activity = CleanBigBubba, maybeSpell = Just Wind }
                    |> Game.setActivitySkilling (Just ( CleanBigBubba, Timer.create ))
                    |> grantScrolls
            , effects = [ effect ]
            , check = expectOk (expectXp (Xp.int 12) Chores)
            }
        , testEffects "Spell has no effect when no scrolls"
            { initialGame =
                defaultGame
                    |> Game.selectSpell { activity = CleanBigBubba, maybeSpell = Just Wind }
                    |> Game.setActivitySkilling (Just ( CleanBigBubba, Timer.create ))
            , effects = [ effect ]
            , check = expectOk (expectXp (Xp.int 10) Chores)
            }
        , testEffects
            "Spell deducts a scroll"
            { initialGame =
                defaultGame
                    |> Game.selectSpell { activity = CleanBigBubba, maybeSpell = Just Wind }
                    |> Game.setActivitySkilling (Just ( CleanBigBubba, Timer.create ))
                    |> grantScrolls
            , effects = [ effect ]
            , check =
                expectOk
                    (\game ->
                        getBySpell Wind game.scrolls
                            |> Expect.equal 999
                    )
            }
        ]
