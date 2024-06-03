module Gen.IdleGame.PerfTesting.PerfTestingUtil exposing (call_, createTick, moduleName_, testTimePasses, values_)

{-| 
@docs moduleName_, testTimePasses, createTick, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]


{-| testTimePasses: 
    { tick : IdleGame.Snapshot.Tick IdleGame.PerfTesting.PerfTestingUtil.Game
    , duration : Duration.Duration
    }
    -> IdleGame.PerfTesting.PerfTestingUtil.Test
-}
testTimePasses :
    { tick : Elm.Expression, duration : Elm.Expression } -> Elm.Expression
testTimePasses testTimePassesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
             , name = "testTimePasses"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "tick"
                                , Type.namedWith
                                    [ "IdleGame", "Snapshot" ]
                                    "Tick"
                                    [ Type.namedWith
                                          [ "IdleGame"
                                          , "PerfTesting"
                                          , "PerfTestingUtil"
                                          ]
                                          "Game"
                                          []
                                    ]
                                )
                              , ( "duration"
                                , Type.namedWith [ "Duration" ] "Duration" []
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
                               "Test"
                               []
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "tick" testTimePassesArg.tick
            , Tuple.pair "duration" testTimePassesArg.duration
            ]
        ]


{-| createTick: 
    Duration.Duration
    -> IdleGame.Snapshot.Tick IdleGame.PerfTesting.PerfTestingUtil.Game
-}
createTick : Elm.Expression -> Elm.Expression
createTick createTickArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
             , name = "createTick"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          (Type.namedWith
                               [ "IdleGame", "Snapshot" ]
                               "Tick"
                               [ Type.namedWith
                                   [ "IdleGame"
                                   , "PerfTesting"
                                   , "PerfTestingUtil"
                                   ]
                                   "Game"
                                   []
                               ]
                          )
                     )
             }
        )
        [ createTickArg ]


call_ :
    { testTimePasses : Elm.Expression -> Elm.Expression
    , createTick : Elm.Expression -> Elm.Expression
    }
call_ =
    { testTimePasses =
        \testTimePassesArg ->
            Elm.apply
                (Elm.value
                     { importFrom =
                         [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
                     , name = "testTimePasses"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "tick"
                                        , Type.namedWith
                                            [ "IdleGame", "Snapshot" ]
                                            "Tick"
                                            [ Type.namedWith
                                                  [ "IdleGame"
                                                  , "PerfTesting"
                                                  , "PerfTestingUtil"
                                                  ]
                                                  "Game"
                                                  []
                                            ]
                                        )
                                      , ( "duration"
                                        , Type.namedWith
                                            [ "Duration" ]
                                            "Duration"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame"
                                       , "PerfTesting"
                                       , "PerfTestingUtil"
                                       ]
                                       "Test"
                                       []
                                  )
                             )
                     }
                )
                [ testTimePassesArg ]
    , createTick =
        \createTickArg ->
            Elm.apply
                (Elm.value
                     { importFrom =
                         [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
                     , name = "createTick"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Snapshot" ]
                                       "Tick"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "PerfTesting"
                                           , "PerfTestingUtil"
                                           ]
                                           "Game"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ createTickArg ]
    }


values_ : { testTimePasses : Elm.Expression, createTick : Elm.Expression }
values_ =
    { testTimePasses =
        Elm.value
            { importFrom = [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
            , name = "testTimePasses"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "tick"
                               , Type.namedWith
                                   [ "IdleGame", "Snapshot" ]
                                   "Tick"
                                   [ Type.namedWith
                                         [ "IdleGame"
                                         , "PerfTesting"
                                         , "PerfTestingUtil"
                                         ]
                                         "Game"
                                         []
                                   ]
                               )
                             , ( "duration"
                               , Type.namedWith [ "Duration" ] "Duration" []
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
                              "Test"
                              []
                         )
                    )
            }
    , createTick =
        Elm.value
            { importFrom = [ "IdleGame", "PerfTesting", "PerfTestingUtil" ]
            , name = "createTick"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         (Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Tick"
                              [ Type.namedWith
                                  [ "IdleGame"
                                  , "PerfTesting"
                                  , "PerfTestingUtil"
                                  ]
                                  "Game"
                                  []
                              ]
                         )
                    )
            }
    }