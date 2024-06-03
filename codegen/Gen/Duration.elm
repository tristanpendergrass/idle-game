module Gen.Duration exposing (addTo, annotation_, call_, day, days, from, hour, hours, inDays, inHours, inJulianYears, inMilliseconds, inMinutes, inSeconds, inWeeks, julianYear, julianYears, millisecond, milliseconds, minute, minutes, moduleName_, second, seconds, subtractFrom, values_, week, weeks)

{-| 
@docs moduleName_, seconds, inSeconds, milliseconds, inMilliseconds, minutes, inMinutes, hours, inHours, days, inDays, weeks, inWeeks, julianYears, inJulianYears, from, addTo, subtractFrom, second, millisecond, minute, hour, day, week, julianYear, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Duration" ]


{-| Construct a `Duration` from a given number of seconds.

seconds: Float -> Duration.Duration
-}
seconds : Float -> Elm.Expression
seconds secondsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "seconds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.float secondsArg ]


{-| Convert a `Duration` to a value in seconds.

    Duration.milliseconds 10 |> Duration.inSeconds
    --> 0.01

inSeconds: Duration.Duration -> Float
-}
inSeconds : Elm.Expression -> Elm.Expression
inSeconds inSecondsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "inSeconds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          Type.float
                     )
             }
        )
        [ inSecondsArg ]


{-| Construct a `Duration` from a given number of milliseconds.

    Duration.milliseconds 5000
    --> Duration.seconds 5

milliseconds: Float -> Duration.Duration
-}
milliseconds : Float -> Elm.Expression
milliseconds millisecondsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "milliseconds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.float millisecondsArg ]


{-| Convert a `Duration` to a value in milliseconds.

    Duration.seconds 0.5 |> Duration.inMilliseconds
    --> 500

inMilliseconds: Duration.Duration -> Float
-}
inMilliseconds : Elm.Expression -> Elm.Expression
inMilliseconds inMillisecondsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "inMilliseconds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          Type.float
                     )
             }
        )
        [ inMillisecondsArg ]


{-| Construct a `Duration` from a given number of minutes.

    Duration.minutes 3
    --> Duration.seconds 180

minutes: Float -> Duration.Duration
-}
minutes : Float -> Elm.Expression
minutes minutesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "minutes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.float minutesArg ]


{-| Convert a `Duration` to a value in minutes.

    Duration.seconds 90 |> Duration.inMinutes
    --> 1.5

inMinutes: Duration.Duration -> Float
-}
inMinutes : Elm.Expression -> Elm.Expression
inMinutes inMinutesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "inMinutes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          Type.float
                     )
             }
        )
        [ inMinutesArg ]


{-| Construct a `Duration` from a given number of hours.

    Duration.hours 1
    --> Duration.seconds 3600

hours: Float -> Duration.Duration
-}
hours : Float -> Elm.Expression
hours hoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "hours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.float hoursArg ]


{-| Convert a `Duration` to a value in hours.

    Duration.minutes 120 |> Duration.inHours
    --> 2

inHours: Duration.Duration -> Float
-}
inHours : Elm.Expression -> Elm.Expression
inHours inHoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "inHours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          Type.float
                     )
             }
        )
        [ inHoursArg ]


{-| Construct a `Duration` from a given number of days. A day is defined as
exactly 24 hours or 86400 seconds. Therefore, it is only equal to the length of
a given calendar day if that calendar day does not include either a leap second
or any added/removed daylight savings hours.

    Duration.days 1
    --> Duration.hours 24

days: Float -> Duration.Duration
-}
days : Float -> Elm.Expression
days daysArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "days"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.float daysArg ]


{-| Convert a `Duration` to a value in days.

    Duration.hours 72 |> Duration.inDays
    --> 3

inDays: Duration.Duration -> Float
-}
inDays : Elm.Expression -> Elm.Expression
inDays inDaysArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "inDays"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          Type.float
                     )
             }
        )
        [ inDaysArg ]


{-| Construct a `Duration` from a given number of weeks.

    Duration.weeks 1
    --> Duration.days 7

weeks: Float -> Duration.Duration
-}
weeks : Float -> Elm.Expression
weeks weeksArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "weeks"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.float weeksArg ]


{-| Convert a `Duration` to a value in weeks.

    Duration.days 28 |> Duration.inWeeks
    --> 4

inWeeks: Duration.Duration -> Float
-}
inWeeks : Elm.Expression -> Elm.Expression
inWeeks inWeeksArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "inWeeks"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          Type.float
                     )
             }
        )
        [ inWeeksArg ]


