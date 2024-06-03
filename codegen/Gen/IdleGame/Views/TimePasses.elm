module Gen.IdleGame.Views.TimePasses exposing (call_, hasGains, moduleName_, render, renderCombatsLost, renderCombatsWon, resourceIcon, values_)

{-| 
@docs moduleName_, render, hasGains, renderCombatsLost, renderCombatsWon, resourceIcon, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "TimePasses" ]


{-| render: 
    Duration.Duration
    -> Time.Posix
    -> IdleGame.Views.TimePasses.TimePassesData
    -> IdleGame.Views.TimePasses.Html IdleGame.Views.TimePasses.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
render renderArg renderArg0 renderArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "TimePasses" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith
                              [ "IdleGame", "Views", "TimePasses" ]
                              "TimePassesData"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "TimePasses" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "TimePasses" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ renderArg, renderArg0, renderArg1 ]


{-| hasGains: IdleGame.Views.TimePasses.TimePassesData -> Bool -}
hasGains : Elm.Expression -> Elm.Expression
hasGains hasGainsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "TimePasses" ]
             , name = "hasGains"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Views", "TimePasses" ]
                              "TimePassesData"
                              []
                          ]
                          Type.bool
                     )
             }
        )
        [ hasGainsArg ]


{-| renderCombatsLost: Int -> IdleGame.Views.TimePasses.Html IdleGame.Views.TimePasses.FrontendMsg -}
renderCombatsLost : Int -> Elm.Expression
renderCombatsLost renderCombatsLostArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "TimePasses" ]
             , name = "renderCombatsLost"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "TimePasses" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "TimePasses" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.int renderCombatsLostArg ]


{-| renderCombatsWon: Int -> IdleGame.Views.TimePasses.Html IdleGame.Views.TimePasses.FrontendMsg -}
renderCombatsWon : Int -> Elm.Expression
renderCombatsWon renderCombatsWonArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "TimePasses" ]
             , name = "renderCombatsWon"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "TimePasses" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "TimePasses" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.int renderCombatsWonArg ]


{-| resourceIcon: FeatherIcons.Icon -}
resourceIcon : Elm.Expression
resourceIcon =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "TimePasses" ]
        , name = "resourceIcon"
        , annotation = Just (Type.namedWith [ "FeatherIcons" ] "Icon" [])
        }


call_ :
    { render :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , hasGains : Elm.Expression -> Elm.Expression
    , renderCombatsLost : Elm.Expression -> Elm.Expression
    , renderCombatsWon : Elm.Expression -> Elm.Expression
    }
call_ =
    { render =
        \renderArg renderArg0 renderArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "TimePasses" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith
                                      [ "IdleGame", "Views", "TimePasses" ]
                                      "TimePassesData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "TimePasses" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "TimePasses" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg, renderArg0, renderArg1 ]
    , hasGains =
        \hasGainsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "TimePasses" ]
                     , name = "hasGains"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Views", "TimePasses" ]
                                      "TimePassesData"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasGainsArg ]
    , renderCombatsLost =
        \renderCombatsLostArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "TimePasses" ]
                     , name = "renderCombatsLost"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "TimePasses" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "TimePasses" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderCombatsLostArg ]
    , renderCombatsWon =
        \renderCombatsWonArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "TimePasses" ]
                     , name = "renderCombatsWon"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "TimePasses" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame", "Views", "TimePasses" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderCombatsWonArg ]
    }


values_ :
    { render : Elm.Expression
    , hasGains : Elm.Expression
    , renderCombatsLost : Elm.Expression
    , renderCombatsWon : Elm.Expression
    , resourceIcon : Elm.Expression
    }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TimePasses" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith
                             [ "IdleGame", "Views", "TimePasses" ]
                             "TimePassesData"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "TimePasses" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "TimePasses" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , hasGains =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TimePasses" ]
            , name = "hasGains"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Views", "TimePasses" ]
                             "TimePassesData"
                             []
                         ]
                         Type.bool
                    )
            }
    , renderCombatsLost =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TimePasses" ]
            , name = "renderCombatsLost"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "TimePasses" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "TimePasses" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , renderCombatsWon =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TimePasses" ]
            , name = "renderCombatsWon"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "TimePasses" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "TimePasses" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    , resourceIcon =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "TimePasses" ]
            , name = "resourceIcon"
            , annotation = Just (Type.namedWith [ "FeatherIcons" ] "Icon" [])
            }
    }