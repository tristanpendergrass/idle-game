module Gen.IdleGame.Views.Shop exposing (call_, moduleName_, render, values_)

{-| 
@docs moduleName_, render, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Shop" ]


{-| render: 
    IdleGame.Views.Shop.Game
    -> IdleGame.Views.Shop.Html IdleGame.Views.Shop.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression
render renderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Shop" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Shop" ]
                              "Game"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Shop" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Shop" ]
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
                     { importFrom = [ "IdleGame", "Views", "Shop" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Shop" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Shop" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Shop" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg ]
    }


values_ : { render : Elm.Expression }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Shop" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Shop" ]
                             "Game"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Shop" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Shop" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }