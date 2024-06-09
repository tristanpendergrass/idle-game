module Gen.IdleGame.Skill exposing (call_, moduleName_, updateBySkill, values_)

{-| 
@docs moduleName_, updateBySkill, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Skill" ]


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


call_ :
    { updateBySkill :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { updateBySkill =
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


values_ : { updateBySkill : Elm.Expression }
values_ =
    { updateBySkill =
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