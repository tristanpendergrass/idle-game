module Gen.IdleGame.Views.SyllabusModal exposing (call_, moduleName_, render, values_, withUnlockLevel)

{-| 
@docs moduleName_, render, withUnlockLevel, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "SyllabusModal" ]


{-| render: 
    IdleGame.Views.SyllabusModal.Game
    -> IdleGame.Views.SyllabusModal.Skill
    -> IdleGame.Views.SyllabusModal.Html IdleGame.Views.SyllabusModal.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression -> Elm.Expression
render renderArg renderArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "SyllabusModal" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "SyllabusModal" ]
                              "Game"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "SyllabusModal" ]
                              "Skill"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "SyllabusModal" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "SyllabusModal" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderArg, renderArg0 ]


{-| withUnlockLevel: IdleGame.Views.SyllabusModal.Activity -> Maybe Int -}
withUnlockLevel : Elm.Expression -> Elm.Expression
withUnlockLevel withUnlockLevelArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "SyllabusModal" ]
             , name = "withUnlockLevel"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "SyllabusModal" ]
                              "Activity"
                              []
                          ]
                          (Type.maybe Type.int)
                     )
             }
        )
        [ withUnlockLevelArg ]


call_ :
    { render : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withUnlockLevel : Elm.Expression -> Elm.Expression
    }
call_ =
    { render =
        \renderArg renderArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "SyllabusModal" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "SyllabusModal" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "SyllabusModal" ]
                                      "Skill"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "SyllabusModal" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "SyllabusModal"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg, renderArg0 ]
    , withUnlockLevel =
        \withUnlockLevelArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "SyllabusModal" ]
                     , name = "withUnlockLevel"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "SyllabusModal" ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.maybe Type.int)
                             )
                     }
                )
                [ withUnlockLevelArg ]
    }


values_ : { render : Elm.Expression, withUnlockLevel : Elm.Expression }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "SyllabusModal" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "SyllabusModal" ]
                             "Game"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "SyllabusModal" ]
                             "Skill"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "SyllabusModal" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "SyllabusModal" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , withUnlockLevel =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "SyllabusModal" ]
            , name = "withUnlockLevel"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "SyllabusModal" ]
                             "Activity"
                             []
                         ]
                         (Type.maybe Type.int)
                    )
            }
    }