module Gen.IdleGame.Views.Content exposing (call_, moduleName_, renderContent, values_)

{-| 
@docs moduleName_, renderContent, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Content" ]


{-| renderContent: 
    IdleGame.Views.Content.FrontendModel
    -> IdleGame.Views.Content.Game
    -> IdleGame.Tab.Tab
    -> IdleGame.Views.Content.Html IdleGame.Views.Content.FrontendMsg
-}
renderContent :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
renderContent renderContentArg renderContentArg0 renderContentArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Content" ]
             , name = "renderContent"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Content" ]
                              "FrontendModel"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "Content" ]
                              "Game"
                              []
                          , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Content" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Content" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderContentArg, renderContentArg0, renderContentArg1 ]


call_ :
    { renderContent :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { renderContent =
        \renderContentArg renderContentArg0 renderContentArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Content" ]
                     , name = "renderContent"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Content" ]
                                      "FrontendModel"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "Content" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Tab" ]
                                      "Tab"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Content" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Content" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderContentArg, renderContentArg0, renderContentArg1 ]
    }


values_ : { renderContent : Elm.Expression }
values_ =
    { renderContent =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Content" ]
            , name = "renderContent"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Content" ]
                             "FrontendModel"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "Content" ]
                             "Game"
                             []
                         , Type.namedWith [ "IdleGame", "Tab" ] "Tab" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Content" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Content" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }