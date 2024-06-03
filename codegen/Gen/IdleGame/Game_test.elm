module Gen.IdleGame.Game_test exposing (applyEffectsTest, call_, defaultGame, expectCoin, expectErr, expectOk, expectResource, expectToasts, expectXp, hasCoin, hasErr, hasNoneOf, hasOk, hasResource, hasXp, moduleName_, testEffects, testEffectsDistribution, values_)

{-| 
@docs moduleName_, applyEffectsTest, testEffectsDistribution, testEffects, defaultGame, hasXp, expectXp, hasResource, expectResource, hasCoin, expectCoin, expectToasts, hasErr, expectErr, hasOk, expectOk, hasNoneOf, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Game_test" ]


{-| applyEffectsTest: IdleGame.Game_test.Test -}
applyEffectsTest : Elm.Expression
applyEffectsTest =
    Elm.value
        { importFrom = [ "IdleGame", "Game_test" ]
        , name = "applyEffectsTest"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Game_test" ] "Test" [])
        }


{-| testEffectsDistribution: 
    String
    -> { initialGame : IdleGame.Game_test.Game
    , effects : List IdleGame.Effect.Effect
    , count : Int
    , distribution :
        IdleGame.Game_test.Distribution (Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectsValue)
    }
    -> IdleGame.Game_test.Test
-}
testEffectsDistribution :
    String
    -> { initialGame : Elm.Expression
    , effects : List Elm.Expression
    , count : Int
    , distribution : Elm.Expression
    }
    -> Elm.Expression
testEffectsDistribution testEffectsDistributionArg testEffectsDistributionArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "testEffectsDistribution"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.record
                              [ ( "initialGame"
                                , Type.namedWith
                                    [ "IdleGame", "Game_test" ]
                                    "Game"
                                    []
                                )
                              , ( "effects"
                                , Type.list
                                    (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                    )
                                )
                              , ( "count", Type.int )
                              , ( "distribution"
                                , Type.namedWith
                                    [ "IdleGame", "Game_test" ]
                                    "Distribution"
                                    [ Type.namedWith
                                          [ "Result" ]
                                          "Result"
                                          [ Type.namedWith
                                              [ "IdleGame", "EffectErr" ]
                                              "EffectErr"
                                              []
                                          , Type.namedWith
                                              [ "IdleGame", "Game" ]
                                              "ApplyEffectsValue"
                                              []
                                          ]
                                    ]
                                )
                              ]
                          ]
                          (Type.namedWith [ "IdleGame", "Game_test" ] "Test" [])
                     )
             }
        )
        [ Elm.string testEffectsDistributionArg
        , Elm.record
            [ Tuple.pair "initialGame" testEffectsDistributionArg0.initialGame
            , Tuple.pair
                  "effects"
                  (Elm.list testEffectsDistributionArg0.effects)
            , Tuple.pair "count" (Elm.int testEffectsDistributionArg0.count)
            , Tuple.pair "distribution" testEffectsDistributionArg0.distribution
            ]
        ]


{-| testEffects: 
    String
    -> { initialGame : IdleGame.Game_test.Game
    , effects : List IdleGame.Effect.Effect
    , count : Int
    , check :
        Result.Result IdleGame.EffectErr.EffectErr { game : IdleGame.Game_test.Game
        , toasts : List IdleGame.Game_test.Toast
        }
        -> IdleGame.Game_test.Expectation
    }
    -> IdleGame.Game_test.Test
-}
testEffects :
    String
    -> { initialGame : Elm.Expression
    , effects : List Elm.Expression
    , count : Int
    , check : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
testEffects testEffectsArg testEffectsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "testEffects"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.record
                              [ ( "initialGame"
                                , Type.namedWith
                                    [ "IdleGame", "Game_test" ]
                                    "Game"
                                    []
                                )
                              , ( "effects"
                                , Type.list
                                    (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                    )
                                )
                              , ( "count", Type.int )
                              , ( "check"
                                , Type.function
                                    [ Type.namedWith
                                          [ "Result" ]
                                          "Result"
                                          [ Type.namedWith
                                              [ "IdleGame", "EffectErr" ]
                                              "EffectErr"
                                              []
                                          , Type.record
                                              [ ( "game"
                                                , Type.namedWith
                                                    [ "IdleGame", "Game_test" ]
                                                    "Game"
                                                    []
                                                )
                                              , ( "toasts"
                                                , Type.list
                                                    (Type.namedWith
                                                       [ "IdleGame"
                                                       , "Game_test"
                                                       ]
                                                       "Toast"
                                                       []
                                                    )
                                                )
                                              ]
                                          ]
                                    ]
                                    (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Expectation"
                                       []
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "IdleGame", "Game_test" ] "Test" [])
                     )
             }
        )
        [ Elm.string testEffectsArg
        , Elm.record
            [ Tuple.pair "initialGame" testEffectsArg0.initialGame
            , Tuple.pair "effects" (Elm.list testEffectsArg0.effects)
            , Tuple.pair "count" (Elm.int testEffectsArg0.count)
            , Tuple.pair
                  "check"
                  (Elm.functionReduced "testEffectsUnpack" testEffectsArg0.check
                  )
            ]
        ]


{-| defaultGame: IdleGame.Game_test.Game -}
defaultGame : Elm.Expression
defaultGame =
    Elm.value
        { importFrom = [ "IdleGame", "Game_test" ]
        , name = "defaultGame"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Game_test" ] "Game" [])
        }


{-| hasXp: IdleGame.Xp.Xp -> IdleGame.Game_test.Skill -> IdleGame.Game_test.Game -> Bool -}
hasXp : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
hasXp hasXpArg hasXpArg0 hasXpArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "hasXp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Skill"
                              []
                          , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                          ]
                          Type.bool
                     )
             }
        )
        [ hasXpArg, hasXpArg0, hasXpArg1 ]


{-| expectXp: 
    IdleGame.Xp.Xp
    -> IdleGame.Game_test.Skill
    -> IdleGame.Game_test.Game
    -> IdleGame.Game_test.Expectation
-}
expectXp : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
expectXp expectXpArg expectXpArg0 expectXpArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "expectXp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Skill"
                              []
                          , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ expectXpArg, expectXpArg0, expectXpArg1 ]


{-| hasResource: Int -> IdleGame.Game_test.Resource -> IdleGame.Game_test.Game -> Bool -}
hasResource : Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
hasResource hasResourceArg hasResourceArg0 hasResourceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "hasResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Resource"
                              []
                          , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                          ]
                          Type.bool
                     )
             }
        )
        [ Elm.int hasResourceArg, hasResourceArg0, hasResourceArg1 ]


{-| expectResource: 
    Int
    -> IdleGame.Game_test.Resource
    -> IdleGame.Game_test.Game
    -> IdleGame.Game_test.Expectation
-}
expectResource : Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
expectResource expectResourceArg expectResourceArg0 expectResourceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "expectResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Resource"
                              []
                          , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ Elm.int expectResourceArg, expectResourceArg0, expectResourceArg1 ]


{-| hasCoin: IdleGame.Coin.Coin -> IdleGame.Game_test.Game -> Bool -}
hasCoin : Elm.Expression -> Elm.Expression -> Elm.Expression
hasCoin hasCoinArg hasCoinArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "hasCoin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                          , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                          ]
                          Type.bool
                     )
             }
        )
        [ hasCoinArg, hasCoinArg0 ]


{-| expectCoin: IdleGame.Coin.Coin -> IdleGame.Game_test.Game -> IdleGame.Game_test.Expectation -}
expectCoin : Elm.Expression -> Elm.Expression -> Elm.Expression
expectCoin expectCoinArg expectCoinArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "expectCoin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                          , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ expectCoinArg, expectCoinArg0 ]


