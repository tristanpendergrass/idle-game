module Gen.IdleGame.Tab exposing (annotation_, call_, caseOf_, getConfig, make_, moduleName_, values_)

{-| 
@docs moduleName_, getConfig, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Tab" ]


{-| getConfig: IdleGame.Tab.Tab -> IdleGame.Tab.TabConfig -}
getConfig : Elm.Expression -> Elm.Expression
getConfig getConfigArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Tab" ]
             , name = "getConfig"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Tab" ] "Tab" [] ]
                          (Type.namedWith [ "IdleGame", "Tab" ] "TabConfig" [])
                     )
             }
        )
        [ getConfigArg ]


annotation_ : { tabConfig : Type.Annotation, tab : Type.Annotation }
annotation_ =
    { tabConfig =
        Type.alias
            moduleName_
            "TabConfig"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "icon"
                   , Type.namedWith [ "IdleGame", "Views", "Icon" ] "Icon" []
                   )
                 ]
            )
    , tab = Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
    }


make_ :
    { tabConfig :
        { title : Elm.Expression, icon : Elm.Expression } -> Elm.Expression
    , backpack : Elm.Expression
    , shop : Elm.Expression
    , subjectTab : Elm.Expression -> Elm.Expression
    }
make_ =
    { tabConfig =
        \tabConfig_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Tab" ]
                     "TabConfig"
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
                     [ Tuple.pair "title" tabConfig_args.title
                     , Tuple.pair "icon" tabConfig_args.icon
                     ]
                )
    , backpack =
        Elm.value
            { importFrom = [ "IdleGame", "Tab" ]
            , name = "Backpack"
            , annotation = Just (Type.namedWith [] "Tab" [])
            }
    , shop =
        Elm.value
            { importFrom = [ "IdleGame", "Tab" ]
            , name = "Shop"
            , annotation = Just (Type.namedWith [] "Tab" [])
            }
    , subjectTab =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Tab" ]
                     , name = "SubjectTab"
                     , annotation = Just (Type.namedWith [] "Tab" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { tab :
        Elm.Expression
        -> { tabTags_0_0
            | backpack : Elm.Expression
            , shop : Elm.Expression
            , subjectTab : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { tab =
        \tabExpression tabTags ->
            Elm.Case.custom
                tabExpression
                (Type.namedWith [ "IdleGame", "Tab" ] "Tab" [])
                [ Elm.Case.branch0 "Backpack" tabTags.backpack
                , Elm.Case.branch0 "Shop" tabTags.shop
                , Elm.Case.branch1
                    "SubjectTab"
                    ( "idleGameTabSkill"
                    , Type.namedWith [ "IdleGame", "Tab" ] "Skill" []
                    )
                    tabTags.subjectTab
                ]
    }


call_ : { getConfig : Elm.Expression -> Elm.Expression }
call_ =
    { getConfig =
        \getConfigArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Tab" ]
                     , name = "getConfig"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Tab" ]
                                      "Tab"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Tab" ]
                                       "TabConfig"
                                       []
                                  )
                             )
                     }
                )
                [ getConfigArg ]
    }


values_ : { getConfig : Elm.Expression }
values_ =
    { getConfig =
        Elm.value
            { importFrom = [ "IdleGame", "Tab" ]
            , name = "getConfig"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Tab" ] "Tab" [] ]
                         (Type.namedWith [ "IdleGame", "Tab" ] "TabConfig" [])
                    )
            }
    }