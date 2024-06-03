module Gen.IdleGame.Views.SubjectViews exposing (call_, moduleName_, renderSubject, values_)

{-| 
@docs moduleName_, renderSubject, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "SubjectViews" ]


{-| renderSubject: 
    IdleGame.Views.SubjectViews.Skill
    -> IdleGame.Views.SubjectViews.Game
    -> IdleGame.Views.SubjectViews.Html IdleGame.Views.SubjectViews.FrontendMsg
-}
renderSubject : Elm.Expression -> Elm.Expression -> Elm.Expression
renderSubject renderSubjectArg renderSubjectArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "SubjectViews" ]
             , name = "renderSubject"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "SubjectViews" ]
                              "Skill"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "SubjectViews" ]
                              "Game"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "SubjectViews" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "SubjectViews" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderSubjectArg, renderSubjectArg0 ]


call_ : { renderSubject : Elm.Expression -> Elm.Expression -> Elm.Expression }
call_ =
    { renderSubject =
        \renderSubjectArg renderSubjectArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "SubjectViews" ]
                     , name = "renderSubject"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "SubjectViews" ]
                                      "Skill"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "SubjectViews" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "SubjectViews" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "SubjectViews"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderSubjectArg, renderSubjectArg0 ]
    }


values_ : { renderSubject : Elm.Expression }
values_ =
    { renderSubject =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "SubjectViews" ]
            , name = "renderSubject"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "SubjectViews" ]
                             "Skill"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "SubjectViews" ]
                             "Game"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "SubjectViews" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "SubjectViews" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }