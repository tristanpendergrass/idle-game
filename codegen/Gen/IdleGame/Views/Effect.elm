module Gen.IdleGame.Views.Effect exposing (annotation_, call_, caseOf_, make_, moduleName_, probabilityToInt, render, renderCoin, renderModdedEffect, renderMonsterPower, renderMxp, renderResource, renderVariableResource, renderXp, values_)

{-| 
@docs moduleName_, renderMonsterPower, renderVariableResource, probabilityToInt, renderMxp, renderXp, renderResource, renderCoin, renderModdedEffect, render, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Effect" ]


{-| renderMonsterPower: Int -> IdleGame.Views.Effect.Html msg -}
renderMonsterPower : Int -> Elm.Expression
renderMonsterPower renderMonsterPowerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "renderMonsterPower"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.int renderMonsterPowerArg ]


{-| renderVariableResource: 
    Percent.Percent
    -> IdleGame.Views.Effect.Resource
    -> IdleGame.Views.Effect.Html msg
-}
renderVariableResource : Elm.Expression -> Elm.Expression -> Elm.Expression
renderVariableResource renderVariableResourceArg renderVariableResourceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "renderVariableResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" []
                          , Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Resource"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ renderVariableResourceArg, renderVariableResourceArg0 ]


{-| probabilityToInt: Float -> Int -}
probabilityToInt : Float -> Elm.Expression
probabilityToInt probabilityToIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "probabilityToInt"
             , annotation = Just (Type.function [ Type.float ] Type.int)
             }
        )
        [ Elm.float probabilityToIntArg ]


{-| renderMxp: 
    IdleGame.Views.Effect.Game
    -> IdleGame.Effect.GainMxpParams
    -> IdleGame.Views.Effect.Html msg
-}
renderMxp : Elm.Expression -> Elm.Expression -> Elm.Expression
renderMxp renderMxpArg renderMxpArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "renderMxp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Game"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "GainMxpParams"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ renderMxpArg, renderMxpArg0 ]


{-| renderXp: IdleGame.Effect.GainXpParams -> IdleGame.Views.Effect.Html msg -}
renderXp : Elm.Expression -> Elm.Expression
renderXp renderXpArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "renderXp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "GainXpParams"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ renderXpArg ]


{-| renderResource: 
    IdleGame.Views.Effect.Game
    -> IdleGame.Views.Effect.Resource
    -> Int
    -> IdleGame.Views.Effect.Html msg
-}
renderResource : Elm.Expression -> Elm.Expression -> Int -> Elm.Expression
renderResource renderResourceArg renderResourceArg0 renderResourceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "renderResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Game"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Resource"
                              []
                          , Type.int
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ renderResourceArg, renderResourceArg0, Elm.int renderResourceArg1 ]


{-| renderCoin: 
    { base : IdleGame.Coin.Coin, percentIncrease : Percent.Percent }
    -> IdleGame.Views.Effect.Html msg
-}
renderCoin :
    { base : Elm.Expression, percentIncrease : Elm.Expression }
    -> Elm.Expression
renderCoin renderCoinArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "renderCoin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "base"
                                , Type.namedWith
                                    [ "IdleGame", "Coin" ]
                                    "Coin"
                                    []
                                )
                              , ( "percentIncrease"
                                , Type.namedWith [ "Percent" ] "Percent" []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "base" renderCoinArg.base
            , Tuple.pair "percentIncrease" renderCoinArg.percentIncrease
            ]
        ]


{-| renderModdedEffect: 
    IdleGame.Views.Effect.RenderType
    -> IdleGame.Views.Effect.Game
    -> IdleGame.Effect.Effect
    -> IdleGame.Views.Effect.Html msg
-}
renderModdedEffect :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
renderModdedEffect renderModdedEffectArg renderModdedEffectArg0 renderModdedEffectArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "renderModdedEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "RenderType"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Game"
                              []
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ renderModdedEffectArg
        , renderModdedEffectArg0
        , renderModdedEffectArg1
        ]


{-| render: 
    { game : IdleGame.Views.Effect.Game
    , mods : List IdleGame.Mod.Mod
    , effect : IdleGame.Effect.Effect
    , renderType : IdleGame.Views.Effect.RenderType
    }
    -> IdleGame.Views.Effect.Html IdleGame.Views.Effect.FrontendMsg
-}
render :
    { game : Elm.Expression
    , mods : List Elm.Expression
    , effect : Elm.Expression
    , renderType : Elm.Expression
    }
    -> Elm.Expression
render renderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Effect" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "game"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Effect" ]
                                    "Game"
                                    []
                                )
                              , ( "mods"
                                , Type.list
                                    (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Mod"
                                       []
                                    )
                                )
                              , ( "effect"
                                , Type.namedWith
                                    [ "IdleGame", "Effect" ]
                                    "Effect"
                                    []
                                )
                              , ( "renderType"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "Effect" ]
                                    "RenderType"
                                    []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Effect" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Effect" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "game" renderArg.game
            , Tuple.pair "mods" (Elm.list renderArg.mods)
            , Tuple.pair "effect" renderArg.effect
            , Tuple.pair "renderType" renderArg.renderType
            ]
        ]


annotation_ : { renderType : Type.Annotation }
annotation_ =
    { renderType =
        Type.namedWith [ "IdleGame", "Views", "Effect" ] "RenderType" []
    }


make_ : { card : Elm.Expression, detailView : Elm.Expression }
make_ =
    { card =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "Card"
            , annotation = Just (Type.namedWith [] "RenderType" [])
            }
    , detailView =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "DetailView"
            , annotation = Just (Type.namedWith [] "RenderType" [])
            }
    }


caseOf_ :
    { renderType :
        Elm.Expression
        -> { renderTypeTags_0_0
            | card : Elm.Expression
            , detailView : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { renderType =
        \renderTypeExpression renderTypeTags ->
            Elm.Case.custom
                renderTypeExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "Effect" ]
                     "RenderType"
                     []
                )
                [ Elm.Case.branch0 "Card" renderTypeTags.card
                , Elm.Case.branch0 "DetailView" renderTypeTags.detailView
                ]
    }


call_ :
    { renderMonsterPower : Elm.Expression -> Elm.Expression
    , renderVariableResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , probabilityToInt : Elm.Expression -> Elm.Expression
    , renderMxp : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderXp : Elm.Expression -> Elm.Expression
    , renderResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderCoin : Elm.Expression -> Elm.Expression
    , renderModdedEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , render : Elm.Expression -> Elm.Expression
    }
call_ =
    { renderMonsterPower =
        \renderMonsterPowerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "renderMonsterPower"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderMonsterPowerArg ]
    , renderVariableResource =
        \renderVariableResourceArg renderVariableResourceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "renderVariableResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "Effect" ]
                                      "Resource"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderVariableResourceArg, renderVariableResourceArg0 ]
    , probabilityToInt =
        \probabilityToIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "probabilityToInt"
                     , annotation = Just (Type.function [ Type.float ] Type.int)
                     }
                )
                [ probabilityToIntArg ]
    , renderMxp =
        \renderMxpArg renderMxpArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "renderMxp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Effect" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "GainMxpParams"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderMxpArg, renderMxpArg0 ]
    , renderXp =
        \renderXpArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "renderXp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "GainXpParams"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderXpArg ]
    , renderResource =
        \renderResourceArg renderResourceArg0 renderResourceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "renderResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Effect" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "Effect" ]
                                      "Resource"
                                      []
                                  , Type.int
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderResourceArg, renderResourceArg0, renderResourceArg1 ]
    , renderCoin =
        \renderCoinArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "renderCoin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "base"
                                        , Type.namedWith
                                            [ "IdleGame", "Coin" ]
                                            "Coin"
                                            []
                                        )
                                      , ( "percentIncrease"
                                        , Type.namedWith
                                            [ "Percent" ]
                                            "Percent"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderCoinArg ]
    , renderModdedEffect =
        \renderModdedEffectArg renderModdedEffectArg0 renderModdedEffectArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "renderModdedEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Effect" ]
                                      "RenderType"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "Effect" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderModdedEffectArg
                , renderModdedEffectArg0
                , renderModdedEffectArg1
                ]
    , render =
        \renderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Effect" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "game"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Effect" ]
                                            "Game"
                                            []
                                        )
                                      , ( "mods"
                                        , Type.list
                                            (Type.namedWith
                                               [ "IdleGame", "Mod" ]
                                               "Mod"
                                               []
                                            )
                                        )
                                      , ( "effect"
                                        , Type.namedWith
                                            [ "IdleGame", "Effect" ]
                                            "Effect"
                                            []
                                        )
                                      , ( "renderType"
                                        , Type.namedWith
                                            [ "IdleGame", "Views", "Effect" ]
                                            "RenderType"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Effect" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Effect" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg ]
    }


values_ :
    { renderMonsterPower : Elm.Expression
    , renderVariableResource : Elm.Expression
    , probabilityToInt : Elm.Expression
    , renderMxp : Elm.Expression
    , renderXp : Elm.Expression
    , renderResource : Elm.Expression
    , renderCoin : Elm.Expression
    , renderModdedEffect : Elm.Expression
    , render : Elm.Expression
    }
values_ =
    { renderMonsterPower =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "renderMonsterPower"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , renderVariableResource =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "renderVariableResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" []
                         , Type.namedWith
                             [ "IdleGame", "Views", "Effect" ]
                             "Resource"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , probabilityToInt =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "probabilityToInt"
            , annotation = Just (Type.function [ Type.float ] Type.int)
            }
    , renderMxp =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "renderMxp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Effect" ]
                             "Game"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Effect" ]
                             "GainMxpParams"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , renderXp =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "renderXp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Effect" ]
                             "GainXpParams"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , renderResource =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "renderResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Effect" ]
                             "Game"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "Effect" ]
                             "Resource"
                             []
                         , Type.int
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , renderCoin =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "renderCoin"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "base"
                               , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                               )
                             , ( "percentIncrease"
                               , Type.namedWith [ "Percent" ] "Percent" []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , renderModdedEffect =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "renderModdedEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Effect" ]
                             "RenderType"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "Effect" ]
                             "Game"
                             []
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Effect" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "game"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Effect" ]
                                   "Game"
                                   []
                               )
                             , ( "mods"
                               , Type.list
                                   (Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                   )
                               )
                             , ( "effect"
                               , Type.namedWith
                                   [ "IdleGame", "Effect" ]
                                   "Effect"
                                   []
                               )
                             , ( "renderType"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "Effect" ]
                                   "RenderType"
                                   []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Effect" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Effect" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }