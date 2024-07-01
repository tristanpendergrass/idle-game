module Gen.IdleGame.Effect exposing (annotation_, call_, caseOf_, gainCoin, gainMxp, gainResource, gainResourceWithDoubling, gainWithProbability, gainXp, getEffect, hasTags, make_, moduleName_, order, setEffect, spendResource, values_, withPreservationChance, withReducedBy, withTags)

{-| 
@docs moduleName_, hasTags, order, withTags, gainWithProbability, gainResourceWithDoubling, withPreservationChance, withReducedBy, spendResource, gainResource, gainMxp, gainCoin, gainXp, setEffect, getEffect, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Effect" ]


{-| hasTags: List IdleGame.Effect.Tag -> IdleGame.Effect.Effect -> Bool -}
hasTags : List Elm.Expression -> Elm.Expression -> Elm.Expression
hasTags hasTagsArg hasTagsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "hasTags"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          Type.bool
                     )
             }
        )
        [ Elm.list hasTagsArg, hasTagsArg0 ]


{-| order: IdleGame.Effect.Effect -> IdleGame.Effect.Effect -> Basics.Order -}
order : Elm.Expression -> Elm.Expression -> Elm.Expression
order orderArg orderArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "order"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.namedWith [ "Basics" ] "Order" [])
                     )
             }
        )
        [ orderArg, orderArg0 ]


{-| withTags: List IdleGame.Effect.Tag -> IdleGame.Effect.Effect -> IdleGame.Effect.Effect -}
withTags : List Elm.Expression -> Elm.Expression -> Elm.Expression
withTags withTagsArg withTagsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "withTags"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ Elm.list withTagsArg, withTagsArg0 ]


{-| gainWithProbability: Percent.Percent -> List IdleGame.Effect.Effect -> IdleGame.Effect.Effect -}
gainWithProbability : Elm.Expression -> List Elm.Expression -> Elm.Expression
gainWithProbability gainWithProbabilityArg gainWithProbabilityArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "gainWithProbability"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" []
                          , Type.list
                              (Type.namedWith
                                 [ "IdleGame", "Effect" ]
                                 "Effect"
                                 []
                              )
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ gainWithProbabilityArg, Elm.list gainWithProbabilityArg0 ]


{-| gainResourceWithDoubling: Int -> IdleGame.Effect.Resource -> Percent.Percent -> IdleGame.Effect.Effect -}
gainResourceWithDoubling :
    Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
gainResourceWithDoubling gainResourceWithDoublingArg gainResourceWithDoublingArg0 gainResourceWithDoublingArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "gainResourceWithDoubling"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "Resource"
                              []
                          , Type.namedWith [ "Percent" ] "Percent" []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ Elm.int gainResourceWithDoublingArg
        , gainResourceWithDoublingArg0
        , gainResourceWithDoublingArg1
        ]


{-| withPreservationChance: Percent.Percent -> IdleGame.Effect.Effect -> IdleGame.Effect.Effect -}
withPreservationChance : Elm.Expression -> Elm.Expression -> Elm.Expression
withPreservationChance withPreservationChanceArg withPreservationChanceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "withPreservationChance"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" []
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ withPreservationChanceArg, withPreservationChanceArg0 ]


{-| withReducedBy: IdleGame.Effect.ReducedBy -> IdleGame.Effect.Effect -> IdleGame.Effect.Effect -}
withReducedBy : Elm.Expression -> Elm.Expression -> Elm.Expression
withReducedBy withReducedByArg withReducedByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "withReducedBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "ReducedBy"
                              []
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ withReducedByArg, withReducedByArg0 ]


{-| spendResource: Int -> IdleGame.Effect.Resource -> IdleGame.Effect.Effect -}
spendResource : Int -> Elm.Expression -> Elm.Expression
spendResource spendResourceArg spendResourceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "spendResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "Resource"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ Elm.int spendResourceArg, spendResourceArg0 ]


{-| gainResource: Int -> IdleGame.Effect.Resource -> IdleGame.Effect.Effect -}
gainResource : Int -> Elm.Expression -> Elm.Expression
gainResource gainResourceArg gainResourceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "gainResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "Resource"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ Elm.int gainResourceArg, gainResourceArg0 ]


{-| gainMxp: IdleGame.Effect.Activity -> IdleGame.Effect.Effect -}
gainMxp : Elm.Expression -> Elm.Expression
gainMxp gainMxpArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "gainMxp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "Activity"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ gainMxpArg ]


{-| gainCoin: IdleGame.Coin.Coin -> IdleGame.Effect.Effect -}
gainCoin : Elm.Expression -> Elm.Expression
gainCoin gainCoinArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "gainCoin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" [] ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ gainCoinArg ]


{-| gainXp: IdleGame.Xp.Xp -> IdleGame.Effect.Skill -> IdleGame.Effect.Effect -}
gainXp : Elm.Expression -> Elm.Expression -> Elm.Expression
gainXp gainXpArg gainXpArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "gainXp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.namedWith [ "IdleGame", "Effect" ] "Skill" []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ gainXpArg, gainXpArg0 ]


{-| setEffect: IdleGame.Effect.EffectType -> IdleGame.Effect.Effect -> IdleGame.Effect.Effect -}
setEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
setEffect setEffectArg setEffectArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "setEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "EffectType"
                              []
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                     )
             }
        )
        [ setEffectArg, setEffectArg0 ]


{-| getEffect: IdleGame.Effect.Effect -> IdleGame.Effect.EffectType -}
getEffect : Elm.Expression -> Elm.Expression
getEffect getEffectArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Effect" ]
             , name = "getEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Effect" ]
                               "EffectType"
                               []
                          )
                     )
             }
        )
        [ getEffectArg ]


annotation_ :
    { spendResourceParams : Type.Annotation
    , gainResourceParams : Type.Annotation
    , gainCoinParams : Type.Annotation
    , gainMxpParams : Type.Annotation
    , gainXpParams : Type.Annotation
    , effect : Type.Annotation
    , effectType : Type.Annotation
    , reducedBy : Type.Annotation
    , tag : Type.Annotation
    }
annotation_ =
    { spendResourceParams =
        Type.alias
            moduleName_
            "SpendResourceParams"
            []
            (Type.record
                 [ ( "base", Type.int )
                 , ( "resource"
                   , Type.namedWith [ "IdleGame", "Effect" ] "Resource" []
                   )
                 , ( "preservationChance"
                   , Type.namedWith [ "Percent" ] "Percent" []
                   )
                 , ( "reducedBy"
                   , Type.maybe
                         (Type.namedWith [ "IdleGame", "Effect" ] "ReducedBy" []
                         )
                   )
                 ]
            )
    , gainResourceParams =
        Type.alias
            moduleName_
            "GainResourceParams"
            []
            (Type.record
                 [ ( "base", Type.int )
                 , ( "doublingChance"
                   , Type.namedWith [ "Percent" ] "Percent" []
                   )
                 , ( "resource"
                   , Type.namedWith [ "IdleGame", "Effect" ] "Resource" []
                   )
                 ]
            )
    , gainCoinParams =
        Type.alias
            moduleName_
            "GainCoinParams"
            []
            (Type.record
                 [ ( "base", Type.namedWith [ "IdleGame", "Coin" ] "Coin" [] )
                 , ( "percentIncrease"
                   , Type.namedWith [ "Percent" ] "Percent" []
                   )
                 ]
            )
    , gainMxpParams =
        Type.alias
            moduleName_
            "GainMxpParams"
            []
            (Type.record
                 [ ( "percentIncrease"
                   , Type.namedWith [ "Percent" ] "Percent" []
                   )
                 , ( "activity"
                   , Type.namedWith [ "IdleGame", "Effect" ] "Activity" []
                   )
                 ]
            )
    , gainXpParams =
        Type.alias
            moduleName_
            "GainXpParams"
            []
            (Type.record
                 [ ( "base", Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] )
                 , ( "percentIncrease"
                   , Type.namedWith [ "Percent" ] "Percent" []
                   )
                 , ( "skill"
                   , Type.namedWith [ "IdleGame", "Effect" ] "Skill" []
                   )
                 ]
            )
    , effect =
        Type.alias
            moduleName_
            "Effect"
            []
            (Type.record
                 [ ( "effect"
                   , Type.namedWith [ "IdleGame", "Effect" ] "EffectType" []
                   )
                 , ( "tags"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                   )
                 ]
            )
    , effectType = Type.namedWith [ "IdleGame", "Effect" ] "EffectType" []
    , reducedBy = Type.namedWith [ "IdleGame", "Effect" ] "ReducedBy" []
    , tag = Type.namedWith [ "IdleGame", "Effect" ] "Tag" []
    }


make_ :
    { spendResourceParams :
        { base : Elm.Expression
        , resource : Elm.Expression
        , preservationChance : Elm.Expression
        , reducedBy : Elm.Expression
        }
        -> Elm.Expression
    , gainResourceParams :
        { base : Elm.Expression
        , doublingChance : Elm.Expression
        , resource : Elm.Expression
        }
        -> Elm.Expression
    , gainCoinParams :
        { base : Elm.Expression, percentIncrease : Elm.Expression }
        -> Elm.Expression
    , gainMxpParams :
        { percentIncrease : Elm.Expression, activity : Elm.Expression }
        -> Elm.Expression
    , gainXpParams :
        { base : Elm.Expression
        , percentIncrease : Elm.Expression
        , skill : Elm.Expression
        }
        -> Elm.Expression
    , effect :
        { effect : Elm.Expression, tags : Elm.Expression } -> Elm.Expression
    , variableSuccess : Elm.Expression -> Elm.Expression
    , gainResource : Elm.Expression -> Elm.Expression
    , spendResource : Elm.Expression -> Elm.Expression
    , gainXp : Elm.Expression -> Elm.Expression
    , gainMxp : Elm.Expression -> Elm.Expression
    , gainCoin : Elm.Expression -> Elm.Expression
    , reducedByFlat : Elm.Expression -> Elm.Expression
    , reducedByPercent : Elm.Expression -> Elm.Expression -> Elm.Expression
    , skillTag : Elm.Expression -> Elm.Expression
    , xpTag : Elm.Expression
    , mxpTag : Elm.Expression
    , activityTag : Elm.Expression -> Elm.Expression
    }
make_ =
    { spendResourceParams =
        \spendResourceParams_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Effect" ]
                     "SpendResourceParams"
                     []
                     (Type.record
                          [ ( "base", Type.int )
                          , ( "resource"
                            , Type.namedWith
                                  [ "IdleGame", "Effect" ]
                                  "Resource"
                                  []
                            )
                          , ( "preservationChance"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          , ( "reducedBy"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "ReducedBy"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "base" spendResourceParams_args.base
                     , Tuple.pair "resource" spendResourceParams_args.resource
                     , Tuple.pair
                         "preservationChance"
                         spendResourceParams_args.preservationChance
                     , Tuple.pair "reducedBy" spendResourceParams_args.reducedBy
                     ]
                )
    , gainResourceParams =
        \gainResourceParams_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Effect" ]
                     "GainResourceParams"
                     []
                     (Type.record
                          [ ( "base", Type.int )
                          , ( "doublingChance"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          , ( "resource"
                            , Type.namedWith
                                  [ "IdleGame", "Effect" ]
                                  "Resource"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "base" gainResourceParams_args.base
                     , Tuple.pair
                         "doublingChance"
                         gainResourceParams_args.doublingChance
                     , Tuple.pair "resource" gainResourceParams_args.resource
                     ]
                )
    , gainCoinParams =
        \gainCoinParams_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Effect" ]
                     "GainCoinParams"
                     []
                     (Type.record
                          [ ( "base"
                            , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                            )
                          , ( "percentIncrease"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "base" gainCoinParams_args.base
                     , Tuple.pair
                         "percentIncrease"
                         gainCoinParams_args.percentIncrease
                     ]
                )
    , gainMxpParams =
        \gainMxpParams_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Effect" ]
                     "GainMxpParams"
                     []
                     (Type.record
                          [ ( "percentIncrease"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          , ( "activity"
                            , Type.namedWith
                                  [ "IdleGame", "Effect" ]
                                  "Activity"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair
                         "percentIncrease"
                         gainMxpParams_args.percentIncrease
                     , Tuple.pair "activity" gainMxpParams_args.activity
                     ]
                )
    , gainXpParams =
        \gainXpParams_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Effect" ]
                     "GainXpParams"
                     []
                     (Type.record
                          [ ( "base"
                            , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                            )
                          , ( "percentIncrease"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          , ( "skill"
                            , Type.namedWith [ "IdleGame", "Effect" ] "Skill" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "base" gainXpParams_args.base
                     , Tuple.pair
                         "percentIncrease"
                         gainXpParams_args.percentIncrease
                     , Tuple.pair "skill" gainXpParams_args.skill
                     ]
                )
    , effect =
        \effect_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Effect" ]
                     "Effect"
                     []
                     (Type.record
                          [ ( "effect"
                            , Type.namedWith
                                  [ "IdleGame", "Effect" ]
                                  "EffectType"
                                  []
                            )
                          , ( "tags"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Tag"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "effect" effect_args.effect
                     , Tuple.pair "tags" effect_args.tags
                     ]
                )
    , variableSuccess =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "VariableSuccess"
                     , annotation = Just (Type.namedWith [] "EffectType" [])
                     }
                )
                [ ar0 ]
    , gainResource =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "GainResource"
                     , annotation = Just (Type.namedWith [] "EffectType" [])
                     }
                )
                [ ar0 ]
    , spendResource =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "SpendResource"
                     , annotation = Just (Type.namedWith [] "EffectType" [])
                     }
                )
                [ ar0 ]
    , gainXp =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "GainXp"
                     , annotation = Just (Type.namedWith [] "EffectType" [])
                     }
                )
                [ ar0 ]
    , gainMxp =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "GainMxp"
                     , annotation = Just (Type.namedWith [] "EffectType" [])
                     }
                )
                [ ar0 ]
    , gainCoin =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "GainCoin"
                     , annotation = Just (Type.namedWith [] "EffectType" [])
                     }
                )
                [ ar0 ]
    , reducedByFlat =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "ReducedByFlat"
                     , annotation = Just (Type.namedWith [] "ReducedBy" [])
                     }
                )
                [ ar0 ]
    , reducedByPercent =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "ReducedByPercent"
                     , annotation = Just (Type.namedWith [] "ReducedBy" [])
                     }
                )
                [ ar0, ar1 ]
    , skillTag =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "SkillTag"
                     , annotation = Just (Type.namedWith [] "Tag" [])
                     }
                )
                [ ar0 ]
    , xpTag =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "XpTag"
            , annotation = Just (Type.namedWith [] "Tag" [])
            }
    , mxpTag =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "MxpTag"
            , annotation = Just (Type.namedWith [] "Tag" [])
            }
    , activityTag =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "ActivityTag"
                     , annotation = Just (Type.namedWith [] "Tag" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { effectType :
        Elm.Expression
        -> { effectTypeTags_0_0
            | variableSuccess : Elm.Expression -> Elm.Expression
            , gainResource : Elm.Expression -> Elm.Expression
            , spendResource : Elm.Expression -> Elm.Expression
            , gainXp : Elm.Expression -> Elm.Expression
            , gainMxp : Elm.Expression -> Elm.Expression
            , gainCoin : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , reducedBy :
        Elm.Expression
        -> { reducedByTags_1_0
            | reducedByFlat : Elm.Expression -> Elm.Expression
            , reducedByPercent :
                Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , tag :
        Elm.Expression
        -> { tagTags_2_0
            | skillTag : Elm.Expression -> Elm.Expression
            , xpTag : Elm.Expression
            , mxpTag : Elm.Expression
            , activityTag : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { effectType =
        \effectTypeExpression effectTypeTags ->
            Elm.Case.custom
                effectTypeExpression
                (Type.namedWith [ "IdleGame", "Effect" ] "EffectType" [])
                [ Elm.Case.branch1
                    "VariableSuccess"
                    ( "one"
                    , Type.record
                          [ ( "successProbability"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          , ( "successEffects"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                            )
                          , ( "failureEffects"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                            )
                          ]
                    )
                    effectTypeTags.variableSuccess
                , Elm.Case.branch1
                    "GainResource"
                    ( "idleGameEffectGainResourceParams"
                    , Type.namedWith
                          [ "IdleGame", "Effect" ]
                          "GainResourceParams"
                          []
                    )
                    effectTypeTags.gainResource
                , Elm.Case.branch1
                    "SpendResource"
                    ( "idleGameEffectSpendResourceParams"
                    , Type.namedWith
                          [ "IdleGame", "Effect" ]
                          "SpendResourceParams"
                          []
                    )
                    effectTypeTags.spendResource
                , Elm.Case.branch1
                    "GainXp"
                    ( "idleGameEffectGainXpParams"
                    , Type.namedWith [ "IdleGame", "Effect" ] "GainXpParams" []
                    )
                    effectTypeTags.gainXp
                , Elm.Case.branch1
                    "GainMxp"
                    ( "idleGameEffectGainMxpParams"
                    , Type.namedWith [ "IdleGame", "Effect" ] "GainMxpParams" []
                    )
                    effectTypeTags.gainMxp
                , Elm.Case.branch1
                    "GainCoin"
                    ( "idleGameEffectGainCoinParams"
                    , Type.namedWith
                          [ "IdleGame", "Effect" ]
                          "GainCoinParams"
                          []
                    )
                    effectTypeTags.gainCoin
                ]
    , reducedBy =
        \reducedByExpression reducedByTags ->
            Elm.Case.custom
                reducedByExpression
                (Type.namedWith [ "IdleGame", "Effect" ] "ReducedBy" [])
                [ Elm.Case.branch1
                    "ReducedByFlat"
                    ( "idleGameEffectResource"
                    , Type.namedWith [ "IdleGame", "Effect" ] "Resource" []
                    )
                    reducedByTags.reducedByFlat
                , Elm.Case.branch2
                    "ReducedByPercent"
                    ( "idleGameEffectResource"
                    , Type.namedWith [ "IdleGame", "Effect" ] "Resource" []
                    )
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    reducedByTags.reducedByPercent
                ]
    , tag =
        \tagExpression tagTags ->
            Elm.Case.custom
                tagExpression
                (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                [ Elm.Case.branch1
                    "SkillTag"
                    ( "idleGameEffectSkill"
                    , Type.namedWith [ "IdleGame", "Effect" ] "Skill" []
                    )
                    tagTags.skillTag
                , Elm.Case.branch0 "XpTag" tagTags.xpTag
                , Elm.Case.branch0 "MxpTag" tagTags.mxpTag
                , Elm.Case.branch1
                    "ActivityTag"
                    ( "idleGameEffectActivity"
                    , Type.namedWith [ "IdleGame", "Effect" ] "Activity" []
                    )
                    tagTags.activityTag
                ]
    }


call_ :
    { hasTags : Elm.Expression -> Elm.Expression -> Elm.Expression
    , order : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withTags : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gainWithProbability : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gainResourceWithDoubling :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withPreservationChance :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , withReducedBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , spendResource : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gainResource : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gainMxp : Elm.Expression -> Elm.Expression
    , gainCoin : Elm.Expression -> Elm.Expression
    , gainXp : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getEffect : Elm.Expression -> Elm.Expression
    }
call_ =
    { hasTags =
        \hasTagsArg hasTagsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "hasTags"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Tag"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasTagsArg, hasTagsArg0 ]
    , order =
        \orderArg orderArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "order"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.namedWith [ "Basics" ] "Order" [])
                             )
                     }
                )
                [ orderArg, orderArg0 ]
    , withTags =
        \withTagsArg withTagsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "withTags"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Tag"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ withTagsArg, withTagsArg0 ]
    , gainWithProbability =
        \gainWithProbabilityArg gainWithProbabilityArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "gainWithProbability"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" []
                                  , Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ gainWithProbabilityArg, gainWithProbabilityArg0 ]
    , gainResourceWithDoubling =
        \gainResourceWithDoublingArg gainResourceWithDoublingArg0 gainResourceWithDoublingArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "gainResourceWithDoubling"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Resource"
                                      []
                                  , Type.namedWith [ "Percent" ] "Percent" []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ gainResourceWithDoublingArg
                , gainResourceWithDoublingArg0
                , gainResourceWithDoublingArg1
                ]
    , withPreservationChance =
        \withPreservationChanceArg withPreservationChanceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "withPreservationChance"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" []
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ withPreservationChanceArg, withPreservationChanceArg0 ]
    , withReducedBy =
        \withReducedByArg withReducedByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "withReducedBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "ReducedBy"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ withReducedByArg, withReducedByArg0 ]
    , spendResource =
        \spendResourceArg spendResourceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "spendResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Resource"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ spendResourceArg, spendResourceArg0 ]
    , gainResource =
        \gainResourceArg gainResourceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "gainResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Resource"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ gainResourceArg, gainResourceArg0 ]
    , gainMxp =
        \gainMxpArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "gainMxp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ gainMxpArg ]
    , gainCoin =
        \gainCoinArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "gainCoin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Coin" ]
                                      "Coin"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ gainCoinArg ]
    , gainXp =
        \gainXpArg gainXpArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "gainXp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Skill"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ gainXpArg, gainXpArg0 ]
    , setEffect =
        \setEffectArg setEffectArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "setEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "EffectType"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                             )
                     }
                )
                [ setEffectArg, setEffectArg0 ]
    , getEffect =
        \getEffectArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Effect" ]
                     , name = "getEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "EffectType"
                                       []
                                  )
                             )
                     }
                )
                [ getEffectArg ]
    }


values_ :
    { hasTags : Elm.Expression
    , order : Elm.Expression
    , withTags : Elm.Expression
    , gainWithProbability : Elm.Expression
    , gainResourceWithDoubling : Elm.Expression
    , withPreservationChance : Elm.Expression
    , withReducedBy : Elm.Expression
    , spendResource : Elm.Expression
    , gainResource : Elm.Expression
    , gainMxp : Elm.Expression
    , gainCoin : Elm.Expression
    , gainXp : Elm.Expression
    , setEffect : Elm.Expression
    , getEffect : Elm.Expression
    }
values_ =
    { hasTags =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "hasTags"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         Type.bool
                    )
            }
    , order =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "order"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.namedWith [ "Basics" ] "Order" [])
                    )
            }
    , withTags =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "withTags"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , gainWithProbability =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "gainWithProbability"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" []
                         , Type.list
                             (Type.namedWith
                                [ "IdleGame", "Effect" ]
                                "Effect"
                                []
                             )
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , gainResourceWithDoubling =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "gainResourceWithDoubling"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "IdleGame", "Effect" ] "Resource" []
                         , Type.namedWith [ "Percent" ] "Percent" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , withPreservationChance =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "withPreservationChance"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" []
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , withReducedBy =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "withReducedBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Effect" ]
                             "ReducedBy"
                             []
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , spendResource =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "spendResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "IdleGame", "Effect" ] "Resource" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , gainResource =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "gainResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "IdleGame", "Effect" ] "Resource" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , gainMxp =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "gainMxp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Effect" ] "Activity" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , gainCoin =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "gainCoin"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" [] ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , gainXp =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "gainXp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.namedWith [ "IdleGame", "Effect" ] "Skill" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , setEffect =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "setEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Effect" ]
                             "EffectType"
                             []
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , getEffect =
        Elm.value
            { importFrom = [ "IdleGame", "Effect" ]
            , name = "getEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" [] ]
                         (Type.namedWith
                              [ "IdleGame", "Effect" ]
                              "EffectType"
                              []
                         )
                    )
            }
    }