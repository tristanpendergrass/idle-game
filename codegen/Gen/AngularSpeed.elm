module Gen.AngularSpeed exposing (annotation_, call_, degreesPerSecond, inDegreesPerSecond, inRadiansPerSecond, inRevolutionsPerMinute, inRevolutionsPerSecond, inTurnsPerMinute, inTurnsPerSecond, moduleName_, radiansPerSecond, revolutionsPerMinute, revolutionsPerSecond, turnsPerMinute, turnsPerSecond, values_)

{-| 
@docs moduleName_, radiansPerSecond, inRadiansPerSecond, degreesPerSecond, inDegreesPerSecond, turnsPerSecond, inTurnsPerSecond, turnsPerMinute, inTurnsPerMinute, revolutionsPerSecond, inRevolutionsPerSecond, revolutionsPerMinute, inRevolutionsPerMinute, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "AngularSpeed" ]


{-| Construct an angular speed from a number of radians per second.

radiansPerSecond: Float -> AngularSpeed.AngularSpeed
-}
radiansPerSecond : Float -> Elm.Expression
radiansPerSecond radiansPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "radiansPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                     )
             }
        )
        [ Elm.float radiansPerSecondArg ]


{-| Convert an angular speed to a number of radians per second.

inRadiansPerSecond: AngularSpeed.AngularSpeed -> Float
-}
inRadiansPerSecond : Elm.Expression -> Elm.Expression
inRadiansPerSecond inRadiansPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "inRadiansPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" []
                          ]
                          Type.float
                     )
             }
        )
        [ inRadiansPerSecondArg ]


{-| Construct an angular speed from a number of degrees per second.

degreesPerSecond: Float -> AngularSpeed.AngularSpeed
-}
degreesPerSecond : Float -> Elm.Expression
degreesPerSecond degreesPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "degreesPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                     )
             }
        )
        [ Elm.float degreesPerSecondArg ]


{-| Convert an angular speed to a number of degrees per second.

inDegreesPerSecond: AngularSpeed.AngularSpeed -> Float
-}
inDegreesPerSecond : Elm.Expression -> Elm.Expression
inDegreesPerSecond inDegreesPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "inDegreesPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" []
                          ]
                          Type.float
                     )
             }
        )
        [ inDegreesPerSecondArg ]


{-| Construct an angular speed from a number of turns per second.

turnsPerSecond: Float -> AngularSpeed.AngularSpeed
-}
turnsPerSecond : Float -> Elm.Expression
turnsPerSecond turnsPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "turnsPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                     )
             }
        )
        [ Elm.float turnsPerSecondArg ]


{-| Convert an angular speed to a number of turns per second.

inTurnsPerSecond: AngularSpeed.AngularSpeed -> Float
-}
inTurnsPerSecond : Elm.Expression -> Elm.Expression
inTurnsPerSecond inTurnsPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "inTurnsPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" []
                          ]
                          Type.float
                     )
             }
        )
        [ inTurnsPerSecondArg ]


{-| Construct an angular speed from a number of turns per minute.

turnsPerMinute: Float -> AngularSpeed.AngularSpeed
-}
turnsPerMinute : Float -> Elm.Expression
turnsPerMinute turnsPerMinuteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "turnsPerMinute"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                     )
             }
        )
        [ Elm.float turnsPerMinuteArg ]


{-| Convert an angular speed to a number of turns per minute.

inTurnsPerMinute: AngularSpeed.AngularSpeed -> Float
-}
inTurnsPerMinute : Elm.Expression -> Elm.Expression
inTurnsPerMinute inTurnsPerMinuteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "inTurnsPerMinute"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" []
                          ]
                          Type.float
                     )
             }
        )
        [ inTurnsPerMinuteArg ]


{-| Alias for `turnsPerSecond`.

revolutionsPerSecond: Float -> AngularSpeed.AngularSpeed
-}
revolutionsPerSecond : Float -> Elm.Expression
revolutionsPerSecond revolutionsPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "revolutionsPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                     )
             }
        )
        [ Elm.float revolutionsPerSecondArg ]


{-| Alias for `inTurnsPerSecond`.

inRevolutionsPerSecond: AngularSpeed.AngularSpeed -> Float
-}
inRevolutionsPerSecond : Elm.Expression -> Elm.Expression
inRevolutionsPerSecond inRevolutionsPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "inRevolutionsPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" []
                          ]
                          Type.float
                     )
             }
        )
        [ inRevolutionsPerSecondArg ]


{-| Alias for `turnsPerMinute`.

revolutionsPerMinute: Float -> AngularSpeed.AngularSpeed
-}
revolutionsPerMinute : Float -> Elm.Expression
revolutionsPerMinute revolutionsPerMinuteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "revolutionsPerMinute"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                     )
             }
        )
        [ Elm.float revolutionsPerMinuteArg ]


{-| Alias for `inTurnsPerMinute`.

inRevolutionsPerMinute: AngularSpeed.AngularSpeed -> Float
-}
inRevolutionsPerMinute : Elm.Expression -> Elm.Expression
inRevolutionsPerMinute inRevolutionsPerMinuteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularSpeed" ]
             , name = "inRevolutionsPerMinute"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" []
                          ]
                          Type.float
                     )
             }
        )
        [ inRevolutionsPerMinuteArg ]


annotation_ :
    { angularSpeed : Type.Annotation, radiansPerSecond : Type.Annotation }
annotation_ =
    { angularSpeed =
        Type.alias
            moduleName_
            "AngularSpeed"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith [ "AngularSpeed" ] "RadiansPerSecond" []
                 ]
            )
    , radiansPerSecond =
        Type.alias
            moduleName_
            "RadiansPerSecond"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Angle" ] "Radians" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    }


call_ :
    { radiansPerSecond : Elm.Expression -> Elm.Expression
    , inRadiansPerSecond : Elm.Expression -> Elm.Expression
    , degreesPerSecond : Elm.Expression -> Elm.Expression
    , inDegreesPerSecond : Elm.Expression -> Elm.Expression
    , turnsPerSecond : Elm.Expression -> Elm.Expression
    , inTurnsPerSecond : Elm.Expression -> Elm.Expression
    , turnsPerMinute : Elm.Expression -> Elm.Expression
    , inTurnsPerMinute : Elm.Expression -> Elm.Expression
    , revolutionsPerSecond : Elm.Expression -> Elm.Expression
    , inRevolutionsPerSecond : Elm.Expression -> Elm.Expression
    , revolutionsPerMinute : Elm.Expression -> Elm.Expression
    , inRevolutionsPerMinute : Elm.Expression -> Elm.Expression
    }
call_ =
    { radiansPerSecond =
        \radiansPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "radiansPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularSpeed" ]
                                       "AngularSpeed"
                                       []
                                  )
                             )
                     }
                )
                [ radiansPerSecondArg ]
    , inRadiansPerSecond =
        \inRadiansPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "inRadiansPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularSpeed" ]
                                      "AngularSpeed"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inRadiansPerSecondArg ]
    , degreesPerSecond =
        \degreesPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "degreesPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularSpeed" ]
                                       "AngularSpeed"
                                       []
                                  )
                             )
                     }
                )
                [ degreesPerSecondArg ]
    , inDegreesPerSecond =
        \inDegreesPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "inDegreesPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularSpeed" ]
                                      "AngularSpeed"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inDegreesPerSecondArg ]
    , turnsPerSecond =
        \turnsPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "turnsPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularSpeed" ]
                                       "AngularSpeed"
                                       []
                                  )
                             )
                     }
                )
                [ turnsPerSecondArg ]
    , inTurnsPerSecond =
        \inTurnsPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "inTurnsPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularSpeed" ]
                                      "AngularSpeed"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inTurnsPerSecondArg ]
    , turnsPerMinute =
        \turnsPerMinuteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "turnsPerMinute"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularSpeed" ]
                                       "AngularSpeed"
                                       []
                                  )
                             )
                     }
                )
                [ turnsPerMinuteArg ]
    , inTurnsPerMinute =
        \inTurnsPerMinuteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "inTurnsPerMinute"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularSpeed" ]
                                      "AngularSpeed"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inTurnsPerMinuteArg ]
    , revolutionsPerSecond =
        \revolutionsPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "revolutionsPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularSpeed" ]
                                       "AngularSpeed"
                                       []
                                  )
                             )
                     }
                )
                [ revolutionsPerSecondArg ]
    , inRevolutionsPerSecond =
        \inRevolutionsPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "inRevolutionsPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularSpeed" ]
                                      "AngularSpeed"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inRevolutionsPerSecondArg ]
    , revolutionsPerMinute =
        \revolutionsPerMinuteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "revolutionsPerMinute"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularSpeed" ]
                                       "AngularSpeed"
                                       []
                                  )
                             )
                     }
                )
                [ revolutionsPerMinuteArg ]
    , inRevolutionsPerMinute =
        \inRevolutionsPerMinuteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularSpeed" ]
                     , name = "inRevolutionsPerMinute"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularSpeed" ]
                                      "AngularSpeed"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inRevolutionsPerMinuteArg ]
    }


values_ :
    { radiansPerSecond : Elm.Expression
    , inRadiansPerSecond : Elm.Expression
    , degreesPerSecond : Elm.Expression
    , inDegreesPerSecond : Elm.Expression
    , turnsPerSecond : Elm.Expression
    , inTurnsPerSecond : Elm.Expression
    , turnsPerMinute : Elm.Expression
    , inTurnsPerMinute : Elm.Expression
    , revolutionsPerSecond : Elm.Expression
    , inRevolutionsPerSecond : Elm.Expression
    , revolutionsPerMinute : Elm.Expression
    , inRevolutionsPerMinute : Elm.Expression
    }
values_ =
    { radiansPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "radiansPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                    )
            }
    , inRadiansPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "inRadiansPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [] ]
                         Type.float
                    )
            }
    , degreesPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "degreesPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                    )
            }
    , inDegreesPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "inDegreesPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [] ]
                         Type.float
                    )
            }
    , turnsPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "turnsPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                    )
            }
    , inTurnsPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "inTurnsPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [] ]
                         Type.float
                    )
            }
    , turnsPerMinute =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "turnsPerMinute"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                    )
            }
    , inTurnsPerMinute =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "inTurnsPerMinute"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [] ]
                         Type.float
                    )
            }
    , revolutionsPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "revolutionsPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                    )
            }
    , inRevolutionsPerSecond =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "inRevolutionsPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [] ]
                         Type.float
                    )
            }
    , revolutionsPerMinute =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "revolutionsPerMinute"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [])
                    )
            }
    , inRevolutionsPerMinute =
        Elm.value
            { importFrom = [ "AngularSpeed" ]
            , name = "inRevolutionsPerMinute"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "AngularSpeed" ] "AngularSpeed" [] ]
                         Type.float
                    )
            }
    }