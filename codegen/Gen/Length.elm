module Gen.Length exposing (angstrom, angstroms, annotation_, astronomicalUnit, astronomicalUnits, call_, centimeter, centimeters, cssPixels, feet, foot, inAngstroms, inAstronomicalUnits, inCentimeters, inCssPixels, inFeet, inInches, inKilometers, inLightYears, inMeters, inMicrons, inMiles, inMillimeters, inNanometers, inParsecs, inPicas, inPoints, inThou, inYards, inch, inches, kilometer, kilometers, lightYear, lightYears, meter, meters, micron, microns, mile, miles, millimeter, millimeters, moduleName_, nanometer, nanometers, parsec, parsecs, picas, points, thou, values_, yard, yards)

{-| 
@docs moduleName_, meters, inMeters, angstroms, inAngstroms, nanometers, inNanometers, microns, inMicrons, millimeters, inMillimeters, centimeters, inCentimeters, kilometers, inKilometers, thou, inThou, inches, inInches, feet, inFeet, yards, inYards, miles, inMiles, cssPixels, inCssPixels, points, inPoints, picas, inPicas, astronomicalUnits, inAstronomicalUnits, parsecs, inParsecs, lightYears, inLightYears, meter, angstrom, nanometer, micron, millimeter, centimeter, kilometer, inch, foot, yard, mile, astronomicalUnit, parsec, lightYear, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Length" ]


{-| Construct a length from a number of meters.

    height : Length
    height =
        Length.meters 2

meters: Float -> Length.Length
-}
meters : Float -> Elm.Expression
meters metersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "meters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float metersArg ]


{-| Convert a length to a number of meters.

    Length.feet 1 |> Length.inMeters
    --> 0.3048

inMeters: Length.Length -> Float
-}
inMeters : Elm.Expression -> Elm.Expression
inMeters inMetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inMeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inMetersArg ]


{-| Construct a length from a number of angstroms.

    Length.angstroms 1
    --> Length.meters 1e-10

angstroms: Float -> Length.Length
-}
angstroms : Float -> Elm.Expression
angstroms angstromsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "angstroms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float angstromsArg ]


{-| Convert a length to a number of angstroms.

    Length.nanometers 1 |> Length.inAngstroms
    --> 10

inAngstroms: Length.Length -> Float
-}
inAngstroms : Elm.Expression -> Elm.Expression
inAngstroms inAngstromsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inAngstroms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inAngstromsArg ]


{-| Construct a length from a number of nanometers.

    Length.nanometers 1
    --> Length.meters 1e-9

nanometers: Float -> Length.Length
-}
nanometers : Float -> Elm.Expression
nanometers nanometersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "nanometers"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float nanometersArg ]


{-| Convert a length to a number of nanometers.

    Length.microns 1 |> Length.inNanometers
    --> 1000

inNanometers: Length.Length -> Float
-}
inNanometers : Elm.Expression -> Elm.Expression
inNanometers inNanometersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inNanometers"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inNanometersArg ]


{-| Construct a length from a number of microns (micrometers).

    Length.microns 1
    --> Length.meters 1e-6

microns: Float -> Length.Length
-}
microns : Float -> Elm.Expression
microns micronsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "microns"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float micronsArg ]


{-| Convert a length to a number of microns (micrometers).

    Length.millimeters 1 |> Length.inMicrons
    --> 1000

inMicrons: Length.Length -> Float
-}
inMicrons : Elm.Expression -> Elm.Expression
inMicrons inMicronsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inMicrons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inMicronsArg ]


{-| Construct a length from number of millimeters.

millimeters: Float -> Length.Length
-}
millimeters : Float -> Elm.Expression
millimeters millimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "millimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float millimetersArg ]


{-| Convert a length to number of millimeters.

inMillimeters: Length.Length -> Float
-}
inMillimeters : Elm.Expression -> Elm.Expression
inMillimeters inMillimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inMillimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inMillimetersArg ]


{-| Construct a length from a number of centimeters.

centimeters: Float -> Length.Length
-}
centimeters : Float -> Elm.Expression
centimeters centimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "centimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float centimetersArg ]


{-| Convert a length to a number of centimeters.

inCentimeters: Length.Length -> Float
-}
inCentimeters : Elm.Expression -> Elm.Expression
inCentimeters inCentimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inCentimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inCentimetersArg ]


{-| Construct a length from a number of kilometers.

kilometers: Float -> Length.Length
-}
kilometers : Float -> Elm.Expression
kilometers kilometersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "kilometers"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float kilometersArg ]


{-| Convert a length to a number of kilometers.

inKilometers: Length.Length -> Float
-}
inKilometers : Elm.Expression -> Elm.Expression
inKilometers inKilometersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inKilometers"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inKilometersArg ]


{-| Construct a length from a number of thou (thousandths of an inch).

    Length.thou 5
    --> Length.inches 0.005

thou: Float -> Length.Length
-}
thou : Float -> Elm.Expression
thou thouArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "thou"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float thouArg ]


{-| Convert a length to a number of thou (thousandths of an inch).

    Length.millimeters 1 |> Length.inThou
    --> 39.37007874015748

inThou: Length.Length -> Float
-}
inThou : Elm.Expression -> Elm.Expression
inThou inThouArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inThou"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inThouArg ]


{-| Construct a length from a number of inches.

inches: Float -> Length.Length
-}
inches : Float -> Elm.Expression
inches inchesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inches"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float inchesArg ]


{-| Convert a length to a number of inches.

inInches: Length.Length -> Float
-}
inInches : Elm.Expression -> Elm.Expression
inInches inInchesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inInches"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inInchesArg ]


{-| Construct a length from a number of feet.

feet: Float -> Length.Length
-}
feet : Float -> Elm.Expression
feet feetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "feet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float feetArg ]


{-| Convert a length to a number of feet.

inFeet: Length.Length -> Float
-}
inFeet : Elm.Expression -> Elm.Expression
inFeet inFeetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inFeet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inFeetArg ]


{-| Construct a length from a number of yards.

yards: Float -> Length.Length
-}
yards : Float -> Elm.Expression
yards yardsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "yards"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float yardsArg ]


{-| Convert a length to a number of yards.

inYards: Length.Length -> Float
-}
inYards : Elm.Expression -> Elm.Expression
inYards inYardsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inYards"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inYardsArg ]


{-| Construct a length from a number of miles.

miles: Float -> Length.Length
-}
miles : Float -> Elm.Expression
miles milesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "miles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float milesArg ]


{-| Convert a length to a number of miles.

inMiles: Length.Length -> Float
-}
inMiles : Elm.Expression -> Elm.Expression
inMiles inMilesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inMiles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inMilesArg ]


{-| Construct a length from a number of [CSS pixels](https://drafts.csswg.org/css-values-3/#absolute-lengths),
defined as 1/96 of an inch.

Note the difference between this function and [`Pixels.pixels`](Pixels#pixels).
`Length.cssPixels 1` is equivalent to `Length.inches (1 / 96)` or
approximately `Length.millimeters 0.264583`; it returns a length in _real world_
units equal to the (nominal) physical size of one CSS pixel.

In contrast, `Pixels.pixels 1` simply returns an abstract "1 pixel" value. You
can think of `Length.cssPixels 1` as a shorthand for

    Pixels.pixels 1
        |> Quantity.at_
            (Pixels.pixels 96
                |> Quantity.per (Length.inches 1)
            )

That is, `Length.cssPixels 1` is the size of 1 pixel at a resolution of 96 DPI.

cssPixels: Float -> Length.Length
-}
cssPixels : Float -> Elm.Expression
cssPixels cssPixelsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "cssPixels"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float cssPixelsArg ]


{-| Convert a length to a number of CSS pixels.

inCssPixels: Length.Length -> Float
-}
inCssPixels : Elm.Expression -> Elm.Expression
inCssPixels inCssPixelsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inCssPixels"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inCssPixelsArg ]


{-| Construct a length from a number of [points](https://en.wikipedia.org/wiki/Point_%28typography%29),
defined as 1/72 of an inch.

points: Float -> Length.Length
-}
points : Float -> Elm.Expression
points pointsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "points"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float pointsArg ]


{-| Convert a length to a number of points.

inPoints: Length.Length -> Float
-}
inPoints : Elm.Expression -> Elm.Expression
inPoints inPointsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inPoints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inPointsArg ]


{-| Construct a length from a number of [picas](https://en.wikipedia.org/wiki/Pica_%28typography%29),
defined as 1/6 of an inch.

picas: Float -> Length.Length
-}
picas : Float -> Elm.Expression
picas picasArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "picas"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float picasArg ]


{-| Convert a length to a number of picas.

inPicas: Length.Length -> Float
-}
inPicas : Elm.Expression -> Elm.Expression
inPicas inPicasArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inPicas"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inPicasArg ]


{-| Construct a length from a number of [astronomical units][au] (AU). One AU is
approximately equal to the average distance of the Earth from the Sun.

[au]: https://en.wikipedia.org/wiki/Astronomical_unit "Astronomical unit"

astronomicalUnits: Float -> Length.Length
-}
astronomicalUnits : Float -> Elm.Expression
astronomicalUnits astronomicalUnitsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "astronomicalUnits"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float astronomicalUnitsArg ]


{-| Convert a length to a number of astronomical units.

inAstronomicalUnits: Length.Length -> Float
-}
inAstronomicalUnits : Elm.Expression -> Elm.Expression
inAstronomicalUnits inAstronomicalUnitsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inAstronomicalUnits"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inAstronomicalUnitsArg ]


{-| Construct a length from a number of [parsecs][parsec].

[parsec]: https://en.wikipedia.org/wiki/Parsec "Parsec"

parsecs: Float -> Length.Length
-}
parsecs : Float -> Elm.Expression
parsecs parsecsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "parsecs"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float parsecsArg ]


{-| Convert a length to a number of parsecs.

inParsecs: Length.Length -> Float
-}
inParsecs : Elm.Expression -> Elm.Expression
inParsecs inParsecsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inParsecs"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inParsecsArg ]


{-| Construct a length from a number of light years. One light year is the
distance traveled when moving at the speed of light for one [Julian year](Duration#julianYear).

lightYears: Float -> Length.Length
-}
lightYears : Float -> Elm.Expression
lightYears lightYearsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "lightYears"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Length" ] "Length" [])
                     )
             }
        )
        [ Elm.float lightYearsArg ]


{-| Convert a length to a number of light years.

inLightYears: Length.Length -> Float
-}
inLightYears : Elm.Expression -> Elm.Expression
inLightYears inLightYearsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Length" ]
             , name = "inLightYears"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Length" ] "Length" [] ]
                          Type.float
                     )
             }
        )
        [ inLightYearsArg ]


{-| meter: Length.Length -}
meter : Elm.Expression
meter =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "meter"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| angstrom: Length.Length -}
angstrom : Elm.Expression
angstrom =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "angstrom"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| nanometer: Length.Length -}
nanometer : Elm.Expression
nanometer =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "nanometer"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| micron: Length.Length -}
micron : Elm.Expression
micron =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "micron"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| millimeter: Length.Length -}
millimeter : Elm.Expression
millimeter =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "millimeter"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| centimeter: Length.Length -}
centimeter : Elm.Expression
centimeter =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "centimeter"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| kilometer: Length.Length -}
kilometer : Elm.Expression
kilometer =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "kilometer"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| inch: Length.Length -}
inch : Elm.Expression
inch =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "inch"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| foot: Length.Length -}
foot : Elm.Expression
foot =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "foot"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| yard: Length.Length -}
yard : Elm.Expression
yard =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "yard"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| mile: Length.Length -}
mile : Elm.Expression
mile =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "mile"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| astronomicalUnit: Length.Length -}
astronomicalUnit : Elm.Expression
astronomicalUnit =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "astronomicalUnit"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| parsec: Length.Length -}
parsec : Elm.Expression
parsec =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "parsec"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


{-| lightYear: Length.Length -}
lightYear : Elm.Expression
lightYear =
    Elm.value
        { importFrom = [ "Length" ]
        , name = "lightYear"
        , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
        }


annotation_ : { length : Type.Annotation, meters : Type.Annotation }
annotation_ =
    { length =
        Type.alias
            moduleName_
            "Length"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Length" ] "Meters" [] ]
            )
    , meters = Type.namedWith [ "Length" ] "Meters" []
    }


call_ :
    { meters : Elm.Expression -> Elm.Expression
    , inMeters : Elm.Expression -> Elm.Expression
    , angstroms : Elm.Expression -> Elm.Expression
    , inAngstroms : Elm.Expression -> Elm.Expression
    , nanometers : Elm.Expression -> Elm.Expression
    , inNanometers : Elm.Expression -> Elm.Expression
    , microns : Elm.Expression -> Elm.Expression
    , inMicrons : Elm.Expression -> Elm.Expression
    , millimeters : Elm.Expression -> Elm.Expression
    , inMillimeters : Elm.Expression -> Elm.Expression
    , centimeters : Elm.Expression -> Elm.Expression
    , inCentimeters : Elm.Expression -> Elm.Expression
    , kilometers : Elm.Expression -> Elm.Expression
    , inKilometers : Elm.Expression -> Elm.Expression
    , thou : Elm.Expression -> Elm.Expression
    , inThou : Elm.Expression -> Elm.Expression
    , inches : Elm.Expression -> Elm.Expression
    , inInches : Elm.Expression -> Elm.Expression
    , feet : Elm.Expression -> Elm.Expression
    , inFeet : Elm.Expression -> Elm.Expression
    , yards : Elm.Expression -> Elm.Expression
    , inYards : Elm.Expression -> Elm.Expression
    , miles : Elm.Expression -> Elm.Expression
    , inMiles : Elm.Expression -> Elm.Expression
    , cssPixels : Elm.Expression -> Elm.Expression
    , inCssPixels : Elm.Expression -> Elm.Expression
    , points : Elm.Expression -> Elm.Expression
    , inPoints : Elm.Expression -> Elm.Expression
    , picas : Elm.Expression -> Elm.Expression
    , inPicas : Elm.Expression -> Elm.Expression
    , astronomicalUnits : Elm.Expression -> Elm.Expression
    , inAstronomicalUnits : Elm.Expression -> Elm.Expression
    , parsecs : Elm.Expression -> Elm.Expression
    , inParsecs : Elm.Expression -> Elm.Expression
    , lightYears : Elm.Expression -> Elm.Expression
    , inLightYears : Elm.Expression -> Elm.Expression
    }
call_ =
    { meters =
        \metersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "meters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ metersArg ]
    , inMeters =
        \inMetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inMeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMetersArg ]
    , angstroms =
        \angstromsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "angstroms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ angstromsArg ]
    , inAngstroms =
        \inAngstromsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inAngstroms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inAngstromsArg ]
    , nanometers =
        \nanometersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "nanometers"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ nanometersArg ]
    , inNanometers =
        \inNanometersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inNanometers"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inNanometersArg ]
    , microns =
        \micronsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "microns"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ micronsArg ]
    , inMicrons =
        \inMicronsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inMicrons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMicronsArg ]
    , millimeters =
        \millimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "millimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ millimetersArg ]
    , inMillimeters =
        \inMillimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inMillimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMillimetersArg ]
    , centimeters =
        \centimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "centimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ centimetersArg ]
    , inCentimeters =
        \inCentimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inCentimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCentimetersArg ]
    , kilometers =
        \kilometersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "kilometers"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ kilometersArg ]
    , inKilometers =
        \inKilometersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inKilometers"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilometersArg ]
    , thou =
        \thouArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "thou"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ thouArg ]
    , inThou =
        \inThouArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inThou"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inThouArg ]
    , inches =
        \inchesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inches"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ inchesArg ]
    , inInches =
        \inInchesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inInches"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inInchesArg ]
    , feet =
        \feetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "feet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ feetArg ]
    , inFeet =
        \inFeetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inFeet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inFeetArg ]
    , yards =
        \yardsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "yards"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ yardsArg ]
    , inYards =
        \inYardsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inYards"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inYardsArg ]
    , miles =
        \milesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "miles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ milesArg ]
    , inMiles =
        \inMilesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inMiles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMilesArg ]
    , cssPixels =
        \cssPixelsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "cssPixels"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ cssPixelsArg ]
    , inCssPixels =
        \inCssPixelsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inCssPixels"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCssPixelsArg ]
    , points =
        \pointsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "points"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ pointsArg ]
    , inPoints =
        \inPointsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inPoints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inPointsArg ]
    , picas =
        \picasArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "picas"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ picasArg ]
    , inPicas =
        \inPicasArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inPicas"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inPicasArg ]
    , astronomicalUnits =
        \astronomicalUnitsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "astronomicalUnits"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ astronomicalUnitsArg ]
    , inAstronomicalUnits =
        \inAstronomicalUnitsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inAstronomicalUnits"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inAstronomicalUnitsArg ]
    , parsecs =
        \parsecsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "parsecs"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ parsecsArg ]
    , inParsecs =
        \inParsecsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inParsecs"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inParsecsArg ]
    , lightYears =
        \lightYearsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "lightYears"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Length" ] "Length" [])
                             )
                     }
                )
                [ lightYearsArg ]
    , inLightYears =
        \inLightYearsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Length" ]
                     , name = "inLightYears"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Length" ] "Length" [] ]
                                  Type.float
                             )
                     }
                )
                [ inLightYearsArg ]
    }


