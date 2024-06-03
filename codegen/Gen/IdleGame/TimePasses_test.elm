module Gen.IdleGame.TimePasses_test exposing (moduleName_, performantPlusTick, performantTick, standardTick, testTimePasses, values_)

{-| 
@docs moduleName_, testTimePasses, performantPlusTick, performantTick, standardTick, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "TimePasses_test" ]


{-| testTimePasses: IdleGame.TimePasses_test.Test -}
testTimePasses : Elm.Expression
testTimePasses =
    Elm.value
        { importFrom = [ "IdleGame", "TimePasses_test" ]
        , name = "testTimePasses"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "TimePasses_test" ] "Test" [])
        }


{-| performantPlusTick: IdleGame.Snapshot.Tick IdleGame.TimePasses_test.Game -}
performantPlusTick : Elm.Expression
performantPlusTick =
    Elm.value
        { importFrom = [ "IdleGame", "TimePasses_test" ]
        , name = "performantPlusTick"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Snapshot" ]
                     "Tick"
                     [ Type.namedWith
                         [ "IdleGame", "TimePasses_test" ]
                         "Game"
                         []
                     ]
                )
        }


{-| performantTick: IdleGame.Snapshot.Tick IdleGame.TimePasses_test.Game -}
performantTick : Elm.Expression
performantTick =
    Elm.value
        { importFrom = [ "IdleGame", "TimePasses_test" ]
        , name = "performantTick"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Snapshot" ]
                     "Tick"
                     [ Type.namedWith
                         [ "IdleGame", "TimePasses_test" ]
                         "Game"
                         []
                     ]
                )
        }


{-| standardTick: IdleGame.Snapshot.Tick ( IdleGame.TimePasses_test.Game, List IdleGame.TimePasses_test.Toast ) -}
standardTick : Elm.Expression
standardTick =
    Elm.value
        { importFrom = [ "IdleGame", "TimePasses_test" ]
        , name = "standardTick"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Snapshot" ]
                     "Tick"
                     [ Type.tuple
                         (Type.namedWith
                            [ "IdleGame", "TimePasses_test" ]
                            "Game"
                            []
                         )
                         (Type.list
                            (Type.namedWith
                               [ "IdleGame", "TimePasses_test" ]
                               "Toast"
                               []
                            )
                         )
                     ]
                )
        }


values_ :
    { testTimePasses : Elm.Expression
    , performantPlusTick : Elm.Expression
    , performantTick : Elm.Expression
    , standardTick : Elm.Expression
    }
values_ =
    { testTimePasses =
        Elm.value
            { importFrom = [ "IdleGame", "TimePasses_test" ]
            , name = "testTimePasses"
            , annotation =
                Just
                    (Type.namedWith [ "IdleGame", "TimePasses_test" ] "Test" [])
            }
    , performantPlusTick =
        Elm.value
            { importFrom = [ "IdleGame", "TimePasses_test" ]
            , name = "performantPlusTick"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Snapshot" ]
                         "Tick"
                         [ Type.namedWith
                             [ "IdleGame", "TimePasses_test" ]
                             "Game"
                             []
                         ]
                    )
            }
    , performantTick =
        Elm.value
            { importFrom = [ "IdleGame", "TimePasses_test" ]
            , name = "performantTick"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Snapshot" ]
                         "Tick"
                         [ Type.namedWith
                             [ "IdleGame", "TimePasses_test" ]
                             "Game"
                             []
                         ]
                    )
            }
    , standardTick =
        Elm.value
            { importFrom = [ "IdleGame", "TimePasses_test" ]
            , name = "standardTick"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Snapshot" ]
                         "Tick"
                         [ Type.tuple
                             (Type.namedWith
                                [ "IdleGame", "TimePasses_test" ]
                                "Game"
                                []
                             )
                             (Type.list
                                (Type.namedWith
                                   [ "IdleGame", "TimePasses_test" ]
                                   "Toast"
                                   []
                                )
                             )
                         ]
                    )
            }
    }