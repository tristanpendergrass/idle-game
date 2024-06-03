module Gen.SolidAngle exposing (annotation_, call_, conical, inSpats, inSquareDegrees, inSteradians, moduleName_, pyramidal, spats, squareDegrees, steradians, values_)

{-| 
@docs moduleName_, steradians, inSteradians, spats, inSpats, squareDegrees, inSquareDegrees, conical, pyramidal, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "SolidAngle" ]


{-| Construct a solid angle from a number of steradians.

steradians: Float -> SolidAngle.SolidAngle
-}
steradians : Float -> Elm.Expression
steradians steradiansArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "steradians"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                     )
             }
        )
        [ Elm.float steradiansArg ]


{-| Convert a solid angle to a number of steradians.

inSteradians: SolidAngle.SolidAngle -> Float
-}
inSteradians : Elm.Expression -> Elm.Expression
inSteradians inSteradiansArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "inSteradians"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "SolidAngle" ] "SolidAngle" [] ]
                          Type.float
                     )
             }
        )
        [ inSteradiansArg ]


{-| Construct a solid angle from a number of [spats][1]. One spat is the 3D
equivalent of one full turn; in the same way that one turn is the angle that
covers an entire circle, one spat is the solid angle that covers an entire
sphere. It's rare to have solid angles more than one spat, since solid angles
are usually used to measure what angular fraction of a full sphere something
covers.

    SolidAngle.spats 1
    --> SolidAngle.steradians (4 * pi)

[1]: https://en.wikipedia.org/wiki/Spat_(unit)

spats: Float -> SolidAngle.SolidAngle
-}
spats : Float -> Elm.Expression
spats spatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "spats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                     )
             }
        )
        [ Elm.float spatsArg ]


{-| Convert a solid angle to a number of spats.

    SolidAngle.steradians (2 * pi) |> SolidAngle.inSpats
    --> 0.5

inSpats: SolidAngle.SolidAngle -> Float
-}
inSpats : Elm.Expression -> Elm.Expression
inSpats inSpatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "inSpats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "SolidAngle" ] "SolidAngle" [] ]
                          Type.float
                     )
             }
        )
        [ inSpatsArg ]


{-| Construct a solid angle from a number of [square
degrees](https://en.wikipedia.org/wiki/Square_degree). One square degree is,
roughly speaking, the solid angle of a square on the surface of a sphere where
the square is one degree wide and one degree tall as viewed from the center of
the sphere.

    SolidAngle.squareDegrees 100
    -> SolidAngle.steradians 0.03046

squareDegrees: Float -> SolidAngle.SolidAngle
-}
squareDegrees : Float -> Elm.Expression
squareDegrees squareDegreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "squareDegrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                     )
             }
        )
        [ Elm.float squareDegreesArg ]


{-| Convert a solid angle to a number of square degrees.

    SolidAngle.spats 1 |> SolidAngle.inSquareDegrees
    --> 41252.96125

inSquareDegrees: SolidAngle.SolidAngle -> Float
-}
inSquareDegrees : Elm.Expression -> Elm.Expression
inSquareDegrees inSquareDegreesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "inSquareDegrees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "SolidAngle" ] "SolidAngle" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareDegreesArg ]


{-| Find the solid angle of a cone with a given tip angle (the angle between two
opposite sides of the cone, _not_ the half-angle from the axis of the cone to
its side). A 1 degree cone has a solid angle of approximately π/4 square
degrees, similar to how a circle of diameter 1 has an area of π/4:

    SolidAngle.conical (Angle.degrees 1)
        |> SolidAngle.inSquareDegrees
    --> 0.78539318

    pi / 4
    --> 0.78539816

A cone with a tip angle of 180 degrees is just a hemisphere:

    SolidAngle.conical (Angle.degrees 180)
    --> SolidAngle.spats 0.5

"Inside out" cones are also supported, up to 360 degrees (a full sphere):

    SolidAngle.conical (Angle.degrees 270)
    --> SolidAngle.spats 0.85355

    SolidAngle.conical (Angle.degrees 360)
    --> SolidAngle.spats 1

conical: Angle.Angle -> SolidAngle.SolidAngle
-}
conical : Elm.Expression -> Elm.Expression
conical conicalArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "conical"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" [] ]
                          (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                     )
             }
        )
        [ conicalArg ]


{-| Find the solid angle of a rectangular pyramid given the angles between the
two pairs of sides. A 1 degree by 1 degree pyramid has a solid angle of almost
exactly 1 square degree:

    SolidAngle.pyramidal
        (Angle.degrees 1)
        (Angle.degrees 1)
    --> SolidAngle.squareDegrees 0.9999746

In general, the solid angle of a pyramid that is _n_ degrees wide by _m_ degrees
tall is (for relatively small values of _n_ and _m_) approximately _nm_ square
degrees:

    SolidAngle.pyramidal
        (Angle.degrees 10)
        (Angle.degrees 10)
    --> SolidAngle.squareDegrees 99.7474

    SolidAngle.pyramidal
        (Angle.degrees 60)
        (Angle.degrees 30)
    --> SolidAngle.squareDegrees 1704.08

A pyramid that is 180 degrees by 180 degrees covers an entire hemisphere:

    SolidAngle.pyramidal
        (Angle.degrees 180)
        (Angle.degrees 180)
    --> SolidAngle.spats 0.5

"Inside out" pyramids greater than 180 degrees are not supported and will be
treated as the corresponding "normal" pyramid (an angle of 240 degrees will be
treated as 120 degrees, an angle of 330 degrees will be treated as 30 degrees,
etc.).

pyramidal: Angle.Angle -> Angle.Angle -> SolidAngle.SolidAngle
-}
pyramidal : Elm.Expression -> Elm.Expression -> Elm.Expression
pyramidal pyramidalArg pyramidalArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "SolidAngle" ]
             , name = "pyramidal"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Angle" ] "Angle" []
                          , Type.namedWith [ "Angle" ] "Angle" []
                          ]
                          (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                     )
             }
        )
        [ pyramidalArg, pyramidalArg0 ]


annotation_ : { solidAngle : Type.Annotation, steradians : Type.Annotation }
annotation_ =
    { solidAngle =
        Type.alias
            moduleName_
            "SolidAngle"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "SolidAngle" ] "Steradians" [] ]
            )
    , steradians = Type.namedWith [ "SolidAngle" ] "Steradians" []
    }


call_ :
    { steradians : Elm.Expression -> Elm.Expression
    , inSteradians : Elm.Expression -> Elm.Expression
    , spats : Elm.Expression -> Elm.Expression
    , inSpats : Elm.Expression -> Elm.Expression
    , squareDegrees : Elm.Expression -> Elm.Expression
    , inSquareDegrees : Elm.Expression -> Elm.Expression
    , conical : Elm.Expression -> Elm.Expression
    , pyramidal : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { steradians =
        \steradiansArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "steradians"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SolidAngle" ]
                                       "SolidAngle"
                                       []
                                  )
                             )
                     }
                )
                [ steradiansArg ]
    , inSteradians =
        \inSteradiansArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "inSteradians"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SolidAngle" ]
                                      "SolidAngle"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inSteradiansArg ]
    , spats =
        \spatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "spats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SolidAngle" ]
                                       "SolidAngle"
                                       []
                                  )
                             )
                     }
                )
                [ spatsArg ]
    , inSpats =
        \inSpatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "inSpats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SolidAngle" ]
                                      "SolidAngle"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inSpatsArg ]
    , squareDegrees =
        \squareDegreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "squareDegrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "SolidAngle" ]
                                       "SolidAngle"
                                       []
                                  )
                             )
                     }
                )
                [ squareDegreesArg ]
    , inSquareDegrees =
        \inSquareDegreesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "inSquareDegrees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "SolidAngle" ]
                                      "SolidAngle"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inSquareDegreesArg ]
    , conical =
        \conicalArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "conical"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" [] ]
                                  (Type.namedWith
                                       [ "SolidAngle" ]
                                       "SolidAngle"
                                       []
                                  )
                             )
                     }
                )
                [ conicalArg ]
    , pyramidal =
        \pyramidalArg pyramidalArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "SolidAngle" ]
                     , name = "pyramidal"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Angle" ] "Angle" []
                                  , Type.namedWith [ "Angle" ] "Angle" []
                                  ]
                                  (Type.namedWith
                                       [ "SolidAngle" ]
                                       "SolidAngle"
                                       []
                                  )
                             )
                     }
                )
                [ pyramidalArg, pyramidalArg0 ]
    }


values_ :
    { steradians : Elm.Expression
    , inSteradians : Elm.Expression
    , spats : Elm.Expression
    , inSpats : Elm.Expression
    , squareDegrees : Elm.Expression
    , inSquareDegrees : Elm.Expression
    , conical : Elm.Expression
    , pyramidal : Elm.Expression
    }
values_ =
    { steradians =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "steradians"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                    )
            }
    , inSteradians =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "inSteradians"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "SolidAngle" ] "SolidAngle" [] ]
                         Type.float
                    )
            }
    , spats =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "spats"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                    )
            }
    , inSpats =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "inSpats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "SolidAngle" ] "SolidAngle" [] ]
                         Type.float
                    )
            }
    , squareDegrees =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "squareDegrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                    )
            }
    , inSquareDegrees =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "inSquareDegrees"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "SolidAngle" ] "SolidAngle" [] ]
                         Type.float
                    )
            }
    , conical =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "conical"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" [] ]
                         (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                    )
            }
    , pyramidal =
        Elm.value
            { importFrom = [ "SolidAngle" ]
            , name = "pyramidal"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Angle" ] "Angle" []
                         , Type.namedWith [ "Angle" ] "Angle" []
                         ]
                         (Type.namedWith [ "SolidAngle" ] "SolidAngle" [])
                    )
            }
    }