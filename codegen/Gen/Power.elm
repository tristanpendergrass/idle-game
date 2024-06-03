module Gen.Power exposing (annotation_, call_, electricalHorsepower, inElectricalHorsepower, inKilowatts, inMechanicalHorsepower, inMegawatts, inMetricHorsepower, inWatts, kilowatts, mechanicalHorsepower, megawatts, metricHorsepower, moduleName_, values_, watts)

{-| 
@docs moduleName_, watts, inWatts, kilowatts, inKilowatts, megawatts, inMegawatts, metricHorsepower, inMetricHorsepower, mechanicalHorsepower, inMechanicalHorsepower, electricalHorsepower, inElectricalHorsepower, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Power" ]


{-| Construct a `Power` value from a number of watts.

watts: Float -> Power.Power
-}
watts : Float -> Elm.Expression
watts wattsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "watts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Power" ] "Power" [])
                     )
             }
        )
        [ Elm.float wattsArg ]


{-| Convert a `Power` value to a number of watts.

inWatts: Power.Power -> Float
-}
inWatts : Elm.Expression -> Elm.Expression
inWatts inWattsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "inWatts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Power" ] "Power" [] ]
                          Type.float
                     )
             }
        )
        [ inWattsArg ]


{-| Construct a `Power` value from a number of kilowatts.

kilowatts: Float -> Power.Power
-}
kilowatts : Float -> Elm.Expression
kilowatts kilowattsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "kilowatts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Power" ] "Power" [])
                     )
             }
        )
        [ Elm.float kilowattsArg ]


{-| Convert a `Power` value to a number of kilowatts.

inKilowatts: Power.Power -> Float
-}
inKilowatts : Elm.Expression -> Elm.Expression
inKilowatts inKilowattsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "inKilowatts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Power" ] "Power" [] ]
                          Type.float
                     )
             }
        )
        [ inKilowattsArg ]


{-| Construct a `Power` value from a number of megawatts.

megawatts: Float -> Power.Power
-}
megawatts : Float -> Elm.Expression
megawatts megawattsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "megawatts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Power" ] "Power" [])
                     )
             }
        )
        [ Elm.float megawattsArg ]


{-| Convert a `Power` value to a number of megawatts.

inMegawatts: Power.Power -> Float
-}
inMegawatts : Elm.Expression -> Elm.Expression
inMegawatts inMegawattsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "inMegawatts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Power" ] "Power" [] ]
                          Type.float
                     )
             }
        )
        [ inMegawattsArg ]


{-| Construct a `Power` value from an number of [metric horsepower][1].

    Power.metricHorsepower 1
    --> Power.watts 735.49875

[1]: https://en.wikipedia.org/wiki/Horsepower#Metric_horsepower

metricHorsepower: Float -> Power.Power
-}
metricHorsepower : Float -> Elm.Expression
metricHorsepower metricHorsepowerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "metricHorsepower"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Power" ] "Power" [])
                     )
             }
        )
        [ Elm.float metricHorsepowerArg ]


{-| Convert a `Power` value to a number of metric horsepower.

inMetricHorsepower: Power.Power -> Float
-}
inMetricHorsepower : Elm.Expression -> Elm.Expression
inMetricHorsepower inMetricHorsepowerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "inMetricHorsepower"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Power" ] "Power" [] ]
                          Type.float
                     )
             }
        )
        [ inMetricHorsepowerArg ]


{-| Construct a `Power` value from an number of [mechanical horsepower][1].

    Power.mechanicalHorsepower 1
    --> Power.watts 745.6998715822702

[1]: https://en.wikipedia.org/wiki/Horsepower#Mechanical_horsepower

mechanicalHorsepower: Float -> Power.Power
-}
mechanicalHorsepower : Float -> Elm.Expression
mechanicalHorsepower mechanicalHorsepowerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "mechanicalHorsepower"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Power" ] "Power" [])
                     )
             }
        )
        [ Elm.float mechanicalHorsepowerArg ]


{-| Convert a `Power` value to a number of mechanical horsepower.

inMechanicalHorsepower: Power.Power -> Float
-}
inMechanicalHorsepower : Elm.Expression -> Elm.Expression
inMechanicalHorsepower inMechanicalHorsepowerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "inMechanicalHorsepower"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Power" ] "Power" [] ]
                          Type.float
                     )
             }
        )
        [ inMechanicalHorsepowerArg ]


{-| Construct a `Power` value from an number of [electrical horsepower][1].

    Power.electricalHorsepower 1
    --> Power.watts 746

[1]: https://en.wikipedia.org/wiki/Horsepower#Electrical_horsepower

electricalHorsepower: Float -> Power.Power
-}
electricalHorsepower : Float -> Elm.Expression
electricalHorsepower electricalHorsepowerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "electricalHorsepower"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Power" ] "Power" [])
                     )
             }
        )
        [ Elm.float electricalHorsepowerArg ]


{-| Convert a `Power` value to a number of electrical horsepower.

inElectricalHorsepower: Power.Power -> Float
-}
inElectricalHorsepower : Elm.Expression -> Elm.Expression
inElectricalHorsepower inElectricalHorsepowerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Power" ]
             , name = "inElectricalHorsepower"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Power" ] "Power" [] ]
                          Type.float
                     )
             }
        )
        [ inElectricalHorsepowerArg ]


annotation_ : { power : Type.Annotation, watts : Type.Annotation }
annotation_ =
    { power =
        Type.alias
            moduleName_
            "Power"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Power" ] "Watts" [] ]
            )
    , watts =
        Type.alias
            moduleName_
            "Watts"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Energy" ] "Joules" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    }


call_ :
    { watts : Elm.Expression -> Elm.Expression
    , inWatts : Elm.Expression -> Elm.Expression
    , kilowatts : Elm.Expression -> Elm.Expression
    , inKilowatts : Elm.Expression -> Elm.Expression
    , megawatts : Elm.Expression -> Elm.Expression
    , inMegawatts : Elm.Expression -> Elm.Expression
    , metricHorsepower : Elm.Expression -> Elm.Expression
    , inMetricHorsepower : Elm.Expression -> Elm.Expression
    , mechanicalHorsepower : Elm.Expression -> Elm.Expression
    , inMechanicalHorsepower : Elm.Expression -> Elm.Expression
    , electricalHorsepower : Elm.Expression -> Elm.Expression
    , inElectricalHorsepower : Elm.Expression -> Elm.Expression
    }
call_ =
    { watts =
        \wattsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "watts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Power" ] "Power" [])
                             )
                     }
                )
                [ wattsArg ]
    , inWatts =
        \inWattsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "inWatts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Power" ] "Power" [] ]
                                  Type.float
                             )
                     }
                )
                [ inWattsArg ]
    , kilowatts =
        \kilowattsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "kilowatts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Power" ] "Power" [])
                             )
                     }
                )
                [ kilowattsArg ]
    , inKilowatts =
        \inKilowattsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "inKilowatts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Power" ] "Power" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilowattsArg ]
    , megawatts =
        \megawattsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "megawatts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Power" ] "Power" [])
                             )
                     }
                )
                [ megawattsArg ]
    , inMegawatts =
        \inMegawattsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "inMegawatts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Power" ] "Power" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMegawattsArg ]
    , metricHorsepower =
        \metricHorsepowerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "metricHorsepower"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Power" ] "Power" [])
                             )
                     }
                )
                [ metricHorsepowerArg ]
    , inMetricHorsepower =
        \inMetricHorsepowerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "inMetricHorsepower"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Power" ] "Power" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMetricHorsepowerArg ]
    , mechanicalHorsepower =
        \mechanicalHorsepowerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "mechanicalHorsepower"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Power" ] "Power" [])
                             )
                     }
                )
                [ mechanicalHorsepowerArg ]
    , inMechanicalHorsepower =
        \inMechanicalHorsepowerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "inMechanicalHorsepower"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Power" ] "Power" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMechanicalHorsepowerArg ]
    , electricalHorsepower =
        \electricalHorsepowerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "electricalHorsepower"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Power" ] "Power" [])
                             )
                     }
                )
                [ electricalHorsepowerArg ]
    , inElectricalHorsepower =
        \inElectricalHorsepowerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Power" ]
                     , name = "inElectricalHorsepower"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Power" ] "Power" [] ]
                                  Type.float
                             )
                     }
                )
                [ inElectricalHorsepowerArg ]
    }


values_ :
    { watts : Elm.Expression
    , inWatts : Elm.Expression
    , kilowatts : Elm.Expression
    , inKilowatts : Elm.Expression
    , megawatts : Elm.Expression
    , inMegawatts : Elm.Expression
    , metricHorsepower : Elm.Expression
    , inMetricHorsepower : Elm.Expression
    , mechanicalHorsepower : Elm.Expression
    , inMechanicalHorsepower : Elm.Expression
    , electricalHorsepower : Elm.Expression
    , inElectricalHorsepower : Elm.Expression
    }
values_ =
    { watts =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "watts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Power" ] "Power" [])
                    )
            }
    , inWatts =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "inWatts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Power" ] "Power" [] ]
                         Type.float
                    )
            }
    , kilowatts =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "kilowatts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Power" ] "Power" [])
                    )
            }
    , inKilowatts =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "inKilowatts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Power" ] "Power" [] ]
                         Type.float
                    )
            }
    , megawatts =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "megawatts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Power" ] "Power" [])
                    )
            }
    , inMegawatts =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "inMegawatts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Power" ] "Power" [] ]
                         Type.float
                    )
            }
    , metricHorsepower =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "metricHorsepower"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Power" ] "Power" [])
                    )
            }
    , inMetricHorsepower =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "inMetricHorsepower"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Power" ] "Power" [] ]
                         Type.float
                    )
            }
    , mechanicalHorsepower =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "mechanicalHorsepower"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Power" ] "Power" [])
                    )
            }
    , inMechanicalHorsepower =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "inMechanicalHorsepower"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Power" ] "Power" [] ]
                         Type.float
                    )
            }
    , electricalHorsepower =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "electricalHorsepower"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Power" ] "Power" [])
                    )
            }
    , inElectricalHorsepower =
        Elm.value
            { importFrom = [ "Power" ]
            , name = "inElectricalHorsepower"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Power" ] "Power" [] ]
                         Type.float
                    )
            }
    }