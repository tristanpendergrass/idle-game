module Gen.Temperature exposing (absoluteZero, annotation_, call_, celsiusDegree, celsiusDegrees, clamp, compare, degreesCelsius, degreesFahrenheit, equalWithin, fahrenheitDegree, fahrenheitDegrees, greaterThan, greaterThanOrEqualTo, inCelsiusDegrees, inDegreesCelsius, inDegreesFahrenheit, inFahrenheitDegrees, inKelvins, kelvins, lessThan, lessThanOrEqualTo, max, maximum, min, minimum, minus, moduleName_, plus, sort, sortBy, values_)

{-| 
@docs moduleName_, degreesCelsius, inDegreesCelsius, degreesFahrenheit, inDegreesFahrenheit, kelvins, inKelvins, absoluteZero, celsiusDegrees, inCelsiusDegrees, fahrenheitDegrees, inFahrenheitDegrees, celsiusDegree, fahrenheitDegree, lessThan, greaterThan, lessThanOrEqualTo, greaterThanOrEqualTo, compare, equalWithin, min, max, plus, minus, clamp, minimum, maximum, sort, sortBy, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Temperature" ]


{-| Construct a temperature from a number of degrees Celsius.

degreesCelsius: Float -> Temperature.Temperature
-}
degreesCelsius : Float -> Elm.Expression
degreesCelsius degreesCelsiusArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "degreesCelsius"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Temperature" ] "Temperature" [])
                     )
             }
        )
        [ Elm.float degreesCelsiusArg ]


{-| Convert a temperature to a number of degrees Celsius.

inDegreesCelsius: Temperature.Temperature -> Float
-}
inDegreesCelsius : Elm.Expression -> Elm.Expression
inDegreesCelsius inDegreesCelsiusArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "inDegreesCelsius"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" [] ]
                          Type.float
                     )
             }
        )
        [ inDegreesCelsiusArg ]


{-| Construct a temperature from a number of degrees Fahrenheit.

degreesFahrenheit: Float -> Temperature.Temperature
-}
degreesFahrenheit : Float -> Elm.Expression
degreesFahrenheit degreesFahrenheitArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "degreesFahrenheit"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Temperature" ] "Temperature" [])
                     )
             }
        )
        [ Elm.float degreesFahrenheitArg ]


{-| Convert a temperature to a number of degrees Fahrenheit.

inDegreesFahrenheit: Temperature.Temperature -> Float
-}
inDegreesFahrenheit : Elm.Expression -> Elm.Expression
inDegreesFahrenheit inDegreesFahrenheitArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "inDegreesFahrenheit"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" [] ]
                          Type.float
                     )
             }
        )
        [ inDegreesFahrenheitArg ]


{-| Construct a temperature from a number of [kelvins][kelvin].

    Temperature.kelvins 300
    --> Temperature.degreesCelsius 26.85

[kelvin]: https://en.wikipedia.org/wiki/Kelvin "Kelvin"

kelvins: Float -> Temperature.Temperature
-}
kelvins : Float -> Elm.Expression
kelvins kelvinsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "kelvins"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Temperature" ] "Temperature" [])
                     )
             }
        )
        [ Elm.float kelvinsArg ]


{-| Convert a temperature to a number of kelvins.

    Temperature.degreesCelsius 0
        |> Temperature.inKelvins
    --> 273.15

inKelvins: Temperature.Temperature -> Float
-}
inKelvins : Elm.Expression -> Elm.Expression
inKelvins inKelvinsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "inKelvins"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" [] ]
                          Type.float
                     )
             }
        )
        [ inKelvinsArg ]


{-| [Absolute zero](https://en.wikipedia.org/wiki/Absolute_zero), equal to zero
kelvins or -273.15 degrees Celsius.

    Temperature.absoluteZero
    --> Temperature.degreesCelsius -273.15

absoluteZero: Temperature.Temperature
-}
absoluteZero : Elm.Expression
absoluteZero =
    Elm.value
        { importFrom = [ "Temperature" ]
        , name = "absoluteZero"
        , annotation = Just (Type.namedWith [ "Temperature" ] "Temperature" [])
        }


{-| Construct a temperature delta from a number of Celsius degrees.

celsiusDegrees: Float -> Temperature.Delta
-}
celsiusDegrees : Float -> Elm.Expression
celsiusDegrees celsiusDegreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "celsiusDegrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Temperature" ] "Delta" [])
                     )
             }
        )
        [ Elm.float celsiusDegreesArg ]


{-| Convert a temperature delta to a number of Celsius degrees.

inCelsiusDegrees: Temperature.Delta -> Float
-}
inCelsiusDegrees : Elm.Expression -> Elm.Expression
inCelsiusDegrees inCelsiusDegreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "inCelsiusDegrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Delta" [] ]
                          Type.float
                     )
             }
        )
        [ inCelsiusDegreesArg ]


{-| Construct a temperature delta from a number of Fahrenheit degrees.

    Temperature.fahrenheitDegrees 36
    --> Temperature.celsiusDegrees 20

fahrenheitDegrees: Float -> Temperature.Delta
-}
fahrenheitDegrees : Float -> Elm.Expression
fahrenheitDegrees fahrenheitDegreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "fahrenheitDegrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Temperature" ] "Delta" [])
                     )
             }
        )
        [ Elm.float fahrenheitDegreesArg ]


{-| Convert a temperature delta to a number of Fahrenheit degrees.

    Temperature.celsiusDegrees 10
        |> Temperature.inFahrenheitDegrees
    --> 18

inFahrenheitDegrees: Temperature.Delta -> Float
-}
inFahrenheitDegrees : Elm.Expression -> Elm.Expression
inFahrenheitDegrees inFahrenheitDegreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "inFahrenheitDegrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Delta" [] ]
                          Type.float
                     )
             }
        )
        [ inFahrenheitDegreesArg ]


{-| celsiusDegree: Temperature.Delta -}
celsiusDegree : Elm.Expression
celsiusDegree =
    Elm.value
        { importFrom = [ "Temperature" ]
        , name = "celsiusDegree"
        , annotation = Just (Type.namedWith [ "Temperature" ] "Delta" [])
        }


{-| fahrenheitDegree: Temperature.Delta -}
fahrenheitDegree : Elm.Expression
fahrenheitDegree =
    Elm.value
        { importFrom = [ "Temperature" ]
        , name = "fahrenheitDegree"
        , annotation = Just (Type.namedWith [ "Temperature" ] "Delta" [])
        }


{-| Check if one temperature is less than another. Note the [argument order](/#argument-order)!

    roomTemperature =
        Temperature.degreesCelsius 21

    Temperature.degreesFahrenheit 50
        |> Temperature.lessThan roomTemperature
    --> True

    -- Same as:
    Temperature.lessThan roomTemperature
        (Temperature.degreesFahrenheit 50)
    --> True

lessThan: Temperature.Temperature -> Temperature.Temperature -> Bool
-}
lessThan : Elm.Expression -> Elm.Expression -> Elm.Expression
lessThan lessThanArg lessThanArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "lessThan"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          Type.bool
                     )
             }
        )
        [ lessThanArg, lessThanArg0 ]


{-| Check if one temperature is greater than another. Note the [argument order](/#argument-order)!

    roomTemperature =
        Temperature.degreesCelsius 21

    Temperature.degreesFahrenheit 50
        |> Temperature.greaterThan roomTemperature
    --> False

    -- Same as:
    Temperature.greaterThan roomTemperature
        (Temperature.degreesFahrenheit 50)
    --> False

greaterThan: Temperature.Temperature -> Temperature.Temperature -> Bool
-}
greaterThan : Elm.Expression -> Elm.Expression -> Elm.Expression
greaterThan greaterThanArg greaterThanArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "greaterThan"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          Type.bool
                     )
             }
        )
        [ greaterThanArg, greaterThanArg0 ]


