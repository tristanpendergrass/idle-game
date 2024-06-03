module Gen.Angle exposing (acos, annotation_, asin, atan, atan2, call_, caseOf_, cos, degree, degrees, fromDms, inDegrees, inMinutes, inRadians, inSeconds, inTurns, make_, minute, minutes, moduleName_, normalize, radian, radians, second, seconds, sin, tan, toDms, turn, turns, values_)

{-| 
@docs moduleName_, radians, inRadians, degrees, inDegrees, turns, inTurns, minutes, inMinutes, seconds, inSeconds, fromDms, toDms, sin, cos, tan, asin, acos, atan, atan2, normalize, radian, degree, turn, minute, second, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Angle" ]


{-| Construct an angle from a number of radians.

radians: Float -> Angle.Angle
-}
radians : Float -> Elm.Expression
radians radiansArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "radians"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float radiansArg ]


{-| Convert an angle to a number of radians.

inRadians: Angle.Angle -> Float
-}
inRadians : Elm.Expression -> Elm.Expression
inRadians inRadiansArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "inRadians"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ inRadiansArg ]


{-| Construct an angle from a number of degrees.

    Angle.degrees 180
    --> Angle.radians pi

degrees: Float -> Angle.Angle
-}
degrees : Float -> Elm.Expression
degrees degreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "degrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float degreesArg ]


{-| Convert an angle to a number of degrees.

    Angle.turns 2 |> Angle.inDegrees
    --> 720

inDegrees: Angle.Angle -> Float
-}
inDegrees : Elm.Expression -> Elm.Expression
inDegrees inDegreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "inDegrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ inDegreesArg ]


{-| Construct an angle from a number of turns.

    Angle.turns -0.25
    --> Angle.degrees -90

turns: Float -> Angle.Angle
-}
turns : Float -> Elm.Expression
turns turnsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "turns"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float turnsArg ]


{-| Convert an angle to a number of turns.

    Angle.radians pi |> Angle.inTurns
    --> 0.5

inTurns: Angle.Angle -> Float
-}
inTurns : Elm.Expression -> Elm.Expression
inTurns inTurnsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "inTurns"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ inTurnsArg ]


{-| Construct an angle from a number of minutes.

    Angle.minutes 30
    --> Angle.degrees 0.5

minutes: Float -> Angle.Angle
-}
minutes : Float -> Elm.Expression
minutes minutesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "minutes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float minutesArg ]


{-| Convert an angle to a number of minutes.

    Angle.degrees 2 |> Angle.inMinutes
    --> 120

inMinutes: Angle.Angle -> Float
-}
inMinutes : Elm.Expression -> Elm.Expression
inMinutes inMinutesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "inMinutes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ inMinutesArg ]


{-| Construct an angle from a number of seconds.

    Angle.seconds 120
    --> Angle.minutes 2

seconds: Float -> Angle.Angle
-}
seconds : Float -> Elm.Expression
seconds secondsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "seconds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float secondsArg ]


{-| Convert an angle to a number of seconds.

    Angle.degrees 0.1 |> Angle.inSeconds
    --> 360

inSeconds: Angle.Angle -> Float
-}
inSeconds : Elm.Expression -> Elm.Expression
inSeconds inSecondsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "inSeconds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ inSecondsArg ]


{-| Construct an angle given its sign and its degree, minute and second
components. The signs of `degrees`, `minutes` and `seconds` will be ignored
(their absolute values will be used). Note that only `seconds` may be
fractional! In general `minutes` and `seconds` should each be less than 60, but
this is not enforced.

    Angle.fromDms
        { sign = Angle.Positive
        , degrees = 45
        , minutes = 30
        , seconds = 36
        }
    --> Angle.degrees 45.51

    Angle.fromDms
        { sign = Angle.Negative
        , degrees = 2
        , minutes = 15
        , seconds = 0
        }
    --> Angle.degrees -2.25

fromDms: 
    { sign : Angle.Sign, degrees : Int, minutes : Int, seconds : Float }
    -> Angle.Angle
-}
fromDms :
    { sign : Elm.Expression, degrees : Int, minutes : Int, seconds : Float }
    -> Elm.Expression
fromDms fromDmsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "fromDms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "sign", Type.namedWith [ "Angle" ] "Sign" [] )
                              , ( "degrees", Type.int )
                              , ( "minutes", Type.int )
                              , ( "seconds", Type.float )
                              ]
                          ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "sign" fromDmsArg.sign
            , Tuple.pair "degrees" (Elm.int fromDmsArg.degrees)
            , Tuple.pair "minutes" (Elm.int fromDmsArg.minutes)
            , Tuple.pair "seconds" (Elm.float fromDmsArg.seconds)
            ]
        ]


{-| Convert an angle to a number of degrees, minutes and seconds, along with its
sign. The `degrees`, `minutes` and `seconds` values will all be non-negative,
and both `minutes` and `seconds` will be less than 60.

    Angle.toDms (Angle.degrees 1.5)
    --> { sign = Angle.Positive
    --> , degrees = 1
    --> , minutes = 30
    --> , seconds = 0
    --> }

    Angle.toDms (Angle.degrees -0.751)
    --> { sign = Angle.Negative
    --> , degrees = 0
    --> , minutes = 45
    --> , seconds = 3.6
    --> }

You could use this to write a string-conversion function for angles, something
like:

    angleString angle =
        let
            { sign, degrees, minutes, seconds } =
                Angle.toDms angle

            signString =
                case sign of
                    Angle.Positive ->
                        ""

                    Angle.Negative ->
                        "-"
        in
        String.concat
            [ signString
            , String.fromInt degrees
            , "° "
            , String.fromInt minutes
            , "′ "
            , Round.round 3 seconds
            , "″"
            ]

(Here we're using the
[myrho/elm-round](https://package.elm-lang.org/packages/myrho/elm-round/latest/)
package to control the number of decimal places used when displaying the number
of seconds.)

toDms: 
    Angle.Angle
    -> { sign : Angle.Sign, degrees : Int, minutes : Int, seconds : Float }
-}
toDms : Elm.Expression -> Elm.Expression
toDms toDmsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "toDms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          (Type.record
                               [ ( "sign"
                                 , Type.namedWith [ "Angle" ] "Sign" []
                                 )
                               , ( "degrees", Type.int )
                               , ( "minutes", Type.int )
                               , ( "seconds", Type.float )
                               ]
                          )
                     )
             }
        )
        [ toDmsArg ]


{-| sin: Angle.Angle -> Float -}
sin : Elm.Expression -> Elm.Expression
sin sinArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "sin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ sinArg ]


{-| cos: Angle.Angle -> Float -}
cos : Elm.Expression -> Elm.Expression
cos cosArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "cos"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ cosArg ]


{-| tan: Angle.Angle -> Float -}
tan : Elm.Expression -> Elm.Expression
tan tanArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "tan"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          Type.float
                     )
             }
        )
        [ tanArg ]


{-| asin: Float -> Angle.Angle -}
asin : Float -> Elm.Expression
asin asinArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "asin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float asinArg ]


{-| acos: Float -> Angle.Angle -}
acos : Float -> Elm.Expression
acos acosArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "acos"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float acosArg ]


{-| atan: Float -> Angle.Angle -}
atan : Float -> Elm.Expression
atan atanArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "atan"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ Elm.float atanArg ]


{-| atan2: Quantity.Quantity Float units -> Quantity.Quantity Float units -> Angle.Angle -}
atan2 : Elm.Expression -> Elm.Expression -> Elm.Expression
atan2 atan2Arg atan2Arg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "atan2"
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
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ atan2Arg, atan2Arg0 ]


{-| Convert an arbitrary angle to the equivalent angle in the range -180 to 180
degrees (-π to π radians), by adding or subtracting some multiple of 360
degrees (2π radians) if necessary.

    Angle.normalize (Angle.degrees 45)
    --> Angle.degrees 45

    Angle.normalize (Angle.degrees 270)
    --> Angle.degrees -90

    Angle.normalize (Angle.degrees 370)
    --> Angle.degrees 10

    Angle.normalize (Angle.degrees 181)
    --> Angle.degrees -179

normalize: Angle.Angle -> Angle.Angle
-}
normalize : Elm.Expression -> Elm.Expression
normalize normalizeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Angle" ]
             , name = "normalize"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          (Type.namedWith [ "Angle" ] "Angle" [])
                     )
             }
        )
        [ normalizeArg ]


{-| radian: Angle.Angle -}
radian : Elm.Expression
radian =
    Elm.value
        { importFrom = [ "Angle" ]
        , name = "radian"
        , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
        }


{-| degree: Angle.Angle -}
degree : Elm.Expression
degree =
    Elm.value
        { importFrom = [ "Angle" ]
        , name = "degree"
        , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
        }


{-| turn: Angle.Angle -}
turn : Elm.Expression
turn =
    Elm.value
        { importFrom = [ "Angle" ]
        , name = "turn"
        , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
        }


{-| minute: Angle.Angle -}
minute : Elm.Expression
minute =
    Elm.value
        { importFrom = [ "Angle" ]
        , name = "minute"
        , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
        }


{-| second: Angle.Angle -}
second : Elm.Expression
second =
    Elm.value
        { importFrom = [ "Angle" ]
        , name = "second"
        , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
        }


annotation_ :
    { angle : Type.Annotation
    , radians : Type.Annotation
    , sign : Type.Annotation
    }
annotation_ =
    { angle =
        Type.alias
            moduleName_
            "Angle"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Angle" ] "Radians" [] ]
            )
    , radians = Type.namedWith [ "Angle" ] "Radians" []
    , sign = Type.namedWith [ "Angle" ] "Sign" []
    }


make_ : { positive : Elm.Expression, negative : Elm.Expression }
make_ =
    { positive =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "Positive"
            , annotation = Just (Type.namedWith [] "Sign" [])
            }
    , negative =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "Negative"
            , annotation = Just (Type.namedWith [] "Sign" [])
            }
    }


caseOf_ :
    { sign :
        Elm.Expression
        -> { signTags_0_0
            | positive : Elm.Expression
            , negative : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { sign =
        \signExpression signTags ->
            Elm.Case.custom
                signExpression
                (Type.namedWith [ "Angle" ] "Sign" [])
                [ Elm.Case.branch0 "Positive" signTags.positive
                , Elm.Case.branch0 "Negative" signTags.negative
                ]
    }


call_ :
    { radians : Elm.Expression -> Elm.Expression
    , inRadians : Elm.Expression -> Elm.Expression
    , degrees : Elm.Expression -> Elm.Expression
    , inDegrees : Elm.Expression -> Elm.Expression
    , turns : Elm.Expression -> Elm.Expression
    , inTurns : Elm.Expression -> Elm.Expression
    , minutes : Elm.Expression -> Elm.Expression
    , inMinutes : Elm.Expression -> Elm.Expression
    , seconds : Elm.Expression -> Elm.Expression
    , inSeconds : Elm.Expression -> Elm.Expression
    , fromDms : Elm.Expression -> Elm.Expression
    , toDms : Elm.Expression -> Elm.Expression
    , sin : Elm.Expression -> Elm.Expression
    , cos : Elm.Expression -> Elm.Expression
    , tan : Elm.Expression -> Elm.Expression
    , asin : Elm.Expression -> Elm.Expression
    , acos : Elm.Expression -> Elm.Expression
    , atan : Elm.Expression -> Elm.Expression
    , atan2 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , normalize : Elm.Expression -> Elm.Expression
    }
call_ =
    { radians =
        \radiansArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "radians"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ radiansArg ]
    , inRadians =
        \inRadiansArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "inRadians"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ inRadiansArg ]
    , degrees =
        \degreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "degrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ degreesArg ]
    , inDegrees =
        \inDegreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "inDegrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ inDegreesArg ]
    , turns =
        \turnsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "turns"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ turnsArg ]
    , inTurns =
        \inTurnsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "inTurns"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ inTurnsArg ]
    , minutes =
        \minutesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "minutes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ minutesArg ]
    , inMinutes =
        \inMinutesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "inMinutes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMinutesArg ]
    , seconds =
        \secondsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "seconds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ secondsArg ]
    , inSeconds =
        \inSecondsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "inSeconds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSecondsArg ]
    , fromDms =
        \fromDmsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "fromDms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "sign"
                                        , Type.namedWith [ "Angle" ] "Sign" []
                                        )
                                      , ( "degrees", Type.int )
                                      , ( "minutes", Type.int )
                                      , ( "seconds", Type.float )
                                      ]
                                  ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ fromDmsArg ]
    , toDms =
        \toDmsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "toDms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  (Type.record
                                       [ ( "sign"
                                         , Type.namedWith [ "Angle" ] "Sign" []
                                         )
                                       , ( "degrees", Type.int )
                                       , ( "minutes", Type.int )
                                       , ( "seconds", Type.float )
                                       ]
                                  )
                             )
                     }
                )
                [ toDmsArg ]
    , sin =
        \sinArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "sin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ sinArg ]
    , cos =
        \cosArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "cos"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ cosArg ]
    , tan =
        \tanArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "tan"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  Type.float
                             )
                     }
                )
                [ tanArg ]
    , asin =
        \asinArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "asin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ asinArg ]
    , acos =
        \acosArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "acos"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ acosArg ]
    , atan =
        \atanArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "atan"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ atanArg ]
    , atan2 =
        \atan2Arg atan2Arg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "atan2"
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
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ atan2Arg, atan2Arg0 ]
    , normalize =
        \normalizeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Angle" ]
                     , name = "normalize"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  (Type.namedWith [ "Angle" ] "Angle" [])
                             )
                     }
                )
                [ normalizeArg ]
    }


values_ :
    { radians : Elm.Expression
    , inRadians : Elm.Expression
    , degrees : Elm.Expression
    , inDegrees : Elm.Expression
    , turns : Elm.Expression
    , inTurns : Elm.Expression
    , minutes : Elm.Expression
    , inMinutes : Elm.Expression
    , seconds : Elm.Expression
    , inSeconds : Elm.Expression
    , fromDms : Elm.Expression
    , toDms : Elm.Expression
    , sin : Elm.Expression
    , cos : Elm.Expression
    , tan : Elm.Expression
    , asin : Elm.Expression
    , acos : Elm.Expression
    , atan : Elm.Expression
    , atan2 : Elm.Expression
    , normalize : Elm.Expression
    , radian : Elm.Expression
    , degree : Elm.Expression
    , turn : Elm.Expression
    , minute : Elm.Expression
    , second : Elm.Expression
    }
values_ =
    { radians =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "radians"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , inRadians =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "inRadians"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , degrees =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "degrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , inDegrees =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "inDegrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , turns =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "turns"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , inTurns =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "inTurns"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , minutes =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "minutes"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , inMinutes =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "inMinutes"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , seconds =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "seconds"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , inSeconds =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "inSeconds"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , fromDms =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "fromDms"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "sign", Type.namedWith [ "Angle" ] "Sign" [] )
                             , ( "degrees", Type.int )
                             , ( "minutes", Type.int )
                             , ( "seconds", Type.float )
                             ]
                         ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , toDms =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "toDms"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         (Type.record
                              [ ( "sign", Type.namedWith [ "Angle" ] "Sign" [] )
                              , ( "degrees", Type.int )
                              , ( "minutes", Type.int )
                              , ( "seconds", Type.float )
                              ]
                         )
                    )
            }
    , sin =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "sin"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , cos =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "cos"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , tan =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "tan"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         Type.float
                    )
            }
    , asin =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "asin"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , acos =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "acos"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , atan =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "atan"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , atan2 =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "atan2"
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
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , normalize =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "normalize"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         (Type.namedWith [ "Angle" ] "Angle" [])
                    )
            }
    , radian =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "radian"
            , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
            }
    , degree =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "degree"
            , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
            }
    , turn =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "turn"
            , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
            }
    , minute =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "minute"
            , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
            }
    , second =
        Elm.value
            { importFrom = [ "Angle" ]
            , name = "second"
            , annotation = Just (Type.namedWith [ "Angle" ] "Angle" [])
            }
    }