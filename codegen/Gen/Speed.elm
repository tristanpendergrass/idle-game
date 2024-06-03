module Gen.Speed exposing (annotation_, call_, feetPerSecond, inFeetPerSecond, inKilometersPerHour, inMetersPerSecond, inMilesPerHour, kilometersPerHour, metersPerSecond, milesPerHour, moduleName_, values_)

{-| 
@docs moduleName_, metersPerSecond, inMetersPerSecond, kilometersPerHour, inKilometersPerHour, feetPerSecond, inFeetPerSecond, milesPerHour, inMilesPerHour, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Speed" ]


{-| Construct a speed from a number of meters per second.

metersPerSecond: Float -> Speed.Speed
-}
metersPerSecond : Float -> Elm.Expression
metersPerSecond metersPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "metersPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Speed" ] "Speed" [])
                     )
             }
        )
        [ Elm.float metersPerSecondArg ]


{-| Convert a speed to a number of meters per second.

inMetersPerSecond: Speed.Speed -> Float
-}
inMetersPerSecond : Elm.Expression -> Elm.Expression
inMetersPerSecond inMetersPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "inMetersPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Speed" ] "Speed" [] ]
                          Type.float
                     )
             }
        )
        [ inMetersPerSecondArg ]


{-| Construct a speed from a number of kilometers per hour.

kilometersPerHour: Float -> Speed.Speed
-}
kilometersPerHour : Float -> Elm.Expression
kilometersPerHour kilometersPerHourArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "kilometersPerHour"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Speed" ] "Speed" [])
                     )
             }
        )
        [ Elm.float kilometersPerHourArg ]


{-| Convert a speed to a number of kilometers per hour.

inKilometersPerHour: Speed.Speed -> Float
-}
inKilometersPerHour : Elm.Expression -> Elm.Expression
inKilometersPerHour inKilometersPerHourArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "inKilometersPerHour"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Speed" ] "Speed" [] ]
                          Type.float
                     )
             }
        )
        [ inKilometersPerHourArg ]


{-| Construct a speed from a number of feet per second.

feetPerSecond: Float -> Speed.Speed
-}
feetPerSecond : Float -> Elm.Expression
feetPerSecond feetPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "feetPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Speed" ] "Speed" [])
                     )
             }
        )
        [ Elm.float feetPerSecondArg ]


{-| Convert a speed to a number of feet per second.

inFeetPerSecond: Speed.Speed -> Float
-}
inFeetPerSecond : Elm.Expression -> Elm.Expression
inFeetPerSecond inFeetPerSecondArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "inFeetPerSecond"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Speed" ] "Speed" [] ]
                          Type.float
                     )
             }
        )
        [ inFeetPerSecondArg ]


{-| Construct a speed from a number of miles per hour.

milesPerHour: Float -> Speed.Speed
-}
milesPerHour : Float -> Elm.Expression
milesPerHour milesPerHourArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "milesPerHour"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Speed" ] "Speed" [])
                     )
             }
        )
        [ Elm.float milesPerHourArg ]


{-| Convert a speed to a number of miles per hour.

inMilesPerHour: Speed.Speed -> Float
-}
inMilesPerHour : Elm.Expression -> Elm.Expression
inMilesPerHour inMilesPerHourArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Speed" ]
             , name = "inMilesPerHour"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Speed" ] "Speed" [] ]
                          Type.float
                     )
             }
        )
        [ inMilesPerHourArg ]


annotation_ : { speed : Type.Annotation, metersPerSecond : Type.Annotation }
annotation_ =
    { speed =
        Type.alias
            moduleName_
            "Speed"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Speed" ] "MetersPerSecond" [] ]
            )
    , metersPerSecond =
        Type.alias
            moduleName_
            "MetersPerSecond"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Length" ] "Meters" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    }


call_ :
    { metersPerSecond : Elm.Expression -> Elm.Expression
    , inMetersPerSecond : Elm.Expression -> Elm.Expression
    , kilometersPerHour : Elm.Expression -> Elm.Expression
    , inKilometersPerHour : Elm.Expression -> Elm.Expression
    , feetPerSecond : Elm.Expression -> Elm.Expression
    , inFeetPerSecond : Elm.Expression -> Elm.Expression
    , milesPerHour : Elm.Expression -> Elm.Expression
    , inMilesPerHour : Elm.Expression -> Elm.Expression
    }
call_ =
    { metersPerSecond =
        \metersPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "metersPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Speed" ] "Speed" [])
                             )
                     }
                )
                [ metersPerSecondArg ]
    , inMetersPerSecond =
        \inMetersPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "inMetersPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Speed" ] "Speed" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMetersPerSecondArg ]
    , kilometersPerHour =
        \kilometersPerHourArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "kilometersPerHour"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Speed" ] "Speed" [])
                             )
                     }
                )
                [ kilometersPerHourArg ]
    , inKilometersPerHour =
        \inKilometersPerHourArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "inKilometersPerHour"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Speed" ] "Speed" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilometersPerHourArg ]
    , feetPerSecond =
        \feetPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "feetPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Speed" ] "Speed" [])
                             )
                     }
                )
                [ feetPerSecondArg ]
    , inFeetPerSecond =
        \inFeetPerSecondArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "inFeetPerSecond"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Speed" ] "Speed" [] ]
                                  Type.float
                             )
                     }
                )
                [ inFeetPerSecondArg ]
    , milesPerHour =
        \milesPerHourArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "milesPerHour"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Speed" ] "Speed" [])
                             )
                     }
                )
                [ milesPerHourArg ]
    , inMilesPerHour =
        \inMilesPerHourArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Speed" ]
                     , name = "inMilesPerHour"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Speed" ] "Speed" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMilesPerHourArg ]
    }


values_ :
    { metersPerSecond : Elm.Expression
    , inMetersPerSecond : Elm.Expression
    , kilometersPerHour : Elm.Expression
    , inKilometersPerHour : Elm.Expression
    , feetPerSecond : Elm.Expression
    , inFeetPerSecond : Elm.Expression
    , milesPerHour : Elm.Expression
    , inMilesPerHour : Elm.Expression
    }
values_ =
    { metersPerSecond =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "metersPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Speed" ] "Speed" [])
                    )
            }
    , inMetersPerSecond =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "inMetersPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Speed" ] "Speed" [] ]
                         Type.float
                    )
            }
    , kilometersPerHour =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "kilometersPerHour"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Speed" ] "Speed" [])
                    )
            }
    , inKilometersPerHour =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "inKilometersPerHour"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Speed" ] "Speed" [] ]
                         Type.float
                    )
            }
    , feetPerSecond =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "feetPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Speed" ] "Speed" [])
                    )
            }
    , inFeetPerSecond =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "inFeetPerSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Speed" ] "Speed" [] ]
                         Type.float
                    )
            }
    , milesPerHour =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "milesPerHour"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Speed" ] "Speed" [])
                    )
            }
    , inMilesPerHour =
        Elm.value
            { importFrom = [ "Speed" ]
            , name = "inMilesPerHour"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Speed" ] "Speed" [] ]
                         Type.float
                    )
            }
    }