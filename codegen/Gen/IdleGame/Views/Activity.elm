module Gen.IdleGame.Views.Activity exposing (activityDuration, call_, getTimerForActivity, moduleName_, notMasteryXpEffect, probabilityToInt, renderActivityCard, renderActivityListItem, renderBottomRight, renderLockedActivity, values_)

{-| 
@docs moduleName_, renderBottomRight, renderLockedActivity, renderActivityCard, notMasteryXpEffect, getTimerForActivity, activityDuration, probabilityToInt, renderActivityListItem, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Activity" ]


{-| renderBottomRight: IdleGame.Views.Activity.Html IdleGame.Views.Activity.FrontendMsg -}
renderBottomRight : Elm.Expression
renderBottomRight =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Activity" ]
        , name = "renderBottomRight"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "Activity" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "Activity" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


{-| renderLockedActivity: 
    IdleGame.Views.Activity.Skill
    -> Int
    -> IdleGame.Views.Activity.Html IdleGame.Views.Activity.FrontendMsg
-}
renderLockedActivity : Elm.Expression -> Int -> Elm.Expression
renderLockedActivity renderLockedActivityArg renderLockedActivityArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Activity" ]
             , name = "renderLockedActivity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Skill"
                              []
                          , Type.int
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Activity" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Activity" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderLockedActivityArg, Elm.int renderLockedActivityArg0 ]


{-| renderActivityCard: 
    IdleGame.Views.Activity.Activity
    -> IdleGame.Views.Activity.Game
    -> IdleGame.Views.Activity.ScreenWidth
    -> IdleGame.Views.Activity.Html IdleGame.Views.Activity.FrontendMsg
-}
renderActivityCard :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
renderActivityCard renderActivityCardArg renderActivityCardArg0 renderActivityCardArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Activity" ]
             , name = "renderActivityCard"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Activity"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Game"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "ScreenWidth"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Activity" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Activity" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderActivityCardArg
        , renderActivityCardArg0
        , renderActivityCardArg1
        ]


{-| notMasteryXpEffect: IdleGame.Effect.Effect -> Bool -}
notMasteryXpEffect : Elm.Expression -> Elm.Expression
notMasteryXpEffect notMasteryXpEffectArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Activity" ]
             , name = "notMasteryXpEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          ]
                          Type.bool
                     )
             }
        )
        [ notMasteryXpEffectArg ]


{-| getTimerForActivity: 
    IdleGame.Views.Activity.Activity
    -> IdleGame.Views.Activity.Game
    -> Maybe IdleGame.Timer.Timer
-}
getTimerForActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
getTimerForActivity getTimerForActivityArg getTimerForActivityArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Activity" ]
             , name = "getTimerForActivity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Activity"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Game"
                              []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "IdleGame", "Timer" ]
                                    "Timer"
                                    []
                               )
                          )
                     )
             }
        )
        [ getTimerForActivityArg, getTimerForActivityArg0 ]


{-| activityDuration: Duration.Duration -> IdleGame.Views.Activity.Html msg -}
activityDuration : Elm.Expression -> Elm.Expression
activityDuration activityDurationArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Activity" ]
             , name = "activityDuration"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Activity" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ activityDurationArg ]


{-| probabilityToInt: Float -> Int -}
probabilityToInt : Float -> Elm.Expression
probabilityToInt probabilityToIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Activity" ]
             , name = "probabilityToInt"
             , annotation = Just (Type.function [ Type.float ] Type.int)
             }
        )
        [ Elm.float probabilityToIntArg ]


{-| renderActivityListItem: 
    IdleGame.Views.Activity.Game
    -> IdleGame.Game.ActivityListItem
    -> IdleGame.Views.Activity.Html IdleGame.Views.Activity.FrontendMsg
-}
renderActivityListItem : Elm.Expression -> Elm.Expression -> Elm.Expression
renderActivityListItem renderActivityListItemArg renderActivityListItemArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Activity" ]
             , name = "renderActivityListItem"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Game"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Game" ]
                              "ActivityListItem"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Activity" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "Activity" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderActivityListItemArg, renderActivityListItemArg0 ]


call_ :
    { renderLockedActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderActivityCard :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , notMasteryXpEffect : Elm.Expression -> Elm.Expression
    , getTimerForActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
    , activityDuration : Elm.Expression -> Elm.Expression
    , probabilityToInt : Elm.Expression -> Elm.Expression
    , renderActivityListItem :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { renderLockedActivity =
        \renderLockedActivityArg renderLockedActivityArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Activity" ]
                     , name = "renderLockedActivity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Activity" ]
                                      "Skill"
                                      []
                                  , Type.int
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Activity" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Activity" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderLockedActivityArg, renderLockedActivityArg0 ]
    , renderActivityCard =
        \renderActivityCardArg renderActivityCardArg0 renderActivityCardArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Activity" ]
                     , name = "renderActivityCard"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Activity" ]
                                      "Activity"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "Activity" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "Activity" ]
                                      "ScreenWidth"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Activity" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Activity" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderActivityCardArg
                , renderActivityCardArg0
                , renderActivityCardArg1
                ]
    , notMasteryXpEffect =
        \notMasteryXpEffectArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Activity" ]
                     , name = "notMasteryXpEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ notMasteryXpEffectArg ]
    , getTimerForActivity =
        \getTimerForActivityArg getTimerForActivityArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Activity" ]
                     , name = "getTimerForActivity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Activity" ]
                                      "Activity"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "Activity" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "IdleGame", "Timer" ]
                                            "Timer"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getTimerForActivityArg, getTimerForActivityArg0 ]
    , activityDuration =
        \activityDurationArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Activity" ]
                     , name = "activityDuration"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Activity" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ activityDurationArg ]
    , probabilityToInt =
        \probabilityToIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Activity" ]
                     , name = "probabilityToInt"
                     , annotation = Just (Type.function [ Type.float ] Type.int)
                     }
                )
                [ probabilityToIntArg ]
    , renderActivityListItem =
        \renderActivityListItemArg renderActivityListItemArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Activity" ]
                     , name = "renderActivityListItem"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "Activity" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "ActivityListItem"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Activity" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "Activity" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderActivityListItemArg, renderActivityListItemArg0 ]
    }


values_ :
    { renderBottomRight : Elm.Expression
    , renderLockedActivity : Elm.Expression
    , renderActivityCard : Elm.Expression
    , notMasteryXpEffect : Elm.Expression
    , getTimerForActivity : Elm.Expression
    , activityDuration : Elm.Expression
    , probabilityToInt : Elm.Expression
    , renderActivityListItem : Elm.Expression
    }
values_ =
    { renderBottomRight =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "renderBottomRight"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "Activity" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    , renderLockedActivity =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "renderLockedActivity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "Skill"
                             []
                         , Type.int
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Activity" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , renderActivityCard =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "renderActivityCard"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "Activity"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "Game"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "ScreenWidth"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Activity" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , notMasteryXpEffect =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "notMasteryXpEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" [] ]
                         Type.bool
                    )
            }
    , getTimerForActivity =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "getTimerForActivity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "Activity"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "Game"
                             []
                         ]
                         (Type.maybe
                              (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                              )
                         )
                    )
            }
    , activityDuration =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "activityDuration"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , probabilityToInt =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "probabilityToInt"
            , annotation = Just (Type.function [ Type.float ] Type.int)
            }
    , renderActivityListItem =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Activity" ]
            , name = "renderActivityListItem"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "Activity" ]
                             "Game"
                             []
                         , Type.namedWith
                             [ "IdleGame", "Game" ]
                             "ActivityListItem"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Activity" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "Activity" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }