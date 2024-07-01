module Gen.IdleGame.Views.TestingCenter exposing (call_, moduleName_, render, renderTest, renderTestingCenterTabButton, values_)

{-| 
@docs moduleName_, render, renderTest, renderTestingCenterTabButton, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "TestingCenter" ]


{-| render: 
    IdleGame.Views.TestingCenter.FrontendModel
    -> IdleGame.Views.TestingCenter.Game
    -> IdleGame.Views.TestingCenter.Html IdleGame.Views.TestingCenter.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression -> Elm.Expression
render renderArg renderArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "TestingCenter" ]
                              "FrontendModel"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "TestingCenter" ]
                              "Game"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "TestingCenter" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "TestingCenter" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderArg, renderArg0 ]


{-| renderTest: 
    IdleGame.Views.TestingCenter.Game
    -> List IdleGame.Views.TestingCenter.Mod
    -> IdleGame.Test.Test
    -> IdleGame.Views.TestingCenter.Html IdleGame.Views.TestingCenter.FrontendMsg
-}
renderTest :
    Elm.Expression -> List Elm.Expression -> Elm.Expression -> Elm.Expression
renderTest renderTestArg renderTestArg0 renderTestArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
             , name = "renderTest"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "TestingCenter" ]
                              "Game"
                              []
                          , Type.list
                              (Type.namedWith
                                 [ "IdleGame", "Views", "TestingCenter" ]
                                 "Mod"
                                 []
                              )
                          , Type.namedWith [ "IdleGame", "Test" ] "Test" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "TestingCenter" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "TestingCenter" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderTestArg, Elm.list renderTestArg0, renderTestArg1 ]


{-| renderTestingCenterTabButton: 
    { activeTab : IdleGame.Views.TestingCenter.TestingCenterTab
    , label : String
    , tab : IdleGame.Views.TestingCenter.TestingCenterTab
    }
    -> IdleGame.Views.TestingCenter.Html IdleGame.Views.TestingCenter.FrontendMsg
-}
renderTestingCenterTabButton :
    { activeTab : Elm.Expression, label : String, tab : Elm.Expression }
    -> Elm.Expression
renderTestingCenterTabButton renderTestingCenterTabButtonArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
             , name = "renderTestingCenterTabButton"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "activeTab"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "TestingCenter" ]
                                    "TestingCenterTab"
                                    []
                                )
                              , ( "label", Type.string )
                              , ( "tab"
                                , Type.namedWith
                                    [ "IdleGame", "Views", "TestingCenter" ]
                                    "TestingCenterTab"
                                    []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "TestingCenter" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "TestingCenter" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "activeTab" renderTestingCenterTabButtonArg.activeTab
            , Tuple.pair
                  "label"
                  (Elm.string renderTestingCenterTabButtonArg.label)
            , Tuple.pair "tab" renderTestingCenterTabButtonArg.tab
            ]
        ]


call_ :
    { render : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderTest :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderTestingCenterTabButton : Elm.Expression -> Elm.Expression
    }
call_ =
    { render =
        \renderArg renderArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "TestingCenter" ]
                                      "FrontendModel"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "TestingCenter" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "TestingCenter" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "TestingCenter"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg, renderArg0 ]
    , renderTest =
        \renderTestArg renderTestArg0 renderTestArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
                     , name = "renderTest"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "TestingCenter" ]
                                      "Game"
                                      []
                                  , Type.list
                                      (Type.namedWith
                                         [ "IdleGame"
                                         , "Views"
                                         , "TestingCenter"
                                         ]
                                         "Mod"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Test" ]
                                      "Test"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "TestingCenter" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "TestingCenter"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderTestArg, renderTestArg0, renderTestArg1 ]
    , renderTestingCenterTabButton =
        \renderTestingCenterTabButtonArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
                     , name = "renderTestingCenterTabButton"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "activeTab"
                                        , Type.namedWith
                                            [ "IdleGame"
                                            , "Views"
                                            , "TestingCenter"
                                            ]
                                            "TestingCenterTab"
                                            []
                                        )
                                      , ( "label", Type.string )
                                      , ( "tab"
                                        , Type.namedWith
                                            [ "IdleGame"
                                            , "Views"
                                            , "TestingCenter"
                                            ]
                                            "TestingCenterTab"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "TestingCenter" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "TestingCenter"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderTestingCenterTabButtonArg ]
    }


values_ :
    { render : Elm.Expression
    , renderTest : Elm.Expression
    , renderTestingCenterTabButton : Elm.Expression
    }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "TestingCenter" ]
                             "FrontendModel"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "TestingCenter" ]
                             "Game"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "TestingCenter" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "TestingCenter" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , renderTest =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
            , name = "renderTest"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "TestingCenter" ]
                             "Game"
                             []
                         , Type.list
                             (Type.namedWith
                                [ "IdleGame", "Views", "TestingCenter" ]
                                "Mod"
                                []
                             )
                         , Type.namedWith [ "IdleGame", "Test" ] "Test" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "TestingCenter" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "TestingCenter" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , renderTestingCenterTabButton =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TestingCenter" ]
            , name = "renderTestingCenterTabButton"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "activeTab"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "TestingCenter" ]
                                   "TestingCenterTab"
                                   []
                               )
                             , ( "label", Type.string )
                             , ( "tab"
                               , Type.namedWith
                                   [ "IdleGame", "Views", "TestingCenter" ]
                                   "TestingCenterTab"
                                   []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "TestingCenter" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "TestingCenter" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }