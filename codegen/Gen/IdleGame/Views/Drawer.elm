module Gen.IdleGame.Views.Drawer exposing (call_, moduleName_, renderDrawer, values_)

{-| 
@docs moduleName_, renderDrawer, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Drawer" ]


{-| renderDrawer: 
    Bool
    -> IdleGame.Tab.Tab
    -> IdleGame.Views.Drawer.Html IdleGame.Views.Drawer.FrontendMsg
-}
renderDrawer : Bool -> Elm.Expression -> Elm.Expression
renderDrawer renderDrawerArg renderDrawerArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Drawer" ]
             , name = "renderDrawer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.bool
                          , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Drawer" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Drawer" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.bool renderDrawerArg, renderDrawerArg0 ]


call_ : { renderDrawer : Elm.Expression -> Elm.Expression -> Elm.Expression }
call_ =
    { renderDrawer =
        \renderDrawerArg renderDrawerArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Drawer" ]
                     , name = "renderDrawer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.bool
                                  , Type.namedWith
                                      [ "IdleGame", "Tab" ]
                                      "Tab"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Drawer" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Drawer" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderDrawerArg, renderDrawerArg0 ]
    }


values_ : { renderDrawer : Elm.Expression }
values_ =
    { renderDrawer =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Drawer" ]
            , name = "renderDrawer"
            , annotation =
                Just
                    (Type.function
                         [ Type.bool
                         , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Drawer" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Drawer" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }