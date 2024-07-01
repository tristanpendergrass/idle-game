module Gen.IdleGame.Activity exposing (allAnatomy, annotation_, call_, caseOf_, getAnatomyMastery, getBySkill, getEffectStats, knowledgeResource, make_, moduleName_, updateByKindActivity, values_)

{-| 
@docs moduleName_, getAnatomyMastery, updateByKindActivity, getEffectStats, knowledgeResource, allAnatomy, getBySkill, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Activity" ]


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


{-| getEffectStats: IdleGame.Activity.Activity -> IdleGame.Activity.EffectStats -}
getEffectStats : Elm.Expression -> Elm.Expression
getEffectStats getEffectStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "getEffectStats"
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
                               "EffectStats"
                               []
                          )
                     )
             }
        )
        [ getEffectStatsArg ]


{-| knowledgeResource: IdleGame.Activity.Skill -> Maybe IdleGame.Activity.Resource -}
knowledgeResource : Elm.Expression -> Elm.Expression
knowledgeResource knowledgeResourceArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Activity" ]
             , name = "knowledgeResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Activity" ] "Skill" []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "IdleGame", "Activity" ]
                                    "Resource"
                                    []
                               )
                          )
                     )
             }
        )
        [ knowledgeResourceArg ]


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
    { effectStats : Type.Annotation
    , mastery : Type.Annotation
    , masteryReward : Type.Annotation
    }
annotation_ =
    { effectStats =
        Type.alias
            moduleName_
            "EffectStats"
            []
            (Type.record
                 [ ( "effects"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                   )
                 , ( "mastery"
                   , Type.maybe
                         (Type.namedWith [ "IdleGame", "Activity" ] "Mastery" []
                         )
                   )
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
    , masteryReward =
        Type.namedWith [ "IdleGame", "Activity" ] "MasteryReward" []
    }


make_ :
    { effectStats :
        { effects : Elm.Expression, mastery : Elm.Expression } -> Elm.Expression
    , intervalMod : Elm.Expression -> Elm.Expression
    , gameMod : Elm.Expression -> Elm.Expression
    }
make_ =
    { effectStats =
        \effectStats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Activity" ]
                     "EffectStats"
                     []
                     (Type.record
                          [ ( "effects"
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
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "effects" effectStats_args.effects
                     , Tuple.pair "mastery" effectStats_args.mastery
                     ]
                )
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
    { masteryReward :
        Elm.Expression
        -> { masteryRewardTags_0_0
            | intervalMod : Elm.Expression -> Elm.Expression
            , gameMod : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { masteryReward =
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
    , getEffectStats : Elm.Expression -> Elm.Expression
    , knowledgeResource : Elm.Expression -> Elm.Expression
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
    , getEffectStats =
        \getEffectStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "getEffectStats"
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
                                       "EffectStats"
                                       []
                                  )
                             )
                     }
                )
                [ getEffectStatsArg ]
    , knowledgeResource =
        \knowledgeResourceArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Activity" ]
                     , name = "knowledgeResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "Skill"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "IdleGame", "Activity" ]
                                            "Resource"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ knowledgeResourceArg ]
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
    { getAnatomyMastery : Elm.Expression
    , updateByKindActivity : Elm.Expression
    , getEffectStats : Elm.Expression
    , knowledgeResource : Elm.Expression
    , allAnatomy : Elm.Expression
    , getBySkill : Elm.Expression
    }
values_ =
    { getAnatomyMastery =
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
    , getEffectStats =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "getEffectStats"
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
                              "EffectStats"
                              []
                         )
                    )
            }
    , knowledgeResource =
        Elm.value
            { importFrom = [ "IdleGame", "Activity" ]
            , name = "knowledgeResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Activity" ] "Skill" []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "IdleGame", "Activity" ]
                                   "Resource"
                                   []
                              )
                         )
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