module Gen.Quantity exposing (abs, annotation_, at, at_, call_, caseOf_, cbrt, cbrtUnitless, ceiling, clamp, compare, cubed, cubedUnitless, difference, divideBy, equalWithin, float, floor, for, fractionalModBy, fractionalRemainderBy, greaterThan, greaterThanOrEqualTo, greaterThanOrEqualToZero, greaterThanZero, half, in_, infinity, int, interpolateFrom, inverse, isInfinite, isNaN, lessThan, lessThanOrEqualTo, lessThanOrEqualToZero, lessThanZero, make_, max, maximum, maximumBy, midpoint, min, minimum, minimumBy, minus, modBy, moduleName_, multiplyBy, negate, negativeInfinity, over, overUnitless, over_, per, plus, positiveInfinity, product, range, rate, rateProduct, ratio, reciprocal, remainderBy, round, sign, sort, sortBy, sqrt, sqrtUnitless, squared, squaredUnitless, sum, times, timesUnitless, toFloat, toFloatQuantity, toInt, truncate, twice, unsafe, unwrap, values_, zero)

{-| 
@docs moduleName_, zero, infinity, positiveInfinity, negativeInfinity, lessThan, greaterThan, lessThanOrEqualTo, greaterThanOrEqualTo, lessThanZero, greaterThanZero, lessThanOrEqualToZero, greaterThanOrEqualToZero, compare, equalWithin, max, min, isNaN, isInfinite, negate, abs, plus, difference, minus, multiplyBy, divideBy, twice, half, ratio, squared, sqrt, cubed, cbrt, squaredUnitless, sqrtUnitless, cubedUnitless, cbrtUnitless, reciprocal, product, times, timesUnitless, over, over_, overUnitless, rate, per, at, at_, for, inverse, rateProduct, modBy, fractionalModBy, remainderBy, fractionalRemainderBy, clamp, sign, interpolateFrom, midpoint, range, in_, round, floor, ceiling, truncate, toFloatQuantity, sum, minimum, maximum, minimumBy, maximumBy, sort, sortBy, int, toInt, float, toFloat, unsafe, unwrap, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Quantity" ]


{-| A generic zero value. This can be treated as either an `Int` or `Float`
quantity in any units type, similar to how `Nothing` can be treated as any kind
of `Maybe` type and `[]` can be treated as any kind of `List`.

zero: Quantity.Quantity number units
-}
zero : Elm.Expression
zero =
    Elm.value
        { importFrom = [ "Quantity" ]
        , name = "zero"
        , annotation =
            Just
                (Type.namedWith
                     [ "Quantity" ]
                     "Quantity"
                     [ Type.var "number", Type.var "units" ]
                )
        }


{-| Alias for `positiveInfinity`.

infinity: Quantity.Quantity Float units
-}
infinity : Elm.Expression
infinity =
    Elm.value
        { importFrom = [ "Quantity" ]
        , name = "infinity"
        , annotation =
            Just
                (Type.namedWith
                     [ "Quantity" ]
                     "Quantity"
                     [ Type.float, Type.var "units" ]
                )
        }


{-| A generic positive infinity value.

positiveInfinity: Quantity.Quantity Float units
-}
positiveInfinity : Elm.Expression
positiveInfinity =
    Elm.value
        { importFrom = [ "Quantity" ]
        , name = "positiveInfinity"
        , annotation =
            Just
                (Type.namedWith
                     [ "Quantity" ]
                     "Quantity"
                     [ Type.float, Type.var "units" ]
                )
        }


{-| A generic negative infinity value.

negativeInfinity: Quantity.Quantity Float units
-}
negativeInfinity : Elm.Expression
negativeInfinity =
    Elm.value
        { importFrom = [ "Quantity" ]
        , name = "negativeInfinity"
        , annotation =
            Just
                (Type.namedWith
                     [ "Quantity" ]
                     "Quantity"
                     [ Type.float, Type.var "units" ]
                )
        }


{-| Check if one quantity is less than another. Note the [argument order](/#argument-order)!

    oneMeter =
        Length.meters 1

    Length.feet 1 |> Quantity.lessThan oneMeter
    --> True

    -- Same as:
    Quantity.lessThan oneMeter (Length.feet 1)
    --> True

    List.filter (Quantity.lessThan oneMeter)
        [ Length.feet 1
        , Length.parsecs 1
        , Length.yards 1
        , Length.lightYears 1
        ]
    --> [ Length.feet 1, Length.yards 1 ]

lessThan: Quantity.Quantity number units -> Quantity.Quantity number units -> Bool
-}
lessThan : Elm.Expression -> Elm.Expression -> Elm.Expression
lessThan lessThanArg lessThanArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "lessThan"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ lessThanArg, lessThanArg0 ]


{-| Check if one quantity is greater than another. Note the [argument order](/#argument-order)!

    oneMeter =
        Length.meters 1

    Length.feet 1 |> Quantity.greaterThan oneMeter
    --> False

    -- Same as:
    Quantity.greaterThan oneMeter (Length.feet 1)
    --> False

    List.filter (Quantity.greaterThan oneMeter)
        [ Length.feet 1
        , Length.parsecs 1
        , Length.yards 1
        , Length.lightYears 1
        ]
    --> [ Length.parsecs 1, Length.lightYears 1 ]

greaterThan: Quantity.Quantity number units -> Quantity.Quantity number units -> Bool
-}
greaterThan : Elm.Expression -> Elm.Expression -> Elm.Expression
greaterThan greaterThanArg greaterThanArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "greaterThan"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ greaterThanArg, greaterThanArg0 ]


{-| Check if one quantity is less than or equal to another. Note the [argument
order](/#argument-order)!

lessThanOrEqualTo: Quantity.Quantity number units -> Quantity.Quantity number units -> Bool
-}
lessThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
lessThanOrEqualTo lessThanOrEqualToArg lessThanOrEqualToArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "lessThanOrEqualTo"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ lessThanOrEqualToArg, lessThanOrEqualToArg0 ]


{-| Check if one quantity is greater than or equal to another. Note the
[argument order](/#argument-order)!

greaterThanOrEqualTo: Quantity.Quantity number units -> Quantity.Quantity number units -> Bool
-}
greaterThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
greaterThanOrEqualTo greaterThanOrEqualToArg greaterThanOrEqualToArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "greaterThanOrEqualTo"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ greaterThanOrEqualToArg, greaterThanOrEqualToArg0 ]


{-| Short form for `Quantity.lessThan Quantity.zero`.

lessThanZero: Quantity.Quantity number units -> Bool
-}
lessThanZero : Elm.Expression -> Elm.Expression
lessThanZero lessThanZeroArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "lessThanZero"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ lessThanZeroArg ]


{-| Short form for `Quantity.greaterThan Quantity.zero`.

greaterThanZero: Quantity.Quantity number units -> Bool
-}
greaterThanZero : Elm.Expression -> Elm.Expression
greaterThanZero greaterThanZeroArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "greaterThanZero"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ greaterThanZeroArg ]


{-| Short form for `Quantity.lessThanOrEqualTo Quantity.zero`.

lessThanOrEqualToZero: Quantity.Quantity number units -> Bool
-}
lessThanOrEqualToZero : Elm.Expression -> Elm.Expression
lessThanOrEqualToZero lessThanOrEqualToZeroArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "lessThanOrEqualToZero"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ lessThanOrEqualToZeroArg ]


{-| Short form for `Quantity.greaterThanOrEqualTo Quantity.zero`.

greaterThanOrEqualToZero: Quantity.Quantity number units -> Bool
-}
greaterThanOrEqualToZero : Elm.Expression -> Elm.Expression
greaterThanOrEqualToZero greaterThanOrEqualToZeroArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "greaterThanOrEqualToZero"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ greaterThanOrEqualToZeroArg ]


{-| Compare two quantities, returning an [`Order`](https://package.elm-lang.org/packages/elm/core/latest/Basics#Order)
value indicating whether the first is less than, equal to or greater than the
second.

    Quantity.compare
        (Duration.minutes 90)
        (Duration.hours 1)
    --> GT

    Quantity.compare
        (Duration.minutes 60)
        (Duration.hours 1)
    --> EQ

compare: Quantity.Quantity number units -> Quantity.Quantity number units -> Basics.Order
-}
compare : Elm.Expression -> Elm.Expression -> Elm.Expression
compare compareArg compareArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "compare"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith [ "Basics" ] "Order" [])
                     )
             }
        )
        [ compareArg, compareArg0 ]


{-| Check if two quantities are equal within a given absolute tolerance. The
given tolerance must be greater than or equal to zero - if it is negative, then
the result will always be false.

    -- 3 feet is 91.44 centimeters or 0.9144 meters

    Quantity.equalWithin (Length.centimeters 10)
        (Length.meters 1)
        (Length.feet 3)
    --> True

    Quantity.equalWithin (Length.centimeters 5)
        (Length.meters 1)
        (Length.feet 3)
    --> False

equalWithin: 
    Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Bool
-}
equalWithin :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
equalWithin equalWithinArg equalWithinArg0 equalWithinArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "equalWithin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ equalWithinArg, equalWithinArg0, equalWithinArg1 ]


{-| Find the maximum of two quantities.

    Quantity.max (Duration.hours 2) (Duration.minutes 100)
    --> Duration.hours 2

max: 
    Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
-}
max : Elm.Expression -> Elm.Expression -> Elm.Expression
max maxArg maxArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "max"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ maxArg, maxArg0 ]


{-| Find the minimum of two quantities.

    Quantity.min (Duration.hours 2) (Duration.minutes 100)
    --> Duration.minutes 100

min: 
    Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
-}
min : Elm.Expression -> Elm.Expression -> Elm.Expression
min minArg minArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "min"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ minArg, minArg0 ]


{-| Check if a quantity's underlying value is NaN (not-a-number).

    Quantity.isNan (Quantity.sqrt (Area.squareMeters -4))
    --> True

    Quantity.isNan (Quantity.sqrt (Area.squareMeters 4))
    --> False

isNaN: Quantity.Quantity Float units -> Bool
-}
isNaN : Elm.Expression -> Elm.Expression
isNaN isNaNArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "isNaN"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ isNaNArg ]


{-| Check if a quantity is positive or negative infinity.

    Quantity.isInfinite
        (Length.meters 1
            |> Quantity.per (Duration.seconds 0)
        )
    --> True

    Quantity.isInfinite Quantity.negativeInfinity
    --> True

isInfinite: Quantity.Quantity Float units -> Bool
-}
isInfinite : Elm.Expression -> Elm.Expression
isInfinite isInfiniteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "isInfinite"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ isInfiniteArg ]


{-| Negate a quantity!

    Quantity.negate (Length.millimeters 10)
    --> Length.millimeters -10

negate: Quantity.Quantity number units -> Quantity.Quantity number units
-}
negate : Elm.Expression -> Elm.Expression
negate negateArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "negate"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ negateArg ]


{-| Get the absolute value of a quantity.

    Quantity.abs (Duration.milliseconds -10)
    --> Duration.milliseconds 10

abs: Quantity.Quantity number units -> Quantity.Quantity number units
-}
abs : Elm.Expression -> Elm.Expression
abs absArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "abs"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ absArg ]


{-| Add two quantities.

    Length.meters 1 |> Quantity.plus (Length.centimeters 5)
    --> Length.centimeters 105

plus: 
    Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus plusArg plusArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "plus"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ plusArg, plusArg0 ]


{-| Subtract one quantity from another.

    Quantity.difference
        (Duration.hours 1)
        (Duration.minutes 15)
    --> Duration.minutes 45

difference: 
    Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
-}
difference : Elm.Expression -> Elm.Expression -> Elm.Expression
difference differenceArg differenceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "difference"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ differenceArg, differenceArg0 ]


{-| An 'infix' version of [`difference`](#difference), intended to be used in
pipeline form;

    Quantity.difference x y

can be written as

    x |> Quantity.minus y

Note that unlike `difference`, this also means that partial application will 'do
the right thing':

    List.map (Quantity.minus fifteenMinutes)
        [ Duration.hours 1
        , Duration.hours 2
        , Duration.minutes 30
        ]
    --> [ Duration.minutes 45
    --> , Duration.minutes 105
    --> , Duration.minutes 15
    --> ]

minus: 
    Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus minusArg minusArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "minus"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ minusArg, minusArg0 ]


{-| Scale a `Quantity` by a `number`.

    Quantity.multiplyBy 1.5 (Duration.hours 1)
    --> Duration.minutes 90

Note that there are [other forms of multiplication](/#multiplication-and-division)!

multiplyBy: number -> Quantity.Quantity number units -> Quantity.Quantity number units
-}
multiplyBy : Elm.Expression -> Elm.Expression -> Elm.Expression
multiplyBy multiplyByArg multiplyByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "multiplyBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "number"
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ multiplyByArg, multiplyByArg0 ]


{-| Divide a `Quantity` by a `Float`.

    Quantity.divideBy 2 (Duration.hours 1)
    --> Duration.minutes 30

Note that there are [other forms of division](/#multiplication-and-division)!

divideBy: Float -> Quantity.Quantity Float units -> Quantity.Quantity Float units
-}
divideBy : Float -> Elm.Expression -> Elm.Expression
divideBy divideByArg divideByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "divideBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ Elm.float divideByArg, divideByArg0 ]


{-| Convenient shorthand for `Quantity.multiplyBy 2`.

    Quantity.twice (Duration.minutes 30)
    --> Duration.hours 1

twice: Quantity.Quantity number units -> Quantity.Quantity number units
-}
twice : Elm.Expression -> Elm.Expression
twice twiceArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "twice"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ twiceArg ]


{-| Convenient shorthand for `Quantity.multiplyBy 0.5`.

    Quantity.half (Length.meters 1)
    --> Length.centimeters 50

half: Quantity.Quantity Float units -> Quantity.Quantity Float units
-}
half : Elm.Expression -> Elm.Expression
half halfArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "half"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ halfArg ]


{-| Find the ratio of two quantities with the same units.

    Quantity.ratio (Length.miles 1) (Length.yards 1)
    --> 1760

ratio: Quantity.Quantity Float units -> Quantity.Quantity Float units -> Float
-}
ratio : Elm.Expression -> Elm.Expression -> Elm.Expression
ratio ratioArg ratioArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "ratio"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          Type.float
                     )
             }
        )
        [ ratioArg, ratioArg0 ]


{-| Square a quantity with some `units`, resulting in a new quantity in
`Squared units`:

    Quantity.squared (Length.meters 5)
    --> Area.squareMeters 25

See also [`squaredUnitless`](#squaredUnitless).

squared: 
    Quantity.Quantity number units
    -> Quantity.Quantity number (Quantity.Squared units)
-}
squared : Elm.Expression -> Elm.Expression
squared squaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "squared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Squared"
                                   [ Type.var "units" ]
                               ]
                          )
                     )
             }
        )
        [ squaredArg ]


{-| Take a quantity in `Squared units` and return the square root of that
quantity in plain `units`:

    Quantity.sqrt (Area.hectares 1)
    --> Length.meters 100

Getting fancier, you could write a 2D hypotenuse (magnitude) function that
worked on _any_ quantity type (length, speed, force...) as

    hypotenuse :
        Quantity Float units
        -> Quantity Float units
        -> Quantity Float units
    hypotenuse x y =
        Quantity.sqrt
            (Quantity.squared x
                |> Quantity.plus
                    (Quantity.squared y)
            )

This works because:

  - The `x` and `y` arguments are both in `units`
  - So each squared item is in `Squared units`
  - So the sum is also in `Squared units`
  - And calling `sqrt` on something in `Squared units` returns a value back in
    `units`

See also [`sqrtUnitless`](#sqrtUnitless).

sqrt: 
    Quantity.Quantity Float (Quantity.Squared units)
    -> Quantity.Quantity Float units
-}
sqrt : Elm.Expression -> Elm.Expression
sqrt sqrtArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "sqrt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Squared"
                                    [ Type.var "units" ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ sqrtArg ]


{-| Cube a quantity with some `units`, resulting in a new quantity in
`Cubed units`.

    Quantity.cubed (Length.meters 5)
    --> Volume.cubicMeters 125

See also [`cubedUnitless`](#cubedUnitless).

cubed: 
    Quantity.Quantity number units
    -> Quantity.Quantity number (Quantity.Cubed units)
-}
cubed : Elm.Expression -> Elm.Expression
cubed cubedArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "cubed"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Cubed"
                                   [ Type.var "units" ]
                               ]
                          )
                     )
             }
        )
        [ cubedArg ]


{-| Take a quantity in `Cubed units` and return the cube root of that
quantity in plain `units`.

    Quantity.cbrt (Volume.liters 1)
    --> Length.centimeters 10

See also [`cbrtUnitless`](#cbrtUnitless).

cbrt: Quantity.Quantity Float (Quantity.Cubed units) -> Quantity.Quantity Float units
-}
cbrt : Elm.Expression -> Elm.Expression
cbrt cbrtArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "cbrt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Cubed"
                                    [ Type.var "units" ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ cbrtArg ]


{-| squaredUnitless: 
    Quantity.Quantity number Quantity.Unitless
    -> Quantity.Quantity number Quantity.Unitless
-}
squaredUnitless : Elm.Expression -> Elm.Expression
squaredUnitless squaredUnitlessArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "squaredUnitless"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith [ "Quantity" ] "Unitless" []
                               ]
                          )
                     )
             }
        )
        [ squaredUnitlessArg ]


{-| sqrtUnitless: 
    Quantity.Quantity Float Quantity.Unitless
    -> Quantity.Quantity Float Quantity.Unitless
-}
sqrtUnitless : Elm.Expression -> Elm.Expression
sqrtUnitless sqrtUnitlessArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "sqrtUnitless"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith [ "Quantity" ] "Unitless" []
                               ]
                          )
                     )
             }
        )
        [ sqrtUnitlessArg ]


{-| cubedUnitless: 
    Quantity.Quantity number Quantity.Unitless
    -> Quantity.Quantity number Quantity.Unitless
-}
cubedUnitless : Elm.Expression -> Elm.Expression
cubedUnitless cubedUnitlessArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "cubedUnitless"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith [ "Quantity" ] "Unitless" []
                               ]
                          )
                     )
             }
        )
        [ cubedUnitlessArg ]


{-| cbrtUnitless: 
    Quantity.Quantity Float Quantity.Unitless
    -> Quantity.Quantity Float Quantity.Unitless
-}
cbrtUnitless : Elm.Expression -> Elm.Expression
cbrtUnitless cbrtUnitlessArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "cbrtUnitless"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith [ "Quantity" ] "Unitless" []
                               ]
                          )
                     )
             }
        )
        [ cbrtUnitlessArg ]


{-| Find the inverse of a unitless value.

    Quantity.reciprocal (Quantity.float 5)
    --> Quantity.float 0.2

reciprocal: 
    Quantity.Quantity Float Quantity.Unitless
    -> Quantity.Quantity Float Quantity.Unitless
-}
reciprocal : Elm.Expression -> Elm.Expression
reciprocal reciprocalArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "reciprocal"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith [ "Quantity" ] "Unitless" []
                               ]
                          )
                     )
             }
        )
        [ reciprocalArg ]


{-| Multiply two quantities with units types `units1` and `units2` together,
resulting in a quantity with units type `Product units1 units2`.

This works for any two units types, but one special case is worth pointing out.
The units type of an [`Area`](Area) is `SquareMeters`, which is a type alias for
`Squared Meters`, which in turn expands to `Product Meters Meters`. This means
that the product of two `Length`s does in fact give you an `Area`:

    -- This is the definition of an acre, I kid you not 😈
    Quantity.product (Length.feet 66) (Length.feet 660)
    --> Area.acres 1

We can also multiply an `Area` by a `Length` to get a `Volume`:

    Quantity.product
        (Area.squareMeters 1)
        (Length.centimers 1)
    --> Volume.liters 10

Note that there are [other forms of multiplication](/#multiplication-and-division)!

product: 
    Quantity.Quantity number units1
    -> Quantity.Quantity number units2
    -> Quantity.Quantity number (Quantity.Product units1 units2)
-}
product : Elm.Expression -> Elm.Expression -> Elm.Expression
product productArg productArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "product"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units1" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units2" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Product"
                                   [ Type.var "units1", Type.var "units2" ]
                               ]
                          )
                     )
             }
        )
        [ productArg, productArg0 ]


{-| An 'infix' version of [`product`](#product), intended to be used in pipeline
form;

    Quantity.product a b

can be written as

    a |> Quantity.times b

times: 
    Quantity.Quantity number units2
    -> Quantity.Quantity number units1
    -> Quantity.Quantity number (Quantity.Product units1 units2)
-}
times : Elm.Expression -> Elm.Expression -> Elm.Expression
times timesArg timesArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "times"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units2" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units1" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number"
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Product"
                                   [ Type.var "units1", Type.var "units2" ]
                               ]
                          )
                     )
             }
        )
        [ timesArg, timesArg0 ]


{-| If you use [`times`](#times) or [`product`](#product) to multiply one
quantity by another [unitless](#Unitless) quantity, for example

    quantity |> Quantity.times unitlessQuantity

then the result you'll get will have units type `Product units Unitless`. But
this is silly and not super useful, since the product of `units` and `Unitless`
should really just be `units`. That's what `timesUnitless` does - it's a special
case of `times` for when you're multiplying by another unitless quantity, that
leaves the units alone.

You can think of `timesUnitless` as shorthand for `toFloat` and `multiplyBy`;
for `Float`-valued quantities,

    quantity |> Quantity.timesUnitless unitlessQuantity

is equivalent to

    quantity
        |> Quantity.multiplyBy
            (Quantity.toFloat unitlessQuantity)

timesUnitless: 
    Quantity.Quantity number Quantity.Unitless
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
-}
timesUnitless : Elm.Expression -> Elm.Expression -> Elm.Expression
timesUnitless timesUnitlessArg timesUnitlessArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "timesUnitless"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ timesUnitlessArg, timesUnitlessArg0 ]


{-| Divide a quantity in `Product units1 units2` by a quantity in `units1`,
resulting in another quantity in `units2`. For example, the units type of a
`Force` is `Product Kilograms MetersPerSecondSquared` (mass times acceleration),
so we could divide a force by a given mass to determine how fast that mass would
be accelerated by the given force:

    Force.newtons 100
        |> Quantity.over
            (Mass.kilograms 50)
    --> Acceleration.metersPerSecondSquared 2

Note that there are [other forms of division](/#multiplication-and-division)!

over: 
    Quantity.Quantity Float units1
    -> Quantity.Quantity Float (Quantity.Product units1 units2)
    -> Quantity.Quantity Float units2
-}
over : Elm.Expression -> Elm.Expression -> Elm.Expression
over overArg overArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "over"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units1" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Product"
                                    [ Type.var "units1", Type.var "units2" ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units2" ]
                          )
                     )
             }
        )
        [ overArg, overArg0 ]


{-| Just like `over` but divide by a quantity in `units2`, resulting in another
quantity in `units1`. For example, we could divide a force by a desired
acceleration to determine how much mass could be accelerated at that rate:

    Force.newtons 100
        |> Quantity.over_
            (Acceleration.metersPerSecondSquared 5)
    --> Mass.kilograms 20

over_: 
    Quantity.Quantity Float units2
    -> Quantity.Quantity Float (Quantity.Product units1 units2)
    -> Quantity.Quantity Float units1
-}
over_ : Elm.Expression -> Elm.Expression -> Elm.Expression
over_ over_Arg over_Arg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "over_"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units2" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Product"
                                    [ Type.var "units1", Type.var "units2" ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units1" ]
                          )
                     )
             }
        )
        [ over_Arg, over_Arg0 ]


{-| Similar to [`timesUnitless`](#timesUnitless), `overUnitless` lets you
divide one quantity by a second [unitless](#Unitless) quantity without affecting
the units;

    quantity |> Quantity.overUnitless unitlessQuantity

is equivalent to

    quantity
        |> Quantity.divideBy
            (Quantity.toFloat unitlessQuantity)

overUnitless: 
    Quantity.Quantity Float Quantity.Unitless
    -> Quantity.Quantity Float units
    -> Quantity.Quantity Float units
-}
overUnitless : Elm.Expression -> Elm.Expression -> Elm.Expression
overUnitless overUnitlessArg overUnitlessArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "overUnitless"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ overUnitlessArg, overUnitlessArg0 ]


{-| Construct a rate of change by dividing a dependent quantity (numerator) by
an independent quantity (denominator):

    speed =
        Quantity.rate (Length.miles 1) Duration.minute

    speed |> Speed.inMilesPerHour
    --> 60

Note that we could directly use our rate of change value as a `Speed`! That is
because many built-in quantity types are defined as rates of change, for
example:

  - `Speed` is `Length` per `Duration`
  - `Acceleration` is `Speed` per `Duration`
  - `Pressure` is `Force` per `Area`
  - `Power` is `Energy` per `Duration`
  - `Current` is `Charge` per `Duration`
  - `Resistance` is `Voltage` per `Current`
  - `Voltage` is `Power` per `Current`

Note that there are [other forms of division](/#multiplication-and-division)!

rate: 
    Quantity.Quantity Float dependentUnits
    -> Quantity.Quantity Float independentUnits
    -> Quantity.Quantity Float (Quantity.Rate dependentUnits independentUnits)
-}
rate : Elm.Expression -> Elm.Expression -> Elm.Expression
rate rateArg rateArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "rate"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "dependentUnits" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "independentUnits" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "dependentUnits"
                                   , Type.var "independentUnits"
                                   ]
                               ]
                          )
                     )
             }
        )
        [ rateArg, rateArg0 ]


{-| 'Infix' version of [`rate`](#rate), meant to be used in pipeline form;

    Quantity.rate distance time

can be written as

    distance |> Quantity.per time

per: 
    Quantity.Quantity Float independentUnits
    -> Quantity.Quantity Float dependentUnits
    -> Quantity.Quantity Float (Quantity.Rate dependentUnits independentUnits)
-}
per : Elm.Expression -> Elm.Expression -> Elm.Expression
per perArg perArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "per"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "independentUnits" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "dependentUnits" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "dependentUnits"
                                   , Type.var "independentUnits"
                                   ]
                               ]
                          )
                     )
             }
        )
        [ perArg, perArg0 ]


{-| Multiply a rate of change by an independent quantity (the denominator in
the rate) to get a total value:

    Duration.minutes 30
        |> Quantity.at
            (Speed.kilometersPerHour 100)
    --> Length.kilometers 50

Can be useful to define conversion functions from one unit to another, since
if you define a `rate` then `Quantity.at rate` will give you a conversion
function:

    pixelDensity : Quantity Float (Rate Pixels Meters)
    pixelDensity =
        Pixels.pixels 96 |> Quantity.per (Length.inches 1)

    lengthToPixels : Length -> Quantity Float Pixels
    lengthToPixels length =
        Quantity.at pixelDensity length

    lengthToPixels (Length.inches 3)
    --> Pixels.pixels 288

Eagle-eyed readers will note that using partial application you could also
simply write

    lengthToPixels =
        Quantity.at pixelDensity

Note that there are [other forms of multiplication](/#multiplication-and-division)!

at: 
    Quantity.Quantity number (Quantity.Rate dependentUnits independentUnits)
    -> Quantity.Quantity number independentUnits
    -> Quantity.Quantity number dependentUnits
-}
at : Elm.Expression -> Elm.Expression -> Elm.Expression
at atArg atArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "at"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Rate"
                                    [ Type.var "dependentUnits"
                                    , Type.var "independentUnits"
                                    ]
                              ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "independentUnits" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "dependentUnits" ]
                          )
                     )
             }
        )
        [ atArg, atArg0 ]


{-| Given a rate and a _dependent_ quantity (total value), determine the
necessary amount of the _independent_ quantity:

    Length.kilometers 75
        |> Quantity.at_
            (Speed.kilometersPerHour 100)
    --> Duration.minutes 45

Where `at` performs multiplication, `at_` performs division - you multiply a
speed by a duration to get a distance, but you divide a distance by a speed to
get a duration.

Similar to `at`, `at_` can be used to define an _inverse_ conversion function:

    pixelDensity : Quantity Float (Rate Pixels Meters)
    pixelDensity =
        Pixels.pixels 96 |> Quantity.per (Length.inches 1)

    pixelsToLength : Quantity Float Pixels -> Length
    pixelsToLength pixels =
        Quantity.at_ pixelDensity pixels

    pixelsToLength (Pixels.pixels 48)
    --> Length.inches 0.5

at_: 
    Quantity.Quantity Float (Quantity.Rate dependentUnits independentUnits)
    -> Quantity.Quantity Float dependentUnits
    -> Quantity.Quantity Float independentUnits
-}
at_ : Elm.Expression -> Elm.Expression -> Elm.Expression
at_ at_Arg at_Arg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "at_"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Rate"
                                    [ Type.var "dependentUnits"
                                    , Type.var "independentUnits"
                                    ]
                              ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "dependentUnits" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "independentUnits" ]
                          )
                     )
             }
        )
        [ at_Arg, at_Arg0 ]


{-| Same as `at` but with the argument order flipped, which may read better
in some cases:

    Speed.kilometersPerHour 100
        |> Quantity.for
            (Duration.minutes 30)
    --> Length.kilometers 50

for: 
    Quantity.Quantity number independentUnits
    -> Quantity.Quantity number (Quantity.Rate dependentUnits independentUnits)
    -> Quantity.Quantity number dependentUnits
-}
for : Elm.Expression -> Elm.Expression -> Elm.Expression
for forArg forArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "for"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "independentUnits" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Rate"
                                    [ Type.var "dependentUnits"
                                    , Type.var "independentUnits"
                                    ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "dependentUnits" ]
                          )
                     )
             }
        )
        [ forArg, forArg0 ]


{-| Find the inverse of a given rate. May be useful if you are using a rate to
define a conversion, and want to convert the other way;

    Quantity.at (Quantity.inverse rate)

is equivalent to

    Quantity.at_ rate

inverse: 
    Quantity.Quantity Float (Quantity.Rate dependentUnits independentUnits)
    -> Quantity.Quantity Float (Quantity.Rate independentUnits dependentUnits)
-}
inverse : Elm.Expression -> Elm.Expression
inverse inverseArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "inverse"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Rate"
                                    [ Type.var "dependentUnits"
                                    , Type.var "independentUnits"
                                    ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "independentUnits"
                                   , Type.var "dependentUnits"
                                   ]
                               ]
                          )
                     )
             }
        )
        [ inverseArg ]


{-| Multiply two rates of change that 'cancel out' together, resulting in a new
rate. For example, if you know the real-world speed of an on-screen object and
the display resolution, then you can get the speed in pixels per second:

    realWorldSpeed =
        Speed.metersPerSecond 0.1

    resolution =
        Pixels.float 96 |> Quantity.per Length.inch

    Quantity.rateProduct realWorldSpeed resolution
    --> Pixels.pixelsPerSecond 377.95

That is, "length per duration" multiplyed by "pixels per length" gives you
"pixels per duration".

Sometimes you can't directly multiply two rates to get what you want, in which
case you may need to use [`inverse`](#inverse) in combination with
`rateProduct`. For example, if you know the on-screen speed of some object and
the display resolution, then you can use those to get the real-world speed:

    pixelSpeed =
        Pixels.pixelsPerSecond 500

    resolution =
        Pixels.float 96 |> Quantity.per Length.inch

    Quantity.rateProduct pixelSpeed
        (Quantity.inverse resolution)
    --> Speed.metersPerSecond 0.1323

rateProduct: 
    Quantity.Quantity Float (Quantity.Rate units2 units1)
    -> Quantity.Quantity Float (Quantity.Rate units3 units2)
    -> Quantity.Quantity Float (Quantity.Rate units3 units1)
-}
rateProduct : Elm.Expression -> Elm.Expression -> Elm.Expression
rateProduct rateProductArg rateProductArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "rateProduct"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Rate"
                                    [ Type.var "units2", Type.var "units1" ]
                              ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                    [ "Quantity" ]
                                    "Rate"
                                    [ Type.var "units3", Type.var "units2" ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "units3", Type.var "units1" ]
                               ]
                          )
                     )
             }
        )
        [ rateProductArg, rateProductArg0 ]


{-| modBy: 
    Quantity.Quantity Int units
    -> Quantity.Quantity Int units
    -> Quantity.Quantity Int units
-}
modBy : Elm.Expression -> Elm.Expression -> Elm.Expression
modBy modByArg modByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "modBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int, Type.var "units" ]
                          )
                     )
             }
        )
        [ modByArg, modByArg0 ]


{-| fractionalModBy: 
    Quantity.Quantity Float units
    -> Quantity.Quantity Float units
    -> Quantity.Quantity Float units
-}
fractionalModBy : Elm.Expression -> Elm.Expression -> Elm.Expression
fractionalModBy fractionalModByArg fractionalModByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "fractionalModBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ fractionalModByArg, fractionalModByArg0 ]


{-| remainderBy: 
    Quantity.Quantity Int units
    -> Quantity.Quantity Int units
    -> Quantity.Quantity Int units
-}
remainderBy : Elm.Expression -> Elm.Expression -> Elm.Expression
remainderBy remainderByArg remainderByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "remainderBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int, Type.var "units" ]
                          )
                     )
             }
        )
        [ remainderByArg, remainderByArg0 ]


{-| fractionalRemainderBy: 
    Quantity.Quantity Float units
    -> Quantity.Quantity Float units
    -> Quantity.Quantity Float units
-}
fractionalRemainderBy : Elm.Expression -> Elm.Expression -> Elm.Expression
fractionalRemainderBy fractionalRemainderByArg fractionalRemainderByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "fractionalRemainderBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ fractionalRemainderByArg, fractionalRemainderByArg0 ]


{-| Given a lower and upper bound, clamp a given quantity to within those
bounds. Say you wanted to clamp an angle to be between +/-30 degrees:

    lowerBound =
        Angle.degrees -30

    upperBound =
        Angle.degrees 30

    Quantity.clamp lowerBound upperBound (Angle.degrees 5)
    --> Angle.degrees 5

    -- One radian is approximately 57 degrees
    Quantity.clamp lowerBound upperBound (Angle.radians 1)
    --> Angle.degrees 30

    Quantity.clamp lowerBound upperBound (Angle.turns -0.5)
    --> Angle.degrees -30

clamp: 
    Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
    -> Quantity.Quantity number units
-}
clamp : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
clamp clampArg clampArg0 clampArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "clamp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ clampArg, clampArg0, clampArg1 ]


{-| Get the sign of a quantity. This will return 1, -1, 0 or NaN if the given
quantity is positive, negative, zero or NaN respectively.

    Quantity.sign (Length.meters 3)
    --> 1

    Quantity.sign (Length.meters -3)
    --> -1

    Quantity.sign (Length.meters 0)
    --> 0

    Quantity.sign Quantity.positiveInfinity
    --> 1

    Quantity.sign (Length.meters (0 / 0))
    --> NaN

sign: Quantity.Quantity Float units -> Float
-}
sign : Elm.Expression -> Elm.Expression
sign signArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "sign"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          Type.float
                     )
             }
        )
        [ signArg ]


{-| Interpolate from the first quantity to the second, based on a parameter that
ranges from zero to one. Passing a parameter value of zero will return the start
value and passing a parameter value of one will return the end value.

    fiveMeters =
        Length.meters 5

    tenMeters =
        Length.meters 10

    Quantity.interpolateFrom fiveMeters tenMeters 0
    --> Length.meters 5

    Quantity.interpolateFrom fiveMeters tenMeters 1
    --> Length.meters 10

    Quantity.interpolateFrom fiveMeters tenMeters 0.6
    --> Length.meters 8

The end value can be less than the start value:

    Quantity.interpolateFrom tenMeters fiveMeters 0.1
    --> Length.meters 9.5

Parameter values less than zero or greater than one can be used to extrapolate:

    Quantity.interpolateFrom fiveMeters tenMeters 1.5
    --> Length.meters 12.5

    Quantity.interpolateFrom fiveMeters tenMeters -0.5
    --> Length.meters 2.5

    Quantity.interpolateFrom tenMeters fiveMeters -0.2
    --> Length.meters 11

interpolateFrom: 
    Quantity.Quantity Float units
    -> Quantity.Quantity Float units
    -> Float
    -> Quantity.Quantity Float units
-}
interpolateFrom : Elm.Expression -> Elm.Expression -> Float -> Elm.Expression
interpolateFrom interpolateFromArg interpolateFromArg0 interpolateFromArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "interpolateFrom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          , Type.float
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ interpolateFromArg
        , interpolateFromArg0
        , Elm.float interpolateFromArg1
        ]


{-| Find the midpoint between two quantities.

    Quantity.midpoint (Length.meters 5) (Length.meters 10)
    --> Length.meters 7.5

midpoint: 
    Quantity.Quantity Float units
    -> Quantity.Quantity Float units
    -> Quantity.Quantity Float units
-}
midpoint : Elm.Expression -> Elm.Expression -> Elm.Expression
midpoint midpointArg midpointArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "midpoint"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ midpointArg, midpointArg0 ]


{-| Construct a range of evenly-spaced values given a `start` value, an `end`
value and the number of `steps` to take from the start to the end. The first
value in the returned list will be equal to `start` and the last value will be
equal to `end`. Note that the number of returned values will be one greater than
the number of steps!

    Quantity.range
        { start = Length.meters 2
        , end = Length.meters 3
        , steps = 5
        }
    --> [ Length.centimeters 200
    --> , Length.centimeters 220
    --> , Length.centimeters 240
    --> , Length.centimeters 260
    --> , Length.centimeters 280
    --> , Length.centimeters 300
    --> ]

The start and end values can be in either order:

    Quantity.range
        { start = Duration.hours 1
        , end = Quantity.zero
        , steps = 4
        }
    --> [ Duration.minutes 60
    --> , Duration.minutes 45
    --> , Duration.minutes 30
    --> , Duration.minutes 15
    --> , Duration.minutes 0
    --> ]

Passing a negative or zero `steps` value will result in an empty list being
returned.

If you need finer control over what values get generated, try combining
`interpolateFrom` with the various functions in the
[`elm-1d-parameter`](https://package.elm-lang.org/packages/ianmackenzie/elm-1d-parameter/latest/)
package. For example:

    -- Same as using Quantity.range
    Parameter1d.steps 4 <|
        Quantity.interpolateFrom
            (Length.meters 2)
            (Length.meters 3)
    --> [ Length.centimeters 200
    --> , Length.centimeters 225
    --> , Length.centimeters 250
    --> , Length.centimeters 275
    --> , Length.centimeters 300
    --> ]

    -- Omit the last value
    Parameter1d.leading 4 <|
        Quantity.interpolateFrom
            (Length.meters 2)
            (Length.meters 3)
    --> [ Length.centimeters 200
    --> , Length.centimeters 225
    --> , Length.centimeters 250
    --> , Length.centimeters 275
    --> ]

range: 
    { start : Quantity.Quantity Float units
    , end : Quantity.Quantity Float units
    , steps : Int
    }
    -> List (Quantity.Quantity Float units)
-}
range :
    { start : Elm.Expression, end : Elm.Expression, steps : Int }
    -> Elm.Expression
range rangeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "range"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "start"
                                , Type.namedWith
                                    [ "Quantity" ]
                                    "Quantity"
                                    [ Type.float, Type.var "units" ]
                                )
                              , ( "end"
                                , Type.namedWith
                                    [ "Quantity" ]
                                    "Quantity"
                                    [ Type.float, Type.var "units" ]
                                )
                              , ( "steps", Type.int )
                              ]
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Quantity" ]
                                    "Quantity"
                                    [ Type.float, Type.var "units" ]
                               )
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "start" rangeArg.start
            , Tuple.pair "end" rangeArg.end
            , Tuple.pair "steps" (Elm.int rangeArg.steps)
            ]
        ]


{-| Generalized units conversion function that lets you convert to many kinds of
units not directly supported by `elm-units`. The first argument is a function
that constructs a value of the desired unit type, and the second is the quantity
to convert. For example,

    Speed.metersPerSecond 5
        |> Speed.inFeetPerSecond
    --> 16.4042

is equivalent to

    Speed.metersPerSecond 5
        |> Quantity.in_ Speed.feetPerSecond
    --> 16.4042

More interestingly, if you wanted to get speed in some weirder unit like
millimeters per minute (not directly supported by `elm-units`), you could do

    Speed.metersPerSecond 5
        |> Quantity.in_
            (Length.millimeters
                >> Quantity.per (Duration.minutes 1)
            )
    --> 300000

Internally,

    Quantity.in_ someUnits someQuantity

is simply implemented as

    Quantity.ratio someQuantity (someUnits 1)

in_: 
    (Float -> Quantity.Quantity Float units)
    -> Quantity.Quantity Float units
    -> Float
-}
in_ : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
in_ in_Arg in_Arg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "in_"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.float ]
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.float, Type.var "units" ]
                              )
                          , Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          Type.float
                     )
             }
        )
        [ Elm.functionReduced "in_Unpack" in_Arg, in_Arg0 ]


{-| Round a `Float`-valued quantity to the nearest `Int`. Note that [this may
not do what you expect](#-int-float-conversion).

    Quantity.round (Pixels.pixels 3.5)
    --> Pixels.pixels 4

round: Quantity.Quantity Float units -> Quantity.Quantity Int units
-}
round : Elm.Expression -> Elm.Expression
round roundArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "round"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int, Type.var "units" ]
                          )
                     )
             }
        )
        [ roundArg ]


{-| Round a `Float`-valued quantity down to the nearest `Int`. Note that [this
may not do what you expect](#-int-float-conversion).

    Quantity.floor (Pixels.pixels 2.9)
    --> Pixels.pixels 2

    Quantity.floor (Pixels.pixels -2.1)
    --> Pixels.pixels -3

floor: Quantity.Quantity Float units -> Quantity.Quantity Int units
-}
floor : Elm.Expression -> Elm.Expression
floor floorArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "floor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int, Type.var "units" ]
                          )
                     )
             }
        )
        [ floorArg ]


{-| Round a `Float`-valued quantity up to the nearest `Int`. Note that [this may
not do what you expect](#-int-float-conversion).

    Quantity.ceiling (Pixels.pixels 1.2)
    --> Pixels.pixels 2

    Quantity.ceiling (Pixels.pixels -2.1)
    --> Pixels.pixels -2

ceiling: Quantity.Quantity Float units -> Quantity.Quantity Int units
-}
ceiling : Elm.Expression -> Elm.Expression
ceiling ceilingArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "ceiling"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int, Type.var "units" ]
                          )
                     )
             }
        )
        [ ceilingArg ]


{-| Round a `Float`-valued quantity towards zero. Note that [this may not do
what you expect](#-int-float-conversion).

    Quantity.truncate (Pixels.pixels -2.8)
    --> Pixels.pixels -2

truncate: Quantity.Quantity Float units -> Quantity.Quantity Int units
-}
truncate : Elm.Expression -> Elm.Expression
truncate truncateArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "truncate"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int, Type.var "units" ]
                          )
                     )
             }
        )
        [ truncateArg ]


{-| Convert a `Quantity Int units` to a `Quantity Float units` with the same
value. Useful when you have an `Int`-valued quantity and want to divide it by
something, multiply it by a fractional value etc.

toFloatQuantity: Quantity.Quantity Int units -> Quantity.Quantity Float units
-}
toFloatQuantity : Elm.Expression -> Elm.Expression
toFloatQuantity toFloatQuantityArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "toFloatQuantity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float, Type.var "units" ]
                          )
                     )
             }
        )
        [ toFloatQuantityArg ]


{-| Find the sum of a list of quantities.

    Quantity.sum
        [ Length.meters 1
        , Length.centimeters 2
        , Length.millimeters 3
        ]
    --> Length.meters 1.023

    Quantity.sum []
    --> Quantity.zero

sum: List (Quantity.Quantity number units) -> Quantity.Quantity number units
-}
sum : List Elm.Expression -> Elm.Expression
sum sumArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "sum"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.var "number", Type.var "units" ]
                              )
                          ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ Elm.list sumArg ]


{-| Find the minimum value in a list of quantities. Returns `Nothing` if the
list is empty.

    Quantity.minimum
        [ Mass.kilograms 1
        , Mass.pounds 2
        , Mass.tonnes 3
        ]
    --> Just (Mass.pounds 2)

minimum: List (Quantity.Quantity number units) -> Maybe (Quantity.Quantity number units)
-}
minimum : List Elm.Expression -> Elm.Expression
minimum minimumArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "minimum"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.var "number", Type.var "units" ]
                              )
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "Quantity" ]
                                    "Quantity"
                                    [ Type.var "number", Type.var "units" ]
                               )
                          )
                     )
             }
        )
        [ Elm.list minimumArg ]


{-| Find the maximum value in a list of quantities. Returns `Nothing` if the
list is empty.

    Quantity.maximum
        [ Mass.kilograms 1
        , Mass.pounds 2
        , Mass.tonnes 3
        ]
    --> Just (Mass.tonnes 3)

maximum: List (Quantity.Quantity number units) -> Maybe (Quantity.Quantity number units)
-}
maximum : List Elm.Expression -> Elm.Expression
maximum maximumArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "maximum"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.var "number", Type.var "units" ]
                              )
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "Quantity" ]
                                    "Quantity"
                                    [ Type.var "number", Type.var "units" ]
                               )
                          )
                     )
             }
        )
        [ Elm.list maximumArg ]


{-| Find the 'minimum' item in a list as measured by some derived `Quantity`:

    people =
        [ { name = "Bob", height = Length.meters 1.6 }
        , { name = "Charlie", height = Length.meters 2.0 }
        , { name = "Alice", height = Length.meters 1.8 }
        ]

    Quantity.minimumBy .height people
    --> Just { name = "Bob", height = Length.meters 1.6 }

If the list is empty, returns `Nothing`. If multiple items in the list are tied,
then the first one is returned.

minimumBy: (a -> Quantity.Quantity number units) -> List a -> Maybe a
-}
minimumBy :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
minimumBy minimumByArg minimumByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "minimumBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.var "number", Type.var "units" ]
                              )
                          , Type.list (Type.var "a")
                          ]
                          (Type.maybe (Type.var "a"))
                     )
             }
        )
        [ Elm.functionReduced "minimumByUnpack" minimumByArg
        , Elm.list minimumByArg0
        ]


{-| Find the 'maximum' item in a list as measured by some derived `Quantity`:

    people =
        [ { name = "Bob", height = Length.meters 1.6 }
        , { name = "Charlie", height = Length.meters 2.0 }
        , { name = "Alice", height = Length.meters 1.8 }
        ]

    Quantity.maximumBy .height people
    --> Just { name = "Charlie", height = Length.meters 2.0 }

If the list is empty, returns `Nothing`. If multiple items in the list are tied,
then the first one is returned.

maximumBy: (a -> Quantity.Quantity number units) -> List a -> Maybe a
-}
maximumBy :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
maximumBy maximumByArg maximumByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "maximumBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.var "number", Type.var "units" ]
                              )
                          , Type.list (Type.var "a")
                          ]
                          (Type.maybe (Type.var "a"))
                     )
             }
        )
        [ Elm.functionReduced "maximumByUnpack" maximumByArg
        , Elm.list maximumByArg0
        ]


{-| Sort a list of quantities.

    Quantity.sort
        [ Mass.kilograms 1
        , Mass.pounds 2
        , Mass.tonnes 3
        ]
    --> [ Mass.pounds 2
    --> , Mass.kilograms 1
    --> , Mass.tonnes 3
    --> ]

sort: List (Quantity.Quantity number units) -> List (Quantity.Quantity number units)
-}
sort : List Elm.Expression -> Elm.Expression
sort sortArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "sort"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.var "number", Type.var "units" ]
                              )
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Quantity" ]
                                    "Quantity"
                                    [ Type.var "number", Type.var "units" ]
                               )
                          )
                     )
             }
        )
        [ Elm.list sortArg ]


{-| Sort an arbitrary list of values by a derived `Quantity`. If you had

    people =
        [ { name = "Bob", height = Length.meters 1.6 }
        , { name = "Charlie", height = Length.meters 2.0 }
        , { name = "Alice", height = Length.meters 1.8 }
        ]

then you could sort by name with

    List.sortBy .name people
    --> [ { name = "Alice", height = Length.meters 1.8 }
    --> , { name = "Bob", height = Length.meters 1.6 }
    --> , { name = "Charlie", height = Length.meters 2.0 }
    --> ]

(nothing new there!), and sort by height with

    Quantity.sortBy .height people
    --> [ { name = "Bob", height = Length.meters 1.6 }
    --> , { name = "Alice", height = Length.meters 1.8 }
    --> , { name = "Charlie", height = Length.meters 2.0 }
    --> ]

sortBy: (a -> Quantity.Quantity number units) -> List a -> List a
-}
sortBy :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
sortBy sortByArg sortByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "sortBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "Quantity" ]
                                 "Quantity"
                                 [ Type.var "number", Type.var "units" ]
                              )
                          , Type.list (Type.var "a")
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ Elm.functionReduced "sortByUnpack" sortByArg, Elm.list sortByArg0 ]


{-| Convert a plain `Int` into a `Quantity Int Unitless` value.

int: Int -> Quantity.Quantity Int Quantity.Unitless
-}
int : Int -> Elm.Expression
int intArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "int"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.int
                               , Type.namedWith [ "Quantity" ] "Unitless" []
                               ]
                          )
                     )
             }
        )
        [ Elm.int intArg ]


{-| Convert a `Quantity Int Unitless` value into a plain `Int`.

toInt: Quantity.Quantity Int Quantity.Unitless -> Int
-}
toInt : Elm.Expression -> Elm.Expression
toInt toIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "toInt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          ]
                          Type.int
                     )
             }
        )
        [ toIntArg ]


{-| Convert a plain `Float` into a `Quantity Float Unitless` value.

float: Float -> Quantity.Quantity Float Quantity.Unitless
-}
float : Float -> Elm.Expression
float floatArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "float"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.float
                               , Type.namedWith [ "Quantity" ] "Unitless" []
                               ]
                          )
                     )
             }
        )
        [ Elm.float floatArg ]


{-| Convert a `Quantity Float Unitless` value into a plain `Float`.

If you're looking for a function to convert a `Quantity Int units` to `Quantity
Float units`, check out [`toFloatQuantity`](#toFloatQuantity).

toFloat: Quantity.Quantity Float Quantity.Unitless -> Float
-}
toFloat : Elm.Expression -> Elm.Expression
toFloat toFloatArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "toFloat"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                          ]
                          Type.float
                     )
             }
        )
        [ toFloatArg ]


{-| unsafe: number -> Quantity.Quantity number units -}
unsafe : Elm.Expression -> Elm.Expression
unsafe unsafeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "unsafe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "number" ]
                          (Type.namedWith
                               [ "Quantity" ]
                               "Quantity"
                               [ Type.var "number", Type.var "units" ]
                          )
                     )
             }
        )
        [ unsafeArg ]


{-| unwrap: Quantity.Quantity number units -> number -}
unwrap : Elm.Expression -> Elm.Expression
unwrap unwrapArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Quantity" ]
             , name = "unwrap"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                          ]
                          (Type.var "number")
                     )
             }
        )
        [ unwrapArg ]


annotation_ :
    { quantity : Type.Annotation -> Type.Annotation -> Type.Annotation
    , squared : Type.Annotation -> Type.Annotation
    , cubed : Type.Annotation -> Type.Annotation
    , product : Type.Annotation -> Type.Annotation -> Type.Annotation
    , rate : Type.Annotation -> Type.Annotation -> Type.Annotation
    , unitless : Type.Annotation
    }
annotation_ =
    { quantity =
        \quantityArg0 quantityArg1 ->
            Type.namedWith
                [ "Quantity" ]
                "Quantity"
                [ quantityArg0, quantityArg1 ]
    , squared =
        \squaredArg0 ->
            Type.alias
                moduleName_
                "Squared"
                [ squaredArg0 ]
                (Type.namedWith
                     [ "Quantity" ]
                     "Product"
                     [ Type.var "units", Type.var "units" ]
                )
    , cubed =
        \cubedArg0 ->
            Type.alias
                moduleName_
                "Cubed"
                [ cubedArg0 ]
                (Type.namedWith
                     [ "Quantity" ]
                     "Product"
                     [ Type.namedWith
                         [ "Quantity" ]
                         "Product"
                         [ Type.var "units", Type.var "units" ]
                     , Type.var "units"
                     ]
                )
    , product =
        \productArg0 productArg1 ->
            Type.namedWith [ "Quantity" ] "Product" [ productArg0, productArg1 ]
    , rate =
        \rateArg0 rateArg1 ->
            Type.namedWith [ "Quantity" ] "Rate" [ rateArg0, rateArg1 ]
    , unitless = Type.namedWith [ "Quantity" ] "Unitless" []
    }


make_ : { quantity : Elm.Expression -> Elm.Expression }
make_ =
    { quantity =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "Quantity"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Quantity"
                                  [ Type.var "number", Type.var "units" ]
                             )
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { quantity :
        Elm.Expression
        -> { quantityTags_0_0 | quantity : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { quantity =
        \quantityExpression quantityTags ->
            Elm.Case.custom
                quantityExpression
                (Type.namedWith
                     [ "Quantity" ]
                     "Quantity"
                     [ Type.var "number", Type.var "units" ]
                )
                [ Elm.Case.branch1
                    "Quantity"
                    ( "number", Type.var "number" )
                    quantityTags.quantity
                ]
    }


call_ :
    { lessThan : Elm.Expression -> Elm.Expression -> Elm.Expression
    , greaterThan : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lessThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
    , greaterThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lessThanZero : Elm.Expression -> Elm.Expression
    , greaterThanZero : Elm.Expression -> Elm.Expression
    , lessThanOrEqualToZero : Elm.Expression -> Elm.Expression
    , greaterThanOrEqualToZero : Elm.Expression -> Elm.Expression
    , compare : Elm.Expression -> Elm.Expression -> Elm.Expression
    , equalWithin :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , max : Elm.Expression -> Elm.Expression -> Elm.Expression
    , min : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isNaN : Elm.Expression -> Elm.Expression
    , isInfinite : Elm.Expression -> Elm.Expression
    , negate : Elm.Expression -> Elm.Expression
    , abs : Elm.Expression -> Elm.Expression
    , plus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , difference : Elm.Expression -> Elm.Expression -> Elm.Expression
    , minus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , multiplyBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , divideBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , twice : Elm.Expression -> Elm.Expression
    , half : Elm.Expression -> Elm.Expression
    , ratio : Elm.Expression -> Elm.Expression -> Elm.Expression
    , squared : Elm.Expression -> Elm.Expression
    , sqrt : Elm.Expression -> Elm.Expression
    , cubed : Elm.Expression -> Elm.Expression
    , cbrt : Elm.Expression -> Elm.Expression
    , squaredUnitless : Elm.Expression -> Elm.Expression
    , sqrtUnitless : Elm.Expression -> Elm.Expression
    , cubedUnitless : Elm.Expression -> Elm.Expression
    , cbrtUnitless : Elm.Expression -> Elm.Expression
    , reciprocal : Elm.Expression -> Elm.Expression
    , product : Elm.Expression -> Elm.Expression -> Elm.Expression
    , times : Elm.Expression -> Elm.Expression -> Elm.Expression
    , timesUnitless : Elm.Expression -> Elm.Expression -> Elm.Expression
    , over : Elm.Expression -> Elm.Expression -> Elm.Expression
    , over_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , overUnitless : Elm.Expression -> Elm.Expression -> Elm.Expression
    , rate : Elm.Expression -> Elm.Expression -> Elm.Expression
    , per : Elm.Expression -> Elm.Expression -> Elm.Expression
    , at : Elm.Expression -> Elm.Expression -> Elm.Expression
    , at_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , for : Elm.Expression -> Elm.Expression -> Elm.Expression
    , inverse : Elm.Expression -> Elm.Expression
    , rateProduct : Elm.Expression -> Elm.Expression -> Elm.Expression
    , modBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fractionalModBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , remainderBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fractionalRemainderBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clamp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , sign : Elm.Expression -> Elm.Expression
    , interpolateFrom :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , midpoint : Elm.Expression -> Elm.Expression -> Elm.Expression
    , range : Elm.Expression -> Elm.Expression
    , in_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , round : Elm.Expression -> Elm.Expression
    , floor : Elm.Expression -> Elm.Expression
    , ceiling : Elm.Expression -> Elm.Expression
    , truncate : Elm.Expression -> Elm.Expression
    , toFloatQuantity : Elm.Expression -> Elm.Expression
    , sum : Elm.Expression -> Elm.Expression
    , minimum : Elm.Expression -> Elm.Expression
    , maximum : Elm.Expression -> Elm.Expression
    , minimumBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , maximumBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , sort : Elm.Expression -> Elm.Expression
    , sortBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    , toInt : Elm.Expression -> Elm.Expression
    , float : Elm.Expression -> Elm.Expression
    , toFloat : Elm.Expression -> Elm.Expression
    , unsafe : Elm.Expression -> Elm.Expression
    , unwrap : Elm.Expression -> Elm.Expression
    }
call_ =
    { lessThan =
        \lessThanArg lessThanArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "lessThan"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ lessThanArg, lessThanArg0 ]
    , greaterThan =
        \greaterThanArg greaterThanArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "greaterThan"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ greaterThanArg, greaterThanArg0 ]
    , lessThanOrEqualTo =
        \lessThanOrEqualToArg lessThanOrEqualToArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "lessThanOrEqualTo"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ lessThanOrEqualToArg, lessThanOrEqualToArg0 ]
    , greaterThanOrEqualTo =
        \greaterThanOrEqualToArg greaterThanOrEqualToArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "greaterThanOrEqualTo"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ greaterThanOrEqualToArg, greaterThanOrEqualToArg0 ]
    , lessThanZero =
        \lessThanZeroArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "lessThanZero"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ lessThanZeroArg ]
    , greaterThanZero =
        \greaterThanZeroArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "greaterThanZero"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ greaterThanZeroArg ]
    , lessThanOrEqualToZero =
        \lessThanOrEqualToZeroArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "lessThanOrEqualToZero"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ lessThanOrEqualToZeroArg ]
    , greaterThanOrEqualToZero =
        \greaterThanOrEqualToZeroArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "greaterThanOrEqualToZero"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ greaterThanOrEqualToZeroArg ]
    , compare =
        \compareArg compareArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "compare"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith [ "Basics" ] "Order" [])
                             )
                     }
                )
                [ compareArg, compareArg0 ]
    , equalWithin =
        \equalWithinArg equalWithinArg0 equalWithinArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "equalWithin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ equalWithinArg, equalWithinArg0, equalWithinArg1 ]
    , max =
        \maxArg maxArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "max"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ maxArg, maxArg0 ]
    , min =
        \minArg minArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "min"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ minArg, minArg0 ]
    , isNaN =
        \isNaNArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "isNaN"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ isNaNArg ]
    , isInfinite =
        \isInfiniteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "isInfinite"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ isInfiniteArg ]
    , negate =
        \negateArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "negate"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ negateArg ]
    , abs =
        \absArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "abs"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ absArg ]
    , plus =
        \plusArg plusArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "plus"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ plusArg, plusArg0 ]
    , difference =
        \differenceArg differenceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "difference"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ differenceArg, differenceArg0 ]
    , minus =
        \minusArg minusArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "minus"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ minusArg, minusArg0 ]
    , multiplyBy =
        \multiplyByArg multiplyByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "multiplyBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "number"
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ multiplyByArg, multiplyByArg0 ]
    , divideBy =
        \divideByArg divideByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "divideBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ divideByArg, divideByArg0 ]
    , twice =
        \twiceArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "twice"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ twiceArg ]
    , half =
        \halfArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "half"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ halfArg ]
    , ratio =
        \ratioArg ratioArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "ratio"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  Type.float
                             )
                     }
                )
                [ ratioArg, ratioArg0 ]
    , squared =
        \squaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "squared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Squared"
                                           [ Type.var "units" ]
                                       ]
                                  )
                             )
                     }
                )
                [ squaredArg ]
    , sqrt =
        \sqrtArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "sqrt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Squared"
                                            [ Type.var "units" ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ sqrtArg ]
    , cubed =
        \cubedArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "cubed"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Cubed"
                                           [ Type.var "units" ]
                                       ]
                                  )
                             )
                     }
                )
                [ cubedArg ]
    , cbrt =
        \cbrtArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "cbrt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Cubed"
                                            [ Type.var "units" ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ cbrtArg ]
    , squaredUnitless =
        \squaredUnitlessArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "squaredUnitless"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Unitless"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ squaredUnitlessArg ]
    , sqrtUnitless =
        \sqrtUnitlessArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "sqrtUnitless"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Unitless"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ sqrtUnitlessArg ]
    , cubedUnitless =
        \cubedUnitlessArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "cubedUnitless"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Unitless"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ cubedUnitlessArg ]
    , cbrtUnitless =
        \cbrtUnitlessArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "cbrtUnitless"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Unitless"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ cbrtUnitlessArg ]
    , reciprocal =
        \reciprocalArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "reciprocal"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Unitless"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ reciprocalArg ]
    , product =
        \productArg productArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "product"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units1" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units2" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Product"
                                           [ Type.var "units1"
                                           , Type.var "units2"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ productArg, productArg0 ]
    , times =
        \timesArg timesArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "times"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units2" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units1" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Product"
                                           [ Type.var "units1"
                                           , Type.var "units2"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ timesArg, timesArg0 ]
    , timesUnitless =
        \timesUnitlessArg timesUnitlessArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "timesUnitless"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ timesUnitlessArg, timesUnitlessArg0 ]
    , over =
        \overArg overArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "over"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units1" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Product"
                                            [ Type.var "units1"
                                            , Type.var "units2"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units2" ]
                                  )
                             )
                     }
                )
                [ overArg, overArg0 ]
    , over_ =
        \over_Arg over_Arg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "over_"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units2" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Product"
                                            [ Type.var "units1"
                                            , Type.var "units2"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units1" ]
                                  )
                             )
                     }
                )
                [ over_Arg, over_Arg0 ]
    , overUnitless =
        \overUnitlessArg overUnitlessArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "overUnitless"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ overUnitlessArg, overUnitlessArg0 ]
    , rate =
        \rateArg rateArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "rate"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "dependentUnits" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.var "independentUnits"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Rate"
                                           [ Type.var "dependentUnits"
                                           , Type.var "independentUnits"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ rateArg, rateArg0 ]
    , per =
        \perArg perArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "per"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.var "independentUnits"
                                      ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "dependentUnits" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Rate"
                                           [ Type.var "dependentUnits"
                                           , Type.var "independentUnits"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ perArg, perArg0 ]
    , at =
        \atArg atArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "at"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Rate"
                                            [ Type.var "dependentUnits"
                                            , Type.var "independentUnits"
                                            ]
                                      ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.var "independentUnits"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.var "dependentUnits"
                                       ]
                                  )
                             )
                     }
                )
                [ atArg, atArg0 ]
    , at_ =
        \at_Arg at_Arg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "at_"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Rate"
                                            [ Type.var "dependentUnits"
                                            , Type.var "independentUnits"
                                            ]
                                      ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "dependentUnits" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.var "independentUnits"
                                       ]
                                  )
                             )
                     }
                )
                [ at_Arg, at_Arg0 ]
    , for =
        \forArg forArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "for"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.var "independentUnits"
                                      ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number"
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Rate"
                                            [ Type.var "dependentUnits"
                                            , Type.var "independentUnits"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number"
                                       , Type.var "dependentUnits"
                                       ]
                                  )
                             )
                     }
                )
                [ forArg, forArg0 ]
    , inverse =
        \inverseArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "inverse"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Rate"
                                            [ Type.var "dependentUnits"
                                            , Type.var "independentUnits"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Rate"
                                           [ Type.var "independentUnits"
                                           , Type.var "dependentUnits"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ inverseArg ]
    , rateProduct =
        \rateProductArg rateProductArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "rateProduct"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Rate"
                                            [ Type.var "units2"
                                            , Type.var "units1"
                                            ]
                                      ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Rate"
                                            [ Type.var "units3"
                                            , Type.var "units2"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Rate"
                                           [ Type.var "units3"
                                           , Type.var "units1"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ rateProductArg, rateProductArg0 ]
    , modBy =
        \modByArg modByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "modBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.int, Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.int, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ modByArg, modByArg0 ]
    , fractionalModBy =
        \fractionalModByArg fractionalModByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "fractionalModBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ fractionalModByArg, fractionalModByArg0 ]
    , remainderBy =
        \remainderByArg remainderByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "remainderBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.int, Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.int, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ remainderByArg, remainderByArg0 ]
    , fractionalRemainderBy =
        \fractionalRemainderByArg fractionalRemainderByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "fractionalRemainderBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ fractionalRemainderByArg, fractionalRemainderByArg0 ]
    , clamp =
        \clampArg clampArg0 clampArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "clamp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ clampArg, clampArg0, clampArg1 ]
    , sign =
        \signArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "sign"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  Type.float
                             )
                     }
                )
                [ signArg ]
    , interpolateFrom =
        \interpolateFromArg interpolateFromArg0 interpolateFromArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "interpolateFrom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  , Type.float
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ interpolateFromArg, interpolateFromArg0, interpolateFromArg1 ]
    , midpoint =
        \midpointArg midpointArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "midpoint"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ midpointArg, midpointArg0 ]
    , range =
        \rangeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "range"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "start"
                                        , Type.namedWith
                                            [ "Quantity" ]
                                            "Quantity"
                                            [ Type.float, Type.var "units" ]
                                        )
                                      , ( "end"
                                        , Type.namedWith
                                            [ "Quantity" ]
                                            "Quantity"
                                            [ Type.float, Type.var "units" ]
                                        )
                                      , ( "steps", Type.int )
                                      ]
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Quantity" ]
                                            "Quantity"
                                            [ Type.float, Type.var "units" ]
                                       )
                                  )
                             )
                     }
                )
                [ rangeArg ]
    , in_ =
        \in_Arg in_Arg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "in_"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.float ]
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.float, Type.var "units" ]
                                      )
                                  , Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  Type.float
                             )
                     }
                )
                [ in_Arg, in_Arg0 ]
    , round =
        \roundArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "round"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ roundArg ]
    , floor =
        \floorArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "floor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ floorArg ]
    , ceiling =
        \ceilingArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "ceiling"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ ceilingArg ]
    , truncate =
        \truncateArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "truncate"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ truncateArg ]
    , toFloatQuantity =
        \toFloatQuantityArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "toFloatQuantity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.int, Type.var "units" ]
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float, Type.var "units" ]
                                  )
                             )
                     }
                )
                [ toFloatQuantityArg ]
    , sum =
        \sumArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "sum"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.var "number", Type.var "units" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ sumArg ]
    , minimum =
        \minimumArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "minimum"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.var "number", Type.var "units" ]
                                      )
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "Quantity" ]
                                            "Quantity"
                                            [ Type.var "number"
                                            , Type.var "units"
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ minimumArg ]
    , maximum =
        \maximumArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "maximum"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.var "number", Type.var "units" ]
                                      )
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "Quantity" ]
                                            "Quantity"
                                            [ Type.var "number"
                                            , Type.var "units"
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ maximumArg ]
    , minimumBy =
        \minimumByArg minimumByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "minimumBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.var "number", Type.var "units" ]
                                      )
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.maybe (Type.var "a"))
                             )
                     }
                )
                [ minimumByArg, minimumByArg0 ]
    , maximumBy =
        \maximumByArg maximumByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "maximumBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.var "number", Type.var "units" ]
                                      )
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.maybe (Type.var "a"))
                             )
                     }
                )
                [ maximumByArg, maximumByArg0 ]
    , sort =
        \sortArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "sort"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.var "number", Type.var "units" ]
                                      )
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Quantity" ]
                                            "Quantity"
                                            [ Type.var "number"
                                            , Type.var "units"
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ sortArg ]
    , sortBy =
        \sortByArg sortByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "sortBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "Quantity" ]
                                         "Quantity"
                                         [ Type.var "number", Type.var "units" ]
                                      )
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ sortByArg, sortByArg0 ]
    , int =
        \intArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "int"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.int
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Unitless"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ intArg ]
    , toInt =
        \toIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "toInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.int
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  ]
                                  Type.int
                             )
                     }
                )
                [ toIntArg ]
    , float =
        \floatArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "float"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.float
                                       , Type.namedWith
                                           [ "Quantity" ]
                                           "Unitless"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ floatArg ]
    , toFloat =
        \toFloatArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "toFloat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.float
                                      , Type.namedWith
                                            [ "Quantity" ]
                                            "Unitless"
                                            []
                                      ]
                                  ]
                                  Type.float
                             )
                     }
                )
                [ toFloatArg ]
    , unsafe =
        \unsafeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "unsafe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "number" ]
                                  (Type.namedWith
                                       [ "Quantity" ]
                                       "Quantity"
                                       [ Type.var "number", Type.var "units" ]
                                  )
                             )
                     }
                )
                [ unsafeArg ]
    , unwrap =
        \unwrapArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Quantity" ]
                     , name = "unwrap"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Quantity" ]
                                      "Quantity"
                                      [ Type.var "number", Type.var "units" ]
                                  ]
                                  (Type.var "number")
                             )
                     }
                )
                [ unwrapArg ]
    }


values_ :
    { zero : Elm.Expression
    , infinity : Elm.Expression
    , positiveInfinity : Elm.Expression
    , negativeInfinity : Elm.Expression
    , lessThan : Elm.Expression
    , greaterThan : Elm.Expression
    , lessThanOrEqualTo : Elm.Expression
    , greaterThanOrEqualTo : Elm.Expression
    , lessThanZero : Elm.Expression
    , greaterThanZero : Elm.Expression
    , lessThanOrEqualToZero : Elm.Expression
    , greaterThanOrEqualToZero : Elm.Expression
    , compare : Elm.Expression
    , equalWithin : Elm.Expression
    , max : Elm.Expression
    , min : Elm.Expression
    , isNaN : Elm.Expression
    , isInfinite : Elm.Expression
    , negate : Elm.Expression
    , abs : Elm.Expression
    , plus : Elm.Expression
    , difference : Elm.Expression
    , minus : Elm.Expression
    , multiplyBy : Elm.Expression
    , divideBy : Elm.Expression
    , twice : Elm.Expression
    , half : Elm.Expression
    , ratio : Elm.Expression
    , squared : Elm.Expression
    , sqrt : Elm.Expression
    , cubed : Elm.Expression
    , cbrt : Elm.Expression
    , squaredUnitless : Elm.Expression
    , sqrtUnitless : Elm.Expression
    , cubedUnitless : Elm.Expression
    , cbrtUnitless : Elm.Expression
    , reciprocal : Elm.Expression
    , product : Elm.Expression
    , times : Elm.Expression
    , timesUnitless : Elm.Expression
    , over : Elm.Expression
    , over_ : Elm.Expression
    , overUnitless : Elm.Expression
    , rate : Elm.Expression
    , per : Elm.Expression
    , at : Elm.Expression
    , at_ : Elm.Expression
    , for : Elm.Expression
    , inverse : Elm.Expression
    , rateProduct : Elm.Expression
    , modBy : Elm.Expression
    , fractionalModBy : Elm.Expression
    , remainderBy : Elm.Expression
    , fractionalRemainderBy : Elm.Expression
    , clamp : Elm.Expression
    , sign : Elm.Expression
    , interpolateFrom : Elm.Expression
    , midpoint : Elm.Expression
    , range : Elm.Expression
    , in_ : Elm.Expression
    , round : Elm.Expression
    , floor : Elm.Expression
    , ceiling : Elm.Expression
    , truncate : Elm.Expression
    , toFloatQuantity : Elm.Expression
    , sum : Elm.Expression
    , minimum : Elm.Expression
    , maximum : Elm.Expression
    , minimumBy : Elm.Expression
    , maximumBy : Elm.Expression
    , sort : Elm.Expression
    , sortBy : Elm.Expression
    , int : Elm.Expression
    , toInt : Elm.Expression
    , float : Elm.Expression
    , toFloat : Elm.Expression
    , unsafe : Elm.Expression
    , unwrap : Elm.Expression
    }
values_ =
    { zero =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "zero"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Quantity" ]
                         "Quantity"
                         [ Type.var "number", Type.var "units" ]
                    )
            }
    , infinity =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "infinity"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Quantity" ]
                         "Quantity"
                         [ Type.float, Type.var "units" ]
                    )
            }
    , positiveInfinity =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "positiveInfinity"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Quantity" ]
                         "Quantity"
                         [ Type.float, Type.var "units" ]
                    )
            }
    , negativeInfinity =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "negativeInfinity"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Quantity" ]
                         "Quantity"
                         [ Type.float, Type.var "units" ]
                    )
            }
    , lessThan =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "lessThan"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , greaterThan =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "greaterThan"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , lessThanOrEqualTo =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "lessThanOrEqualTo"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , greaterThanOrEqualTo =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "greaterThanOrEqualTo"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , lessThanZero =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "lessThanZero"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , greaterThanZero =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "greaterThanZero"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , lessThanOrEqualToZero =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "lessThanOrEqualToZero"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , greaterThanOrEqualToZero =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "greaterThanOrEqualToZero"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , compare =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "compare"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith [ "Basics" ] "Order" [])
                    )
            }
    , equalWithin =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "equalWithin"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , max =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "max"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , min =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "min"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , isNaN =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "isNaN"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , isInfinite =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "isInfinite"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         Type.bool
                    )
            }
    , negate =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "negate"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , abs =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "abs"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , plus =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "plus"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , difference =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "difference"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , minus =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "minus"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , multiplyBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "multiplyBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "number"
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , divideBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "divideBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.float
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , twice =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "twice"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , half =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "half"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , ratio =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "ratio"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         Type.float
                    )
            }
    , squared =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "squared"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Squared"
                                  [ Type.var "units" ]
                              ]
                         )
                    )
            }
    , sqrt =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "sqrt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Squared"
                                   [ Type.var "units" ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , cubed =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "cubed"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Cubed"
                                  [ Type.var "units" ]
                              ]
                         )
                    )
            }
    , cbrt =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "cbrt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Cubed"
                                   [ Type.var "units" ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , squaredUnitless =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "squaredUnitless"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number"
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                         )
                    )
            }
    , sqrtUnitless =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "sqrtUnitless"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                         )
                    )
            }
    , cubedUnitless =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "cubedUnitless"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number"
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                         )
                    )
            }
    , cbrtUnitless =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "cbrtUnitless"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                         )
                    )
            }
    , reciprocal =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "reciprocal"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                         )
                    )
            }
    , product =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "product"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units1" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units2" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Product"
                                  [ Type.var "units1", Type.var "units2" ]
                              ]
                         )
                    )
            }
    , times =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "times"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units2" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units1" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number"
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Product"
                                  [ Type.var "units1", Type.var "units2" ]
                              ]
                         )
                    )
            }
    , timesUnitless =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "timesUnitless"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number"
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , over =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "over"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units1" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Product"
                                   [ Type.var "units1", Type.var "units2" ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units2" ]
                         )
                    )
            }
    , over_ =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "over_"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units2" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Product"
                                   [ Type.var "units1", Type.var "units2" ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units1" ]
                         )
                    )
            }
    , overUnitless =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "overUnitless"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , rate =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "rate"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "dependentUnits" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "independentUnits" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Rate"
                                  [ Type.var "dependentUnits"
                                  , Type.var "independentUnits"
                                  ]
                              ]
                         )
                    )
            }
    , per =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "per"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "independentUnits" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "dependentUnits" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Rate"
                                  [ Type.var "dependentUnits"
                                  , Type.var "independentUnits"
                                  ]
                              ]
                         )
                    )
            }
    , at =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "at"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number"
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "dependentUnits"
                                   , Type.var "independentUnits"
                                   ]
                             ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "independentUnits" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "dependentUnits" ]
                         )
                    )
            }
    , at_ =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "at_"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "dependentUnits"
                                   , Type.var "independentUnits"
                                   ]
                             ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "dependentUnits" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "independentUnits" ]
                         )
                    )
            }
    , for =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "for"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "independentUnits" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number"
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "dependentUnits"
                                   , Type.var "independentUnits"
                                   ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "dependentUnits" ]
                         )
                    )
            }
    , inverse =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "inverse"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "dependentUnits"
                                   , Type.var "independentUnits"
                                   ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Rate"
                                  [ Type.var "independentUnits"
                                  , Type.var "dependentUnits"
                                  ]
                              ]
                         )
                    )
            }
    , rateProduct =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "rateProduct"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "units2", Type.var "units1" ]
                             ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith
                                   [ "Quantity" ]
                                   "Rate"
                                   [ Type.var "units3", Type.var "units2" ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith
                                  [ "Quantity" ]
                                  "Rate"
                                  [ Type.var "units3", Type.var "units1" ]
                              ]
                         )
                    )
            }
    , modBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "modBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.int, Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.int, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                         )
                    )
            }
    , fractionalModBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "fractionalModBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , remainderBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "remainderBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.int, Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.int, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                         )
                    )
            }
    , fractionalRemainderBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "fractionalRemainderBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , clamp =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "clamp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , sign =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "sign"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         Type.float
                    )
            }
    , interpolateFrom =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "interpolateFrom"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         , Type.float
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , midpoint =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "midpoint"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , range =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "range"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "start"
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Quantity"
                                   [ Type.float, Type.var "units" ]
                               )
                             , ( "end"
                               , Type.namedWith
                                   [ "Quantity" ]
                                   "Quantity"
                                   [ Type.float, Type.var "units" ]
                               )
                             , ( "steps", Type.int )
                             ]
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "Quantity" ]
                                   "Quantity"
                                   [ Type.float, Type.var "units" ]
                              )
                         )
                    )
            }
    , in_ =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "in_"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.float ]
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.float, Type.var "units" ]
                             )
                         , Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         Type.float
                    )
            }
    , round =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "round"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                         )
                    )
            }
    , floor =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "floor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                         )
                    )
            }
    , ceiling =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "ceiling"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                         )
                    )
            }
    , truncate =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "truncate"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int, Type.var "units" ]
                         )
                    )
            }
    , toFloatQuantity =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "toFloatQuantity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.int, Type.var "units" ]
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float, Type.var "units" ]
                         )
                    )
            }
    , sum =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "sum"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.var "number", Type.var "units" ]
                             )
                         ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , minimum =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "minimum"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.var "number", Type.var "units" ]
                             )
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "Quantity" ]
                                   "Quantity"
                                   [ Type.var "number", Type.var "units" ]
                              )
                         )
                    )
            }
    , maximum =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "maximum"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.var "number", Type.var "units" ]
                             )
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "Quantity" ]
                                   "Quantity"
                                   [ Type.var "number", Type.var "units" ]
                              )
                         )
                    )
            }
    , minimumBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "minimumBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.var "number", Type.var "units" ]
                             )
                         , Type.list (Type.var "a")
                         ]
                         (Type.maybe (Type.var "a"))
                    )
            }
    , maximumBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "maximumBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.var "number", Type.var "units" ]
                             )
                         , Type.list (Type.var "a")
                         ]
                         (Type.maybe (Type.var "a"))
                    )
            }
    , sort =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "sort"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.var "number", Type.var "units" ]
                             )
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "Quantity" ]
                                   "Quantity"
                                   [ Type.var "number", Type.var "units" ]
                              )
                         )
                    )
            }
    , sortBy =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "sortBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "Quantity" ]
                                "Quantity"
                                [ Type.var "number", Type.var "units" ]
                             )
                         , Type.list (Type.var "a")
                         ]
                         (Type.list (Type.var "a"))
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.int
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                         )
                    )
            }
    , toInt =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "toInt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.int
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         ]
                         Type.int
                    )
            }
    , float =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "float"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.float
                              , Type.namedWith [ "Quantity" ] "Unitless" []
                              ]
                         )
                    )
            }
    , toFloat =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "toFloat"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.float
                             , Type.namedWith [ "Quantity" ] "Unitless" []
                             ]
                         ]
                         Type.float
                    )
            }
    , unsafe =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "unsafe"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "number" ]
                         (Type.namedWith
                              [ "Quantity" ]
                              "Quantity"
                              [ Type.var "number", Type.var "units" ]
                         )
                    )
            }
    , unwrap =
        Elm.value
            { importFrom = [ "Quantity" ]
            , name = "unwrap"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Quantity" ]
                             "Quantity"
                             [ Type.var "number", Type.var "units" ]
                         ]
                         (Type.var "number")
                    )
            }
    }