{-| Check if one temperature is less than or equal to another. Note the
[argument order](/#argument-order)!

lessThanOrEqualTo: Temperature.Temperature -> Temperature.Temperature -> Bool
-}
lessThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
lessThanOrEqualTo lessThanOrEqualToArg lessThanOrEqualToArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "lessThanOrEqualTo"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          Type.bool
                     )
             }
        )
        [ lessThanOrEqualToArg, lessThanOrEqualToArg0 ]


{-| Check if one temperature is greater than or equal to another. Note the
[argument order](/#argument-order)!

greaterThanOrEqualTo: Temperature.Temperature -> Temperature.Temperature -> Bool
-}
greaterThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
greaterThanOrEqualTo greaterThanOrEqualToArg greaterThanOrEqualToArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "greaterThanOrEqualTo"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          Type.bool
                     )
             }
        )
        [ greaterThanOrEqualToArg, greaterThanOrEqualToArg0 ]


{-| Compare two temperatures, returning an [`Order`](https://package.elm-lang.org/packages/elm/core/latest/Basics#Order)
value indicating whether the first is less than, equal to or greater than the
second.

    Temperature.compare
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> GT

    Temperature.compare
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 77)
    --> EQ

(Note that due to floating-point roundoff, you generally shouldn't rely on
temperatures comparing as exactly equal.)

compare: Temperature.Temperature -> Temperature.Temperature -> Basics.Order
-}
compare : Elm.Expression -> Elm.Expression -> Elm.Expression
compare compareArg compareArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "compare"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          (Type.namedWith [ "Basics" ] "Order" [])
                     )
             }
        )
        [ compareArg, compareArg0 ]


{-| Check if two temperatures are equal within a given delta tolerance. The
tolerance must be greater than or equal to zero - if it is negative, then the
result will always be false.

    Temperature.equalWithin (Temperature.fahrenheitDegrees 1)
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> False

    Temperature.equalWithin (Temperature.fahrenheitDegrees 3)
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> True

equalWithin: Temperature.Delta -> Temperature.Temperature -> Temperature.Temperature -> Bool
-}
equalWithin :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
equalWithin equalWithinArg equalWithinArg0 equalWithinArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "equalWithin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Delta" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          Type.bool
                     )
             }
        )
        [ equalWithinArg, equalWithinArg0, equalWithinArg1 ]


{-| Find the minimum of two temperatures.

    Temperature.min
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> Temperature.degreesFahrenheit 75

min: Temperature.Temperature -> Temperature.Temperature -> Temperature.Temperature
-}
min : Elm.Expression -> Elm.Expression -> Elm.Expression
min minArg minArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "min"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          (Type.namedWith [ "Temperature" ] "Temperature" [])
                     )
             }
        )
        [ minArg, minArg0 ]


{-| Find the maximum of two temperatures.

    Temperature.max
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> Temperature.degreesCelsius 25

max: Temperature.Temperature -> Temperature.Temperature -> Temperature.Temperature
-}
max : Elm.Expression -> Elm.Expression -> Elm.Expression
max maxArg maxArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "max"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          (Type.namedWith [ "Temperature" ] "Temperature" [])
                     )
             }
        )
        [ maxArg, maxArg0 ]


{-| Add a `Delta` to a `Temperature` to get a new `Temperature`.

    Temperature.degreesCelsius 25
        |> Temperature.plus
            (Temperature.celsiusDegrees 7)
    --> Temperature.degreesCelsius 32

If you want to _subtract_ a `Delta` from a `Temperature`, you can [`negate`](Quantity#negate)
the delta first and then call `plus`.

plus: Temperature.Delta -> Temperature.Temperature -> Temperature.Temperature
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus plusArg plusArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "plus"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Delta" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          (Type.namedWith [ "Temperature" ] "Temperature" [])
                     )
             }
        )
        [ plusArg, plusArg0 ]


{-| Subtract one `Temperature` from another to get a `Delta`. Note the [argument
order](/#argument-order)!

    -- 25 degrees Celsius is 77 degrees Fahrenheit
    start =
        Temperature.degreesCelsius 25

    end =
        Temperature.degreesFahrenheit 80

    end |> Temperature.minus start
    --> Temperature.fahrenheitDegrees 3

    start |> Temperature.minus end
    --> Temperature.fahrenheitDegrees -3

minus: Temperature.Temperature -> Temperature.Temperature -> Temperature.Delta
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus minusArg minusArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "minus"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          (Type.namedWith [ "Temperature" ] "Delta" [])
                     )
             }
        )
        [ minusArg, minusArg0 ]


{-| Given a lower and upper bound, clamp a given temperature to within those
bounds. Say you wanted to clamp a temperature to be between 18 and 22 degrees
Celsius:

    lowerBound =
        Temperature.degreesCelsius 18

    upperBound =
        Temperature.degreesCelsius 22

    Temperature.degreesCelsius 25
        |> Temperature.clamp lowerBound upperBound
    --> Temperature.degreesCelsius 22

    Temperature.degreesFahrenheit 67 -- approx 19.4 °C
        |> Temperature.clamp lowerBound upperBound
    --> Temperature.degreesFahrenheit 67

    Temperature.absoluteZero
        |> Temperature.clamp lowerBound upperBound
    --> Temperature.degreesCelsius 18

clamp: 
    Temperature.Temperature
    -> Temperature.Temperature
    -> Temperature.Temperature
    -> Temperature.Temperature
-}
clamp : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
clamp clampArg clampArg0 clampArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "clamp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          , Type.namedWith [ "Temperature" ] "Temperature" []
                          ]
                          (Type.namedWith [ "Temperature" ] "Temperature" [])
                     )
             }
        )
        [ clampArg, clampArg0, clampArg1 ]


{-| Find the minimum of a list of temperatures. Returns `Nothing` if the list
is empty.

    Temperature.minimum
        [ Temperature.degreesCelsius 20
        , Temperature.kelvins 300
        , Temperature.degreesFahrenheit 74
        ]
    --> Just (Temperature.degreesCelsius 20)

minimum: List Temperature.Temperature -> Maybe Temperature.Temperature
-}
minimum : List Elm.Expression -> Elm.Expression
minimum minimumArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "minimum"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "Temperature" ] "Temperature" []
                              )
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "Temperature" ]
                                    "Temperature"
                                    []
                               )
                          )
                     )
             }
        )
        [ Elm.list minimumArg ]


{-| Find the maximum of a list of temperatures. Returns `Nothing` if the list
is empty.

    Temperature.maximum
        [ Temperature.degreesCelsius 20
        , Temperature.kelvins 300
        , Temperature.degreesFahrenheit 74
        ]
    --> Just (Temperature.kelvins 300)

maximum: List Temperature.Temperature -> Maybe Temperature.Temperature
-}
maximum : List Elm.Expression -> Elm.Expression
maximum maximumArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "maximum"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "Temperature" ] "Temperature" []
                              )
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "Temperature" ]
                                    "Temperature"
                                    []
                               )
                          )
                     )
             }
        )
        [ Elm.list maximumArg ]


{-| Sort a list of temperatures from lowest to highest.

    Temperature.sort
        [ Temperature.degreesCelsius 20
        , Temperature.kelvins 300
        , Temperature.degreesFahrenheit 74
        ]
    --> [ Temperature.degreesCelsius 20
    --> , Temperature.degreesFahrenheit 74
    --> , Temperature.kelvins 300
    --> ]

sort: List Temperature.Temperature -> List Temperature.Temperature
-}
sort : List Elm.Expression -> Elm.Expression
sort sortArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "sort"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "Temperature" ] "Temperature" []
                              )
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Temperature" ]
                                    "Temperature"
                                    []
                               )
                          )
                     )
             }
        )
        [ Elm.list sortArg ]


{-| Sort an arbitrary list of values by a derived `Temperature`. If you had

    rooms =
        [ ( "Lobby", Temperature.degreesCelsius 21 )
        , ( "Locker room", Temperature.degreesCelsius 17 )
        , ( "Rink", Temperature.degreesCelsius -4 )
        , ( "Sauna", Temperature.degreesCelsius 82 )
        ]

then you could sort by temperature with

    Temperature.sortBy Tuple.second rooms
    --> [ ( "Rink", Temperature.degreesCelsius -4 )
    --> , ( "Locker room", Temperature.degreesCelsius 17 )
    --> , ( "Lobby", Temperature.degreesCelsius 21 )
    --> , ( "Sauna", Temperature.degreesCelsius 82 )
    --> ]

sortBy: (a -> Temperature.Temperature) -> List a -> List a
-}
sortBy :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
sortBy sortByArg sortByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Temperature" ]
             , name = "sortBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith [ "Temperature" ] "Temperature" []
                              )
                          , Type.list (Type.var "a")
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ Elm.functionReduced "sortByUnpack" sortByArg, Elm.list sortByArg0 ]


annotation_ :
    { temperature : Type.Annotation
    , delta : Type.Annotation
    , celsiusDegrees : Type.Annotation
    }
annotation_ =
    { temperature = Type.namedWith [ "Temperature" ] "Temperature" []
    , delta =
        Type.alias
            moduleName_
            "Delta"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith [ "Temperature" ] "CelsiusDegrees" []
                 ]
            )
    , celsiusDegrees = Type.namedWith [ "Temperature" ] "CelsiusDegrees" []
    }


call_ :
    { degreesCelsius : Elm.Expression -> Elm.Expression
    , inDegreesCelsius : Elm.Expression -> Elm.Expression
    , degreesFahrenheit : Elm.Expression -> Elm.Expression
    , inDegreesFahrenheit : Elm.Expression -> Elm.Expression
    , kelvins : Elm.Expression -> Elm.Expression
    , inKelvins : Elm.Expression -> Elm.Expression
    , celsiusDegrees : Elm.Expression -> Elm.Expression
    , inCelsiusDegrees : Elm.Expression -> Elm.Expression
    , fahrenheitDegrees : Elm.Expression -> Elm.Expression
    , inFahrenheitDegrees : Elm.Expression -> Elm.Expression
    , lessThan : Elm.Expression -> Elm.Expression -> Elm.Expression
    , greaterThan : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lessThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
    , greaterThanOrEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression
    , compare : Elm.Expression -> Elm.Expression -> Elm.Expression
    , equalWithin :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , min : Elm.Expression -> Elm.Expression -> Elm.Expression
    , max : Elm.Expression -> Elm.Expression -> Elm.Expression
    , plus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , minus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clamp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , minimum : Elm.Expression -> Elm.Expression
    , maximum : Elm.Expression -> Elm.Expression
    , sort : Elm.Expression -> Elm.Expression
    , sortBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { degreesCelsius =
        \degreesCelsiusArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "degreesCelsius"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Temperature" ]
                                       "Temperature"
                                       []
                                  )
                             )
                     }
                )
                [ degreesCelsiusArg ]
    , inDegreesCelsius =
        \inDegreesCelsiusArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "inDegreesCelsius"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inDegreesCelsiusArg ]
    , degreesFahrenheit =
        \degreesFahrenheitArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "degreesFahrenheit"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Temperature" ]
                                       "Temperature"
                                       []
                                  )
                             )
                     }
                )
                [ degreesFahrenheitArg ]
    , inDegreesFahrenheit =
        \inDegreesFahrenheitArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "inDegreesFahrenheit"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inDegreesFahrenheitArg ]
    , kelvins =
        \kelvinsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "kelvins"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Temperature" ]
                                       "Temperature"
                                       []
                                  )
                             )
                     }
                )
                [ kelvinsArg ]
    , inKelvins =
        \inKelvinsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "inKelvins"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inKelvinsArg ]
    , celsiusDegrees =
        \celsiusDegreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "celsiusDegrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Temperature" ] "Delta" [])
                             )
                     }
                )
                [ celsiusDegreesArg ]
    , inCelsiusDegrees =
        \inCelsiusDegreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "inCelsiusDegrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Temperature" ] "Delta" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inCelsiusDegreesArg ]
    , fahrenheitDegrees =
        \fahrenheitDegreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "fahrenheitDegrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Temperature" ] "Delta" [])
                             )
                     }
                )
                [ fahrenheitDegreesArg ]
    , inFahrenheitDegrees =
        \inFahrenheitDegreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "inFahrenheitDegrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Temperature" ] "Delta" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inFahrenheitDegreesArg ]
    , lessThan =
        \lessThanArg lessThanArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "lessThan"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
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
                     { importFrom = [ "Temperature" ]
                     , name = "greaterThan"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
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
                     { importFrom = [ "Temperature" ]
                     , name = "lessThanOrEqualTo"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
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
                     { importFrom = [ "Temperature" ]
                     , name = "greaterThanOrEqualTo"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ greaterThanOrEqualToArg, greaterThanOrEqualToArg0 ]
    , compare =
        \compareArg compareArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "compare"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
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
                     { importFrom = [ "Temperature" ]
                     , name = "equalWithin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Temperature" ] "Delta" []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ equalWithinArg, equalWithinArg0, equalWithinArg1 ]
    , min =
        \minArg minArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "min"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Temperature" ]
                                       "Temperature"
                                       []
                                  )
                             )
                     }
                )
                [ minArg, minArg0 ]
    , max =
        \maxArg maxArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "max"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Temperature" ]
                                       "Temperature"
                                       []
                                  )
                             )
                     }
                )
                [ maxArg, maxArg0 ]
    , plus =
        \plusArg plusArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "plus"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Temperature" ] "Delta" []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Temperature" ]
                                       "Temperature"
                                       []
                                  )
                             )
                     }
                )
                [ plusArg, plusArg0 ]
    , minus =
        \minusArg minusArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "minus"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  (Type.namedWith [ "Temperature" ] "Delta" [])
                             )
                     }
                )
                [ minusArg, minusArg0 ]
    , clamp =
        \clampArg clampArg0 clampArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "clamp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  , Type.namedWith
                                      [ "Temperature" ]
                                      "Temperature"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Temperature" ]
                                       "Temperature"
                                       []
                                  )
                             )
                     }
                )
                [ clampArg, clampArg0, clampArg1 ]
    , minimum =
        \minimumArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "minimum"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Temperature" ]
                                         "Temperature"
                                         []
                                      )
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "Temperature" ]
                                            "Temperature"
                                            []
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
                     { importFrom = [ "Temperature" ]
                     , name = "maximum"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Temperature" ]
                                         "Temperature"
                                         []
                                      )
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "Temperature" ]
                                            "Temperature"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ maximumArg ]
    , sort =
        \sortArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Temperature" ]
                     , name = "sort"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Temperature" ]
                                         "Temperature"
                                         []
                                      )
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Temperature" ]
                                            "Temperature"
                                            []
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
                     { importFrom = [ "Temperature" ]
                     , name = "sortBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "Temperature" ]
                                         "Temperature"
                                         []
                                      )
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ sortByArg, sortByArg0 ]
    }


values_ :
    { degreesCelsius : Elm.Expression
    , inDegreesCelsius : Elm.Expression
    , degreesFahrenheit : Elm.Expression
    , inDegreesFahrenheit : Elm.Expression
    , kelvins : Elm.Expression
    , inKelvins : Elm.Expression
    , absoluteZero : Elm.Expression
    , celsiusDegrees : Elm.Expression
    , inCelsiusDegrees : Elm.Expression
    , fahrenheitDegrees : Elm.Expression
    , inFahrenheitDegrees : Elm.Expression
    , celsiusDegree : Elm.Expression
    , fahrenheitDegree : Elm.Expression
    , lessThan : Elm.Expression
    , greaterThan : Elm.Expression
    , lessThanOrEqualTo : Elm.Expression
    , greaterThanOrEqualTo : Elm.Expression
    , compare : Elm.Expression
    , equalWithin : Elm.Expression
    , min : Elm.Expression
    , max : Elm.Expression
    , plus : Elm.Expression
    , minus : Elm.Expression
    , clamp : Elm.Expression
    , minimum : Elm.Expression
    , maximum : Elm.Expression
    , sort : Elm.Expression
    , sortBy : Elm.Expression
    }
values_ =
    { degreesCelsius =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "degreesCelsius"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Temperature" ] "Temperature" [])
                    )
            }
    , inDegreesCelsius =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "inDegreesCelsius"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" [] ]
                         Type.float
                    )
            }
    , degreesFahrenheit =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "degreesFahrenheit"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Temperature" ] "Temperature" [])
                    )
            }
    , inDegreesFahrenheit =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "inDegreesFahrenheit"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" [] ]
                         Type.float
                    )
            }
    , kelvins =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "kelvins"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Temperature" ] "Temperature" [])
                    )
            }
    , inKelvins =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "inKelvins"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" [] ]
                         Type.float
                    )
            }
    , absoluteZero =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "absoluteZero"
            , annotation =
                Just (Type.namedWith [ "Temperature" ] "Temperature" [])
            }
    , celsiusDegrees =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "celsiusDegrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Temperature" ] "Delta" [])
                    )
            }
    , inCelsiusDegrees =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "inCelsiusDegrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Delta" [] ]
                         Type.float
                    )
            }
    , fahrenheitDegrees =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "fahrenheitDegrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Temperature" ] "Delta" [])
                    )
            }
    , inFahrenheitDegrees =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "inFahrenheitDegrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Delta" [] ]
                         Type.float
                    )
            }
    , celsiusDegree =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "celsiusDegree"
            , annotation = Just (Type.namedWith [ "Temperature" ] "Delta" [])
            }
    , fahrenheitDegree =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "fahrenheitDegree"
            , annotation = Just (Type.namedWith [ "Temperature" ] "Delta" [])
            }
    , lessThan =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "lessThan"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         Type.bool
                    )
            }
    , greaterThan =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "greaterThan"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         Type.bool
                    )
            }
    , lessThanOrEqualTo =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "lessThanOrEqualTo"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         Type.bool
                    )
            }
    , greaterThanOrEqualTo =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "greaterThanOrEqualTo"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         Type.bool
                    )
            }
    , compare =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "compare"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         (Type.namedWith [ "Basics" ] "Order" [])
                    )
            }
    , equalWithin =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "equalWithin"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Delta" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         Type.bool
                    )
            }
    , min =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "min"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         (Type.namedWith [ "Temperature" ] "Temperature" [])
                    )
            }
    , max =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "max"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         (Type.namedWith [ "Temperature" ] "Temperature" [])
                    )
            }
    , plus =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "plus"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Delta" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         (Type.namedWith [ "Temperature" ] "Temperature" [])
                    )
            }
    , minus =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "minus"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         (Type.namedWith [ "Temperature" ] "Delta" [])
                    )
            }
    , clamp =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "clamp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         , Type.namedWith [ "Temperature" ] "Temperature" []
                         ]
                         (Type.namedWith [ "Temperature" ] "Temperature" [])
                    )
            }
    , minimum =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "minimum"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "Temperature" ] "Temperature" [])
                         ]
                         (Type.maybe
                              (Type.namedWith [ "Temperature" ] "Temperature" []
                              )
                         )
                    )
            }
    , maximum =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "maximum"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "Temperature" ] "Temperature" [])
                         ]
                         (Type.maybe
                              (Type.namedWith [ "Temperature" ] "Temperature" []
                              )
                         )
                    )
            }
    , sort =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "sort"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "Temperature" ] "Temperature" [])
                         ]
                         (Type.list
                              (Type.namedWith [ "Temperature" ] "Temperature" []
                              )
                         )
                    )
            }
    , sortBy =
        Elm.value
            { importFrom = [ "Temperature" ]
            , name = "sortBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith [ "Temperature" ] "Temperature" [])
                         , Type.list (Type.var "a")
                         ]
                         (Type.list (Type.var "a"))
                    )
            }
    }