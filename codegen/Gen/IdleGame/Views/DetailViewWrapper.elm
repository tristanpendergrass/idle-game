module Gen.IdleGame.Views.DetailViewWrapper exposing (annotation_, call_, caseOf_, closePreviewButton, collapseActivityButton, emptyContent, make_, moduleName_, renderFullScreen, renderSidebar, renderStatusBarWrapper, topTransitionClasses, values_)

{-| 
@docs moduleName_, renderFullScreen, renderSidebar, renderStatusBarWrapper, emptyContent, topTransitionClasses, collapseActivityButton, closePreviewButton, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "DetailViewWrapper" ]


{-| renderFullScreen: 
    IdleGame.Views.DetailViewWrapper.Props a p msg
    -> IdleGame.Views.DetailViewWrapper.Html msg
-}
renderFullScreen : Elm.Expression -> Elm.Expression
renderFullScreen renderFullScreenArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
             , name = "renderFullScreen"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "DetailViewWrapper" ]
                              "Props"
                              [ Type.var "a", Type.var "p", Type.var "msg" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewWrapper" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ renderFullScreenArg ]


{-| renderSidebar: 
    IdleGame.Views.DetailViewWrapper.Props a p msg
    -> IdleGame.Views.DetailViewWrapper.Html msg
-}
renderSidebar : Elm.Expression -> Elm.Expression
renderSidebar renderSidebarArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
             , name = "renderSidebar"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "DetailViewWrapper" ]
                              "Props"
                              [ Type.var "a", Type.var "p", Type.var "msg" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewWrapper" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ renderSidebarArg ]


{-| renderStatusBarWrapper: 
    (a -> IdleGame.Views.DetailViewWrapper.Html msg)
    -> a
    -> IdleGame.Views.DetailViewWrapper.Html msg
-}
renderStatusBarWrapper :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
renderStatusBarWrapper renderStatusBarWrapperArg renderStatusBarWrapperArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
             , name = "renderStatusBarWrapper"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "IdleGame", "Views", "DetailViewWrapper" ]
                                 "Html"
                                 [ Type.var "msg" ]
                              )
                          , Type.var "a"
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewWrapper" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "renderStatusBarWrapperUnpack"
            renderStatusBarWrapperArg
        , renderStatusBarWrapperArg0
        ]


{-| emptyContent: IdleGame.Views.DetailViewWrapper.Html msg -}
emptyContent : Elm.Expression
emptyContent =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
        , name = "emptyContent"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewWrapper" ]
                     "Html"
                     [ Type.var "msg" ]
                )
        }


{-| topTransitionClasses: IdleGame.Views.DetailViewWrapper.Attribute msg -}
topTransitionClasses : Elm.Expression
topTransitionClasses =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
        , name = "topTransitionClasses"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewWrapper" ]
                     "Attribute"
                     [ Type.var "msg" ]
                )
        }


{-| collapseActivityButton: msg -> IdleGame.Views.DetailViewWrapper.Html msg -}
collapseActivityButton : Elm.Expression -> Elm.Expression
collapseActivityButton collapseActivityButtonArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
             , name = "collapseActivityButton"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "msg" ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewWrapper" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ collapseActivityButtonArg ]


{-| closePreviewButton: msg -> IdleGame.Views.DetailViewWrapper.Html msg -}
closePreviewButton : Elm.Expression -> Elm.Expression
closePreviewButton closePreviewButtonArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
             , name = "closePreviewButton"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "msg" ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewWrapper" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ closePreviewButtonArg ]


annotation_ :
    { props :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    , viewHeight : Type.Annotation
    , state : Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { props =
        \propsArg0 propsArg1 propsArg2 ->
            Type.alias
                moduleName_
                "Props"
                [ propsArg0, propsArg1, propsArg2 ]
                (Type.record
                     [ ( "state"
                       , Type.namedWith
                             [ "IdleGame", "Views", "DetailViewWrapper" ]
                             "State"
                             [ Type.var "a", Type.var "p" ]
                       )
                     , ( "renderActivity"
                       , Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewWrapper" ]
                                  "Html"
                                  [ Type.var "msg" ]
                             )
                       )
                     , ( "renderPreview"
                       , Type.function
                             [ Type.var "p" ]
                             (Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewWrapper" ]
                                  "Html"
                                  [ Type.var "msg" ]
                             )
                       )
                     , ( "renderStatusBar"
                       , Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewWrapper" ]
                                  "Html"
                                  [ Type.var "msg" ]
                             )
                       )
                     , ( "onClosePreview", Type.var "msg" )
                     , ( "onCollapseActivity", Type.var "msg" )
                     , ( "onExpandActivity", Type.var "msg" )
                     ]
                )
    , viewHeight =
        Type.namedWith
            [ "IdleGame", "Views", "DetailViewWrapper" ]
            "ViewHeight"
            []
    , state =
        \stateArg0 stateArg1 ->
            Type.namedWith
                [ "IdleGame", "Views", "DetailViewWrapper" ]
                "State"
                [ stateArg0, stateArg1 ]
    }


