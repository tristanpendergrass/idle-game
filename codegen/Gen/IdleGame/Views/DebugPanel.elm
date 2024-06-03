module Gen.IdleGame.Views.DebugPanel exposing (call_, moduleName_, panelId, render, renderOpenButton, values_)

{-| 
@docs moduleName_, render, renderOpenButton, panelId, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "DebugPanel" ]


{-| render: 
    IdleGame.Views.DebugPanel.FrontendModel
    -> IdleGame.Views.DebugPanel.Html IdleGame.Views.DebugPanel.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression
render renderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DebugPanel" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "DebugPanel" ]
                              "FrontendModel"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DebugPanel" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "DebugPanel" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderArg ]


{-| renderOpenButton: IdleGame.Views.DebugPanel.Html IdleGame.Views.DebugPanel.FrontendMsg -}
renderOpenButton : Elm.Expression
renderOpenButton =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "DebugPanel" ]
        , name = "renderOpenButton"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "DebugPanel" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "DebugPanel" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


{-| panelId: String -}
panelId : Elm.Expression
panelId =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "DebugPanel" ]
        , name = "panelId"
        , annotation = Just Type.string
        }


call_ : { render : Elm.Expression -> Elm.Expression }
call_ =
    { render =
        \renderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DebugPanel" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "DebugPanel" ]
                                      "FrontendModel"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "DebugPanel" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "DebugPanel" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg ]
    }


values_ :
    { render : Elm.Expression
    , renderOpenButton : Elm.Expression
    , panelId : Elm.Expression
    }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DebugPanel" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DebugPanel" ]
                             "FrontendModel"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DebugPanel" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "DebugPanel" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , renderOpenButton =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DebugPanel" ]
            , name = "renderOpenButton"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "DebugPanel" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DebugPanel" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    , panelId =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DebugPanel" ]
            , name = "panelId"
            , annotation = Just Type.string
            }
    }