{-| expectToasts: 
    (List IdleGame.Game_test.Toast -> IdleGame.Game_test.Expectation)
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectsValue
    -> IdleGame.Game_test.Expectation
-}
expectToasts :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectToasts expectToastsArg expectToastsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "expectToasts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.list
                                    (Type.namedWith
                                         [ "IdleGame", "Game_test" ]
                                         "Toast"
                                         []
                                    )
                              ]
                              (Type.namedWith
                                 [ "IdleGame", "Game_test" ]
                                 "Expectation"
                                 []
                              )
                          , Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                    [ "IdleGame", "EffectErr" ]
                                    "EffectErr"
                                    []
                              , Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "ApplyEffectsValue"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ Elm.functionReduced "expectToastsUnpack" expectToastsArg
        , expectToastsArg0
        ]


{-| hasErr: 
    (IdleGame.EffectErr.EffectErr -> Bool)
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectsValue
    -> Bool
-}
hasErr : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
hasErr hasErrArg hasErrArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "hasErr"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "IdleGame", "EffectErr" ]
                                    "EffectErr"
                                    []
                              ]
                              Type.bool
                          , Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                    [ "IdleGame", "EffectErr" ]
                                    "EffectErr"
                                    []
                              , Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "ApplyEffectsValue"
                                    []
                              ]
                          ]
                          Type.bool
                     )
             }
        )
        [ Elm.functionReduced "hasErrUnpack" hasErrArg, hasErrArg0 ]


{-| expectErr: 
    (IdleGame.EffectErr.EffectErr -> IdleGame.Game_test.Expectation)
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectsValue
    -> IdleGame.Game_test.Expectation
-}
expectErr :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectErr expectErrArg expectErrArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "expectErr"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "IdleGame", "EffectErr" ]
                                    "EffectErr"
                                    []
                              ]
                              (Type.namedWith
                                 [ "IdleGame", "Game_test" ]
                                 "Expectation"
                                 []
                              )
                          , Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                    [ "IdleGame", "EffectErr" ]
                                    "EffectErr"
                                    []
                              , Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "ApplyEffectsValue"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ Elm.functionReduced "expectErrUnpack" expectErrArg, expectErrArg0 ]


{-| hasOk: 
    (IdleGame.Game_test.Game -> Bool)
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectsValue
    -> Bool
-}
hasOk : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
hasOk hasOkArg hasOkArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "hasOk"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "IdleGame", "Game_test" ]
                                    "Game"
                                    []
                              ]
                              Type.bool
                          , Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                    [ "IdleGame", "EffectErr" ]
                                    "EffectErr"
                                    []
                              , Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "ApplyEffectsValue"
                                    []
                              ]
                          ]
                          Type.bool
                     )
             }
        )
        [ Elm.functionReduced "hasOkUnpack" hasOkArg, hasOkArg0 ]


{-| expectOk: 
    (IdleGame.Game_test.Game -> IdleGame.Game_test.Expectation)
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectsValue
    -> IdleGame.Game_test.Expectation
-}
expectOk :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectOk expectOkArg expectOkArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "expectOk"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "IdleGame", "Game_test" ]
                                    "Game"
                                    []
                              ]
                              (Type.namedWith
                                 [ "IdleGame", "Game_test" ]
                                 "Expectation"
                                 []
                              )
                          , Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                    [ "IdleGame", "EffectErr" ]
                                    "EffectErr"
                                    []
                              , Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "ApplyEffectsValue"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ Elm.functionReduced "expectOkUnpack" expectOkArg, expectOkArg0 ]


{-| hasNoneOf: List (IdleGame.Game_test.Game -> Bool) -> IdleGame.Game_test.Game -> Bool -}
hasNoneOf : List Elm.Expression -> Elm.Expression -> Elm.Expression
hasNoneOf hasNoneOfArg hasNoneOfArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game_test" ]
             , name = "hasNoneOf"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.function
                                 [ Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Game"
                                       []
                                 ]
                                 Type.bool
                              )
                          , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                          ]
                          Type.bool
                     )
             }
        )
        [ Elm.list hasNoneOfArg, hasNoneOfArg0 ]


call_ :
    { testEffectsDistribution :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , testEffects : Elm.Expression -> Elm.Expression -> Elm.Expression
    , hasXp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectXp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , hasResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , hasCoin : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectCoin : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectToasts : Elm.Expression -> Elm.Expression -> Elm.Expression
    , hasErr : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectErr : Elm.Expression -> Elm.Expression -> Elm.Expression
    , hasOk : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectOk : Elm.Expression -> Elm.Expression -> Elm.Expression
    , hasNoneOf : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { testEffectsDistribution =
        \testEffectsDistributionArg testEffectsDistributionArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "testEffectsDistribution"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.record
                                      [ ( "initialGame"
                                        , Type.namedWith
                                            [ "IdleGame", "Game_test" ]
                                            "Game"
                                            []
                                        )
                                      , ( "effects"
                                        , Type.list
                                            (Type.namedWith
                                               [ "IdleGame", "Effect" ]
                                               "Effect"
                                               []
                                            )
                                        )
                                      , ( "count", Type.int )
                                      , ( "distribution"
                                        , Type.namedWith
                                            [ "IdleGame", "Game_test" ]
                                            "Distribution"
                                            [ Type.namedWith
                                                  [ "Result" ]
                                                  "Result"
                                                  [ Type.namedWith
                                                      [ "IdleGame"
                                                      , "EffectErr"
                                                      ]
                                                      "EffectErr"
                                                      []
                                                  , Type.namedWith
                                                      [ "IdleGame", "Game" ]
                                                      "ApplyEffectsValue"
                                                      []
                                                  ]
                                            ]
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Test"
                                       []
                                  )
                             )
                     }
                )
                [ testEffectsDistributionArg, testEffectsDistributionArg0 ]
    , testEffects =
        \testEffectsArg testEffectsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "testEffects"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.record
                                      [ ( "initialGame"
                                        , Type.namedWith
                                            [ "IdleGame", "Game_test" ]
                                            "Game"
                                            []
                                        )
                                      , ( "effects"
                                        , Type.list
                                            (Type.namedWith
                                               [ "IdleGame", "Effect" ]
                                               "Effect"
                                               []
                                            )
                                        )
                                      , ( "count", Type.int )
                                      , ( "check"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Result" ]
                                                  "Result"
                                                  [ Type.namedWith
                                                      [ "IdleGame"
                                                      , "EffectErr"
                                                      ]
                                                      "EffectErr"
                                                      []
                                                  , Type.record
                                                      [ ( "game"
                                                        , Type.namedWith
                                                            [ "IdleGame"
                                                            , "Game_test"
                                                            ]
                                                            "Game"
                                                            []
                                                        )
                                                      , ( "toasts"
                                                        , Type.list
                                                            (Type.namedWith
                                                               [ "IdleGame"
                                                               , "Game_test"
                                                               ]
                                                               "Toast"
                                                               []
                                                            )
                                                        )
                                                      ]
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "IdleGame", "Game_test" ]
                                               "Expectation"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Test"
                                       []
                                  )
                             )
                     }
                )
                [ testEffectsArg, testEffectsArg0 ]
    , hasXp =
        \hasXpArg hasXpArg0 hasXpArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "hasXp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Skill"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasXpArg, hasXpArg0, hasXpArg1 ]
    , expectXp =
        \expectXpArg expectXpArg0 expectXpArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "expectXp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Skill"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectXpArg, expectXpArg0, expectXpArg1 ]
    , hasResource =
        \hasResourceArg hasResourceArg0 hasResourceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "hasResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Resource"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasResourceArg, hasResourceArg0, hasResourceArg1 ]
    , expectResource =
        \expectResourceArg expectResourceArg0 expectResourceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "expectResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Resource"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectResourceArg, expectResourceArg0, expectResourceArg1 ]
    , hasCoin =
        \hasCoinArg hasCoinArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "hasCoin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Coin" ]
                                      "Coin"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasCoinArg, hasCoinArg0 ]
    , expectCoin =
        \expectCoinArg expectCoinArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "expectCoin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Coin" ]
                                      "Coin"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectCoinArg, expectCoinArg0 ]
    , expectToasts =
        \expectToastsArg expectToastsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "expectToasts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.list
                                            (Type.namedWith
                                                 [ "IdleGame", "Game_test" ]
                                                 "Toast"
                                                 []
                                            )
                                      ]
                                      (Type.namedWith
                                         [ "IdleGame", "Game_test" ]
                                         "Expectation"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.namedWith
                                            [ "IdleGame", "EffectErr" ]
                                            "EffectErr"
                                            []
                                      , Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "ApplyEffectsValue"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectToastsArg, expectToastsArg0 ]
    , hasErr =
        \hasErrArg hasErrArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "hasErr"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "IdleGame", "EffectErr" ]
                                            "EffectErr"
                                            []
                                      ]
                                      Type.bool
                                  , Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.namedWith
                                            [ "IdleGame", "EffectErr" ]
                                            "EffectErr"
                                            []
                                      , Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "ApplyEffectsValue"
                                            []
                                      ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasErrArg, hasErrArg0 ]
    , expectErr =
        \expectErrArg expectErrArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "expectErr"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "IdleGame", "EffectErr" ]
                                            "EffectErr"
                                            []
                                      ]
                                      (Type.namedWith
                                         [ "IdleGame", "Game_test" ]
                                         "Expectation"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.namedWith
                                            [ "IdleGame", "EffectErr" ]
                                            "EffectErr"
                                            []
                                      , Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "ApplyEffectsValue"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectErrArg, expectErrArg0 ]
    , hasOk =
        \hasOkArg hasOkArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "hasOk"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "IdleGame", "Game_test" ]
                                            "Game"
                                            []
                                      ]
                                      Type.bool
                                  , Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.namedWith
                                            [ "IdleGame", "EffectErr" ]
                                            "EffectErr"
                                            []
                                      , Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "ApplyEffectsValue"
                                            []
                                      ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasOkArg, hasOkArg0 ]
    , expectOk =
        \expectOkArg expectOkArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "expectOk"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "IdleGame", "Game_test" ]
                                            "Game"
                                            []
                                      ]
                                      (Type.namedWith
                                         [ "IdleGame", "Game_test" ]
                                         "Expectation"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.namedWith
                                            [ "IdleGame", "EffectErr" ]
                                            "EffectErr"
                                            []
                                      , Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "ApplyEffectsValue"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectOkArg, expectOkArg0 ]
    , hasNoneOf =
        \hasNoneOfArg hasNoneOfArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game_test" ]
                     , name = "hasNoneOf"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.function
                                         [ Type.namedWith
                                               [ "IdleGame", "Game_test" ]
                                               "Game"
                                               []
                                         ]
                                         Type.bool
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasNoneOfArg, hasNoneOfArg0 ]
    }


