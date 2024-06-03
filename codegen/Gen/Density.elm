module Gen.Density exposing (annotation_, call_, gramsPerCubicCentimeter, inGramsPerCubicCentimeter, inKilogramsPerCubicMeter, inPoundsPerCubicFoot, inPoundsPerCubicInch, kilogramsPerCubicMeter, moduleName_, poundsPerCubicFoot, poundsPerCubicInch, values_)

{-| 
@docs moduleName_, kilogramsPerCubicMeter, inKilogramsPerCubicMeter, gramsPerCubicCentimeter, inGramsPerCubicCentimeter, poundsPerCubicInch, inPoundsPerCubicInch, poundsPerCubicFoot, inPoundsPerCubicFoot, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Density" ]


{-| Construct a density from a number of kilograms per cubic meter.

kilogramsPerCubicMeter: Float -> Density.Density
-}
kilogramsPerCubicMeter : Float -> Elm.Expression
kilogramsPerCubicMeter kilogramsPerCubicMeterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "kilogramsPerCubicMeter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Density" ] "Density" [])
                     )
             }
        )
        [ Elm.float kilogramsPerCubicMeterArg ]


{-| Convert a density to a number of kilograms per cubic meter.

inKilogramsPerCubicMeter: Density.Density -> Float
-}
inKilogramsPerCubicMeter : Elm.Expression -> Elm.Expression
inKilogramsPerCubicMeter inKilogramsPerCubicMeterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "inKilogramsPerCubicMeter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Density" ] "Density" [] ]
                          Type.float
                     )
             }
        )
        [ inKilogramsPerCubicMeterArg ]


{-| Construct a density from a number of grams per cubic centimeter.

gramsPerCubicCentimeter: Float -> Density.Density
-}
gramsPerCubicCentimeter : Float -> Elm.Expression
gramsPerCubicCentimeter gramsPerCubicCentimeterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "gramsPerCubicCentimeter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Density" ] "Density" [])
                     )
             }
        )
        [ Elm.float gramsPerCubicCentimeterArg ]


{-| Convert a density to a number of grams per cubic centimeter.

inGramsPerCubicCentimeter: Density.Density -> Float
-}
inGramsPerCubicCentimeter : Elm.Expression -> Elm.Expression
inGramsPerCubicCentimeter inGramsPerCubicCentimeterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "inGramsPerCubicCentimeter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Density" ] "Density" [] ]
                          Type.float
                     )
             }
        )
        [ inGramsPerCubicCentimeterArg ]


{-| Construct a density from a number of pounds per cubic inch.

poundsPerCubicInch: Float -> Density.Density
-}
poundsPerCubicInch : Float -> Elm.Expression
poundsPerCubicInch poundsPerCubicInchArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "poundsPerCubicInch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Density" ] "Density" [])
                     )
             }
        )
        [ Elm.float poundsPerCubicInchArg ]


{-| Convert a density to a number of pounds per cubic inch.

inPoundsPerCubicInch: Density.Density -> Float
-}
inPoundsPerCubicInch : Elm.Expression -> Elm.Expression
inPoundsPerCubicInch inPoundsPerCubicInchArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "inPoundsPerCubicInch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Density" ] "Density" [] ]
                          Type.float
                     )
             }
        )
        [ inPoundsPerCubicInchArg ]


{-| Construct a density from a number of pounds per cubic foot.

poundsPerCubicFoot: Float -> Density.Density
-}
poundsPerCubicFoot : Float -> Elm.Expression
poundsPerCubicFoot poundsPerCubicFootArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "poundsPerCubicFoot"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Density" ] "Density" [])
                     )
             }
        )
        [ Elm.float poundsPerCubicFootArg ]


{-| Convert a density to a number of pounds per cubic foot.

inPoundsPerCubicFoot: Density.Density -> Float
-}
inPoundsPerCubicFoot : Elm.Expression -> Elm.Expression
inPoundsPerCubicFoot inPoundsPerCubicFootArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Density" ]
             , name = "inPoundsPerCubicFoot"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Density" ] "Density" [] ]
                          Type.float
                     )
             }
        )
        [ inPoundsPerCubicFootArg ]


annotation_ :
    { density : Type.Annotation, kilogramsPerCubicMeter : Type.Annotation }
annotation_ =
    { density =
        Type.alias
            moduleName_
            "Density"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith [ "Density" ] "KilogramsPerCubicMeter" []
                 ]
            )
    , kilogramsPerCubicMeter =
        Type.alias
            moduleName_
            "KilogramsPerCubicMeter"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Mass" ] "Kilograms" []
                 , Type.namedWith [ "Volume" ] "CubicMeters" []
                 ]
            )
    }


call_ :
    { kilogramsPerCubicMeter : Elm.Expression -> Elm.Expression
    , inKilogramsPerCubicMeter : Elm.Expression -> Elm.Expression
    , gramsPerCubicCentimeter : Elm.Expression -> Elm.Expression
    , inGramsPerCubicCentimeter : Elm.Expression -> Elm.Expression
    , poundsPerCubicInch : Elm.Expression -> Elm.Expression
    , inPoundsPerCubicInch : Elm.Expression -> Elm.Expression
    , poundsPerCubicFoot : Elm.Expression -> Elm.Expression
    , inPoundsPerCubicFoot : Elm.Expression -> Elm.Expression
    }
call_ =
    { kilogramsPerCubicMeter =
        \kilogramsPerCubicMeterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "kilogramsPerCubicMeter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Density" ] "Density" [])
                             )
                     }
                )
                [ kilogramsPerCubicMeterArg ]
    , inKilogramsPerCubicMeter =
        \inKilogramsPerCubicMeterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "inKilogramsPerCubicMeter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Density" ] "Density" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilogramsPerCubicMeterArg ]
    , gramsPerCubicCentimeter =
        \gramsPerCubicCentimeterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "gramsPerCubicCentimeter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Density" ] "Density" [])
                             )
                     }
                )
                [ gramsPerCubicCentimeterArg ]
    , inGramsPerCubicCentimeter =
        \inGramsPerCubicCentimeterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "inGramsPerCubicCentimeter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Density" ] "Density" [] ]
                                  Type.float
                             )
                     }
                )
                [ inGramsPerCubicCentimeterArg ]
    , poundsPerCubicInch =
        \poundsPerCubicInchArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "poundsPerCubicInch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Density" ] "Density" [])
                             )
                     }
                )
                [ poundsPerCubicInchArg ]
    , inPoundsPerCubicInch =
        \inPoundsPerCubicInchArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "inPoundsPerCubicInch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Density" ] "Density" [] ]
                                  Type.float
                             )
                     }
                )
                [ inPoundsPerCubicInchArg ]
    , poundsPerCubicFoot =
        \poundsPerCubicFootArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "poundsPerCubicFoot"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Density" ] "Density" [])
                             )
                     }
                )
                [ poundsPerCubicFootArg ]
    , inPoundsPerCubicFoot =
        \inPoundsPerCubicFootArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Density" ]
                     , name = "inPoundsPerCubicFoot"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Density" ] "Density" [] ]
                                  Type.float
                             )
                     }
                )
                [ inPoundsPerCubicFootArg ]
    }


values_ :
    { kilogramsPerCubicMeter : Elm.Expression
    , inKilogramsPerCubicMeter : Elm.Expression
    , gramsPerCubicCentimeter : Elm.Expression
    , inGramsPerCubicCentimeter : Elm.Expression
    , poundsPerCubicInch : Elm.Expression
    , inPoundsPerCubicInch : Elm.Expression
    , poundsPerCubicFoot : Elm.Expression
    , inPoundsPerCubicFoot : Elm.Expression
    }
values_ =
    { kilogramsPerCubicMeter =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "kilogramsPerCubicMeter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Density" ] "Density" [])
                    )
            }
    , inKilogramsPerCubicMeter =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "inKilogramsPerCubicMeter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Density" ] "Density" [] ]
                         Type.float
                    )
            }
    , gramsPerCubicCentimeter =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "gramsPerCubicCentimeter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Density" ] "Density" [])
                    )
            }
    , inGramsPerCubicCentimeter =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "inGramsPerCubicCentimeter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Density" ] "Density" [] ]
                         Type.float
                    )
            }
    , poundsPerCubicInch =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "poundsPerCubicInch"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Density" ] "Density" [])
                    )
            }
    , inPoundsPerCubicInch =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "inPoundsPerCubicInch"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Density" ] "Density" [] ]
                         Type.float
                    )
            }
    , poundsPerCubicFoot =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "poundsPerCubicFoot"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Density" ] "Density" [])
                    )
            }
    , inPoundsPerCubicFoot =
        Elm.value
            { importFrom = [ "Density" ]
            , name = "inPoundsPerCubicFoot"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Density" ] "Density" [] ]
                         Type.float
                    )
            }
    }