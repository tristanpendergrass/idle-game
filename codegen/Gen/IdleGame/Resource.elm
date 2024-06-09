module Gen.IdleGame.Resource exposing (add, allStats, annotation_, call_, caseOf_, getDiff, getLabel, getStats, isEmptyDiff, knowledgeStats, make_, mapDiff, mapResources, moduleName_, toList, values_)

{-|
@docs moduleName_, knowledgeStats, getLabel, toList, mapResources, isEmptyDiff, mapDiff, getDiff, add, getStats, allStats, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Resource" ]


{-| knowledgeStats: IdleGame.ResourceStats -}
knowledgeStats : Elm.Expression
knowledgeStats =
    Elm.value
        { importFrom = [ "IdleGame", "Resource" ]
        , name = "knowledgeStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Resource" ] "Stats" [])
        }


{-| getLabel: IdleGame.Resource.Resource -> String -}
getLabel : Elm.Expression -> Elm.Expression
getLabel getLabelArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "getLabel"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Resource" ]
                              "Resource"
                              []
                          ]
                          Type.string
                     )
             }
        )
        [ getLabelArg ]


{-| toList: IdleGame.Resource.ResourceRecord Int -> List ( IdleGame.Resource.Resource, Int ) -}
toList : Elm.Expression -> Elm.Expression
toList toListArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "toList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Resource" ]
                              "ResourceRecord"
                              [ Type.int ]
                          ]
                          (Type.list
                               (Type.tuple
                                    (Type.namedWith
                                         [ "IdleGame", "Resource" ]
                                         "Resource"
                                         []
                                    )
                                    Type.int
                               )
                          )
                     )
             }
        )
        [ toListArg ]


{-| mapResources:
    (Int -> IdleGame.Resource.Resource -> a)
    -> IdleGame.Resource.ResourceRecord Int
    -> List a
-}
mapResources :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
mapResources mapResourcesArg mapResourcesArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "mapResources"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.int
                              , Type.namedWith
                                    [ "IdleGame", "Resource" ]
                                    "Resource"
                                    []
                              ]
                              (Type.var "a")
                          , Type.namedWith
                              [ "IdleGame", "Resource" ]
                              "ResourceRecord"
                              [ Type.int ]
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ Elm.functionReduced
            "mapResourcesUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (mapResourcesArg functionReducedUnpack)
            )
        , mapResourcesArg0
        ]


{-| isEmptyDiff: IdleGame.Resource.Diff -> Bool -}
isEmptyDiff : Elm.Expression -> Elm.Expression
isEmptyDiff isEmptyDiffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "isEmptyDiff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Resource" ] "Diff" []
                          ]
                          Type.bool
                     )
             }
        )
        [ isEmptyDiffArg ]


{-| mapDiff:
    (Int -> IdleGame.Resource.Resource -> a)
    -> IdleGame.Resource.ResourceRecord Int
    -> List a
-}
mapDiff :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
mapDiff mapDiffArg mapDiffArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "mapDiff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.int
                              , Type.namedWith
                                    [ "IdleGame", "Resource" ]
                                    "Resource"
                                    []
                              ]
                              (Type.var "a")
                          , Type.namedWith
                              [ "IdleGame", "Resource" ]
                              "ResourceRecord"
                              [ Type.int ]
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ Elm.functionReduced
            "mapDiffUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (mapDiffArg functionReducedUnpack)
            )
        , mapDiffArg0
        ]


{-| getDiff:
    { original : IdleGame.Resource.ResourceRecord Int
    , current : IdleGame.Resource.ResourceRecord Int
    }
    -> IdleGame.Resource.Diff
-}
getDiff :
    { original : Elm.Expression, current : Elm.Expression } -> Elm.Expression
getDiff getDiffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "getDiff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "original"
                                , Type.namedWith
                                    [ "IdleGame", "Resource" ]
                                    "ResourceRecord"
                                    [ Type.int ]
                                )
                              , ( "current"
                                , Type.namedWith
                                    [ "IdleGame", "Resource" ]
                                    "ResourceRecord"
                                    [ Type.int ]
                                )
                              ]
                          ]
                          (Type.namedWith [ "IdleGame", "Resource" ] "Diff" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "original" getDiffArg.original
            , Tuple.pair "current" getDiffArg.current
            ]
        ]


{-| add:
    IdleGame.Resource.Resource
    -> Int
    -> IdleGame.Resource.ResourceRecord Int
    -> Result.Result IdleGame.EffectErr.EffectErr (IdleGame.Resource.ResourceRecord Int)
-}
add : Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
add addArg addArg0 addArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "add"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Resource" ]
                              "Resource"
                              []
                          , Type.int
                          , Type.namedWith
                              [ "IdleGame", "Resource" ]
                              "ResourceRecord"
                              [ Type.int ]
                          ]
                          (Type.namedWith
                               [ "Result" ]
                               "Result"
                               [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                               , Type.namedWith
                                   [ "IdleGame", "Resource" ]
                                   "ResourceRecord"
                                   [ Type.int ]
                               ]
                          )
                     )
             }
        )
        [ addArg, Elm.int addArg0, addArg1 ]


{-| getStats: IdleGame.Resource.Resource -> IdleGame.ResourceStats -}
getStats : Elm.Expression -> Elm.Expression
getStats getStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Resource" ]
             , name = "getStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Resource" ]
                              "Resource"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Resource" ] "Stats" [])
                     )
             }
        )
        [ getStatsArg ]


{-| allStats: IdleGame.Resource.ResourceRecord IdleGame.ResourceStats -}
allStats : Elm.Expression
allStats =
    Elm.value
        { importFrom = [ "IdleGame", "Resource" ]
        , name = "allStats"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Resource" ]
                     "ResourceRecord"
                     [ Type.namedWith [ "IdleGame", "Resource" ] "Stats" [] ]
                )
        }


annotation_ :
    { diff : Type.Annotation
    , stats : Type.Annotation
    , purchasing : Type.Annotation
    }
annotation_ =
    { diff =
        Type.alias
            moduleName_
            "Diff"
            []
            (Type.namedWith
                 [ "IdleGame", "Resource" ]
                 "ResourceRecord"
                 [ Type.int ]
            )
    , stats =
        Type.alias
            moduleName_
            "Stats"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "icon"
                   , Type.namedWith [ "IdleGame", "Views", "Icon" ] "Icon" []
                   )
                 , ( "purchasing"
                   , Type.namedWith [ "IdleGame", "Resource" ] "Purchasing" []
                   )
                 ]
            )
    , purchasing = Type.namedWith [ "IdleGame", "Resource" ] "Purchasing" []
    }


make_ :
    { stats :
        { title : Elm.Expression
        , icon : Elm.Expression
        , purchasing : Elm.Expression
        }
        -> Elm.Expression
    , purchasable : Elm.Expression -> Elm.Expression
    , notPurchasable : Elm.Expression
    }
make_ =
    { stats =
        \stats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Resource" ]
                     "Stats"
                     []
                     (Type.record
                          [ ( "title", Type.string )
                          , ( "icon"
                            , Type.namedWith
                                  [ "IdleGame", "Views", "Icon" ]
                                  "Icon"
                                  []
                            )
                          , ( "purchasing"
                            , Type.namedWith
                                  [ "IdleGame", "Resource" ]
                                  "Purchasing"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "title" stats_args.title
                     , Tuple.pair "icon" stats_args.icon
                     , Tuple.pair "purchasing" stats_args.purchasing
                     ]
                )
    , purchasable =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "Purchasable"
                     , annotation = Just (Type.namedWith [] "Purchasing" [])
                     }
                )
                [ ar0 ]
    , notPurchasable =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "NotPurchasable"
            , annotation = Just (Type.namedWith [] "Purchasing" [])
            }
    }


caseOf_ :
    { purchasing :
        Elm.Expression
        -> { purchasingTags_0_0
            | purchasable : Elm.Expression -> Elm.Expression
            , notPurchasable : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { purchasing =
        \purchasingExpression purchasingTags ->
            Elm.Case.custom
                purchasingExpression
                (Type.namedWith [ "IdleGame", "Resource" ] "Purchasing" [])
                [ Elm.Case.branch1
                    "Purchasable"
                    ( "idleGameCoinCoin"
                    , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                    )
                    purchasingTags.purchasable
                , Elm.Case.branch0
                    "NotPurchasable"
                    purchasingTags.notPurchasable
                ]
    }


call_ :
    { getLabel : Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , mapResources : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isEmptyDiff : Elm.Expression -> Elm.Expression
    , mapDiff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getDiff : Elm.Expression -> Elm.Expression
    , add : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getStats : Elm.Expression -> Elm.Expression
    }
call_ =
    { getLabel =
        \getLabelArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "getLabel"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "Resource"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ getLabelArg ]
    , toList =
        \toListArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "toList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "ResourceRecord"
                                      [ Type.int ]
                                  ]
                                  (Type.list
                                       (Type.tuple
                                            (Type.namedWith
                                                 [ "IdleGame", "Resource" ]
                                                 "Resource"
                                                 []
                                            )
                                            Type.int
                                       )
                                  )
                             )
                     }
                )
                [ toListArg ]
    , mapResources =
        \mapResourcesArg mapResourcesArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "mapResources"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.int
                                      , Type.namedWith
                                            [ "IdleGame", "Resource" ]
                                            "Resource"
                                            []
                                      ]
                                      (Type.var "a")
                                  , Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "ResourceRecord"
                                      [ Type.int ]
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ mapResourcesArg, mapResourcesArg0 ]
    , isEmptyDiff =
        \isEmptyDiffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "isEmptyDiff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "Diff"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ isEmptyDiffArg ]
    , mapDiff =
        \mapDiffArg mapDiffArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "mapDiff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.int
                                      , Type.namedWith
                                            [ "IdleGame", "Resource" ]
                                            "Resource"
                                            []
                                      ]
                                      (Type.var "a")
                                  , Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "ResourceRecord"
                                      [ Type.int ]
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ mapDiffArg, mapDiffArg0 ]
    , getDiff =
        \getDiffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "getDiff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "original"
                                        , Type.namedWith
                                            [ "IdleGame", "Resource" ]
                                            "ResourceRecord"
                                            [ Type.int ]
                                        )
                                      , ( "current"
                                        , Type.namedWith
                                            [ "IdleGame", "Resource" ]
                                            "ResourceRecord"
                                            [ Type.int ]
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Resource" ]
                                       "Diff"
                                       []
                                  )
                             )
                     }
                )
                [ getDiffArg ]
    , add =
        \addArg addArg0 addArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "add"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "Resource"
                                      []
                                  , Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "ResourceRecord"
                                      [ Type.int ]
                                  ]
                                  (Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.namedWith
                                           [ "IdleGame", "EffectErr" ]
                                           "EffectErr"
                                           []
                                       , Type.namedWith
                                           [ "IdleGame", "Resource" ]
                                           "ResourceRecord"
                                           [ Type.int ]
                                       ]
                                  )
                             )
                     }
                )
                [ addArg, addArg0, addArg1 ]
    , getStats =
        \getStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Resource" ]
                     , name = "getStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Resource" ]
                                      "Resource"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Resource" ]
                                       "Stats"
                                       []
                                  )
                             )
                     }
                )
                [ getStatsArg ]
    }


values_ :
    { knowledgeStats : Elm.Expression
    , getLabel : Elm.Expression
    , toList : Elm.Expression
    , mapResources : Elm.Expression
    , isEmptyDiff : Elm.Expression
    , mapDiff : Elm.Expression
    , getDiff : Elm.Expression
    , add : Elm.Expression
    , getStats : Elm.Expression
    , allStats : Elm.Expression
    }
values_ =
    { knowledgeStats =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "knowledgeStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Resource" ] "Stats" [])
            }
    , getLabel =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "getLabel"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Resource" ]
                             "Resource"
                             []
                         ]
                         Type.string
                    )
            }
    , toList =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "toList"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Resource" ]
                             "ResourceRecord"
                             [ Type.int ]
                         ]
                         (Type.list
                              (Type.tuple
                                   (Type.namedWith
                                        [ "IdleGame", "Resource" ]
                                        "Resource"
                                        []
                                   )
                                   Type.int
                              )
                         )
                    )
            }
    , mapResources =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "mapResources"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.int
                             , Type.namedWith
                                   [ "IdleGame", "Resource" ]
                                   "Resource"
                                   []
                             ]
                             (Type.var "a")
                         , Type.namedWith
                             [ "IdleGame", "Resource" ]
                             "ResourceRecord"
                             [ Type.int ]
                         ]
                         (Type.list (Type.var "a"))
                    )
            }
    , isEmptyDiff =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "isEmptyDiff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Resource" ] "Diff" [] ]
                         Type.bool
                    )
            }
    , mapDiff =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "mapDiff"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.int
                             , Type.namedWith
                                   [ "IdleGame", "Resource" ]
                                   "Resource"
                                   []
                             ]
                             (Type.var "a")
                         , Type.namedWith
                             [ "IdleGame", "Resource" ]
                             "ResourceRecord"
                             [ Type.int ]
                         ]
                         (Type.list (Type.var "a"))
                    )
            }
    , getDiff =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "getDiff"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "original"
                               , Type.namedWith
                                   [ "IdleGame", "Resource" ]
                                   "ResourceRecord"
                                   [ Type.int ]
                               )
                             , ( "current"
                               , Type.namedWith
                                   [ "IdleGame", "Resource" ]
                                   "ResourceRecord"
                                   [ Type.int ]
                               )
                             ]
                         ]
                         (Type.namedWith [ "IdleGame", "Resource" ] "Diff" [])
                    )
            }
    , add =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "add"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Resource" ]
                             "Resource"
                             []
                         , Type.int
                         , Type.namedWith
                             [ "IdleGame", "Resource" ]
                             "ResourceRecord"
                             [ Type.int ]
                         ]
                         (Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                  [ "IdleGame", "EffectErr" ]
                                  "EffectErr"
                                  []
                              , Type.namedWith
                                  [ "IdleGame", "Resource" ]
                                  "ResourceRecord"
                                  [ Type.int ]
                              ]
                         )
                    )
            }
    , getStats =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "getStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Resource" ]
                             "Resource"
                             []
                         ]
                         (Type.namedWith [ "IdleGame", "Resource" ] "Stats" [])
                    )
            }
    , allStats =
        Elm.value
            { importFrom = [ "IdleGame", "Resource" ]
            , name = "allStats"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Resource" ]
                         "ResourceRecord"
                         [ Type.namedWith [ "IdleGame", "Resource" ] "Stats" []
                         ]
                    )
            }
    }