values_ :
    { applyEffectsTest : Elm.Expression
    , testEffectsDistribution : Elm.Expression
    , testEffects : Elm.Expression
    , defaultGame : Elm.Expression
    , hasXp : Elm.Expression
    , expectXp : Elm.Expression
    , hasResource : Elm.Expression
    , expectResource : Elm.Expression
    , hasCoin : Elm.Expression
    , expectCoin : Elm.Expression
    , expectToasts : Elm.Expression
    , hasErr : Elm.Expression
    , expectErr : Elm.Expression
    , hasOk : Elm.Expression
    , expectOk : Elm.Expression
    , hasNoneOf : Elm.Expression
    }
values_ =
    { applyEffectsTest =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "applyEffectsTest"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Game_test" ] "Test" [])
            }
    , testEffectsDistribution =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "testEffectsDistribution"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.record
                             [ ( "initialGame"
                               , Type.namedWith
                                   [ "IdleGame", "Game_test" ]
                                   "Game"
                                   []
                               )
                             , ( "effects"
                               , Type.list
                                   (Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                   )
                               )
                             , ( "count", Type.int )
                             , ( "distribution"
                               , Type.namedWith
                                   [ "IdleGame", "Game_test" ]
                                   "Distribution"
                                   [ Type.namedWith
                                         [ "Result" ]
                                         "Result"
                                         [ Type.namedWith
                                             [ "IdleGame", "EffectErr" ]
                                             "EffectErr"
                                             []
                                         , Type.namedWith
                                             [ "IdleGame", "Game" ]
                                             "ApplyEffectsValue"
                                             []
                                         ]
                                   ]
                               )
                             ]
                         ]
                         (Type.namedWith [ "IdleGame", "Game_test" ] "Test" [])
                    )
            }
    , testEffects =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "testEffects"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.record
                             [ ( "initialGame"
                               , Type.namedWith
                                   [ "IdleGame", "Game_test" ]
                                   "Game"
                                   []
                               )
                             , ( "effects"
                               , Type.list
                                   (Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                   )
                               )
                             , ( "count", Type.int )
                             , ( "check"
                               , Type.function
                                   [ Type.namedWith
                                         [ "Result" ]
                                         "Result"
                                         [ Type.namedWith
                                             [ "IdleGame", "EffectErr" ]
                                             "EffectErr"
                                             []
                                         , Type.record
                                             [ ( "game"
                                               , Type.namedWith
                                                   [ "IdleGame", "Game_test" ]
                                                   "Game"
                                                   []
                                               )
                                             , ( "toasts"
                                               , Type.list
                                                   (Type.namedWith
                                                      [ "IdleGame"
                                                      , "Game_test"
                                                      ]
                                                      "Toast"
                                                      []
                                                   )
                                               )
                                             ]
                                         ]
                                   ]
                                   (Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Expectation"
                                      []
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "IdleGame", "Game_test" ] "Test" [])
                    )
            }
    , defaultGame =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "defaultGame"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Game_test" ] "Game" [])
            }
    , hasXp =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "hasXp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Skill" []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                         ]
                         Type.bool
                    )
            }
    , expectXp =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "expectXp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Skill" []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , hasResource =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "hasResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith
                             [ "IdleGame", "Game_test" ]
                             "Resource"
                             []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                         ]
                         Type.bool
                    )
            }
    , expectResource =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "expectResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith
                             [ "IdleGame", "Game_test" ]
                             "Resource"
                             []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , hasCoin =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "hasCoin"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                         ]
                         Type.bool
                    )
            }
    , expectCoin =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "expectCoin"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , expectToasts =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "expectToasts"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.list
                                   (Type.namedWith
                                        [ "IdleGame", "Game_test" ]
                                        "Toast"
                                        []
                                   )
                             ]
                             (Type.namedWith
                                [ "IdleGame", "Game_test" ]
                                "Expectation"
                                []
                             )
                         , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                             , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectsValue"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , hasErr =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "hasErr"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                             ]
                             Type.bool
                         , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                             , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectsValue"
                                   []
                             ]
                         ]
                         Type.bool
                    )
            }
    , expectErr =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "expectErr"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                             ]
                             (Type.namedWith
                                [ "IdleGame", "Game_test" ]
                                "Expectation"
                                []
                             )
                         , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                             , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectsValue"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , hasOk =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "hasOk"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "IdleGame", "Game_test" ]
                                   "Game"
                                   []
                             ]
                             Type.bool
                         , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                             , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectsValue"
                                   []
                             ]
                         ]
                         Type.bool
                    )
            }
    , expectOk =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "expectOk"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "IdleGame", "Game_test" ]
                                   "Game"
                                   []
                             ]
                             (Type.namedWith
                                [ "IdleGame", "Game_test" ]
                                "Expectation"
                                []
                             )
                         , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                             , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectsValue"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , hasNoneOf =
        Elm.value
            { importFrom = [ "IdleGame", "Game_test" ]
            , name = "hasNoneOf"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.function
                                [ Type.namedWith
                                      [ "IdleGame", "Game_test" ]
                                      "Game"
                                      []
                                ]
                                Type.bool
                             )
                         , Type.namedWith [ "IdleGame", "Game_test" ] "Game" []
                         ]
                         Type.bool
                    )
            }
    }