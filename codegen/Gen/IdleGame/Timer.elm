module Gen.IdleGame.Timer exposing (annotation_, call_, caseOf_, create, increment, incrementUntilComplete, make_, moduleName_, percentComplete, values_)

{-| 
@docs moduleName_, incrementUntilComplete, increment, percentComplete, create, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Timer" ]


{-| {-| Increments timer by duration unless timer would go beyond 100% in which case it sets
the timer to 0 and returns the remaining time
-}

incrementUntilComplete: 
    Duration.Duration
    -> Duration.Duration
    -> IdleGame.Timer.Timer
    -> ( IdleGame.Timer.Timer, Duration.Duration )
-}
incrementUntilComplete :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
incrementUntilComplete incrementUntilCompleteArg incrementUntilCompleteArg0 incrementUntilCompleteArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Timer" ]
             , name = "incrementUntilComplete"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "IdleGame", "Timer" ]
                                    "Timer"
                                    []
                               )
                               (Type.namedWith [ "Duration" ] "Duration" [])
                          )
                     )
             }
        )
        [ incrementUntilCompleteArg
        , incrementUntilCompleteArg0
        , incrementUntilCompleteArg1
        ]


{-| increment: 
    Duration.Duration
    -> Duration.Duration
    -> IdleGame.Timer.Timer
    -> ( IdleGame.Timer.Timer, Int )
-}
increment : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
increment incrementArg incrementArg0 incrementArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Timer" ]
             , name = "increment"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "IdleGame", "Timer" ]
                                    "Timer"
                                    []
                               )
                               Type.int
                          )
                     )
             }
        )
        [ incrementArg, incrementArg0, incrementArg1 ]


{-| percentComplete: IdleGame.Timer.Timer -> Percent.Percent -}
percentComplete : Elm.Expression -> Elm.Expression
percentComplete percentCompleteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Timer" ]
             , name = "percentComplete"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Timer" ] "Timer" [] ]
                          (Type.namedWith [ "Percent" ] "Percent" [])
                     )
             }
        )
        [ percentCompleteArg ]


{-| create: IdleGame.Timer.Timer -}
create : Elm.Expression
create =
    Elm.value
        { importFrom = [ "IdleGame", "Timer" ]
        , name = "create"
        , annotation = Just (Type.namedWith [ "IdleGame", "Timer" ] "Timer" [])
        }


annotation_ : { timer : Type.Annotation }
annotation_ =
    { timer = Type.namedWith [ "IdleGame", "Timer" ] "Timer" [] }


make_ : { timer : Elm.Expression -> Elm.Expression }
make_ =
    { timer =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer" ]
                     , name = "Timer"
                     , annotation = Just (Type.namedWith [] "Timer" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { timer :
        Elm.Expression
        -> { timerTags_0_0 | timer : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { timer =
        \timerExpression timerTags ->
            Elm.Case.custom
                timerExpression
                (Type.namedWith [ "IdleGame", "Timer" ] "Timer" [])
                [ Elm.Case.branch1
                    "Timer"
                    ( "one"
                    , Type.record
                          [ ( "current"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          ]
                    )
                    timerTags.timer
                ]
    }


call_ :
    { incrementUntilComplete :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , increment :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , percentComplete : Elm.Expression -> Elm.Expression
    }
call_ =
    { incrementUntilComplete =
        \incrementUntilCompleteArg incrementUntilCompleteArg0 incrementUntilCompleteArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer" ]
                     , name = "incrementUntilComplete"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith
                                      [ "IdleGame", "Timer" ]
                                      "Timer"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "IdleGame", "Timer" ]
                                            "Timer"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Duration" ]
                                            "Duration"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ incrementUntilCompleteArg
                , incrementUntilCompleteArg0
                , incrementUntilCompleteArg1
                ]
    , increment =
        \incrementArg incrementArg0 incrementArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer" ]
                     , name = "increment"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith
                                      [ "IdleGame", "Timer" ]
                                      "Timer"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "IdleGame", "Timer" ]
                                            "Timer"
                                            []
                                       )
                                       Type.int
                                  )
                             )
                     }
                )
                [ incrementArg, incrementArg0, incrementArg1 ]
    , percentComplete =
        \percentCompleteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Timer" ]
                     , name = "percentComplete"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Timer" ]
                                      "Timer"
                                      []
                                  ]
                                  (Type.namedWith [ "Percent" ] "Percent" [])
                             )
                     }
                )
                [ percentCompleteArg ]
    }


values_ :
    { incrementUntilComplete : Elm.Expression
    , increment : Elm.Expression
    , percentComplete : Elm.Expression
    , create : Elm.Expression
    }
values_ =
    { incrementUntilComplete =
        Elm.value
            { importFrom = [ "IdleGame", "Timer" ]
            , name = "incrementUntilComplete"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                              )
                              (Type.namedWith [ "Duration" ] "Duration" [])
                         )
                    )
            }
    , increment =
        Elm.value
            { importFrom = [ "IdleGame", "Timer" ]
            , name = "increment"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []
                              )
                              Type.int
                         )
                    )
            }
    , percentComplete =
        Elm.value
            { importFrom = [ "IdleGame", "Timer" ]
            , name = "percentComplete"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Timer" ] "Timer" [] ]
                         (Type.namedWith [ "Percent" ] "Percent" [])
                    )
            }
    , create =
        Elm.value
            { importFrom = [ "IdleGame", "Timer" ]
            , name = "create"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Timer" ] "Timer" [])
            }
    }