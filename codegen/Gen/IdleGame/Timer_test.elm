module Gen.IdleGame.Timer_test exposing (aboutEqualDuration, aboutEqualFloat, call_, expectCompletions, expectPercentComplete, moduleName_, timerTest, values_)

{-| 
@docs moduleName_, timerTest, expectCompletions, expectPercentComplete, aboutEqualDuration, aboutEqualFloat, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Timer_test" ]


{-| timerTest: IdleGame.Timer_test.Test -}
timerTest : Elm.Expression
timerTest =
    Elm.value
        { importFrom = [ "IdleGame", "Timer_test" ]
        , name = "timerTest"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Timer_test" ] "Test" [])
        }


{-| expectCompletions: Int -> ( IdleGame.Timer.Timer, Int ) -> IdleGame.Timer_test.Expectation -}
expectCompletions : Int -> Elm.Expression -> Elm.Expression
expectCompletions expectCompletionsArg expectCompletionsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Timer_test" ]
             , name = "expectCompletions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.tuple
                              (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                              )
                              Type.int
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Timer_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ Elm.int expectCompletionsArg, expectCompletionsArg0 ]


{-| expectPercentComplete: Percent.Percent -> IdleGame.Timer.Timer -> IdleGame.Timer_test.Expectation -}
expectPercentComplete : Elm.Expression -> Elm.Expression -> Elm.Expression
expectPercentComplete expectPercentCompleteArg expectPercentCompleteArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Timer_test" ]
             , name = "expectPercentComplete"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" []
                          , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Timer_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ expectPercentCompleteArg, expectPercentCompleteArg0 ]


{-| aboutEqualDuration: Duration.Duration -> Duration.Duration -> IdleGame.Timer_test.Expectation -}
aboutEqualDuration : Elm.Expression -> Elm.Expression -> Elm.Expression
aboutEqualDuration aboutEqualDurationArg aboutEqualDurationArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Timer_test" ]
             , name = "aboutEqualDuration"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith [ "Duration" ] "Duration" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Timer_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ aboutEqualDurationArg, aboutEqualDurationArg0 ]


{-| aboutEqualFloat: Float -> Float -> IdleGame.Timer_test.Expectation -}
aboutEqualFloat : Float -> Float -> Elm.Expression
aboutEqualFloat aboutEqualFloatArg aboutEqualFloatArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Timer_test" ]
             , name = "aboutEqualFloat"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float, Type.float ]
                          (Type.namedWith
                               [ "IdleGame", "Timer_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ Elm.float aboutEqualFloatArg, Elm.float aboutEqualFloatArg0 ]


call_ :
    { expectCompletions : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectPercentComplete : Elm.Expression -> Elm.Expression -> Elm.Expression
    , aboutEqualDuration : Elm.Expression -> Elm.Expression -> Elm.Expression
    , aboutEqualFloat : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { expectCompletions =
        \expectCompletionsArg expectCompletionsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer_test" ]
                     , name = "expectCompletions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.tuple
                                      (Type.namedWith
                                         [ "IdleGame", "Timer" ]
                                         "Timer"
                                         []
                                      )
                                      Type.int
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Timer_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectCompletionsArg, expectCompletionsArg0 ]
    , expectPercentComplete =
        \expectPercentCompleteArg expectPercentCompleteArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer_test" ]
                     , name = "expectPercentComplete"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" []
                                  , Type.namedWith
                                      [ "IdleGame", "Timer" ]
                                      "Timer"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Timer_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ expectPercentCompleteArg, expectPercentCompleteArg0 ]
    , aboutEqualDuration =
        \aboutEqualDurationArg aboutEqualDurationArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer_test" ]
                     , name = "aboutEqualDuration"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Timer_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ aboutEqualDurationArg, aboutEqualDurationArg0 ]
    , aboutEqualFloat =
        \aboutEqualFloatArg aboutEqualFloatArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer_test" ]
                     , name = "aboutEqualFloat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float, Type.float ]
                                  (Type.namedWith
                                       [ "IdleGame", "Timer_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ aboutEqualFloatArg, aboutEqualFloatArg0 ]
    }


values_ :
    { timerTest : Elm.Expression
    , expectCompletions : Elm.Expression
    , expectPercentComplete : Elm.Expression
    , aboutEqualDuration : Elm.Expression
    , aboutEqualFloat : Elm.Expression
    }
values_ =
    { timerTest =
        Elm.value
            { importFrom = [ "IdleGame", "Timer_test" ]
            , name = "timerTest"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Timer_test" ] "Test" [])
            }
    , expectCompletions =
        Elm.value
            { importFrom = [ "IdleGame", "Timer_test" ]
            , name = "expectCompletions"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.tuple
                             (Type.namedWith [ "IdleGame", "Timer" ] "Timer" [])
                             Type.int
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Timer_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , expectPercentComplete =
        Elm.value
            { importFrom = [ "IdleGame", "Timer_test" ]
            , name = "expectPercentComplete"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" []
                         , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Timer_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , aboutEqualDuration =
        Elm.value
            { importFrom = [ "IdleGame", "Timer_test" ]
            , name = "aboutEqualDuration"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith [ "Duration" ] "Duration" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Timer_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    , aboutEqualFloat =
        Elm.value
            { importFrom = [ "IdleGame", "Timer_test" ]
            , name = "aboutEqualFloat"
            , annotation =
                Just
                    (Type.function
                         [ Type.float, Type.float ]
                         (Type.namedWith
                              [ "IdleGame", "Timer_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    }