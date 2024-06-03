module Gen.IdleGame.Views.DetailViewContent exposing (activityProgress, annotation_, call_, caseOf_, collapseButton, fade, intervalModLabelToString, make_, masterySection, moduleName_, mxpSection, playStopButton, renderContent, renderStatusBar, values_)

{-| 
@docs moduleName_, playStopButton, activityProgress, mxpSection, masterySection, intervalModLabelToString, renderContent, fade, renderStatusBar, collapseButton, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "DetailViewContent" ]


{-| playStopButton: 
    IdleGame.Views.DetailViewContent.PlayButtonState
    -> IdleGame.Views.DetailViewContent.Activity
    -> IdleGame.Views.DetailViewContent.Html IdleGame.Views.DetailViewContent.FrontendMsg
-}
playStopButton : Elm.Expression -> Elm.Expression -> Elm.Expression
playStopButton playStopButtonArg playStopButtonArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "playStopButton"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "PlayButtonState"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Activity"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "DetailViewContent" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ playStopButtonArg, playStopButtonArg0 ]


{-| activityProgress: 
    IdleGame.Timer.Timer
    -> IdleGame.Views.DetailViewContent.Html IdleGame.Views.DetailViewContent.FrontendMsg
-}
activityProgress : Elm.Expression -> Elm.Expression
activityProgress activityProgressArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "activityProgress"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Timer" ] "Timer" [] ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "DetailViewContent" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ activityProgressArg ]


{-| mxpSection: IdleGame.Xp.Xp -> IdleGame.Views.DetailViewContent.Html msg -}
mxpSection : Elm.Expression -> Elm.Expression
mxpSection mxpSectionArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "mxpSection"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ mxpSectionArg ]


{-| masterySection: 
    IdleGame.Xp.Xp
    -> IdleGame.Activity.Mastery
    -> IdleGame.Views.DetailViewContent.Html msg
-}
masterySection : Elm.Expression -> Elm.Expression -> Elm.Expression
masterySection masterySectionArg masterySectionArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "masterySection"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.namedWith
                              [ "IdleGame", "Activity" ]
                              "Mastery"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ masterySectionArg, masterySectionArg0 ]


{-| intervalModLabelToString: IdleGame.Views.DetailViewContent.IntervalModLabel -> String -}
intervalModLabelToString : Elm.Expression -> Elm.Expression
intervalModLabelToString intervalModLabelToStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "intervalModLabelToString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "IntervalModLabel"
                              []
                          ]
                          Type.string
                     )
             }
        )
        [ intervalModLabelToStringArg ]


{-| renderContent: 
    IdleGame.Views.DetailViewContent.DetailViewObject
    -> Bool
    -> IdleGame.Views.DetailViewContent.Game
    -> IdleGame.Views.DetailViewContent.Html IdleGame.Views.DetailViewContent.FrontendMsg
-}
renderContent : Elm.Expression -> Bool -> Elm.Expression -> Elm.Expression
renderContent renderContentArg renderContentArg0 renderContentArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "renderContent"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "DetailViewObject"
                              []
                          , Type.bool
                          , Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Game"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "DetailViewContent" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderContentArg, Elm.bool renderContentArg0, renderContentArg1 ]


{-| fade: 
    Bool
    -> IdleGame.Views.DetailViewContent.Html IdleGame.Views.DetailViewContent.FrontendMsg
-}
fade : Bool -> Elm.Expression
fade fadeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "fade"
             , annotation =
                 Just
                     (Type.function
                          [ Type.bool ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "DetailViewContent" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.bool fadeArg ]


{-| renderStatusBar: 
    ( IdleGame.Views.DetailViewContent.Activity, IdleGame.Timer.Timer )
    -> IdleGame.Views.DetailViewContent.Html IdleGame.Views.DetailViewContent.FrontendMsg
-}
renderStatusBar : Elm.Expression -> Elm.Expression
renderStatusBar renderStatusBarArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
             , name = "renderStatusBar"
             , annotation =
                 Just
                     (Type.function
                          [ Type.tuple
                              (Type.namedWith
                                 [ "IdleGame", "Views", "DetailViewContent" ]
                                 "Activity"
                                 []
                              )
                              (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                              )
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "DetailViewContent" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderStatusBarArg ]


{-| collapseButton: IdleGame.Views.DetailViewContent.Html IdleGame.Views.DetailViewContent.FrontendMsg -}
collapseButton : Elm.Expression
collapseButton =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
        , name = "collapseButton"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewContent" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "DetailViewContent" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


annotation_ :
    { playButtonState : Type.Annotation
    , detailViewObject : Type.Annotation
    , collapsibleHeight : Type.Annotation
    }
annotation_ =
    { playButtonState =
        Type.namedWith
            [ "IdleGame", "Views", "DetailViewContent" ]
            "PlayButtonState"
            []
    , detailViewObject =
        Type.namedWith
            [ "IdleGame", "Views", "DetailViewContent" ]
            "DetailViewObject"
            []
    , collapsibleHeight =
        Type.namedWith
            [ "IdleGame", "Views", "DetailViewContent" ]
            "CollapsibleHeight"
            []
    }


make_ :
    { play : Elm.Expression
    , stop : Elm.Expression
    , detailViewActivity : Elm.Expression -> Elm.Expression
    , detailViewPreview : Elm.Expression -> Elm.Expression
    , expanded : Elm.Expression
    , collapsed : Elm.Expression
    , statusBar : Elm.Expression
    }
make_ =
    { play =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "Play"
            , annotation = Just (Type.namedWith [] "PlayButtonState" [])
            }
    , stop =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "Stop"
            , annotation = Just (Type.namedWith [] "PlayButtonState" [])
            }
    , detailViewActivity =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "DetailViewActivity"
                     , annotation =
                         Just (Type.namedWith [] "DetailViewObject" [])
                     }
                )
                [ ar0 ]
    , detailViewPreview =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "DetailViewPreview"
                     , annotation =
                         Just (Type.namedWith [] "DetailViewObject" [])
                     }
                )
                [ ar0 ]
    , expanded =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "Expanded"
            , annotation = Just (Type.namedWith [] "CollapsibleHeight" [])
            }
    , collapsed =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "Collapsed"
            , annotation = Just (Type.namedWith [] "CollapsibleHeight" [])
            }
    , statusBar =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "StatusBar"
            , annotation = Just (Type.namedWith [] "CollapsibleHeight" [])
            }
    }


caseOf_ :
    { playButtonState :
        Elm.Expression
        -> { playButtonStateTags_0_0
            | play : Elm.Expression
            , stop : Elm.Expression
        }
        -> Elm.Expression
    , detailViewObject :
        Elm.Expression
        -> { detailViewObjectTags_1_0
            | detailViewActivity : Elm.Expression -> Elm.Expression
            , detailViewPreview : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , collapsibleHeight :
        Elm.Expression
        -> { collapsibleHeightTags_2_0
            | expanded : Elm.Expression
            , collapsed : Elm.Expression
            , statusBar : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { playButtonState =
        \playButtonStateExpression playButtonStateTags ->
            Elm.Case.custom
                playButtonStateExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewContent" ]
                     "PlayButtonState"
                     []
                )
                [ Elm.Case.branch0 "Play" playButtonStateTags.play
                , Elm.Case.branch0 "Stop" playButtonStateTags.stop
                ]
    , detailViewObject =
        \detailViewObjectExpression detailViewObjectTags ->
            Elm.Case.custom
                detailViewObjectExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewContent" ]
                     "DetailViewObject"
                     []
                )
                [ Elm.Case.branch1
                    "DetailViewActivity"
                    ( "one"
                    , Type.tuple
                          (Type.namedWith
                               [ "IdleGame", "Views", "DetailViewContent" ]
                               "Activity"
                               []
                          )
                          (Type.namedWith [ "IdleGame", "Timer" ] "Timer" [])
                    )
                    detailViewObjectTags.detailViewActivity
                , Elm.Case.branch1
                    "DetailViewPreview"
                    ( "idleGameViewsDetailViewContentPreview"
                    , Type.namedWith
                          [ "IdleGame", "Views", "DetailViewContent" ]
                          "Preview"
                          []
                    )
                    detailViewObjectTags.detailViewPreview
                ]
    , collapsibleHeight =
        \collapsibleHeightExpression collapsibleHeightTags ->
            Elm.Case.custom
                collapsibleHeightExpression
                (Type.namedWith
                     [ "IdleGame", "Views", "DetailViewContent" ]
                     "CollapsibleHeight"
                     []
                )
                [ Elm.Case.branch0 "Expanded" collapsibleHeightTags.expanded
                , Elm.Case.branch0 "Collapsed" collapsibleHeightTags.collapsed
                , Elm.Case.branch0 "StatusBar" collapsibleHeightTags.statusBar
                ]
    }


call_ :
    { playStopButton : Elm.Expression -> Elm.Expression -> Elm.Expression
    , activityProgress : Elm.Expression -> Elm.Expression
    , mxpSection : Elm.Expression -> Elm.Expression
    , masterySection : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intervalModLabelToString : Elm.Expression -> Elm.Expression
    , renderContent :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fade : Elm.Expression -> Elm.Expression
    , renderStatusBar : Elm.Expression -> Elm.Expression
    }
call_ =
    { playStopButton =
        \playStopButtonArg playStopButtonArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "playStopButton"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "DetailViewContent"
                                      ]
                                      "PlayButtonState"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "DetailViewContent"
                                      ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewContent"
                                       ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "DetailViewContent"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ playStopButtonArg, playStopButtonArg0 ]
    , activityProgress =
        \activityProgressArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "activityProgress"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Timer" ]
                                      "Timer"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewContent"
                                       ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "DetailViewContent"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ activityProgressArg ]
    , mxpSection =
        \mxpSectionArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "mxpSection"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewContent"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ mxpSectionArg ]
    , masterySection =
        \masterySectionArg masterySectionArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "masterySection"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.namedWith
                                      [ "IdleGame", "Activity" ]
                                      "Mastery"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewContent"
                                       ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ masterySectionArg, masterySectionArg0 ]
    , intervalModLabelToString =
        \intervalModLabelToStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "intervalModLabelToString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "DetailViewContent"
                                      ]
                                      "IntervalModLabel"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ intervalModLabelToStringArg ]
    , renderContent =
        \renderContentArg renderContentArg0 renderContentArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "renderContent"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "DetailViewContent"
                                      ]
                                      "DetailViewObject"
                                      []
                                  , Type.bool
                                  , Type.namedWith
                                      [ "IdleGame"
                                      , "Views"
                                      , "DetailViewContent"
                                      ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewContent"
                                       ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "DetailViewContent"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderContentArg, renderContentArg0, renderContentArg1 ]
    , fade =
        \fadeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "fade"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.bool ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewContent"
                                       ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "DetailViewContent"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ fadeArg ]
    , renderStatusBar =
        \renderStatusBarArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
                     , name = "renderStatusBar"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.tuple
                                      (Type.namedWith
                                         [ "IdleGame"
                                         , "Views"
                                         , "DetailViewContent"
                                         ]
                                         "Activity"
                                         []
                                      )
                                      (Type.namedWith
                                         [ "IdleGame", "Timer" ]
                                         "Timer"
                                         []
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "Views"
                                       , "DetailViewContent"
                                       ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "DetailViewContent"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderStatusBarArg ]
    }


values_ :
    { playStopButton : Elm.Expression
    , activityProgress : Elm.Expression
    , mxpSection : Elm.Expression
    , masterySection : Elm.Expression
    , intervalModLabelToString : Elm.Expression
    , renderContent : Elm.Expression
    , fade : Elm.Expression
    , renderStatusBar : Elm.Expression
    , collapseButton : Elm.Expression
    }
values_ =
    { playStopButton =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "playStopButton"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DetailViewContent" ]
                             "PlayButtonState"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "DetailViewContent" ]
                             "Activity"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewContent" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , activityProgress =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "activityProgress"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Timer" ] "Timer" [] ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewContent" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , mxpSection =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "mxpSection"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , masterySection =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "masterySection"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.namedWith
                             [ "IdleGame", "Activity" ]
                             "Mastery"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , intervalModLabelToString =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "intervalModLabelToString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DetailViewContent" ]
                             "IntervalModLabel"
                             []
                         ]
                         Type.string
                    )
            }
    , renderContent =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "renderContent"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DetailViewContent" ]
                             "DetailViewObject"
                             []
                         , Type.bool
                         , Type.namedWith
                             [ "IdleGame", "Views", "DetailViewContent" ]
                             "Game"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewContent" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , fade =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "fade"
            , annotation =
                Just
                    (Type.function
                         [ Type.bool ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewContent" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , renderStatusBar =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "renderStatusBar"
            , annotation =
                Just
                    (Type.function
                         [ Type.tuple
                             (Type.namedWith
                                [ "IdleGame", "Views", "DetailViewContent" ]
                                "Activity"
                                []
                             )
                             (Type.namedWith [ "IdleGame", "Timer" ] "Timer" [])
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "DetailViewContent" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "DetailViewContent" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , collapseButton =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "DetailViewContent" ]
            , name = "collapseButton"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "DetailViewContent" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "DetailViewContent" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    }