make_ :
    { props :
        { state : Elm.Expression
        , renderActivity : Elm.Expression
        , renderPreview : Elm.Expression
        , renderStatusBar : Elm.Expression
        , onClosePreview : Elm.Expression
        , onCollapseActivity : Elm.Expression
        , onExpandActivity : Elm.Expression
        }
        -> Elm.Expression
    , expanded : Elm.Expression
    , collapsed : Elm.Expression
    , statusBar : Elm.Expression
    , blank : Elm.Expression
    , activityExpanded : Elm.Expression -> Elm.Expression
    , activityCollapsed : Elm.Expression -> Elm.Expression
    , preview : Elm.Expression -> Elm.Expression
    , previewWithActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
make_ =
    { props =
        \props_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Views", "DetailViewWrapper" ]
                     "Props"
                     [ Type.var "a", Type.var "p", Type.var "msg" ]
                     (Type.record
                          [ ( "state"
                            , Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewWrapper" ]
                                  "State"
                                  [ Type.var "a", Type.var "p" ]
                            )
                          , ( "renderActivity"
                            , Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                            )
                          , ( "renderPreview"
                            , Type.function
                                  [ Type.var "p" ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                            )
                          , ( "renderStatusBar"
                            , Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                            )
                          , ( "onClosePreview", Type.var "msg" )
                          , ( "onCollapseActivity", Type.var "msg" )
                          , ( "onExpandActivity", Type.var "msg" )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "state" props_args.state
                     , Tuple.pair "renderActivity" props_args.renderActivity
                     , Tuple.pair "renderPreview" props_args.renderPreview
                     , Tuple.pair "renderStatusBar" props_args.renderStatusBar
                     , Tuple.pair "onClosePreview" props_args.onClosePreview
                     , Tuple.pair
                         "onCollapseActivity"
                         props_args.onCollapseActivity
                     , Tuple.pair "onExpandActivity" props_args.onExpandActivity
                     ]
                )
    , expanded =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "Expanded"
            , annotation = Just (Type.namedWith [] "ViewHeight" [])
            }
    , collapsed =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "Collapsed"
            , annotation = Just (Type.namedWith [] "ViewHeight" [])
            }
    , statusBar =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "StatusBar"
            , annotation = Just (Type.namedWith [] "ViewHeight" [])
            }
    , blank =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "Blank"
            , annotation =
                Just (Type.namedWith [] "State" [ Type.var "a", Type.var "p" ])
            }
    , activityExpanded =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "ActivityExpanded"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "State"
                                  [ Type.var "a", Type.var "p" ]
                             )
                     }
                )
                [ ar0 ]
    , activityCollapsed =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "ActivityCollapsed"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "State"
                                  [ Type.var "a", Type.var "p" ]
                             )
                     }
                )
                [ ar0 ]
    , preview =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "Preview"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "State"
                                  [ Type.var "a", Type.var "p" ]
                             )
                     }
                )
                [ ar0 ]
    , previewWithActivity =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "PreviewWithActivity"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "State"
                                  [ Type.var "a", Type.var "p" ]
                             )
                     }
                )
                [ ar0, ar1 ]
    }


