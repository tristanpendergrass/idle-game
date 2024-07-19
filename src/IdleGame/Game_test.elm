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
import IdleGame.OneTime as OneTime
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
            Expect.fail "expected an Err"


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


hasResourceBetween : ( Int, Int ) -> Resource -> (Game -> Bool)
hasResourceBetween ( min, max ) kind game =
    let
        resourceCounts : ResourceRecord Int
        resourceCounts =
            game.resources

        myResourceCount : Int
        myResourceCount =
            getByResource kind resourceCounts
    in
    myResourceCount >= min && myResourceCount <= max


expectXp : Xp -> Skill -> (Game -> Expectation)
expectXp amount skill =
    .xp >> getBySkill skill >> Expect.equal amount


hasXp : Xp -> Skill -> (Game -> Bool)
hasXp amount skill =
    .xp >> getBySkill skill >> (==) amount


defaultGame : Game
defaultGame =
    Game.createProd (Random.initialSeed 0)


type ApplyEffectsTestConfig
    = ApplyEffectsTestConfig
        { name : String
        , game : Game
        , effects : List Effect
        , count : Int
        , mods : List Mod
        }


type alias Check =
    Result EffectErr { game : Game, toasts : List Toast } -> Expectation


testApplyEffect : String -> ApplyEffectsTestConfig
testApplyEffect name =
    ApplyEffectsTestConfig
        { name = name
        , game = defaultGame
        , effects = []
        , count = 1
        , mods = []
        }


runTest : Check -> ApplyEffectsTestConfig -> Test
runTest checkFn (ApplyEffectsTestConfig config) =
    Test.Random.check
        config.name
        (Game.applyEffects config.mods (List.map (Game.EffectWithCount config.count) config.effects) config.game)
        checkFn


runTestDistribution : Distribution (Result EffectErr Game.ApplyEffectsValue) -> ApplyEffectsTestConfig -> Test
runTestDistribution distribution (ApplyEffectsTestConfig config) =
    Test.fuzzWith
        -- { runs = 100
        { runs = 1
        , distribution = distribution
        }
        (Fuzz.fromGenerator (Game.applyEffects config.mods (List.map (Game.EffectWithCount config.count) config.effects) config.game))
        config.name
        (\_ -> Expect.pass)


withEffects : List Effect -> ApplyEffectsTestConfig -> ApplyEffectsTestConfig
withEffects effects (ApplyEffectsTestConfig config) =
    ApplyEffectsTestConfig { config | effects = effects }


withMods : List Mod -> ApplyEffectsTestConfig -> ApplyEffectsTestConfig
withMods mods (ApplyEffectsTestConfig config) =
    ApplyEffectsTestConfig { config | mods = mods }


withGame : Game -> ApplyEffectsTestConfig -> ApplyEffectsTestConfig
withGame game (ApplyEffectsTestConfig config) =
    ApplyEffectsTestConfig { config | game = game }


withCount : Int -> ApplyEffectsTestConfig -> ApplyEffectsTestConfig
withCount count (ApplyEffectsTestConfig config) =
    ApplyEffectsTestConfig { config | count = count }


applyEffectsTest =
    -- TODO: test tail call optimization in applyEffects
    describe "applyEffects"
        [ describe "GainCoin"
            [ testApplyEffect "can get a coin"
                |> withEffects [ Effect.gainCoin (Coin.int 5) ]
                |> runTest (expectOk (expectCoin (Coin.int 5)))
            , testApplyEffect "can get a coin with count of 5"
                |> withEffects [ Effect.gainCoin (Coin.int 5) ]
                |> withCount 5
                |> runTest (expectOk (expectCoin (Coin.int 25)))
            , testApplyEffect "can add and remove coin"
                |> withEffects
                    [ Effect.gainCoin (Coin.int 5)
                    , Effect.gainCoin (Coin.int -4)
                    ]
                |> runTest (expectOk (expectCoin (Coin.int 1)))
            , testApplyEffect "cannot go below zero coin"
                |> withEffects [ Effect.gainCoin (Coin.int -5) ]
                |> runTest (expectErr (Expect.equal EffectErr.NegativeAmount))
            , testApplyEffect "cannot go below zero coin and order matters"
                |> withEffects
                    [ Effect.gainCoin (Coin.int 5)
                    , Effect.gainCoin (Coin.int -6)
                    , Effect.gainCoin (Coin.int 2)
                    ]
                |> runTest (expectErr (Expect.equal EffectErr.NegativeAmount))
            ]
        , describe "SpendResource"
            [ testApplyEffect "can spend a resource"
                |> withEffects
                    [ Effect.gainResource 5 AnatomyK
                    , Effect.spendResource 3 AnatomyK
                    ]
                |> runTest (expectOk (expectResource 2 AnatomyK))
            , testApplyEffect "can't go below 0 of a resource"
                |> withEffects
                    [ Effect.gainResource 5 AnatomyK
                    , Effect.spendResource 8 AnatomyK
                    ]
                |> runTest (expectErr (Expect.equal EffectErr.NegativeAmount))
            , testApplyEffect "it can be reduced by a flat amount"
                |> withEffects
                    [ Effect.gainResource 5 AnatomyK
                    , Effect.gainResource 1 AnatomyPK
                    , Effect.spendResource 3 AnatomyK
                        |> Effect.withReducedBy (Effect.ReducedByFlat AnatomyPK)
                    ]
                |> runTest (expectOk (expectResource 3 AnatomyK))
            , testApplyEffect "it can be reduced by a percent amount"
                |> withEffects
                    [ Effect.gainResource 100 AnatomyK
                    , Effect.gainResource 2 AnatomyPK
                    , Effect.spendResource 100 AnatomyK
                        |> Effect.withReducedBy (Effect.ReducedByPercent AnatomyPK (Percent.float 0.05))
                    ]
                |> runTest (expectOk (expectResource 10 AnatomyK))
            ]
        , describe "one time effects"
            [ let
                oneTimeEffect : Effect
                oneTimeEffect =
                    Effect.gainResource 5 AnatomyK
                        |> Effect.withOneTime OneTime.Lab1
              in
              testApplyEffect "only happen once"
                |> withEffects
                    [ oneTimeEffect
                    , oneTimeEffect
                    ]
                |> runTest (expectOk (expectResource 5 AnatomyK))
            , let
                oneTimeEffect : Effect
                oneTimeEffect =
                    Effect.gainResource 5 AnatomyK
                        |> Effect.withOneTime OneTime.Lab1
              in
              testApplyEffect "only happen once even when applied using count greater than 1"
                |> withEffects [ oneTimeEffect ]
                |> withCount 3
                |> runTest (expectOk (expectResource 5 AnatomyK))
            ]
        , describe "GainResource"
            [ testApplyEffect "can get resources"
                |> withEffects [ Effect.gainResource 1 AnatomyK ]
                |> runTest (expectOk (expectResource 1 AnatomyK))
            , testApplyEffect "can get resources with count of 5"
                |> withEffects [ Effect.gainResource 1 AnatomyK ]
                |> withCount 5
                |> runTest (expectOk (expectResource 5 AnatomyK))
            , testApplyEffect "cannot go below 0 of a resource"
                |> withEffects [ Effect.spendResource 1 AnatomyK ]
                |> runTest (expectErr (Expect.equal EffectErr.NegativeAmount))
            , testApplyEffect "doubling chance of 50% works"
                |> withEffects [ Effect.gainResourceWithDoubling 1 AnatomyK (Percent.float 0.5) ]
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 1 of resource"
                          , hasOk (hasResource 1 AnatomyK)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 2 of resource"
                          , hasOk (hasResource 2 AnatomyK)
                          )
                        , ( Test.Distribution.zero
                          , "has something else"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 1 AnatomyK
                                    , hasResource 2 AnatomyK
                                    ]
                                )
                          )
                        ]
                    )
            , testApplyEffect "doubling chance of 50% works with count of 5"
                |> withEffects [ Effect.gainResourceWithDoubling 1 AnatomyK (Percent.float 0.5) ]
                |> withCount 5
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 5 of resource"
                          , hasOk (hasResource 5 AnatomyK)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 10 of resource"
                          , hasOk (hasResource 10 AnatomyK)
                          )
                        , ( Test.Distribution.zero
                          , "has something else"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 5 AnatomyK
                                    , hasResource 10 AnatomyK
                                    ]
                                )
                          )
                        ]
                    )
            ]
        , describe "VariableSuccess"
            [ testApplyEffect "can have a 50% chance to gain a resource"
                |> withEffects
                    [ Effect.gainWithProbability (Percent.float 0.5) [ Effect.gainResource 1 AnatomyK ]
                    ]
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 1 of resource"
                          , hasOk (hasResource 1 AnatomyK)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 0 of resource"
                          , hasOk (hasResource 0 AnatomyK)
                          )
                        , ( Test.Distribution.zero
                          , "has more than 1 reasource"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 0 AnatomyK
                                    , hasResource 1 AnatomyK
                                    ]
                                )
                          )
                        ]
                    )
            , testApplyEffect "chance to gain a resource works correctly on count > 1"
                |> withEffects
                    [ Effect.gainWithProbability (Percent.float 0.5) [ Effect.gainResource 1 AnatomyK ]
                    ]
                |> withCount 100
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 90
                          , "is between 42 and 58"
                          , hasOk (hasResourceBetween ( 42, 58 ) AnatomyK)
                          )
                        ]
                    )
            , testApplyEffect "chance to gain a resource works correctly on high count"
                |> withEffects
                    [ Effect.gainWithProbability (Percent.float 0.5) [ Effect.gainResource 1 AnatomyK ]
                    ]
                |> withCount 1000
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 90
                          , "is between 4200 and 5800"
                          , hasOk (hasResourceBetween ( 420, 580 ) AnatomyK)
                          )
                        ]
                    )
            , testApplyEffect "chance to gain a resource works correctly on very high count"
                |> withEffects
                    [ Effect.gainWithProbability (Percent.float 0.5) [ Effect.gainResource 1 AnatomyK ]
                    ]
                |> withCount 10000
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 90
                          , "is between 42000 and 58000"
                          , hasOk (hasResourceBetween ( 4200, 5800 ) AnatomyK)
                          )
                        ]
                    )
            ]
        , describe "OneOf effect"
            [ testApplyEffect "can choose between two effects"
                |> withEffects
                    [ Effect.oneOf
                        (Effect.gainResource 1 AnatomyK)
                        [ Effect.gainResource 1 MicrobiologyK
                        ]
                    ]
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 45
                          , "has 1 AnatomyK"
                          , hasOk
                                (hasResource 1 AnatomyK)
                          )
                        , ( Test.Distribution.atLeast 45
                          , "has 1 MicrobiologyK"
                          , hasOk
                                (hasResource 1 MicrobiologyK)
                          )
                        , ( Test.Distribution.zero
                          , "has something else"
                          , hasOk
                                (hasNoneOf
                                    [ hasResource 1 AnatomyK
                                    , hasResource 1 MicrobiologyK
                                    ]
                                )
                          )
                        ]
                    )
            , testApplyEffect "can choose between two effects many times"
                |> withEffects
                    [ Effect.oneOf
                        (Effect.gainResource 1 AnatomyK)
                        [ Effect.gainResource 1 MicrobiologyK
                        ]
                    ]
                |> withCount 100
                |> runTestDistribution
                    (Test.expectDistribution
                        [ ( Test.Distribution.atLeast 90
                          , "has the expected number of AnatomyK"
                          , hasOk
                                (hasResourceBetween ( 42, 58 ) AnatomyK)
                          )
                        , ( Test.Distribution.atLeast 99
                          , "was given something each time"
                          , hasOk
                                (\game ->
                                    let
                                        anatomyK =
                                            getByResource AnatomyK game.resources

                                        microbiologyK =
                                            getByResource MicrobiologyK game.resources
                                    in
                                    anatomyK + microbiologyK == 100
                                )
                          )
                        ]
                    )
            ]
        ]
