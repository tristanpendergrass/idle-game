module Gen.IdleGame.Views.ModalWrapper exposing (annotation_, call_, create, moduleName_, render, renderCloseButton, values_, withBorderColor)

{-| 
@docs moduleName_, render, renderCloseButton, withBorderColor, create, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "ModalWrapper" ]


{-| render: 
    IdleGame.Views.ModalWrapper.Modal
    -> IdleGame.Views.ModalWrapper.Html IdleGame.Views.ModalWrapper.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression
render renderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "ModalWrapper" ]
                              "Modal"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "ModalWrapper" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "ModalWrapper" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderArg ]


{-| renderCloseButton: IdleGame.Views.ModalWrapper.Html IdleGame.Views.ModalWrapper.FrontendMsg -}
renderCloseButton : Elm.Expression
renderCloseButton =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
        , name = "renderCloseButton"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "ModalWrapper" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "ModalWrapper" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


{-| withBorderColor: String -> IdleGame.Views.ModalWrapper.Modal -> IdleGame.Views.ModalWrapper.Modal -}
withBorderColor : String -> Elm.Expression -> Elm.Expression
withBorderColor withBorderColorArg withBorderColorArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
             , name = "withBorderColor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "IdleGame", "Views", "ModalWrapper" ]
                              "Modal"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "ModalWrapper" ]
                               "Modal"
                               []
                          )
                     )
             }
        )
        [ Elm.string withBorderColorArg, withBorderColorArg0 ]


{-| create: 
    IdleGame.Views.ModalWrapper.Html IdleGame.Views.ModalWrapper.FrontendMsg
    -> IdleGame.Views.ModalWrapper.Modal
-}
create : Elm.Expression -> Elm.Expression
create createArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
             , name = "create"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "ModalWrapper" ]
                              "Html"
                              [ Type.namedWith
                                    [ "IdleGame", "Views", "ModalWrapper" ]
                                    "FrontendMsg"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "ModalWrapper" ]
                               "Modal"
                               []
                          )
                     )
             }
        )
        [ createArg ]


annotation_ : { modal : Type.Annotation }
annotation_ =
    { modal = Type.namedWith [ "IdleGame", "Views", "ModalWrapper" ] "Modal" []
    }


call_ :
    { render : Elm.Expression -> Elm.Expression
    , withBorderColor : Elm.Expression -> Elm.Expression -> Elm.Expression
    , create : Elm.Expression -> Elm.Expression
    }
call_ =
    { render =
        \renderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "ModalWrapper" ]
                                      "Modal"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "ModalWrapper" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "ModalWrapper"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg ]
    , withBorderColor =
        \withBorderColorArg withBorderColorArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
                     , name = "withBorderColor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "ModalWrapper" ]
                                      "Modal"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "ModalWrapper" ]
                                       "Modal"
                                       []
                                  )
                             )
                     }
                )
                [ withBorderColorArg, withBorderColorArg0 ]
    , create =
        \createArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
                     , name = "create"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "ModalWrapper" ]
                                      "Html"
                                      [ Type.namedWith
                                            [ "IdleGame"
                                            , "Views"
                                            , "ModalWrapper"
                                            ]
                                            "FrontendMsg"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "ModalWrapper" ]
                                       "Modal"
                                       []
                                  )
                             )
                     }
                )
                [ createArg ]
    }


values_ :
    { render : Elm.Expression
    , renderCloseButton : Elm.Expression
    , withBorderColor : Elm.Expression
    , create : Elm.Expression
    }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "ModalWrapper" ]
                             "Modal"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "ModalWrapper" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "ModalWrapper" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , renderCloseButton =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
            , name = "renderCloseButton"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "ModalWrapper" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "ModalWrapper" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    , withBorderColor =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
            , name = "withBorderColor"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "IdleGame", "Views", "ModalWrapper" ]
                             "Modal"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "ModalWrapper" ]
                              "Modal"
                              []
                         )
                    )
            }
    , create =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "ModalWrapper" ]
            , name = "create"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "ModalWrapper" ]
                             "Html"
                             [ Type.namedWith
                                   [ "IdleGame", "Views", "ModalWrapper" ]
                                   "FrontendMsg"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "ModalWrapper" ]
                              "Modal"
                              []
                         )
                    )
            }
    }