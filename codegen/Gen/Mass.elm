module Gen.Mass exposing (annotation_, call_, gram, grams, inGrams, inKilograms, inLongTons, inMetricTons, inOunces, inPounds, inShortTons, kilogram, kilograms, longTon, longTons, metricTon, metricTons, moduleName_, ounce, ounces, pound, pounds, shortTon, shortTons, values_)

{-| 
@docs moduleName_, kilograms, inKilograms, grams, inGrams, metricTons, inMetricTons, pounds, inPounds, ounces, inOunces, longTons, inLongTons, shortTons, inShortTons, kilogram, gram, metricTon, pound, ounce, longTon, shortTon, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Mass" ]


{-| Construct a mass from a number of kilograms.

kilograms: Float -> Mass.Mass
-}
kilograms : Float -> Elm.Expression
kilograms kilogramsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "kilograms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Mass" ] "Mass" [])
                     )
             }
        )
        [ Elm.float kilogramsArg ]


{-| Convert a mass to a number of kilograms.

inKilograms: Mass.Mass -> Float
-}
inKilograms : Elm.Expression -> Elm.Expression
inKilograms inKilogramsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "inKilograms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Mass" ] "Mass" [] ]
                          Type.float
                     )
             }
        )
        [ inKilogramsArg ]


{-| Construct a mass from a number of grams.

grams: Float -> Mass.Mass
-}
grams : Float -> Elm.Expression
grams gramsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "grams"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Mass" ] "Mass" [])
                     )
             }
        )
        [ Elm.float gramsArg ]


{-| Convert a mass to a number of grams.

inGrams: Mass.Mass -> Float
-}
inGrams : Elm.Expression -> Elm.Expression
inGrams inGramsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "inGrams"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Mass" ] "Mass" [] ]
                          Type.float
                     )
             }
        )
        [ inGramsArg ]


{-| Construct a mass from a number of [metric tons][1].

    Mass.metricTons 1
    --> Mass.kilograms 1000

[1]: https://en.wikipedia.org/wiki/Tonne

metricTons: Float -> Mass.Mass
-}
metricTons : Float -> Elm.Expression
metricTons metricTonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "metricTons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Mass" ] "Mass" [])
                     )
             }
        )
        [ Elm.float metricTonsArg ]


{-| Convert a mass to a number of metric tons.

inMetricTons: Mass.Mass -> Float
-}
inMetricTons : Elm.Expression -> Elm.Expression
inMetricTons inMetricTonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "inMetricTons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Mass" ] "Mass" [] ]
                          Type.float
                     )
             }
        )
        [ inMetricTonsArg ]


{-| Construct a mass from a number of pounds.

pounds: Float -> Mass.Mass
-}
pounds : Float -> Elm.Expression
pounds poundsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "pounds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Mass" ] "Mass" [])
                     )
             }
        )
        [ Elm.float poundsArg ]


{-| Convert a mass to a number of pounds.

inPounds: Mass.Mass -> Float
-}
inPounds : Elm.Expression -> Elm.Expression
inPounds inPoundsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "inPounds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Mass" ] "Mass" [] ]
                          Type.float
                     )
             }
        )
        [ inPoundsArg ]


{-| Construct a mass from a number of ounces.

ounces: Float -> Mass.Mass
-}
ounces : Float -> Elm.Expression
ounces ouncesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "ounces"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Mass" ] "Mass" [])
                     )
             }
        )
        [ Elm.float ouncesArg ]


{-| Convert a mass to a number of ounces.

    Mass.pounds 1 |> Mass.inOunces
    --> 16

inOunces: Mass.Mass -> Float
-}
inOunces : Elm.Expression -> Elm.Expression
inOunces inOuncesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "inOunces"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Mass" ] "Mass" [] ]
                          Type.float
                     )
             }
        )
        [ inOuncesArg ]


{-| Construct a mass from a number of [long tons][1]. This is the 'ton' commonly
used in the United Kingdom and British Commonwealth.

    Mass.longTons 1
    --> Mass.pounds 2240

[1]: https://en.wikipedia.org/wiki/Long_ton

longTons: Float -> Mass.Mass
-}
longTons : Float -> Elm.Expression
longTons longTonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "longTons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Mass" ] "Mass" [])
                     )
             }
        )
        [ Elm.float longTonsArg ]


{-| Convert a mass to a number of long tons.

inLongTons: Mass.Mass -> Float
-}
inLongTons : Elm.Expression -> Elm.Expression
inLongTons inLongTonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "inLongTons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Mass" ] "Mass" [] ]
                          Type.float
                     )
             }
        )
        [ inLongTonsArg ]


{-| Construct a mass from a number of [short tons][1]. This is the 'ton'
commonly used in the United States.

    Mass.shortTons 1
    --> Mass.pounds 2000

[1]: https://en.wikipedia.org/wiki/Short_ton

shortTons: Float -> Mass.Mass
-}
shortTons : Float -> Elm.Expression
shortTons shortTonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "shortTons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Mass" ] "Mass" [])
                     )
             }
        )
        [ Elm.float shortTonsArg ]


{-| Convert a mass to a number of short tons.

inShortTons: Mass.Mass -> Float
-}
inShortTons : Elm.Expression -> Elm.Expression
inShortTons inShortTonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Mass" ]
             , name = "inShortTons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Mass" ] "Mass" [] ]
                          Type.float
                     )
             }
        )
        [ inShortTonsArg ]


{-| kilogram: Mass.Mass -}
kilogram : Elm.Expression
kilogram =
    Elm.value
        { importFrom = [ "Mass" ]
        , name = "kilogram"
        , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
        }


{-| gram: Mass.Mass -}
gram : Elm.Expression
gram =
    Elm.value
        { importFrom = [ "Mass" ]
        , name = "gram"
        , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
        }


{-| metricTon: Mass.Mass -}
metricTon : Elm.Expression
metricTon =
    Elm.value
        { importFrom = [ "Mass" ]
        , name = "metricTon"
        , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
        }


{-| pound: Mass.Mass -}
pound : Elm.Expression
pound =
    Elm.value
        { importFrom = [ "Mass" ]
        , name = "pound"
        , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
        }


{-| ounce: Mass.Mass -}
ounce : Elm.Expression
ounce =
    Elm.value
        { importFrom = [ "Mass" ]
        , name = "ounce"
        , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
        }


{-| longTon: Mass.Mass -}
longTon : Elm.Expression
longTon =
    Elm.value
        { importFrom = [ "Mass" ]
        , name = "longTon"
        , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
        }


{-| shortTon: Mass.Mass -}
shortTon : Elm.Expression
shortTon =
    Elm.value
        { importFrom = [ "Mass" ]
        , name = "shortTon"
        , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
        }


annotation_ : { mass : Type.Annotation, kilograms : Type.Annotation }
annotation_ =
    { mass =
        Type.alias
            moduleName_
            "Mass"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Mass" ] "Kilograms" [] ]
            )
    , kilograms = Type.namedWith [ "Mass" ] "Kilograms" []
    }


call_ :
    { kilograms : Elm.Expression -> Elm.Expression
    , inKilograms : Elm.Expression -> Elm.Expression
    , grams : Elm.Expression -> Elm.Expression
    , inGrams : Elm.Expression -> Elm.Expression
    , metricTons : Elm.Expression -> Elm.Expression
    , inMetricTons : Elm.Expression -> Elm.Expression
    , pounds : Elm.Expression -> Elm.Expression
    , inPounds : Elm.Expression -> Elm.Expression
    , ounces : Elm.Expression -> Elm.Expression
    , inOunces : Elm.Expression -> Elm.Expression
    , longTons : Elm.Expression -> Elm.Expression
    , inLongTons : Elm.Expression -> Elm.Expression
    , shortTons : Elm.Expression -> Elm.Expression
    , inShortTons : Elm.Expression -> Elm.Expression
    }
call_ =
    { kilograms =
        \kilogramsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "kilograms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Mass" ] "Mass" [])
                             )
                     }
                )
                [ kilogramsArg ]
    , inKilograms =
        \inKilogramsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "inKilograms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Mass" ] "Mass" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilogramsArg ]
    , grams =
        \gramsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "grams"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Mass" ] "Mass" [])
                             )
                     }
                )
                [ gramsArg ]
    , inGrams =
        \inGramsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "inGrams"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Mass" ] "Mass" [] ]
                                  Type.float
                             )
                     }
                )
                [ inGramsArg ]
    , metricTons =
        \metricTonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "metricTons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Mass" ] "Mass" [])
                             )
                     }
                )
                [ metricTonsArg ]
    , inMetricTons =
        \inMetricTonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "inMetricTons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Mass" ] "Mass" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMetricTonsArg ]
    , pounds =
        \poundsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "pounds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Mass" ] "Mass" [])
                             )
                     }
                )
                [ poundsArg ]
    , inPounds =
        \inPoundsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "inPounds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Mass" ] "Mass" [] ]
                                  Type.float
                             )
                     }
                )
                [ inPoundsArg ]
    , ounces =
        \ouncesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "ounces"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Mass" ] "Mass" [])
                             )
                     }
                )
                [ ouncesArg ]
    , inOunces =
        \inOuncesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "inOunces"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Mass" ] "Mass" [] ]
                                  Type.float
                             )
                     }
                )
                [ inOuncesArg ]
    , longTons =
        \longTonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "longTons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Mass" ] "Mass" [])
                             )
                     }
                )
                [ longTonsArg ]
    , inLongTons =
        \inLongTonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "inLongTons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Mass" ] "Mass" [] ]
                                  Type.float
                             )
                     }
                )
                [ inLongTonsArg ]
    , shortTons =
        \shortTonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "shortTons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Mass" ] "Mass" [])
                             )
                     }
                )
                [ shortTonsArg ]
    , inShortTons =
        \inShortTonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Mass" ]
                     , name = "inShortTons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Mass" ] "Mass" [] ]
                                  Type.float
                             )
                     }
                )
                [ inShortTonsArg ]
    }


values_ :
    { kilograms : Elm.Expression
    , inKilograms : Elm.Expression
    , grams : Elm.Expression
    , inGrams : Elm.Expression
    , metricTons : Elm.Expression
    , inMetricTons : Elm.Expression
    , pounds : Elm.Expression
    , inPounds : Elm.Expression
    , ounces : Elm.Expression
    , inOunces : Elm.Expression
    , longTons : Elm.Expression
    , inLongTons : Elm.Expression
    , shortTons : Elm.Expression
    , inShortTons : Elm.Expression
    , kilogram : Elm.Expression
    , gram : Elm.Expression
    , metricTon : Elm.Expression
    , pound : Elm.Expression
    , ounce : Elm.Expression
    , longTon : Elm.Expression
    , shortTon : Elm.Expression
    }
values_ =
    { kilograms =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "kilograms"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Mass" ] "Mass" [])
                    )
            }
    , inKilograms =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "inKilograms"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Mass" ] "Mass" [] ]
                         Type.float
                    )
            }
    , grams =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "grams"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Mass" ] "Mass" [])
                    )
            }
    , inGrams =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "inGrams"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Mass" ] "Mass" [] ]
                         Type.float
                    )
            }
    , metricTons =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "metricTons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Mass" ] "Mass" [])
                    )
            }
    , inMetricTons =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "inMetricTons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Mass" ] "Mass" [] ]
                         Type.float
                    )
            }
    , pounds =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "pounds"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Mass" ] "Mass" [])
                    )
            }
    , inPounds =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "inPounds"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Mass" ] "Mass" [] ]
                         Type.float
                    )
            }
    , ounces =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "ounces"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Mass" ] "Mass" [])
                    )
            }
    , inOunces =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "inOunces"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Mass" ] "Mass" [] ]
                         Type.float
                    )
            }
    , longTons =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "longTons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Mass" ] "Mass" [])
                    )
            }
    , inLongTons =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "inLongTons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Mass" ] "Mass" [] ]
                         Type.float
                    )
            }
    , shortTons =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "shortTons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Mass" ] "Mass" [])
                    )
            }
    , inShortTons =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "inShortTons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Mass" ] "Mass" [] ]
                         Type.float
                    )
            }
    , kilogram =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "kilogram"
            , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
            }
    , gram =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "gram"
            , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
            }
    , metricTon =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "metricTon"
            , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
            }
    , pound =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "pound"
            , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
            }
    , ounce =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "ounce"
            , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
            }
    , longTon =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "longTon"
            , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
            }
    , shortTon =
        Elm.value
            { importFrom = [ "Mass" ]
            , name = "shortTon"
            , annotation = Just (Type.namedWith [ "Mass" ] "Mass" [])
            }
    }