caseOf_ :
    { viewHeight :
        Elm.Expression
        -> { viewHeightTags_0_0
            | expanded : Elm.Expression
            , collapsed : Elm.Expression
            , statusBar : Elm.Expression
        }
        -> Elm.Expression
    , state :
        Elm.Expression
        -> { stateTags_1_0
            | blank : Elm.Expression
            , activityExpanded : Elm.Expression -> Elm.Expression
            , activityCollapsed : Elm.Expression -> Elm.Expression
            , preview : Elm.Expression -> Elm.Expression
            , previewWithActivity :
                Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { viewHeight =
        \viewHeightExpression viewHeightTags ->
            Elm.Case.custom
                viewHeightExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewWrapper" ]
                     "ViewHeight"
                     []
                )
                [ Elm.Case.branch0 "Expanded" viewHeightTags.expanded
                , Elm.Case.branch0 "Collapsed" viewHeightTags.collapsed
                , Elm.Case.branch0 "StatusBar" viewHeightTags.statusBar
                ]
    , state =
        \stateExpression stateTags ->
            Elm.Case.custom
                stateExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewWrapper" ]
                     "State"
                     [ Type.var "a", Type.var "p" ]
                )
                [ Elm.Case.branch0 "Blank" stateTags.blank
                , Elm.Case.branch1
                    "ActivityExpanded"
                    ( "a", Type.var "a" )
                    stateTags.activityExpanded
                , Elm.Case.branch1
                    "ActivityCollapsed"
                    ( "a", Type.var "a" )
                    stateTags.activityCollapsed
                , Elm.Case.branch1
                    "Preview"
                    ( "p", Type.var "p" )
                    stateTags.preview
                , Elm.Case.branch2
                    "PreviewWithActivity"
                    ( "p", Type.var "p" )
                    ( "a", Type.var "a" )
                    stateTags.previewWithActivity
                ]
    }


call_ :
    { renderFullScreen : Elm.Expression -> Elm.Expression
    , renderSidebar : Elm.Expression -> Elm.Expression
    , renderStatusBarWrapper :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , collapseActivityButton : Elm.Expression -> Elm.Expression
    , closePreviewButton : Elm.Expression -> Elm.Expression
    }
call_ =
    { renderFullScreen =
        \renderFullScreenArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "renderFullScreen"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "DetailViewWrapper"
                                      ]
                                      "Props"
                                      [ Type.var "a"
                                      , Type.var "p"
                                      , Type.var "msg"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderFullScreenArg ]
    , renderSidebar =
        \renderSidebarArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "renderSidebar"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "DetailViewWrapper"
                                      ]
                                      "Props"
                                      [ Type.var "a"
                                      , Type.var "p"
                                      , Type.var "msg"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderSidebarArg ]
    , renderStatusBarWrapper =
        \renderStatusBarWrapperArg renderStatusBarWrapperArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "renderStatusBarWrapper"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "IdleGame"
                                         , "Views"
                                         , "DetailViewWrapper"
                                         ]
                                         "Html"
                                         [ Type.var "msg" ]
                                      )
                                  , Type.var "a"
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ renderStatusBarWrapperArg, renderStatusBarWrapperArg0 ]
    , collapseActivityButton =
        \collapseActivityButtonArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "collapseActivityButton"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "msg" ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ collapseActivityButtonArg ]
    , closePreviewButton =
        \closePreviewButtonArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
                     , name = "closePreviewButton"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "msg" ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewWrapper"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ closePreviewButtonArg ]
    }


values_ :
    { renderFullScreen : Elm.Expression
    , renderSidebar : Elm.Expression
    , renderStatusBarWrapper : Elm.Expression
    , emptyContent : Elm.Expression
    , topTransitionClasses : Elm.Expression
    , collapseActivityButton : Elm.Expression
    , closePreviewButton : Elm.Expression
    }
values_ =
    { renderFullScreen =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "renderFullScreen"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DetailViewWrapper" ]
                             "Props"
                             [ Type.var "a", Type.var "p", Type.var "msg" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewWrapper" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , renderSidebar =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "renderSidebar"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DetailViewWrapper" ]
                             "Props"
                             [ Type.var "a", Type.var "p", Type.var "msg" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewWrapper" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , renderStatusBarWrapper =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "renderStatusBarWrapper"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "IdleGame", "Views", "DetailViewWrapper" ]
                                "Html"
                                [ Type.var "msg" ]
                             )
                         , Type.var "a"
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewWrapper" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , emptyContent =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "emptyContent"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "DetailViewWrapper" ]
                         "Html"
                         [ Type.var "msg" ]
                    )
            }
    , topTransitionClasses =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "topTransitionClasses"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "DetailViewWrapper" ]
                         "Attribute"
                         [ Type.var "msg" ]
                    )
            }
    , collapseActivityButton =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "collapseActivityButton"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "msg" ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewWrapper" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , closePreviewButton =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewWrapper" ]
            , name = "closePreviewButton"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "msg" ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewWrapper" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    }