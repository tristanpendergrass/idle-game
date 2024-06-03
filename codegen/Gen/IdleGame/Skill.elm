module Gen.IdleGame.Skill exposing (allStats, annotation_, call_, getStats, make_, moduleName_, updateBySkill, values_)

{-|
@docs moduleName_, allStats, getStats, updateBySkill, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Skill" ]


{-| allStats: IdleGame.Skill.SkillRecord IdleGame.SkillStats -}
allStats : Elm.Expression
allStats =
    Elm.value
        { importFrom = [ "IdleGame", "Skill" ]
        , name = "allStats"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Skill" ]
                     "SkillRecord"
                     [ Type.namedWith [ "IdleGame", "Skill" ] "Stats" [] ]
                )
        }


{-| getStats: IdleGame.Skill.Skill -> IdleGame.SkillStats -}
getStats : Elm.Expression -> Elm.Expression
getStats getStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Skill" ]
             , name = "getStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Skill" ] "Skill" [] ]
                          (Type.namedWith [ "IdleGame", "Skill" ] "Stats" [])
                     )
             }
        )
        [ getStatsArg ]


{-| updateBySkill:
    IdleGame.Skill.Skill
    -> (a -> a)
    -> IdleGame.Skill.SkillRecord a
    -> IdleGame.Skill.SkillRecord a
-}
updateBySkill :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
updateBySkill updateBySkillArg updateBySkillArg0 updateBySkillArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Skill" ]
             , name = "updateBySkill"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Skill" ] "Skill" []
                          , Type.function [ Type.var "a" ] (Type.var "a")
                          , Type.namedWith
                              [ "IdleGame", "Skill" ]
                              "SkillRecord"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Skill" ]
                               "SkillRecord"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ updateBySkillArg
        , Elm.functionReduced "updateBySkillUnpack" updateBySkillArg0
        , updateBySkillArg1
        ]


annotation_ : { stats : Type.Annotation }
annotation_ =
    { stats =
        Type.alias
            moduleName_
            "Stats"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "icon"
                   , Type.namedWith [ "IdleGame", "Views", "Icon" ] "Icon" []
                   )
                 ]
            )
    }


make_ :
    { stats :
        { title : Elm.Expression, icon : Elm.Expression } -> Elm.Expression
    }
make_ =
    { stats =
        \stats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Skill" ]
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
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "title" stats_args.title
                     , Tuple.pair "icon" stats_args.icon
                     ]
                )
    }


call_ :
    { getStats : Elm.Expression -> Elm.Expression
    , updateBySkill :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { getStats =
        \getStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Skill" ]
                     , name = "getStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Skill" ]
                                      "Skill"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Skill" ]
                                       "Stats"
                                       []
                                  )
                             )
                     }
                )
                [ getStatsArg ]
    , updateBySkill =
        \updateBySkillArg updateBySkillArg0 updateBySkillArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Skill" ]
                     , name = "updateBySkill"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Skill" ]
                                      "Skill"
                                      []
                                  , Type.function
                                      [ Type.var "a" ]
                                      (Type.var "a")
                                  , Type.namedWith
                                      [ "IdleGame", "Skill" ]
                                      "SkillRecord"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Skill" ]
                                       "SkillRecord"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ updateBySkillArg, updateBySkillArg0, updateBySkillArg1 ]
    }


values_ :
    { allStats : Elm.Expression
    , getStats : Elm.Expression
    , updateBySkill : Elm.Expression
    }
values_ =
    { allStats =
        Elm.value
            { importFrom = [ "IdleGame", "Skill" ]
            , name = "allStats"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Skill" ]
                         "SkillRecord"
                         [ Type.namedWith [ "IdleGame", "Skill" ] "Stats" [] ]
                    )
            }
    , getStats =
        Elm.value
            { importFrom = [ "IdleGame", "Skill" ]
            , name = "getStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Skill" ] "Skill" [] ]
                         (Type.namedWith [ "IdleGame", "Skill" ] "Stats" [])
                    )
            }
    , updateBySkill =
        Elm.value
            { importFrom = [ "IdleGame", "Skill" ]
            , name = "updateBySkill"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Skill" ] "Skill" []
                         , Type.function [ Type.var "a" ] (Type.var "a")
                         , Type.namedWith
                             [ "IdleGame", "Skill" ]
                             "SkillRecord"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Skill" ]
                              "SkillRecord"
                              [ Type.var "a" ]
                         )
                    )
            }
    }