values_ :
    { meters : Elm.Expression
    , inMeters : Elm.Expression
    , angstroms : Elm.Expression
    , inAngstroms : Elm.Expression
    , nanometers : Elm.Expression
    , inNanometers : Elm.Expression
    , microns : Elm.Expression
    , inMicrons : Elm.Expression
    , millimeters : Elm.Expression
    , inMillimeters : Elm.Expression
    , centimeters : Elm.Expression
    , inCentimeters : Elm.Expression
    , kilometers : Elm.Expression
    , inKilometers : Elm.Expression
    , thou : Elm.Expression
    , inThou : Elm.Expression
    , inches : Elm.Expression
    , inInches : Elm.Expression
    , feet : Elm.Expression
    , inFeet : Elm.Expression
    , yards : Elm.Expression
    , inYards : Elm.Expression
    , miles : Elm.Expression
    , inMiles : Elm.Expression
    , cssPixels : Elm.Expression
    , inCssPixels : Elm.Expression
    , points : Elm.Expression
    , inPoints : Elm.Expression
    , picas : Elm.Expression
    , inPicas : Elm.Expression
    , astronomicalUnits : Elm.Expression
    , inAstronomicalUnits : Elm.Expression
    , parsecs : Elm.Expression
    , inParsecs : Elm.Expression
    , lightYears : Elm.Expression
    , inLightYears : Elm.Expression
    , meter : Elm.Expression
    , angstrom : Elm.Expression
    , nanometer : Elm.Expression
    , micron : Elm.Expression
    , millimeter : Elm.Expression
    , centimeter : Elm.Expression
    , kilometer : Elm.Expression
    , inch : Elm.Expression
    , foot : Elm.Expression
    , yard : Elm.Expression
    , mile : Elm.Expression
    , astronomicalUnit : Elm.Expression
    , parsec : Elm.Expression
    , lightYear : Elm.Expression
    }
values_ =
    { meters =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "meters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inMeters =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inMeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , angstroms =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "angstroms"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inAngstroms =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inAngstroms"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , nanometers =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "nanometers"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inNanometers =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inNanometers"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , microns =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "microns"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inMicrons =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inMicrons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , millimeters =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "millimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inMillimeters =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inMillimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , centimeters =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "centimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inCentimeters =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inCentimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , kilometers =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "kilometers"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inKilometers =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inKilometers"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , thou =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "thou"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inThou =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inThou"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , inches =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inches"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inInches =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inInches"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , feet =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "feet"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inFeet =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inFeet"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , yards =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "yards"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inYards =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inYards"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , miles =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "miles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inMiles =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inMiles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , cssPixels =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "cssPixels"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inCssPixels =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inCssPixels"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , points =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "points"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inPoints =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inPoints"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , picas =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "picas"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inPicas =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inPicas"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , astronomicalUnits =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "astronomicalUnits"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inAstronomicalUnits =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inAstronomicalUnits"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , parsecs =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "parsecs"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inParsecs =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inParsecs"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , lightYears =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "lightYears"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Length" ] "Length" [])
                    )
            }
    , inLightYears =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inLightYears"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Length" ] "Length" [] ]
                         Type.float
                    )
            }
    , meter =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "meter"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , angstrom =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "angstrom"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , nanometer =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "nanometer"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , micron =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "micron"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , millimeter =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "millimeter"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , centimeter =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "centimeter"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , kilometer =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "kilometer"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , inch =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "inch"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , foot =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "foot"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , yard =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "yard"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , mile =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "mile"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , astronomicalUnit =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "astronomicalUnit"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , parsec =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "parsec"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    , lightYear =
        Elm.value
            { importFrom = [ "Length" ]
            , name = "lightYear"
            , annotation = Just (Type.namedWith [ "Length" ] "Length" [])
            }
    }