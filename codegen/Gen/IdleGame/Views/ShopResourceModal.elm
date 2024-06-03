module Gen.IdleGame.Views.ShopResourceModal exposing (call_, moduleName_, render, values_)

{-| 
@docs moduleName_, render, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "ShopResourceModal" ]


{-| render: 
    IdleGame.Views.ShopResourceModal.Game
    -> Int
    -> ( IdleGame.Views.ShopResourceModal.Resource, IdleGame.Coin.Coin )
    -> IdleGame.Views.ShopResourceModal.Html IdleGame.Views.ShopResourceModal.FrontendMsg
-}
render : Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
render renderArg renderArg0 renderArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "ShopResourceModal" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "ShopResourceModal" ]
                              "Game"
                              []
                          , Type.int
                          , Type.tuple
                              (Type.namedWith
                                 [ "IdleGame", "Views", "ShopResourceModal" ]
                                 "Resource"
                                 []
                              )
                              (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "ShopResourceModal" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "ShopResourceModal" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderArg, Elm.int renderArg0, renderArg1 ]


call_ :
    { render :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { render =
        \renderArg renderArg0 renderArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "ShopResourceModal" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "ShopResourceModal"
                                      ]
                                      "Game"
                                      []
                                  , Type.int
                                  , Type.tuple
                                      (Type.namedWith
                                         [ "IdleGame"
                                         , "Views"
                                         , "ShopResourceModal"
                                         ]
                                         "Resource"
                                         []
                                      )
                                      (Type.namedWith
                                         [ "IdleGame", "Coin" ]
                                         "Coin"
                                         []
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "ShopResourceModal"
                                       ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "ShopResourceModal"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg, renderArg0, renderArg1 ]
    }


values_ : { render : Elm.Expression }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "ShopResourceModal" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "ShopResourceModal" ]
                             "Game"
                             []
                         , Type.int
                         , Type.tuple
                             (Type.namedWith
                                [ "IdleGame", "Views", "ShopResourceModal" ]
                                "Resource"
                                []
                             )
                             (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "ShopResourceModal" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "ShopResourceModal" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }