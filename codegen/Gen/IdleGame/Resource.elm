module Gen.IdleGame.Resource exposing (add, annotation_, call_, getDiff, getLabel, isEmptyDiff, mapDiff, mapResources, moduleName_, toList, values_)

{-| 
@docs moduleName_, getLabel, toList, mapResources, isEmptyDiff, mapDiff, getDiff, add, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Resource" ]


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


annotation_ : { diff : Type.Annotation }
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
    }


call_ :
    { getLabel : Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , mapResources : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isEmptyDiff : Elm.Expression -> Elm.Expression
    , mapDiff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getDiff : Elm.Expression -> Elm.Expression
    , add : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
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
    }


values_ :
    { getLabel : Elm.Expression
    , toList : Elm.Expression
    , mapResources : Elm.Expression
    , isEmptyDiff : Elm.Expression
    , mapDiff : Elm.Expression
    , getDiff : Elm.Expression
    , add : Elm.Expression
    }
values_ =
    { getLabel =
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
    }