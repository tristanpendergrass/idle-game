module Gen.Acceleration exposing (annotation_, call_, feetPerSecondSquared, gees, inFeetPerSecondSquared, inGees, inMetersPerSecondSquared, metersPerSecondSquared, moduleName_, values_)

{-| 
@docs moduleName_, metersPerSecondSquared, inMetersPerSecondSquared, feetPerSecondSquared, inFeetPerSecondSquared, gees, inGees, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Acceleration" ]


{-| Construct an acceleration from a number of meters per second squared.

metersPerSecondSquared: Float -> Acceleration.Acceleration
-}
metersPerSecondSquared : Float -> Elm.Expression
metersPerSecondSquared metersPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Acceleration" ]
             , name = "metersPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Acceleration" ] "Acceleration" [])
                     )
             }
        )
        [ Elm.float metersPerSecondSquaredArg ]


{-| Convert an acceleration to a number of meters per second squared.

inMetersPerSecondSquared: Acceleration.Acceleration -> Float
-}
inMetersPerSecondSquared : Elm.Expression -> Elm.Expression
inMetersPerSecondSquared inMetersPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Acceleration" ]
             , name = "inMetersPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Acceleration" ] "Acceleration" []
                          ]
                          Type.float
                     )
             }
        )
        [ inMetersPerSecondSquaredArg ]


{-| Construct an acceleration from a number of feet per second squared.

feetPerSecondSquared: Float -> Acceleration.Acceleration
-}
feetPerSecondSquared : Float -> Elm.Expression
feetPerSecondSquared feetPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Acceleration" ]
             , name = "feetPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Acceleration" ] "Acceleration" [])
                     )
             }
        )
        [ Elm.float feetPerSecondSquaredArg ]


{-| Convert an acceleration to a number of feet per second squared.

inFeetPerSecondSquared: Acceleration.Acceleration -> Float
-}
inFeetPerSecondSquared : Elm.Expression -> Elm.Expression
inFeetPerSecondSquared inFeetPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Acceleration" ]
             , name = "inFeetPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Acceleration" ] "Acceleration" []
                          ]
                          Type.float
                     )
             }
        )
        [ inFeetPerSecondSquaredArg ]


{-| Construct an acceleration from a number of [gees][1]. One gee is equal to
9.80665 meters per second squared (the standard acceleration due to gravity).

    Acceleration.gees 1
    --> Acceleration.metersPerSecondSquared 9.80665

[1]: https://en.wikipedia.org/wiki/G-force#Unit_and_measurement

gees: Float -> Acceleration.Acceleration
-}
gees : Float -> Elm.Expression
gees geesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Acceleration" ]
             , name = "gees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Acceleration" ] "Acceleration" [])
                     )
             }
        )
        [ Elm.float geesArg ]


{-| Convert an acceleration to a number of gees.

inGees: Acceleration.Acceleration -> Float
-}
inGees : Elm.Expression -> Elm.Expression
inGees inGeesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Acceleration" ]
             , name = "inGees"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Acceleration" ] "Acceleration" []
                          ]
                          Type.float
                     )
             }
        )
        [ inGeesArg ]


annotation_ :
    { acceleration : Type.Annotation, metersPerSecondSquared : Type.Annotation }
annotation_ =
    { acceleration =
        Type.alias
            moduleName_
            "Acceleration"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith [ "Acceleration" ] "MetersPerSecondSquared" []
                 ]
            )
    , metersPerSecondSquared =
        Type.alias
            moduleName_
            "MetersPerSecondSquared"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Speed" ] "MetersPerSecond" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    }


call_ :
    { metersPerSecondSquared : Elm.Expression -> Elm.Expression
    , inMetersPerSecondSquared : Elm.Expression -> Elm.Expression
    , feetPerSecondSquared : Elm.Expression -> Elm.Expression
    , inFeetPerSecondSquared : Elm.Expression -> Elm.Expression
    , gees : Elm.Expression -> Elm.Expression
    , inGees : Elm.Expression -> Elm.Expression
    }
call_ =
    { metersPerSecondSquared =
        \metersPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Acceleration" ]
                     , name = "metersPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Acceleration" ]
                                       "Acceleration"
                                       []
                                  )
                             )
                     }
                )
                [ metersPerSecondSquaredArg ]
    , inMetersPerSecondSquared =
        \inMetersPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Acceleration" ]
                     , name = "inMetersPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Acceleration" ]
                                      "Acceleration"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMetersPerSecondSquaredArg ]
    , feetPerSecondSquared =
        \feetPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Acceleration" ]
                     , name = "feetPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Acceleration" ]
                                       "Acceleration"
                                       []
                                  )
                             )
                     }
                )
                [ feetPerSecondSquaredArg ]
    , inFeetPerSecondSquared =
        \inFeetPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Acceleration" ]
                     , name = "inFeetPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Acceleration" ]
                                      "Acceleration"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inFeetPerSecondSquaredArg ]
    , gees =
        \geesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Acceleration" ]
                     , name = "gees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Acceleration" ]
                                       "Acceleration"
                                       []
                                  )
                             )
                     }
                )
                [ geesArg ]
    , inGees =
        \inGeesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Acceleration" ]
                     , name = "inGees"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Acceleration" ]
                                      "Acceleration"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inGeesArg ]
    }


values_ :
    { metersPerSecondSquared : Elm.Expression
    , inMetersPerSecondSquared : Elm.Expression
    , feetPerSecondSquared : Elm.Expression
    , inFeetPerSecondSquared : Elm.Expression
    , gees : Elm.Expression
    , inGees : Elm.Expression
    }
values_ =
    { metersPerSecondSquared =
        Elm.value
            { importFrom = [ "Acceleration" ]
            , name = "metersPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Acceleration" ] "Acceleration" [])
                    )
            }
    , inMetersPerSecondSquared =
        Elm.value
            { importFrom = [ "Acceleration" ]
            , name = "inMetersPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Acceleration" ] "Acceleration" [] ]
                         Type.float
                    )
            }
    , feetPerSecondSquared =
        Elm.value
            { importFrom = [ "Acceleration" ]
            , name = "feetPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Acceleration" ] "Acceleration" [])
                    )
            }
    , inFeetPerSecondSquared =
        Elm.value
            { importFrom = [ "Acceleration" ]
            , name = "inFeetPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Acceleration" ] "Acceleration" [] ]
                         Type.float
                    )
            }
    , gees =
        Elm.value
            { importFrom = [ "Acceleration" ]
            , name = "gees"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Acceleration" ] "Acceleration" [])
                    )
            }
    , inGees =
        Elm.value
            { importFrom = [ "Acceleration" ]
            , name = "inGees"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Acceleration" ] "Acceleration" [] ]
                         Type.float
                    )
            }
    }