module Gen.Volume exposing (annotation_, call_, cubicCentimeter, cubicCentimeters, cubicFeet, cubicFoot, cubicInch, cubicInches, cubicMeter, cubicMeters, cubicYard, cubicYards, imperialFluidOunce, imperialFluidOunces, imperialGallon, imperialGallons, imperialPint, imperialPints, imperialQuart, imperialQuarts, inCubicCentimeters, inCubicFeet, inCubicInches, inCubicMeters, inCubicYards, inImperialFluidOunces, inImperialGallons, inImperialPints, inImperialQuarts, inLiters, inMilliliters, inUsDryGallons, inUsDryPints, inUsDryQuarts, inUsFluidOunces, inUsLiquidGallons, inUsLiquidPints, inUsLiquidQuarts, liter, liters, milliliter, milliliters, moduleName_, usDryGallon, usDryGallons, usDryPint, usDryPints, usDryQuart, usDryQuarts, usFluidOunce, usFluidOunces, usLiquidGallon, usLiquidGallons, usLiquidPint, usLiquidPints, usLiquidQuart, usLiquidQuarts, values_)

{-| 
@docs moduleName_, cubicMeters, inCubicMeters, milliliters, inMilliliters, liters, inLiters, cubicCentimeters, inCubicCentimeters, cubicInches, inCubicInches, cubicFeet, inCubicFeet, cubicYards, inCubicYards, usLiquidGallons, inUsLiquidGallons, usDryGallons, inUsDryGallons, imperialGallons, inImperialGallons, usLiquidQuarts, inUsLiquidQuarts, usDryQuarts, inUsDryQuarts, imperialQuarts, inImperialQuarts, usLiquidPints, inUsLiquidPints, usDryPints, inUsDryPints, imperialPints, inImperialPints, usFluidOunces, inUsFluidOunces, imperialFluidOunces, inImperialFluidOunces, cubicMeter, milliliter, liter, cubicCentimeter, cubicInch, cubicFoot, cubicYard, usLiquidGallon, usDryGallon, imperialGallon, usLiquidQuart, usDryQuart, imperialQuart, usLiquidPint, usDryPint, imperialPint, usFluidOunce, imperialFluidOunce, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Volume" ]


{-| Construct a volume from a number of cubic meters.

cubicMeters: Float -> Volume.Volume
-}
cubicMeters : Float -> Elm.Expression
cubicMeters cubicMetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "cubicMeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float cubicMetersArg ]


{-| Convert a volume to a number of cubic meters.

inCubicMeters: Volume.Volume -> Float
-}
inCubicMeters : Elm.Expression -> Elm.Expression
inCubicMeters inCubicMetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inCubicMeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inCubicMetersArg ]


{-| Construct a volume from a number of milliliters.

milliliters: Float -> Volume.Volume
-}
milliliters : Float -> Elm.Expression
milliliters millilitersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "milliliters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float millilitersArg ]


{-| Convert a volume to a number of milliliters.

inMilliliters: Volume.Volume -> Float
-}
inMilliliters : Elm.Expression -> Elm.Expression
inMilliliters inMillilitersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inMilliliters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inMillilitersArg ]


{-| Construct a volume from a number of liters.

liters: Float -> Volume.Volume
-}
liters : Float -> Elm.Expression
liters litersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "liters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float litersArg ]


{-| Convert a volume to a number of liters.

inLiters: Volume.Volume -> Float
-}
inLiters : Elm.Expression -> Elm.Expression
inLiters inLitersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inLiters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inLitersArg ]


{-| Construct a volume from a number of cubic centimeters.
Alias for `milliliters`.

cubicCentimeters: Float -> Volume.Volume
-}
cubicCentimeters : Float -> Elm.Expression
cubicCentimeters cubicCentimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "cubicCentimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float cubicCentimetersArg ]


{-| Convert a volume to a number of cubic centimeters.
Alias for `inMilliliters`.

inCubicCentimeters: Volume.Volume -> Float
-}
inCubicCentimeters : Elm.Expression -> Elm.Expression
inCubicCentimeters inCubicCentimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inCubicCentimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inCubicCentimetersArg ]


{-| Construct a volume from a number of cubic inches.

cubicInches: Float -> Volume.Volume
-}
cubicInches : Float -> Elm.Expression
cubicInches cubicInchesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "cubicInches"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float cubicInchesArg ]


{-| Convert a volume to a number of cubic inches.

inCubicInches: Volume.Volume -> Float
-}
inCubicInches : Elm.Expression -> Elm.Expression
inCubicInches inCubicInchesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inCubicInches"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inCubicInchesArg ]


{-| Construct a volume from a number of cubic feet.

cubicFeet: Float -> Volume.Volume
-}
cubicFeet : Float -> Elm.Expression
cubicFeet cubicFeetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "cubicFeet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float cubicFeetArg ]


{-| Convert a volume to a number of cubic feet.

inCubicFeet: Volume.Volume -> Float
-}
inCubicFeet : Elm.Expression -> Elm.Expression
inCubicFeet inCubicFeetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inCubicFeet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inCubicFeetArg ]


{-| Construct a volume from a number of cubic yards.

cubicYards: Float -> Volume.Volume
-}
cubicYards : Float -> Elm.Expression
cubicYards cubicYardsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "cubicYards"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float cubicYardsArg ]


{-| Convert a volume to a number of cubic yards.

inCubicYards: Volume.Volume -> Float
-}
inCubicYards : Elm.Expression -> Elm.Expression
inCubicYards inCubicYardsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inCubicYards"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inCubicYardsArg ]


{-| Construct a volume from a number of U.S. liquid gallon.

usLiquidGallons: Float -> Volume.Volume
-}
usLiquidGallons : Float -> Elm.Expression
usLiquidGallons usLiquidGallonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "usLiquidGallons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float usLiquidGallonsArg ]


{-| Convert a volume to a number of U.S. liquid gallons.

inUsLiquidGallons: Volume.Volume -> Float
-}
inUsLiquidGallons : Elm.Expression -> Elm.Expression
inUsLiquidGallons inUsLiquidGallonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inUsLiquidGallons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inUsLiquidGallonsArg ]


{-| Construct a volume from a number of U.S. dry gallons.

usDryGallons: Float -> Volume.Volume
-}
usDryGallons : Float -> Elm.Expression
usDryGallons usDryGallonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "usDryGallons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float usDryGallonsArg ]


{-| Convert a volume to a number of U.S. dry gallons.

inUsDryGallons: Volume.Volume -> Float
-}
inUsDryGallons : Elm.Expression -> Elm.Expression
inUsDryGallons inUsDryGallonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inUsDryGallons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inUsDryGallonsArg ]


{-| Construct a volume from a number of imperial gallons.

imperialGallons: Float -> Volume.Volume
-}
imperialGallons : Float -> Elm.Expression
imperialGallons imperialGallonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "imperialGallons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float imperialGallonsArg ]


{-| Convert a volume to a number of imperial gallons.

inImperialGallons: Volume.Volume -> Float
-}
inImperialGallons : Elm.Expression -> Elm.Expression
inImperialGallons inImperialGallonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inImperialGallons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inImperialGallonsArg ]


{-| Construct a volume from a number of U.S. liquid quarts.

usLiquidQuarts: Float -> Volume.Volume
-}
usLiquidQuarts : Float -> Elm.Expression
usLiquidQuarts usLiquidQuartsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "usLiquidQuarts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float usLiquidQuartsArg ]


{-| Convert a volume to a number of U.S. liquid quarts.

inUsLiquidQuarts: Volume.Volume -> Float
-}
inUsLiquidQuarts : Elm.Expression -> Elm.Expression
inUsLiquidQuarts inUsLiquidQuartsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inUsLiquidQuarts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inUsLiquidQuartsArg ]


{-| Construct a volume from a number of U.S. dry quarts.

usDryQuarts: Float -> Volume.Volume
-}
usDryQuarts : Float -> Elm.Expression
usDryQuarts usDryQuartsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "usDryQuarts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float usDryQuartsArg ]


{-| Convert a volume to a number of U.S. dry quarts.

inUsDryQuarts: Volume.Volume -> Float
-}
inUsDryQuarts : Elm.Expression -> Elm.Expression
inUsDryQuarts inUsDryQuartsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inUsDryQuarts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inUsDryQuartsArg ]


{-| Construct a volume from a number of imperial quarts.

imperialQuarts: Float -> Volume.Volume
-}
imperialQuarts : Float -> Elm.Expression
imperialQuarts imperialQuartsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "imperialQuarts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float imperialQuartsArg ]


{-| Convert a volume to a number of imperial quarts.

inImperialQuarts: Volume.Volume -> Float
-}
inImperialQuarts : Elm.Expression -> Elm.Expression
inImperialQuarts inImperialQuartsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inImperialQuarts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inImperialQuartsArg ]


{-| Construct a volume from a number of U.S. liquid pints.

usLiquidPints: Float -> Volume.Volume
-}
usLiquidPints : Float -> Elm.Expression
usLiquidPints usLiquidPintsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "usLiquidPints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float usLiquidPintsArg ]


{-| Convert a volume to a number of U.S. liquid pints.

inUsLiquidPints: Volume.Volume -> Float
-}
inUsLiquidPints : Elm.Expression -> Elm.Expression
inUsLiquidPints inUsLiquidPintsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inUsLiquidPints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inUsLiquidPintsArg ]


{-| Construct a volume from a number of U.S. dry pints.

usDryPints: Float -> Volume.Volume
-}
usDryPints : Float -> Elm.Expression
usDryPints usDryPintsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "usDryPints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float usDryPintsArg ]


{-| Convert a volume to a number of U.S. dry pints.

inUsDryPints: Volume.Volume -> Float
-}
inUsDryPints : Elm.Expression -> Elm.Expression
inUsDryPints inUsDryPintsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inUsDryPints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inUsDryPintsArg ]


{-| Construct a volume from a number of imperial pints.

imperialPints: Float -> Volume.Volume
-}
imperialPints : Float -> Elm.Expression
imperialPints imperialPintsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "imperialPints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float imperialPintsArg ]


{-| Convert a volume to a number of imperial pints.

inImperialPints: Volume.Volume -> Float
-}
inImperialPints : Elm.Expression -> Elm.Expression
inImperialPints inImperialPintsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inImperialPints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inImperialPintsArg ]


{-| Construct a volume from a number of U.S. fluid ounces.

usFluidOunces: Float -> Volume.Volume
-}
usFluidOunces : Float -> Elm.Expression
usFluidOunces usFluidOuncesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "usFluidOunces"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float usFluidOuncesArg ]


{-| Convert a volume to a number of U.S. fluid ounces.

inUsFluidOunces: Volume.Volume -> Float
-}
inUsFluidOunces : Elm.Expression -> Elm.Expression
inUsFluidOunces inUsFluidOuncesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inUsFluidOunces"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inUsFluidOuncesArg ]


{-| Construct a volume from a number of imperial fluid ounces.

imperialFluidOunces: Float -> Volume.Volume
-}
imperialFluidOunces : Float -> Elm.Expression
imperialFluidOunces imperialFluidOuncesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "imperialFluidOunces"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Volume" ] "Volume" [])
                     )
             }
        )
        [ Elm.float imperialFluidOuncesArg ]


{-| Convert a volume to a number of imperial fluid ounces.

inImperialFluidOunces: Volume.Volume -> Float
-}
inImperialFluidOunces : Elm.Expression -> Elm.Expression
inImperialFluidOunces inImperialFluidOuncesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Volume" ]
             , name = "inImperialFluidOunces"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Volume" ] "Volume" [] ]
                          Type.float
                     )
             }
        )
        [ inImperialFluidOuncesArg ]


{-| cubicMeter: Volume.Volume -}
cubicMeter : Elm.Expression
cubicMeter =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "cubicMeter"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| milliliter: Volume.Volume -}
milliliter : Elm.Expression
milliliter =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "milliliter"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| liter: Volume.Volume -}
liter : Elm.Expression
liter =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "liter"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| cubicCentimeter: Volume.Volume -}
cubicCentimeter : Elm.Expression
cubicCentimeter =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "cubicCentimeter"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| cubicInch: Volume.Volume -}
cubicInch : Elm.Expression
cubicInch =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "cubicInch"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| cubicFoot: Volume.Volume -}
cubicFoot : Elm.Expression
cubicFoot =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "cubicFoot"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| cubicYard: Volume.Volume -}
cubicYard : Elm.Expression
cubicYard =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "cubicYard"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| usLiquidGallon: Volume.Volume -}
usLiquidGallon : Elm.Expression
usLiquidGallon =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "usLiquidGallon"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| usDryGallon: Volume.Volume -}
usDryGallon : Elm.Expression
usDryGallon =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "usDryGallon"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| imperialGallon: Volume.Volume -}
imperialGallon : Elm.Expression
imperialGallon =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "imperialGallon"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| usLiquidQuart: Volume.Volume -}
usLiquidQuart : Elm.Expression
usLiquidQuart =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "usLiquidQuart"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| usDryQuart: Volume.Volume -}
usDryQuart : Elm.Expression
usDryQuart =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "usDryQuart"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| imperialQuart: Volume.Volume -}
imperialQuart : Elm.Expression
imperialQuart =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "imperialQuart"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| usLiquidPint: Volume.Volume -}
usLiquidPint : Elm.Expression
usLiquidPint =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "usLiquidPint"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| usDryPint: Volume.Volume -}
usDryPint : Elm.Expression
usDryPint =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "usDryPint"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| imperialPint: Volume.Volume -}
imperialPint : Elm.Expression
imperialPint =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "imperialPint"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| usFluidOunce: Volume.Volume -}
usFluidOunce : Elm.Expression
usFluidOunce =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "usFluidOunce"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


{-| imperialFluidOunce: Volume.Volume -}
imperialFluidOunce : Elm.Expression
imperialFluidOunce =
    Elm.value
        { importFrom = [ "Volume" ]
        , name = "imperialFluidOunce"
        , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
        }


annotation_ : { volume : Type.Annotation, cubicMeters : Type.Annotation }
annotation_ =
    { volume =
        Type.alias
            moduleName_
            "Volume"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Volume" ] "CubicMeters" [] ]
            )
    , cubicMeters =
        Type.alias
            moduleName_
            "CubicMeters"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Cubed"
                 [ Type.namedWith [ "Length" ] "Meters" [] ]
            )
    }


call_ :
    { cubicMeters : Elm.Expression -> Elm.Expression
    , inCubicMeters : Elm.Expression -> Elm.Expression
    , milliliters : Elm.Expression -> Elm.Expression
    , inMilliliters : Elm.Expression -> Elm.Expression
    , liters : Elm.Expression -> Elm.Expression
    , inLiters : Elm.Expression -> Elm.Expression
    , cubicCentimeters : Elm.Expression -> Elm.Expression
    , inCubicCentimeters : Elm.Expression -> Elm.Expression
    , cubicInches : Elm.Expression -> Elm.Expression
    , inCubicInches : Elm.Expression -> Elm.Expression
    , cubicFeet : Elm.Expression -> Elm.Expression
    , inCubicFeet : Elm.Expression -> Elm.Expression
    , cubicYards : Elm.Expression -> Elm.Expression
    , inCubicYards : Elm.Expression -> Elm.Expression
    , usLiquidGallons : Elm.Expression -> Elm.Expression
    , inUsLiquidGallons : Elm.Expression -> Elm.Expression
    , usDryGallons : Elm.Expression -> Elm.Expression
    , inUsDryGallons : Elm.Expression -> Elm.Expression
    , imperialGallons : Elm.Expression -> Elm.Expression
    , inImperialGallons : Elm.Expression -> Elm.Expression
    , usLiquidQuarts : Elm.Expression -> Elm.Expression
    , inUsLiquidQuarts : Elm.Expression -> Elm.Expression
    , usDryQuarts : Elm.Expression -> Elm.Expression
    , inUsDryQuarts : Elm.Expression -> Elm.Expression
    , imperialQuarts : Elm.Expression -> Elm.Expression
    , inImperialQuarts : Elm.Expression -> Elm.Expression
    , usLiquidPints : Elm.Expression -> Elm.Expression
    , inUsLiquidPints : Elm.Expression -> Elm.Expression
    , usDryPints : Elm.Expression -> Elm.Expression
    , inUsDryPints : Elm.Expression -> Elm.Expression
    , imperialPints : Elm.Expression -> Elm.Expression
    , inImperialPints : Elm.Expression -> Elm.Expression
    , usFluidOunces : Elm.Expression -> Elm.Expression
    , inUsFluidOunces : Elm.Expression -> Elm.Expression
    , imperialFluidOunces : Elm.Expression -> Elm.Expression
    , inImperialFluidOunces : Elm.Expression -> Elm.Expression
    }
call_ =
    { cubicMeters =
        \cubicMetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "cubicMeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ cubicMetersArg ]
    , inCubicMeters =
        \inCubicMetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inCubicMeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCubicMetersArg ]
    , milliliters =
        \millilitersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "milliliters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ millilitersArg ]
    , inMilliliters =
        \inMillilitersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inMilliliters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMillilitersArg ]
    , liters =
        \litersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "liters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ litersArg ]
    , inLiters =
        \inLitersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inLiters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inLitersArg ]
    , cubicCentimeters =
        \cubicCentimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "cubicCentimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ cubicCentimetersArg ]
    , inCubicCentimeters =
        \inCubicCentimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inCubicCentimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCubicCentimetersArg ]
    , cubicInches =
        \cubicInchesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "cubicInches"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ cubicInchesArg ]
    , inCubicInches =
        \inCubicInchesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inCubicInches"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCubicInchesArg ]
    , cubicFeet =
        \cubicFeetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "cubicFeet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ cubicFeetArg ]
    , inCubicFeet =
        \inCubicFeetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inCubicFeet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCubicFeetArg ]
    , cubicYards =
        \cubicYardsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "cubicYards"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ cubicYardsArg ]
    , inCubicYards =
        \inCubicYardsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inCubicYards"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCubicYardsArg ]
    , usLiquidGallons =
        \usLiquidGallonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "usLiquidGallons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ usLiquidGallonsArg ]
    , inUsLiquidGallons =
        \inUsLiquidGallonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inUsLiquidGallons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inUsLiquidGallonsArg ]
    , usDryGallons =
        \usDryGallonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "usDryGallons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ usDryGallonsArg ]
    , inUsDryGallons =
        \inUsDryGallonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inUsDryGallons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inUsDryGallonsArg ]
    , imperialGallons =
        \imperialGallonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "imperialGallons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ imperialGallonsArg ]
    , inImperialGallons =
        \inImperialGallonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inImperialGallons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inImperialGallonsArg ]
    , usLiquidQuarts =
        \usLiquidQuartsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "usLiquidQuarts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ usLiquidQuartsArg ]
    , inUsLiquidQuarts =
        \inUsLiquidQuartsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inUsLiquidQuarts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inUsLiquidQuartsArg ]
    , usDryQuarts =
        \usDryQuartsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "usDryQuarts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ usDryQuartsArg ]
    , inUsDryQuarts =
        \inUsDryQuartsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inUsDryQuarts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inUsDryQuartsArg ]
    , imperialQuarts =
        \imperialQuartsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "imperialQuarts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ imperialQuartsArg ]
    , inImperialQuarts =
        \inImperialQuartsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inImperialQuarts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inImperialQuartsArg ]
    , usLiquidPints =
        \usLiquidPintsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "usLiquidPints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ usLiquidPintsArg ]
    , inUsLiquidPints =
        \inUsLiquidPintsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inUsLiquidPints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inUsLiquidPintsArg ]
    , usDryPints =
        \usDryPintsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "usDryPints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ usDryPintsArg ]
    , inUsDryPints =
        \inUsDryPintsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inUsDryPints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inUsDryPintsArg ]
    , imperialPints =
        \imperialPintsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "imperialPints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ imperialPintsArg ]
    , inImperialPints =
        \inImperialPintsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inImperialPints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inImperialPintsArg ]
    , usFluidOunces =
        \usFluidOuncesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "usFluidOunces"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ usFluidOuncesArg ]
    , inUsFluidOunces =
        \inUsFluidOuncesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inUsFluidOunces"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inUsFluidOuncesArg ]
    , imperialFluidOunces =
        \imperialFluidOuncesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "imperialFluidOunces"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Volume" ] "Volume" [])
                             )
                     }
                )
                [ imperialFluidOuncesArg ]
    , inImperialFluidOunces =
        \inImperialFluidOuncesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Volume" ]
                     , name = "inImperialFluidOunces"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Volume" ] "Volume" [] ]
                                  Type.float
                             )
                     }
                )
                [ inImperialFluidOuncesArg ]
    }


values_ :
    { cubicMeters : Elm.Expression
    , inCubicMeters : Elm.Expression
    , milliliters : Elm.Expression
    , inMilliliters : Elm.Expression
    , liters : Elm.Expression
    , inLiters : Elm.Expression
    , cubicCentimeters : Elm.Expression
    , inCubicCentimeters : Elm.Expression
    , cubicInches : Elm.Expression
    , inCubicInches : Elm.Expression
    , cubicFeet : Elm.Expression
    , inCubicFeet : Elm.Expression
    , cubicYards : Elm.Expression
    , inCubicYards : Elm.Expression
    , usLiquidGallons : Elm.Expression
    , inUsLiquidGallons : Elm.Expression
    , usDryGallons : Elm.Expression
    , inUsDryGallons : Elm.Expression
    , imperialGallons : Elm.Expression
    , inImperialGallons : Elm.Expression
    , usLiquidQuarts : Elm.Expression
    , inUsLiquidQuarts : Elm.Expression
    , usDryQuarts : Elm.Expression
    , inUsDryQuarts : Elm.Expression
    , imperialQuarts : Elm.Expression
    , inImperialQuarts : Elm.Expression
    , usLiquidPints : Elm.Expression
    , inUsLiquidPints : Elm.Expression
    , usDryPints : Elm.Expression
    , inUsDryPints : Elm.Expression
    , imperialPints : Elm.Expression
    , inImperialPints : Elm.Expression
    , usFluidOunces : Elm.Expression
    , inUsFluidOunces : Elm.Expression
    , imperialFluidOunces : Elm.Expression
    , inImperialFluidOunces : Elm.Expression
    , cubicMeter : Elm.Expression
    , milliliter : Elm.Expression
    , liter : Elm.Expression
    , cubicCentimeter : Elm.Expression
    , cubicInch : Elm.Expression
    , cubicFoot : Elm.Expression
    , cubicYard : Elm.Expression
    , usLiquidGallon : Elm.Expression
    , usDryGallon : Elm.Expression
    , imperialGallon : Elm.Expression
    , usLiquidQuart : Elm.Expression
    , usDryQuart : Elm.Expression
    , imperialQuart : Elm.Expression
    , usLiquidPint : Elm.Expression
    , usDryPint : Elm.Expression
    , imperialPint : Elm.Expression
    , usFluidOunce : Elm.Expression
    , imperialFluidOunce : Elm.Expression
    }
values_ =
    { cubicMeters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicMeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inCubicMeters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inCubicMeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , milliliters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "milliliters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inMilliliters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inMilliliters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , liters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "liters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inLiters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inLiters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , cubicCentimeters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicCentimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inCubicCentimeters =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inCubicCentimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , cubicInches =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicInches"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inCubicInches =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inCubicInches"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , cubicFeet =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicFeet"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inCubicFeet =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inCubicFeet"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , cubicYards =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicYards"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inCubicYards =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inCubicYards"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , usLiquidGallons =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usLiquidGallons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inUsLiquidGallons =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inUsLiquidGallons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , usDryGallons =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usDryGallons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inUsDryGallons =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inUsDryGallons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , imperialGallons =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialGallons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inImperialGallons =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inImperialGallons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , usLiquidQuarts =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usLiquidQuarts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inUsLiquidQuarts =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inUsLiquidQuarts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , usDryQuarts =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usDryQuarts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inUsDryQuarts =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inUsDryQuarts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , imperialQuarts =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialQuarts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inImperialQuarts =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inImperialQuarts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , usLiquidPints =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usLiquidPints"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inUsLiquidPints =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inUsLiquidPints"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , usDryPints =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usDryPints"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inUsDryPints =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inUsDryPints"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , imperialPints =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialPints"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inImperialPints =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inImperialPints"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , usFluidOunces =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usFluidOunces"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inUsFluidOunces =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inUsFluidOunces"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , imperialFluidOunces =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialFluidOunces"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Volume" ] "Volume" [])
                    )
            }
    , inImperialFluidOunces =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "inImperialFluidOunces"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Volume" ] "Volume" [] ]
                         Type.float
                    )
            }
    , cubicMeter =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicMeter"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , milliliter =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "milliliter"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , liter =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "liter"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , cubicCentimeter =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicCentimeter"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , cubicInch =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicInch"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , cubicFoot =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicFoot"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , cubicYard =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "cubicYard"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , usLiquidGallon =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usLiquidGallon"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , usDryGallon =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usDryGallon"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , imperialGallon =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialGallon"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , usLiquidQuart =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usLiquidQuart"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , usDryQuart =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usDryQuart"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , imperialQuart =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialQuart"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , usLiquidPint =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usLiquidPint"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , usDryPint =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usDryPint"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , imperialPint =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialPint"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , usFluidOunce =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "usFluidOunce"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    , imperialFluidOunce =
        Elm.value
            { importFrom = [ "Volume" ]
            , name = "imperialFluidOunce"
            , annotation = Just (Type.namedWith [ "Volume" ] "Volume" [])
            }
    }