{-| Construct a `Duration` from a given number of [Julian years][julian_year].
A Julian year is defined as exactly 365.25 days, the average length of a year in
the historical Julian calendar. This is 10 minutes and 48 seconds longer than
a Gregorian year (365.2425 days), which is the average length of a year in the
modern Gregorian calendar, but the Julian year is a bit easier to remember and
reason about and has the virtue of being the 'year' value used in the definition
of a [light year](Length#lightYears).

    Duration.julianYears 1
    --> Duration.days 365.25

[julian_year]: https://en.wikipedia.org/wiki/Julian_year_(astronomy) "Julian year"

julianYears: Float -> Duration.Duration
-}
julianYears : Float -> Elm.Expression
julianYears julianYearsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "julianYears"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.float julianYearsArg ]


{-| Convert a `Duration` to a value in Julian years.

    Duration.hours 10000 |> Duration.inJulianYears
    --> 1.1407711613050422

inJulianYears: Duration.Duration -> Float
-}
inJulianYears : Elm.Expression -> Elm.Expression
inJulianYears inJulianYearsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "inJulianYears"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" [] ]
                          Type.float
                     )
             }
        )
        [ inJulianYearsArg ]


{-| Find the elapsed time from a start time to an end time. For example,
assuming that `nineAM` and `fivePM` are two [`Time.Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
values on the same day:

    Duration.from nineAM fivePM
    --> Duration.hours 8

from: Time.Posix -> Time.Posix -> Duration.Duration
-}
from : Elm.Expression -> Elm.Expression -> Elm.Expression
from fromArg fromArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "from"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ fromArg, fromArg0 ]


{-| Offset a [`Time.Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
value forwards in time by a given `Duration`:

    -- Assuming that 'now' is a Time.Posix value obtained
    -- from Time.now
    threeHoursFromNow =
        Duration.addTo now (Duration.hours 3)

addTo: Time.Posix -> Duration.Duration -> Time.Posix
-}
addTo : Elm.Expression -> Elm.Expression -> Elm.Expression
addTo addToArg addToArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "addTo"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith [ "Duration" ] "Duration" []
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ addToArg, addToArg0 ]


{-| Offset a [`Time.Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
value backwards in time by a given `Duration`:

    -- Assuming that 'now' is a Time.Posix value obtained
    -- from Time.now
    fiveMinutesAgo =
        Duration.subtractFrom now (Duration.minutes 5)

`Duration.subtractFrom time duration` is equivalent to `Duration.addTo time
(Quantity.negate duration)`.

subtractFrom: Time.Posix -> Duration.Duration -> Time.Posix
-}
subtractFrom : Elm.Expression -> Elm.Expression -> Elm.Expression
subtractFrom subtractFromArg subtractFromArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Duration" ]
             , name = "subtractFrom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith [ "Duration" ] "Duration" []
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ subtractFromArg, subtractFromArg0 ]


{-| second: Duration.Duration -}
second : Elm.Expression
second =
    Elm.value
        { importFrom = [ "Duration" ]
        , name = "second"
        , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
        }


{-| millisecond: Duration.Duration -}
millisecond : Elm.Expression
millisecond =
    Elm.value
        { importFrom = [ "Duration" ]
        , name = "millisecond"
        , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
        }


{-| minute: Duration.Duration -}
minute : Elm.Expression
minute =
    Elm.value
        { importFrom = [ "Duration" ]
        , name = "minute"
        , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
        }


{-| hour: Duration.Duration -}
hour : Elm.Expression
hour =
    Elm.value
        { importFrom = [ "Duration" ]
        , name = "hour"
        , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
        }


{-| day: Duration.Duration -}
day : Elm.Expression
day =
    Elm.value
        { importFrom = [ "Duration" ]
        , name = "day"
        , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
        }


{-| week: Duration.Duration -}
week : Elm.Expression
week =
    Elm.value
        { importFrom = [ "Duration" ]
        , name = "week"
        , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
        }


{-| julianYear: Duration.Duration -}
julianYear : Elm.Expression
julianYear =
    Elm.value
        { importFrom = [ "Duration" ]
        , name = "julianYear"
        , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
        }


annotation_ : { duration : Type.Annotation, seconds : Type.Annotation }
annotation_ =
    { duration =
        Type.alias
            moduleName_
            "Duration"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Duration" ] "Seconds" [] ]
            )
    , seconds = Type.namedWith [ "Duration" ] "Seconds" []
    }


call_ :
    { seconds : Elm.Expression -> Elm.Expression
    , inSeconds : Elm.Expression -> Elm.Expression
    , milliseconds : Elm.Expression -> Elm.Expression
    , inMilliseconds : Elm.Expression -> Elm.Expression
    , minutes : Elm.Expression -> Elm.Expression
    , inMinutes : Elm.Expression -> Elm.Expression
    , hours : Elm.Expression -> Elm.Expression
    , inHours : Elm.Expression -> Elm.Expression
    , days : Elm.Expression -> Elm.Expression
    , inDays : Elm.Expression -> Elm.Expression
    , weeks : Elm.Expression -> Elm.Expression
    , inWeeks : Elm.Expression -> Elm.Expression
    , julianYears : Elm.Expression -> Elm.Expression
    , inJulianYears : Elm.Expression -> Elm.Expression
    , from : Elm.Expression -> Elm.Expression -> Elm.Expression
    , addTo : Elm.Expression -> Elm.Expression -> Elm.Expression
    , subtractFrom : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { seconds =
        \secondsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "seconds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ secondsArg ]
    , inSeconds =
        \inSecondsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "inSeconds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inSecondsArg ]
    , milliseconds =
        \millisecondsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "milliseconds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ millisecondsArg ]
    , inMilliseconds =
        \inMillisecondsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "inMilliseconds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMillisecondsArg ]
    , minutes =
        \minutesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "minutes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ minutesArg ]
    , inMinutes =
        \inMinutesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "inMinutes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMinutesArg ]
    , hours =
        \hoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "hours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ hoursArg ]
    , inHours =
        \inHoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "inHours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inHoursArg ]
    , days =
        \daysArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "days"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ daysArg ]
    , inDays =
        \inDaysArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "inDays"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inDaysArg ]
    , weeks =
        \weeksArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "weeks"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ weeksArg ]
    , inWeeks =
        \inWeeksArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "inWeeks"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inWeeksArg ]
    , julianYears =
        \julianYearsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "julianYears"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ julianYearsArg ]
    , inJulianYears =
        \inJulianYearsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "inJulianYears"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inJulianYearsArg ]
    , from =
        \fromArg fromArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "from"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ fromArg, fromArg0 ]
    , addTo =
        \addToArg addToArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "addTo"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ addToArg, addToArg0 ]
    , subtractFrom =
        \subtractFromArg subtractFromArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Duration" ]
                     , name = "subtractFrom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ subtractFromArg, subtractFromArg0 ]
    }


values_ :
    { seconds : Elm.Expression
    , inSeconds : Elm.Expression
    , milliseconds : Elm.Expression
    , inMilliseconds : Elm.Expression
    , minutes : Elm.Expression
    , inMinutes : Elm.Expression
    , hours : Elm.Expression
    , inHours : Elm.Expression
    , days : Elm.Expression
    , inDays : Elm.Expression
    , weeks : Elm.Expression
    , inWeeks : Elm.Expression
    , julianYears : Elm.Expression
    , inJulianYears : Elm.Expression
    , from : Elm.Expression
    , addTo : Elm.Expression
    , subtractFrom : Elm.Expression
    , second : Elm.Expression
    , millisecond : Elm.Expression
    , minute : Elm.Expression
    , hour : Elm.Expression
    , day : Elm.Expression
    , week : Elm.Expression
    , julianYear : Elm.Expression
    }
values_ =
    { seconds =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "seconds"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , inSeconds =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "inSeconds"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         Type.float
                    )
            }
    , milliseconds =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "milliseconds"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , inMilliseconds =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "inMilliseconds"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         Type.float
                    )
            }
    , minutes =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "minutes"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , inMinutes =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "inMinutes"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         Type.float
                    )
            }
    , hours =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "hours"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , inHours =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "inHours"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         Type.float
                    )
            }
    , days =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "days"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , inDays =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "inDays"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         Type.float
                    )
            }
    , weeks =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "weeks"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , inWeeks =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "inWeeks"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         Type.float
                    )
            }
    , julianYears =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "julianYears"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , inJulianYears =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "inJulianYears"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" [] ]
                         Type.float
                    )
            }
    , from =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "from"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , addTo =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "addTo"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith [ "Duration" ] "Duration" []
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , subtractFrom =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "subtractFrom"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith [ "Duration" ] "Duration" []
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , second =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "second"
            , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
            }
    , millisecond =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "millisecond"
            , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
            }
    , minute =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "minute"
            , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
            }
    , hour =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "hour"
            , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
            }
    , day =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "day"
            , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
            }
    , week =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "week"
            , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
            }
    , julianYear =
        Elm.value
            { importFrom = [ "Duration" ]
            , name = "julianYear"
            , annotation = Just (Type.namedWith [ "Duration" ] "Duration" [])
            }
    }