module Gen.IdleGame.Views.Bag exposing (call_, moduleName_, render, renderBottomRight, values_)

{-| 
@docs moduleName_, renderBottomRight, render, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Bag" ]


{-| renderBottomRight: IdleGame.Views.Bag.Html IdleGame.Views.Bag.FrontendMsg -}
renderBottomRight : Elm.Expression
renderBottomRight =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Bag" ]
        , name = "renderBottomRight"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "Bag" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "Bag" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


{-| render: 
    IdleGame.Views.Bag.Game
    -> IdleGame.Views.Bag.Html IdleGame.Views.Bag.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression
render renderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Bag" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Bag" ]
                              "Game"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Bag" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Bag" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderArg ]


call_ : { render : Elm.Expression -> Elm.Expression }
call_ =
    { render =
        \renderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Bag" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Bag" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Bag" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Bag" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg ]
    }


values_ : { renderBottomRight : Elm.Expression, render : Elm.Expression }
values_ =
    { renderBottomRight =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Bag" ]
            , name = "renderBottomRight"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "Bag" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Bag" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    , render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Bag" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Bag" ]
                             "Game"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Bag" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Bag" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }