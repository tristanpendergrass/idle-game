module Gen.IdleGame.Activity exposing (allAnatomy, allStats, annotation_, backAndSpineStats, bacteriologyStats, belongsToLabel, call_, cardiovascularPhysiologyStats, caseOf_, cellInjuryStats, cellularPhysiologyStats, confidentialityAndPrivacyStats, enzymologyStats, getAnatomyMastery, getBySkill, getStats, hemodynamicDisordersStats, inflammationStats, informedConsentStats, lowerLimbStats, make_, metabolicPathwaysStats, moduleName_, molecularBiologyStats, mycologyStats, pharmacodynamicsStats, pharmacokineticsStats, principlesOfMedicalEthicsStats, respiratoryPhysiologyStats, toxicologyStats, typeToString, updateByKindActivity, upperLimbStats, values_, virologyStats)

{-|
@docs moduleName_, confidentialityAndPrivacyStats, informedConsentStats, principlesOfMedicalEthicsStats, hemodynamicDisordersStats, inflammationStats, cellInjuryStats, mycologyStats, virologyStats, bacteriologyStats, toxicologyStats, pharmacodynamicsStats, pharmacokineticsStats, respiratoryPhysiologyStats, cardiovascularPhysiologyStats, cellularPhysiologyStats, molecularBiologyStats, enzymologyStats, metabolicPathwaysStats, lowerLimbStats, upperLimbStats, backAndSpineStats, getAnatomyMastery, updateByKindActivity, allStats, getStats, typeToString, belongsToLabel, allAnatomy, getBySkill, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Activity" ]


{-| confidentialityAndPrivacyStats: IdleGame.ActivityStats -}
confidentialityAndPrivacyStats : Elm.Expression
confidentialityAndPrivacyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "confidentialityAndPrivacyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| informedConsentStats: IdleGame.ActivityStats -}
informedConsentStats : Elm.Expression
informedConsentStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "informedConsentStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| principlesOfMedicalEthicsStats: IdleGame.ActivityStats -}
principlesOfMedicalEthicsStats : Elm.Expression
principlesOfMedicalEthicsStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "principlesOfMedicalEthicsStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| hemodynamicDisordersStats: IdleGame.ActivityStats -}
hemodynamicDisordersStats : Elm.Expression
hemodynamicDisordersStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "hemodynamicDisordersStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| inflammationStats: IdleGame.ActivityStats -}
inflammationStats : Elm.Expression
inflammationStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "inflammationStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| cellInjuryStats: IdleGame.ActivityStats -}
cellInjuryStats : Elm.Expression
cellInjuryStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "cellInjuryStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| mycologyStats: IdleGame.ActivityStats -}
mycologyStats : Elm.Expression
mycologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "mycologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| virologyStats: IdleGame.ActivityStats -}
virologyStats : Elm.Expression
virologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "virologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| bacteriologyStats: IdleGame.ActivityStats -}
bacteriologyStats : Elm.Expression
bacteriologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "bacteriologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| toxicologyStats: IdleGame.ActivityStats -}
toxicologyStats : Elm.Expression
toxicologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "toxicologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| pharmacodynamicsStats: IdleGame.ActivityStats -}
pharmacodynamicsStats : Elm.Expression
pharmacodynamicsStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "pharmacodynamicsStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| pharmacokineticsStats: IdleGame.ActivityStats -}
pharmacokineticsStats : Elm.Expression
pharmacokineticsStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "pharmacokineticsStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| respiratoryPhysiologyStats: IdleGame.ActivityStats -}
respiratoryPhysiologyStats : Elm.Expression
respiratoryPhysiologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "respiratoryPhysiologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| cardiovascularPhysiologyStats: IdleGame.ActivityStats -}
cardiovascularPhysiologyStats : Elm.Expression
cardiovascularPhysiologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "cardiovascularPhysiologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| cellularPhysiologyStats: IdleGame.ActivityStats -}
cellularPhysiologyStats : Elm.Expression
cellularPhysiologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "cellularPhysiologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| molecularBiologyStats: IdleGame.ActivityStats -}
molecularBiologyStats : Elm.Expression
molecularBiologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "molecularBiologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| enzymologyStats: IdleGame.ActivityStats -}
enzymologyStats : Elm.Expression
enzymologyStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "enzymologyStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| metabolicPathwaysStats: IdleGame.ActivityStats -}
metabolicPathwaysStats : Elm.Expression
metabolicPathwaysStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "metabolicPathwaysStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| lowerLimbStats: IdleGame.ActivityStats -}
lowerLimbStats : Elm.Expression
lowerLimbStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "lowerLimbStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| upperLimbStats: IdleGame.ActivityStats -}
upperLimbStats : Elm.Expression
upperLimbStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "upperLimbStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| backAndSpineStats: IdleGame.ActivityStats -}
backAndSpineStats : Elm.Expression
backAndSpineStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "backAndSpineStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
        }


{-| getAnatomyMastery: IdleGame.Activity.Activity -> IdleGame.Activity.Mastery -}
getAnatomyMastery : Elm.Expression -> Elm.Expression
getAnatomyMastery getAnatomyMasteryArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "getAnatomyMastery"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "Activity"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Activity" ]
                               "Mastery"
                               []
                          )
                     )
             }
        )
        [ getAnatomyMasteryArg ]


{-| updateByKindActivity:
    IdleGame.Activity.Activity
    -> (a -> a)
    -> IdleGame.Activity.ActivityRecord a
    -> IdleGame.Activity.ActivityRecord a
-}
updateByKindActivity :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
updateByKindActivity updateByKindActivityArg updateByKindActivityArg0 updateByKindActivityArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "updateByKindActivity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "Activity"
                              []
                          , Type.function [ Type.var "a" ] (Type.var "a")
                          , Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "ActivityRecord"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Activity" ]
                               "ActivityRecord"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ updateByKindActivityArg
        , Elm.functionReduced
            "updateByKindActivityUnpack"
            updateByKindActivityArg0
        , updateByKindActivityArg1
        ]


{-| allStats: IdleGame.Activity.ActivityRecord IdleGame.ActivityStats -}
allStats : Elm.Expression
allStats =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "allStats"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Activity" ]
                     "ActivityRecord"
                     [ Type.namedWith [ "IdleGame", "Activity" ] "Stats" [] ]
                )
        }


{-| getStats: IdleGame.Activity.Activity -> IdleGame.ActivityStats -}
getStats : Elm.Expression -> Elm.Expression
getStats getStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "getStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "Activity"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
                     )
             }
        )
        [ getStatsArg ]


{-| typeToString: IdleGame.Activity.ActivityType -> String -}
typeToString : Elm.Expression -> Elm.Expression
typeToString typeToStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "typeToString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "ActivityType"
                              []
                          ]
                          Type.string
                     )
             }
        )
        [ typeToStringArg ]


{-| belongsToLabel: IdleGame.Activity.BelongsTo -> String -}
belongsToLabel : Elm.Expression -> Elm.Expression
belongsToLabel belongsToLabelArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "belongsToLabel"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "BelongsTo"
                              []
                          ]
                          Type.string
                     )
             }
        )
        [ belongsToLabelArg ]


{-| allAnatomy: List IdleGame.Activity.Activity -}
allAnatomy : Elm.Expression
allAnatomy =
    Elm.value
        { importFrom = [ "IdleGame", "Activity" ]
        , name = "allAnatomy"
        , annotation =
            Just
                (Type.list
                     (Type.namedWith [ "IdleGame", "Activity" ] "Activity" [])
                )
        }


{-| getBySkill: IdleGame.Activity.Skill -> List IdleGame.Activity.Activity -}
getBySkill : Elm.Expression -> Elm.Expression
getBySkill getBySkillArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "getBySkill"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Activity" ] "Skill" []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "Activity" ]
                                    "Activity"
                                    []
                               )
                          )
                     )
             }
        )
        [ getBySkillArg ]


annotation_ :
    { stats : Type.Annotation
    , mastery : Type.Annotation
    , activityType : Type.Annotation
    , belongsTo : Type.Annotation
    , masteryReward : Type.Annotation
    }
annotation_ =
    { stats =
        Type.alias
            moduleName_
            "Stats"
            []
            (Type.record
                 [ ( "belongsTo"
                   , Type.namedWith [ "IdleGame", "Activity" ] "BelongsTo" []
                   )
                 , ( "title", Type.string )
                 , ( "activityType"
                   , Type.namedWith [ "IdleGame", "Activity" ] "ActivityType" []
                   )
                 , ( "image"
                   , Type.namedWith [ "IdleGame", "Activity" ] "CardImage" []
                   )
                 , ( "unlockRequirements"
                   , Type.maybe
                         (Type.tuple
                              (Type.namedWith
                                   [ "IdleGame", "Activity" ]
                                   "Skill"
                                   []
                              )
                              Type.int
                         )
                   )
                 , ( "duration", Type.namedWith [ "Duration" ] "Duration" [] )
                 , ( "effects"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                   )
                 , ( "mastery"
                   , Type.maybe
                         (Type.namedWith [ "IdleGame", "Activity" ] "Mastery" []
                         )
                   )
                 , ( "showDuration", Type.bool )
                 ]
            )
    , mastery =
        Type.alias
            moduleName_
            "Mastery"
            []
            (Type.list
                 (Type.tuple
                      Type.int
                      (Type.namedWith
                           [ "IdleGame", "Activity" ]
                           "MasteryReward"
                           []
                      )
                 )
            )
    , activityType = Type.namedWith [ "IdleGame", "Activity" ] "ActivityType" []
    , belongsTo = Type.namedWith [ "IdleGame", "Activity" ] "BelongsTo" []
    , masteryReward =
        Type.namedWith [ "IdleGame", "Activity" ] "MasteryReward" []
    }


make_ :
    { stats :
        { belongsTo : Elm.Expression
        , title : Elm.Expression
        , activityType : Elm.Expression
        , image : Elm.Expression
        , unlockRequirements : Elm.Expression
        , duration : Elm.Expression
        , effects : Elm.Expression
        , mastery : Elm.Expression
        , showDuration : Elm.Expression
        }
        -> Elm.Expression
    , study : Elm.Expression
    , belongsToSkill : Elm.Expression -> Elm.Expression
    , intervalMod : Elm.Expression -> Elm.Expression
    , gameMod : Elm.Expression -> Elm.Expression
    }
make_ =
    { stats =
        \stats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Activity" ]
                     "Stats"
                     []
                     (Type.record
                          [ ( "belongsTo"
                            , Type.namedWith
                                  [ "IdleGame", "Activity" ]
                                  "BelongsTo"
                                  []
                            )
                          , ( "title", Type.string )
                          , ( "activityType"
                            , Type.namedWith
                                  [ "IdleGame", "Activity" ]
                                  "ActivityType"
                                  []
                            )
                          , ( "image"
                            , Type.namedWith
                                  [ "IdleGame", "Activity" ]
                                  "CardImage"
                                  []
                            )
                          , ( "unlockRequirements"
                            , Type.maybe
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "IdleGame", "Activity" ]
                                            "Skill"
                                            []
                                       )
                                       Type.int
                                  )
                            )
                          , ( "duration"
                            , Type.namedWith [ "Duration" ] "Duration" []
                            )
                          , ( "effects"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                            )
                          , ( "mastery"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "IdleGame", "Activity" ]
                                       "Mastery"
                                       []
                                  )
                            )
                          , ( "showDuration", Type.bool )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "belongsTo" stats_args.belongsTo
                     , Tuple.pair "title" stats_args.title
                     , Tuple.pair "activityType" stats_args.activityType
                     , Tuple.pair "image" stats_args.image
                     , Tuple.pair
                         "unlockRequirements"
                         stats_args.unlockRequirements
                     , Tuple.pair "duration" stats_args.duration
                     , Tuple.pair "effects" stats_args.effects
                     , Tuple.pair "mastery" stats_args.mastery
                     , Tuple.pair "showDuration" stats_args.showDuration
                     ]
                )
    , study =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "Study"
            , annotation = Just (Type.namedWith [] "ActivityType" [])
            }
    , belongsToSkill =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "BelongsToSkill"
                     , annotation = Just (Type.namedWith [] "BelongsTo" [])
                     }
                )
                [ ar0 ]
    , intervalMod =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "IntervalMod"
                     , annotation = Just (Type.namedWith [] "MasteryReward" [])
                     }
                )
                [ ar0 ]
    , gameMod =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "GameMod"
                     , annotation = Just (Type.namedWith [] "MasteryReward" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { activityType :
        Elm.Expression
        -> { activityTypeTags_0_0 | study : Elm.Expression }
        -> Elm.Expression
    , belongsTo :
        Elm.Expression
        -> { belongsToTags_1_0
            | belongsToSkill : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , masteryReward :
        Elm.Expression
        -> { masteryRewardTags_2_0
            | intervalMod : Elm.Expression -> Elm.Expression
            , gameMod : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { activityType =
        \activityTypeExpression activityTypeTags ->
            Elm.Case.custom
                activityTypeExpression
                (Type.namedWith [ "IdleGame", "Activity" ] "ActivityType" [])
                [ Elm.Case.branch0 "Study" activityTypeTags.study ]
    , belongsTo =
        \belongsToExpression belongsToTags ->
            Elm.Case.custom
                belongsToExpression
                (Type.namedWith [ "IdleGame", "Activity" ] "BelongsTo" [])
                [ Elm.Case.branch1
                    "BelongsToSkill"
                    ( "idleGameActivitySkill"
                    , Type.namedWith [ "IdleGame", "Activity" ] "Skill" []
                    )
                    belongsToTags.belongsToSkill
                ]
    , masteryReward =
        \masteryRewardExpression masteryRewardTags ->
            Elm.Case.custom
                masteryRewardExpression
                (Type.namedWith [ "IdleGame", "Activity" ] "MasteryReward" [])
                [ Elm.Case.branch1
                    "IntervalMod"
                    ( "idleGameActivityIntervalMod"
                    , Type.namedWith [ "IdleGame", "Activity" ] "IntervalMod" []
                    )
                    masteryRewardTags.intervalMod
                , Elm.Case.branch1
                    "GameMod"
                    ( "idleGameModMod"
                    , Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                    )
                    masteryRewardTags.gameMod
                ]
    }


call_ :
    { getAnatomyMastery : Elm.Expression -> Elm.Expression
    , updateByKindActivity :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getStats : Elm.Expression -> Elm.Expression
    , typeToString : Elm.Expression -> Elm.Expression
    , belongsToLabel : Elm.Expression -> Elm.Expression
    , getBySkill : Elm.Expression -> Elm.Expression
    }
call_ =
    { getAnatomyMastery =
        \getAnatomyMasteryArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "getAnatomyMastery"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Activity" ]
                                       "Mastery"
                                       []
                                  )
                             )
                     }
                )
                [ getAnatomyMasteryArg ]
    , updateByKindActivity =
        \updateByKindActivityArg updateByKindActivityArg0 updateByKindActivityArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "updateByKindActivity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "Activity"
                                      []
                                  , Type.function
                                      [ Type.var "a" ]
                                      (Type.var "a")
                                  , Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "ActivityRecord"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Activity" ]
                                       "ActivityRecord"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ updateByKindActivityArg
                , updateByKindActivityArg0
                , updateByKindActivityArg1
                ]
    , getStats =
        \getStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "getStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Activity" ]
                                       "Stats"
                                       []
                                  )
                             )
                     }
                )
                [ getStatsArg ]
    , typeToString =
        \typeToStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "typeToString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "ActivityType"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ typeToStringArg ]
    , belongsToLabel =
        \belongsToLabelArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "belongsToLabel"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "BelongsTo"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ belongsToLabelArg ]
    , getBySkill =
        \getBySkillArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "getBySkill"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "Skill"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Activity" ]
                                            "Activity"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getBySkillArg ]
    }


values_ :
    { confidentialityAndPrivacyStats : Elm.Expression
    , informedConsentStats : Elm.Expression
    , principlesOfMedicalEthicsStats : Elm.Expression
    , hemodynamicDisordersStats : Elm.Expression
    , inflammationStats : Elm.Expression
    , cellInjuryStats : Elm.Expression
    , mycologyStats : Elm.Expression
    , virologyStats : Elm.Expression
    , bacteriologyStats : Elm.Expression
    , toxicologyStats : Elm.Expression
    , pharmacodynamicsStats : Elm.Expression
    , pharmacokineticsStats : Elm.Expression
    , respiratoryPhysiologyStats : Elm.Expression
    , cardiovascularPhysiologyStats : Elm.Expression
    , cellularPhysiologyStats : Elm.Expression
    , molecularBiologyStats : Elm.Expression
    , enzymologyStats : Elm.Expression
    , metabolicPathwaysStats : Elm.Expression
    , lowerLimbStats : Elm.Expression
    , upperLimbStats : Elm.Expression
    , backAndSpineStats : Elm.Expression
    , getAnatomyMastery : Elm.Expression
    , updateByKindActivity : Elm.Expression
    , allStats : Elm.Expression
    , getStats : Elm.Expression
    , typeToString : Elm.Expression
    , belongsToLabel : Elm.Expression
    , allAnatomy : Elm.Expression
    , getBySkill : Elm.Expression
    }
values_ =
    { confidentialityAndPrivacyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "confidentialityAndPrivacyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , informedConsentStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "informedConsentStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , principlesOfMedicalEthicsStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "principlesOfMedicalEthicsStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , hemodynamicDisordersStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "hemodynamicDisordersStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , inflammationStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "inflammationStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , cellInjuryStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "cellInjuryStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , mycologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "mycologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , virologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "virologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , bacteriologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "bacteriologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , toxicologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "toxicologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , pharmacodynamicsStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "pharmacodynamicsStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , pharmacokineticsStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "pharmacokineticsStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , respiratoryPhysiologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "respiratoryPhysiologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , cardiovascularPhysiologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "cardiovascularPhysiologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , cellularPhysiologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "cellularPhysiologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , molecularBiologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "molecularBiologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , enzymologyStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "enzymologyStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , metabolicPathwaysStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "metabolicPathwaysStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , lowerLimbStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "lowerLimbStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , upperLimbStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "upperLimbStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , backAndSpineStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "backAndSpineStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
            }
    , getAnatomyMastery =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "getAnatomyMastery"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Activity" ]
                             "Activity"
                             []
                         ]
                         (Type.namedWith [ "IdleGame", "Activity" ] "Mastery" []
                         )
                    )
            }
    , updateByKindActivity =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "updateByKindActivity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Activity" ]
                             "Activity"
                             []
                         , Type.function [ Type.var "a" ] (Type.var "a")
                         , Type.namedWith
                             [ "IdleGame", "Activity" ]
                             "ActivityRecord"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "ActivityRecord"
                              [ Type.var "a" ]
                         )
                    )
            }
    , allStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "allStats"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Activity" ]
                         "ActivityRecord"
                         [ Type.namedWith [ "IdleGame", "Activity" ] "Stats" []
                         ]
                    )
            }
    , getStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "getStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Activity" ]
                             "Activity"
                             []
                         ]
                         (Type.namedWith [ "IdleGame", "Activity" ] "Stats" [])
                    )
            }
    , typeToString =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "typeToString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Activity" ]
                             "ActivityType"
                             []
                         ]
                         Type.string
                    )
            }
    , belongsToLabel =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "belongsToLabel"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Activity" ]
                             "BelongsTo"
                             []
                         ]
                         Type.string
                    )
            }
    , allAnatomy =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "allAnatomy"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "Activity"
                              []
                         )
                    )
            }
    , getBySkill =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "getBySkill"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Activity" ] "Skill" []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "Activity" ]
                                   "Activity"
                                   []
                              )
                         )
                    )
            }
    }