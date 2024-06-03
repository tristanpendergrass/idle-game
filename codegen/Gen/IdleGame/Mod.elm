module Gen.IdleGame.Mod exposing (activityXpBuff, addEffects, addEffectsTransformer, anatomyXpBuff, annotation_, applyModToEffect, applyModsToEffect, applyModsToEffectHelp, call_, caseOf_, coinBuff, coinTransformer, includeVariableEffects, increaseSuccessTransformer, make_, moduleName_, mxpBuff, mxpTransformer, resourceBaseBuff, resourceBaseTransformer, resourceBuff, resourceDoublingTransformer, resourcePreservationBuff, resourcePreservationTransformer, scopeTransformerToTags, skillXpBuff, successBuff, tupleToList, useSimpleTransformer, useSimpleTransformerHelp, values_, withHowManyTimesToApplyMod, withLabel, withSource, withTags, xpBuff, xpTransformer)

{-| 
@docs moduleName_, addEffects, successBuff, resourcePreservationBuff, resourceBaseBuff, resourceBuff, mxpBuff, coinBuff, anatomyXpBuff, skillXpBuff, xpBuff, activityXpBuff, addEffectsTransformer, increaseSuccessTransformer, resourcePreservationTransformer, resourceBaseTransformer, resourceDoublingTransformer, mxpTransformer, coinTransformer, xpTransformer, withLabel, withTags, withSource, withHowManyTimesToApplyMod, applyModsToEffectHelp, tupleToList, applyModsToEffect, applyModToEffect, useSimpleTransformerHelp, useSimpleTransformer, includeVariableEffects, scopeTransformerToTags, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Mod" ]


{-| addEffects: List IdleGame.Effect.Effect -> IdleGame.Mod.Mod -}
addEffects : List Elm.Expression -> Elm.Expression
addEffects addEffectsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "addEffects"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "IdleGame", "Effect" ]
                                 "Effect"
                                 []
                              )
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ Elm.list addEffectsArg ]


{-| successBuff: Percent.Percent -> IdleGame.Mod.Mod -}
successBuff : Elm.Expression -> Elm.Expression
successBuff successBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "successBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ successBuffArg ]


{-| resourcePreservationBuff: Percent.Percent -> IdleGame.Mod.Mod -}
resourcePreservationBuff : Elm.Expression -> Elm.Expression
resourcePreservationBuff resourcePreservationBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "resourcePreservationBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ resourcePreservationBuffArg ]


{-| resourceBaseBuff: Int -> IdleGame.Mod.Mod -}
resourceBaseBuff : Int -> Elm.Expression
resourceBaseBuff resourceBaseBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "resourceBaseBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ Elm.int resourceBaseBuffArg ]


{-| resourceBuff: Percent.Percent -> IdleGame.Mod.Mod -}
resourceBuff : Elm.Expression -> Elm.Expression
resourceBuff resourceBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "resourceBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ resourceBuffArg ]


{-| mxpBuff: Percent.Percent -> IdleGame.Mod.Mod -}
mxpBuff : Elm.Expression -> Elm.Expression
mxpBuff mxpBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "mxpBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ mxpBuffArg ]


{-| coinBuff: Percent.Percent -> IdleGame.Mod.Mod -}
coinBuff : Elm.Expression -> Elm.Expression
coinBuff coinBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "coinBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ coinBuffArg ]


{-| anatomyXpBuff: Percent.Percent -> IdleGame.Mod.Mod -}
anatomyXpBuff : Elm.Expression -> Elm.Expression
anatomyXpBuff anatomyXpBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "anatomyXpBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ anatomyXpBuffArg ]


{-| skillXpBuff: IdleGame.Mod.Skill -> Percent.Percent -> IdleGame.Mod.Mod -}
skillXpBuff : Elm.Expression -> Elm.Expression -> Elm.Expression
skillXpBuff skillXpBuffArg skillXpBuffArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "skillXpBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Mod" ] "Skill" []
                          , Type.namedWith [ "Percent" ] "Percent" []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ skillXpBuffArg, skillXpBuffArg0 ]


{-| xpBuff: Percent.Percent -> IdleGame.Mod.Mod -}
xpBuff : Elm.Expression -> Elm.Expression
xpBuff xpBuffArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "xpBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ xpBuffArg ]


{-| activityXpBuff: IdleGame.Mod.Activity -> Percent.Percent -> IdleGame.Mod.Mod -}
activityXpBuff : Elm.Expression -> Elm.Expression -> Elm.Expression
activityXpBuff activityXpBuffArg activityXpBuffArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "activityXpBuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Mod" ] "Activity" []
                          , Type.namedWith [ "Percent" ] "Percent" []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ activityXpBuffArg, activityXpBuffArg0 ]


{-| addEffectsTransformer: List IdleGame.Effect.Effect -> IdleGame.Mod.Transformer -}
addEffectsTransformer : List Elm.Expression -> Elm.Expression
addEffectsTransformer addEffectsTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "addEffectsTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "IdleGame", "Effect" ]
                                 "Effect"
                                 []
                              )
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ Elm.list addEffectsTransformerArg ]


{-| increaseSuccessTransformer: Percent.Percent -> IdleGame.Mod.Transformer -}
increaseSuccessTransformer : Elm.Expression -> Elm.Expression
increaseSuccessTransformer increaseSuccessTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "increaseSuccessTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ increaseSuccessTransformerArg ]


{-| resourcePreservationTransformer: Percent.Percent -> IdleGame.Mod.Transformer -}
resourcePreservationTransformer : Elm.Expression -> Elm.Expression
resourcePreservationTransformer resourcePreservationTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "resourcePreservationTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ resourcePreservationTransformerArg ]


{-| resourceBaseTransformer: Int -> IdleGame.Mod.Transformer -}
resourceBaseTransformer : Int -> Elm.Expression
resourceBaseTransformer resourceBaseTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "resourceBaseTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ Elm.int resourceBaseTransformerArg ]


{-| resourceDoublingTransformer: Percent.Percent -> IdleGame.Mod.Transformer -}
resourceDoublingTransformer : Elm.Expression -> Elm.Expression
resourceDoublingTransformer resourceDoublingTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "resourceDoublingTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ resourceDoublingTransformerArg ]


{-| mxpTransformer: Percent.Percent -> IdleGame.Mod.Transformer -}
mxpTransformer : Elm.Expression -> Elm.Expression
mxpTransformer mxpTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "mxpTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ mxpTransformerArg ]


{-| coinTransformer: Percent.Percent -> IdleGame.Mod.Transformer -}
coinTransformer : Elm.Expression -> Elm.Expression
coinTransformer coinTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "coinTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ coinTransformerArg ]


{-| xpTransformer: Percent.Percent -> IdleGame.Mod.Transformer -}
xpTransformer : Elm.Expression -> Elm.Expression
xpTransformer xpTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "xpTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ xpTransformerArg ]


{-| withLabel: IdleGame.Mod.Label -> IdleGame.Mod.Mod -> IdleGame.Mod.Mod -}
withLabel : Elm.Expression -> Elm.Expression -> Elm.Expression
withLabel withLabelArg withLabelArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "withLabel"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Mod" ] "Label" []
                          , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ withLabelArg, withLabelArg0 ]


{-| withTags: List IdleGame.Effect.Tag -> IdleGame.Mod.Mod -> IdleGame.Mod.Mod -}
withTags : List Elm.Expression -> Elm.Expression -> Elm.Expression
withTags withTagsArg withTagsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "withTags"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                          , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ Elm.list withTagsArg, withTagsArg0 ]


{-| withSource: IdleGame.Mod.ModSource -> IdleGame.Mod.Mod -> IdleGame.Mod.Mod -}
withSource : Elm.Expression -> Elm.Expression -> Elm.Expression
withSource withSourceArg withSourceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "withSource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Mod" ] "ModSource" []
                          , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ withSourceArg, withSourceArg0 ]


{-| withHowManyTimesToApplyMod: Int -> IdleGame.Mod.Mod -> IdleGame.Mod.Mod -}
withHowManyTimesToApplyMod : Int -> Elm.Expression -> Elm.Expression
withHowManyTimesToApplyMod withHowManyTimesToApplyModArg withHowManyTimesToApplyModArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "withHowManyTimesToApplyMod"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ Elm.int withHowManyTimesToApplyModArg
        , withHowManyTimesToApplyModArg0
        ]


{-| applyModsToEffectHelp: 
    Int
    -> List IdleGame.Mod.Mod
    -> IdleGame.Effect.Effect
    -> ( IdleGame.Effect.Effect, List IdleGame.Effect.Effect )
-}
applyModsToEffectHelp :
    Int -> List Elm.Expression -> Elm.Expression -> Elm.Expression
applyModsToEffectHelp applyModsToEffectHelpArg applyModsToEffectHelpArg0 applyModsToEffectHelpArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "applyModsToEffectHelp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "IdleGame", "Effect" ]
                                    "Effect"
                                    []
                               )
                               (Type.list
                                    (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ Elm.int applyModsToEffectHelpArg
        , Elm.list applyModsToEffectHelpArg0
        , applyModsToEffectHelpArg1
        ]


{-| tupleToList: ( a, List a ) -> List a -}
tupleToList : Elm.Expression -> Elm.Expression
tupleToList tupleToListArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "tupleToList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.tuple (Type.var "a") (Type.list (Type.var "a"))
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ tupleToListArg ]


{-| applyModsToEffect: 
    List IdleGame.Mod.Mod
    -> IdleGame.Effect.Effect
    -> ( IdleGame.Effect.Effect, List IdleGame.Effect.Effect )
-}
applyModsToEffect : List Elm.Expression -> Elm.Expression -> Elm.Expression
applyModsToEffect applyModsToEffectArg applyModsToEffectArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "applyModsToEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "IdleGame", "Effect" ]
                                    "Effect"
                                    []
                               )
                               (Type.list
                                    (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ Elm.list applyModsToEffectArg, applyModsToEffectArg0 ]


{-| applyModToEffect: 
    IdleGame.Mod.Mod
    -> ( IdleGame.Effect.Effect, List IdleGame.Effect.Effect )
    -> ( IdleGame.Effect.Effect, List IdleGame.Effect.Effect )
-}
applyModToEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
applyModToEffect applyModToEffectArg applyModToEffectArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "applyModToEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                          , Type.tuple
                              (Type.namedWith
                                 [ "IdleGame", "Effect" ]
                                 "Effect"
                                 []
                              )
                              (Type.list
                                 (Type.namedWith
                                    [ "IdleGame", "Effect" ]
                                    "Effect"
                                    []
                                 )
                              )
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "IdleGame", "Effect" ]
                                    "Effect"
                                    []
                               )
                               (Type.list
                                    (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ applyModToEffectArg, applyModToEffectArg0 ]


{-| useSimpleTransformerHelp: Int -> IdleGame.Mod.SimpleTransformer -> IdleGame.Mod.Transformer -}
useSimpleTransformerHelp : Int -> Elm.Expression -> Elm.Expression
useSimpleTransformerHelp useSimpleTransformerHelpArg useSimpleTransformerHelpArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "useSimpleTransformerHelp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "IdleGame", "Mod" ]
                              "SimpleTransformer"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ Elm.int useSimpleTransformerHelpArg, useSimpleTransformerHelpArg0 ]


{-| useSimpleTransformer: IdleGame.Mod.SimpleTransformer -> IdleGame.Mod.Transformer -}
useSimpleTransformer : Elm.Expression -> Elm.Expression
useSimpleTransformer useSimpleTransformerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "useSimpleTransformer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Mod" ]
                              "SimpleTransformer"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ useSimpleTransformerArg ]


{-| includeVariableEffects: IdleGame.Mod.Mod -> IdleGame.Mod.Mod -}
includeVariableEffects : Elm.Expression -> Elm.Expression
includeVariableEffects includeVariableEffectsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "includeVariableEffects"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Mod" ] "Mod" [] ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                     )
             }
        )
        [ includeVariableEffectsArg ]


{-| scopeTransformerToTags: List IdleGame.Effect.Tag -> IdleGame.Mod.Transformer -> IdleGame.Mod.Transformer -}
scopeTransformerToTags : List Elm.Expression -> Elm.Expression -> Elm.Expression
scopeTransformerToTags scopeTransformerToTagsArg scopeTransformerToTagsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Mod" ]
             , name = "scopeTransformerToTags"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                          , Type.namedWith
                              [ "IdleGame", "Mod" ]
                              "Transformer"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                          )
                     )
             }
        )
        [ Elm.list scopeTransformerToTagsArg, scopeTransformerToTagsArg0 ]


annotation_ :
    { simpleTransformer : Type.Annotation
    , transformer : Type.Annotation
    , mod : Type.Annotation
    , label : Type.Annotation
    , transformerResult : Type.Annotation
    , modSource : Type.Annotation
    }
annotation_ =
    { simpleTransformer =
        Type.alias
            moduleName_
            "SimpleTransformer"
            []
            (Type.function
                 [ Type.namedWith [ "IdleGame", "Effect" ] "EffectType" [] ]
                 (Type.namedWith [ "IdleGame", "Effect" ] "EffectType" [])
            )
    , transformer =
        Type.alias
            moduleName_
            "Transformer"
            []
            (Type.function
                 [ Type.int
                 , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                 ]
                 (Type.namedWith [ "IdleGame", "Mod" ] "TransformerResult" [])
            )
    , mod =
        Type.alias
            moduleName_
            "Mod"
            []
            (Type.record
                 [ ( "tags"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                   )
                 , ( "label", Type.namedWith [ "IdleGame", "Mod" ] "Label" [] )
                 , ( "transformer"
                   , Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                   )
                 , ( "repetitions", Type.int )
                 , ( "source"
                   , Type.namedWith [ "IdleGame", "Mod" ] "ModSource" []
                   )
                 ]
            )
    , label = Type.namedWith [ "IdleGame", "Mod" ] "Label" []
    , transformerResult =
        Type.namedWith [ "IdleGame", "Mod" ] "TransformerResult" []
    , modSource = Type.namedWith [ "IdleGame", "Mod" ] "ModSource" []
    }


make_ :
    { mod :
        { tags : Elm.Expression
        , label : Elm.Expression
        , transformer : Elm.Expression
        , repetitions : Elm.Expression
        , source : Elm.Expression
        }
        -> Elm.Expression
    , nullLabel : Elm.Expression
    , xpActivityLabel : Elm.Expression -> Elm.Expression
    , xpSkillLabel : Elm.Expression -> Elm.Expression -> Elm.Expression
    , mxpModLabel : Elm.Expression -> Elm.Expression
    , resourceDoublingLabel : Elm.Expression -> Elm.Expression
    , resourcePreservationLabel : Elm.Expression -> Elm.Expression
    , resourceBaseLabel : Elm.Expression -> Elm.Expression
    , moreManure : Elm.Expression
    , successLabel : Elm.Expression -> Elm.Expression
    , coinLabel : Elm.Expression -> Elm.Expression
    , powerLabel : Elm.Expression -> Elm.Expression
    , noChange : Elm.Expression
    , changeEffect : Elm.Expression -> Elm.Expression
    , changeAndAddEffects : Elm.Expression -> Elm.Expression -> Elm.Expression
    , adminCrimes : Elm.Expression
    , shopItem : Elm.Expression
    }
make_ =
    { mod =
        \mod_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Mod" ]
                     "Mod"
                     []
                     (Type.record
                          [ ( "tags"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Tag"
                                       []
                                  )
                            )
                          , ( "label"
                            , Type.namedWith [ "IdleGame", "Mod" ] "Label" []
                            )
                          , ( "transformer"
                            , Type.namedWith
                                  [ "IdleGame", "Mod" ]
                                  "Transformer"
                                  []
                            )
                          , ( "repetitions", Type.int )
                          , ( "source"
                            , Type.namedWith
                                  [ "IdleGame", "Mod" ]
                                  "ModSource"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "tags" mod_args.tags
                     , Tuple.pair "label" mod_args.label
                     , Tuple.pair "transformer" mod_args.transformer
                     , Tuple.pair "repetitions" mod_args.repetitions
                     , Tuple.pair "source" mod_args.source
                     ]
                )
    , nullLabel =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "NullLabel"
            , annotation = Just (Type.namedWith [] "Label" [])
            }
    , xpActivityLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "XpActivityLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , xpSkillLabel =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "XpSkillLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0, ar1 ]
    , mxpModLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "MxpModLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , resourceDoublingLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "ResourceDoublingLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , resourcePreservationLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "ResourcePreservationLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , resourceBaseLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "ResourceBaseLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , moreManure =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "MoreManure"
            , annotation = Just (Type.namedWith [] "Label" [])
            }
    , successLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "SuccessLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , coinLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "CoinLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , powerLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "PowerLabel"
                     , annotation = Just (Type.namedWith [] "Label" [])
                     }
                )
                [ ar0 ]
    , noChange =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "NoChange"
            , annotation = Just (Type.namedWith [] "TransformerResult" [])
            }
    , changeEffect =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "ChangeEffect"
                     , annotation =
                         Just (Type.namedWith [] "TransformerResult" [])
                     }
                )
                [ ar0 ]
    , changeAndAddEffects =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "ChangeAndAddEffects"
                     , annotation =
                         Just (Type.namedWith [] "TransformerResult" [])
                     }
                )
                [ ar0, ar1 ]
    , adminCrimes =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "AdminCrimes"
            , annotation = Just (Type.namedWith [] "ModSource" [])
            }
    , shopItem =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "ShopItem"
            , annotation = Just (Type.namedWith [] "ModSource" [])
            }
    }


caseOf_ :
    { label :
        Elm.Expression
        -> { labelTags_0_0
            | nullLabel : Elm.Expression
            , xpActivityLabel : Elm.Expression -> Elm.Expression
            , xpSkillLabel : Elm.Expression -> Elm.Expression -> Elm.Expression
            , mxpModLabel : Elm.Expression -> Elm.Expression
            , resourceDoublingLabel : Elm.Expression -> Elm.Expression
            , resourcePreservationLabel : Elm.Expression -> Elm.Expression
            , resourceBaseLabel : Elm.Expression -> Elm.Expression
            , moreManure : Elm.Expression
            , successLabel : Elm.Expression -> Elm.Expression
            , coinLabel : Elm.Expression -> Elm.Expression
            , powerLabel : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , transformerResult :
        Elm.Expression
        -> { transformerResultTags_1_0
            | noChange : Elm.Expression
            , changeEffect : Elm.Expression -> Elm.Expression
            , changeAndAddEffects :
                Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , modSource :
        Elm.Expression
        -> { modSourceTags_2_0
            | adminCrimes : Elm.Expression
            , shopItem : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { label =
        \labelExpression labelTags ->
            Elm.Case.custom
                labelExpression
                (Type.namedWith [ "IdleGame", "Mod" ] "Label" [])
                [ Elm.Case.branch0 "NullLabel" labelTags.nullLabel
                , Elm.Case.branch1
                    "XpActivityLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    labelTags.xpActivityLabel
                , Elm.Case.branch2
                    "XpSkillLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    ( "idleGameModSkill"
                    , Type.namedWith [ "IdleGame", "Mod" ] "Skill" []
                    )
                    labelTags.xpSkillLabel
                , Elm.Case.branch1
                    "MxpModLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    labelTags.mxpModLabel
                , Elm.Case.branch1
                    "ResourceDoublingLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    labelTags.resourceDoublingLabel
                , Elm.Case.branch1
                    "ResourcePreservationLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    labelTags.resourcePreservationLabel
                , Elm.Case.branch1
                    "ResourceBaseLabel"
                    ( "basicsInt", Type.int )
                    labelTags.resourceBaseLabel
                , Elm.Case.branch0 "MoreManure" labelTags.moreManure
                , Elm.Case.branch1
                    "SuccessLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    labelTags.successLabel
                , Elm.Case.branch1
                    "CoinLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    labelTags.coinLabel
                , Elm.Case.branch1
                    "PowerLabel"
                    ( "basicsInt", Type.int )
                    labelTags.powerLabel
                ]
    , transformerResult =
        \transformerResultExpression transformerResultTags ->
            Elm.Case.custom
                transformerResultExpression
                (Type.namedWith [ "IdleGame", "Mod" ] "TransformerResult" [])
                [ Elm.Case.branch0 "NoChange" transformerResultTags.noChange
                , Elm.Case.branch1
                    "ChangeEffect"
                    ( "idleGameEffectEffect"
                    , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                    )
                    transformerResultTags.changeEffect
                , Elm.Case.branch2
                    "ChangeAndAddEffects"
                    ( "idleGameEffectEffect"
                    , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                    )
                    ( "listList"
                    , Type.list
                          (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
                    transformerResultTags.changeAndAddEffects
                ]
    , modSource =
        \modSourceExpression modSourceTags ->
            Elm.Case.custom
                modSourceExpression
                (Type.namedWith [ "IdleGame", "Mod" ] "ModSource" [])
                [ Elm.Case.branch0 "AdminCrimes" modSourceTags.adminCrimes
                , Elm.Case.branch0 "ShopItem" modSourceTags.shopItem
                ]
    }


call_ :
    { addEffects : Elm.Expression -> Elm.Expression
    , successBuff : Elm.Expression -> Elm.Expression
    , resourcePreservationBuff : Elm.Expression -> Elm.Expression
    , resourceBaseBuff : Elm.Expression -> Elm.Expression
    , resourceBuff : Elm.Expression -> Elm.Expression
    , mxpBuff : Elm.Expression -> Elm.Expression
    , coinBuff : Elm.Expression -> Elm.Expression
    , anatomyXpBuff : Elm.Expression -> Elm.Expression
    , skillXpBuff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , xpBuff : Elm.Expression -> Elm.Expression
    , activityXpBuff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , addEffectsTransformer : Elm.Expression -> Elm.Expression
    , increaseSuccessTransformer : Elm.Expression -> Elm.Expression
    , resourcePreservationTransformer : Elm.Expression -> Elm.Expression
    , resourceBaseTransformer : Elm.Expression -> Elm.Expression
    , resourceDoublingTransformer : Elm.Expression -> Elm.Expression
    , mxpTransformer : Elm.Expression -> Elm.Expression
    , coinTransformer : Elm.Expression -> Elm.Expression
    , xpTransformer : Elm.Expression -> Elm.Expression
    , withLabel : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withTags : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withSource : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withHowManyTimesToApplyMod :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , applyModsToEffectHelp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , tupleToList : Elm.Expression -> Elm.Expression
    , applyModsToEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , applyModToEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , useSimpleTransformerHelp :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , useSimpleTransformer : Elm.Expression -> Elm.Expression
    , includeVariableEffects : Elm.Expression -> Elm.Expression
    , scopeTransformerToTags :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { addEffects =
        \addEffectsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "addEffects"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                      )
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ addEffectsArg ]
    , successBuff =
        \successBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "successBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ successBuffArg ]
    , resourcePreservationBuff =
        \resourcePreservationBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "resourcePreservationBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ resourcePreservationBuffArg ]
    , resourceBaseBuff =
        \resourceBaseBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "resourceBaseBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ resourceBaseBuffArg ]
    , resourceBuff =
        \resourceBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "resourceBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ resourceBuffArg ]
    , mxpBuff =
        \mxpBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "mxpBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ mxpBuffArg ]
    , coinBuff =
        \coinBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "coinBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ coinBuffArg ]
    , anatomyXpBuff =
        \anatomyXpBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "anatomyXpBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ anatomyXpBuffArg ]
    , skillXpBuff =
        \skillXpBuffArg skillXpBuffArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "skillXpBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Skill"
                                      []
                                  , Type.namedWith [ "Percent" ] "Percent" []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ skillXpBuffArg, skillXpBuffArg0 ]
    , xpBuff =
        \xpBuffArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "xpBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ xpBuffArg ]
    , activityXpBuff =
        \activityXpBuffArg activityXpBuffArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "activityXpBuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Activity"
                                      []
                                  , Type.namedWith [ "Percent" ] "Percent" []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ activityXpBuffArg, activityXpBuffArg0 ]
    , addEffectsTransformer =
        \addEffectsTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "addEffectsTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ addEffectsTransformerArg ]
    , increaseSuccessTransformer =
        \increaseSuccessTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "increaseSuccessTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ increaseSuccessTransformerArg ]
    , resourcePreservationTransformer =
        \resourcePreservationTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "resourcePreservationTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ resourcePreservationTransformerArg ]
    , resourceBaseTransformer =
        \resourceBaseTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "resourceBaseTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ resourceBaseTransformerArg ]
    , resourceDoublingTransformer =
        \resourceDoublingTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "resourceDoublingTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ resourceDoublingTransformerArg ]
    , mxpTransformer =
        \mxpTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "mxpTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ mxpTransformerArg ]
    , coinTransformer =
        \coinTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "coinTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ coinTransformerArg ]
    , xpTransformer =
        \xpTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "xpTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ xpTransformerArg ]
    , withLabel =
        \withLabelArg withLabelArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "withLabel"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Label"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ withLabelArg, withLabelArg0 ]
    , withTags =
        \withTagsArg withTagsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
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
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ withTagsArg, withTagsArg0 ]
    , withSource =
        \withSourceArg withSourceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "withSource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "ModSource"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ withSourceArg, withSourceArg0 ]
    , withHowManyTimesToApplyMod =
        \withHowManyTimesToApplyModArg withHowManyTimesToApplyModArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "withHowManyTimesToApplyMod"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ withHowManyTimesToApplyModArg
                , withHowManyTimesToApplyModArg0
                ]
    , applyModsToEffectHelp =
        \applyModsToEffectHelpArg applyModsToEffectHelpArg0 applyModsToEffectHelpArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "applyModsToEffectHelp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Mod" ]
                                         "Mod"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "IdleGame", "Effect" ]
                                            "Effect"
                                            []
                                       )
                                       (Type.list
                                            (Type.namedWith
                                                 [ "IdleGame", "Effect" ]
                                                 "Effect"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ applyModsToEffectHelpArg
                , applyModsToEffectHelpArg0
                , applyModsToEffectHelpArg1
                ]
    , tupleToList =
        \tupleToListArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "tupleToList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.tuple
                                      (Type.var "a")
                                      (Type.list (Type.var "a"))
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ tupleToListArg ]
    , applyModsToEffect =
        \applyModsToEffectArg applyModsToEffectArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "applyModsToEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Mod" ]
                                         "Mod"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "IdleGame", "Effect" ]
                                            "Effect"
                                            []
                                       )
                                       (Type.list
                                            (Type.namedWith
                                                 [ "IdleGame", "Effect" ]
                                                 "Effect"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ applyModsToEffectArg, applyModsToEffectArg0 ]
    , applyModToEffect =
        \applyModToEffectArg applyModToEffectArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "applyModToEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                  , Type.tuple
                                      (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                      )
                                      (Type.list
                                         (Type.namedWith
                                            [ "IdleGame", "Effect" ]
                                            "Effect"
                                            []
                                         )
                                      )
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "IdleGame", "Effect" ]
                                            "Effect"
                                            []
                                       )
                                       (Type.list
                                            (Type.namedWith
                                                 [ "IdleGame", "Effect" ]
                                                 "Effect"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ applyModToEffectArg, applyModToEffectArg0 ]
    , useSimpleTransformerHelp =
        \useSimpleTransformerHelpArg useSimpleTransformerHelpArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "useSimpleTransformerHelp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "SimpleTransformer"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ useSimpleTransformerHelpArg, useSimpleTransformerHelpArg0 ]
    , useSimpleTransformer =
        \useSimpleTransformerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "useSimpleTransformer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "SimpleTransformer"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ useSimpleTransformerArg ]
    , includeVariableEffects =
        \includeVariableEffectsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "includeVariableEffects"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Mod" ]
                                      "Mod"
                                      []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                             )
                     }
                )
                [ includeVariableEffectsArg ]
    , scopeTransformerToTags =
        \scopeTransformerToTagsArg scopeTransformerToTagsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Mod" ]
                     , name = "scopeTransformerToTags"
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
                                      [ "IdleGame", "Mod" ]
                                      "Transformer"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Mod" ]
                                       "Transformer"
                                       []
                                  )
                             )
                     }
                )
                [ scopeTransformerToTagsArg, scopeTransformerToTagsArg0 ]
    }


values_ :
    { addEffects : Elm.Expression
    , successBuff : Elm.Expression
    , resourcePreservationBuff : Elm.Expression
    , resourceBaseBuff : Elm.Expression
    , resourceBuff : Elm.Expression
    , mxpBuff : Elm.Expression
    , coinBuff : Elm.Expression
    , anatomyXpBuff : Elm.Expression
    , skillXpBuff : Elm.Expression
    , xpBuff : Elm.Expression
    , activityXpBuff : Elm.Expression
    , addEffectsTransformer : Elm.Expression
    , increaseSuccessTransformer : Elm.Expression
    , resourcePreservationTransformer : Elm.Expression
    , resourceBaseTransformer : Elm.Expression
    , resourceDoublingTransformer : Elm.Expression
    , mxpTransformer : Elm.Expression
    , coinTransformer : Elm.Expression
    , xpTransformer : Elm.Expression
    , withLabel : Elm.Expression
    , withTags : Elm.Expression
    , withSource : Elm.Expression
    , withHowManyTimesToApplyMod : Elm.Expression
    , applyModsToEffectHelp : Elm.Expression
    , tupleToList : Elm.Expression
    , applyModsToEffect : Elm.Expression
    , applyModToEffect : Elm.Expression
    , useSimpleTransformerHelp : Elm.Expression
    , useSimpleTransformer : Elm.Expression
    , includeVariableEffects : Elm.Expression
    , scopeTransformerToTags : Elm.Expression
    }
values_ =
    { addEffects =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "addEffects"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "IdleGame", "Effect" ]
                                "Effect"
                                []
                             )
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , successBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "successBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , resourcePreservationBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "resourcePreservationBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , resourceBaseBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "resourceBaseBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , resourceBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "resourceBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , mxpBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "mxpBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , coinBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "coinBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , anatomyXpBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "anatomyXpBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , skillXpBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "skillXpBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Mod" ] "Skill" []
                         , Type.namedWith [ "Percent" ] "Percent" []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , xpBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "xpBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , activityXpBuff =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "activityXpBuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Mod" ] "Activity" []
                         , Type.namedWith [ "Percent" ] "Percent" []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , addEffectsTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "addEffectsTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "IdleGame", "Effect" ]
                                "Effect"
                                []
                             )
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , increaseSuccessTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "increaseSuccessTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , resourcePreservationTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "resourcePreservationTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , resourceBaseTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "resourceBaseTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , resourceDoublingTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "resourceDoublingTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , mxpTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "mxpTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , coinTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "coinTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , xpTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "xpTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , withLabel =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "withLabel"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Mod" ] "Label" []
                         , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , withTags =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "withTags"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                         , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , withSource =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "withSource"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Mod" ] "ModSource" []
                         , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , withHowManyTimesToApplyMod =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "withHowManyTimesToApplyMod"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , applyModsToEffectHelp =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "applyModsToEffectHelp"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.list
                             (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "IdleGame", "Effect" ]
                                   "Effect"
                                   []
                              )
                              (Type.list
                                   (Type.namedWith
                                        [ "IdleGame", "Effect" ]
                                        "Effect"
                                        []
                                   )
                              )
                         )
                    )
            }
    , tupleToList =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "tupleToList"
            , annotation =
                Just
                    (Type.function
                         [ Type.tuple (Type.var "a") (Type.list (Type.var "a"))
                         ]
                         (Type.list (Type.var "a"))
                    )
            }
    , applyModsToEffect =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "applyModsToEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         , Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "IdleGame", "Effect" ]
                                   "Effect"
                                   []
                              )
                              (Type.list
                                   (Type.namedWith
                                        [ "IdleGame", "Effect" ]
                                        "Effect"
                                        []
                                   )
                              )
                         )
                    )
            }
    , applyModToEffect =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "applyModToEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                         , Type.tuple
                             (Type.namedWith
                                [ "IdleGame", "Effect" ]
                                "Effect"
                                []
                             )
                             (Type.list
                                (Type.namedWith
                                   [ "IdleGame", "Effect" ]
                                   "Effect"
                                   []
                                )
                             )
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "IdleGame", "Effect" ]
                                   "Effect"
                                   []
                              )
                              (Type.list
                                   (Type.namedWith
                                        [ "IdleGame", "Effect" ]
                                        "Effect"
                                        []
                                   )
                              )
                         )
                    )
            }
    , useSimpleTransformerHelp =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "useSimpleTransformerHelp"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith
                             [ "IdleGame", "Mod" ]
                             "SimpleTransformer"
                             []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , useSimpleTransformer =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "useSimpleTransformer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Mod" ]
                             "SimpleTransformer"
                             []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    , includeVariableEffects =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "includeVariableEffects"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Mod" ] "Mod" [] ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
            }
    , scopeTransformerToTags =
        Elm.value
            { importFrom = [ "IdleGame", "Mod" ]
            , name = "scopeTransformerToTags"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "IdleGame", "Effect" ] "Tag" [])
                         , Type.namedWith [ "IdleGame", "Mod" ] "Transformer" []
                         ]
                         (Type.namedWith [ "IdleGame", "Mod" ] "Transformer" [])
                    )
            }
    }