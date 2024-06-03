module Gen.AngularAcceleration exposing (annotation_, call_, degreesPerSecondSquared, inDegreesPerSecondSquared, inRadiansPerSecondSquared, inTurnsPerSecondSquared, moduleName_, radiansPerSecondSquared, turnsPerSecondSquared, values_)

{-| 
@docs moduleName_, radiansPerSecondSquared, inRadiansPerSecondSquared, degreesPerSecondSquared, inDegreesPerSecondSquared, turnsPerSecondSquared, inTurnsPerSecondSquared, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "AngularAcceleration" ]


{-| Construct an angular acceleration from a number of radians per second squared.

radiansPerSecondSquared: Float -> AngularAcceleration.AngularAcceleration
-}
radiansPerSecondSquared : Float -> Elm.Expression
radiansPerSecondSquared radiansPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularAcceleration" ]
             , name = "radiansPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "AngularAcceleration" ]
                               "AngularAcceleration"
                               []
                          )
                     )
             }
        )
        [ Elm.float radiansPerSecondSquaredArg ]


{-| Convert an angular acceleration to a number of radians per second squared.

inRadiansPerSecondSquared: AngularAcceleration.AngularAcceleration -> Float
-}
inRadiansPerSecondSquared : Elm.Expression -> Elm.Expression
inRadiansPerSecondSquared inRadiansPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularAcceleration" ]
             , name = "inRadiansPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "AngularAcceleration" ]
                              "AngularAcceleration"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inRadiansPerSecondSquaredArg ]


{-| Construct an angular acceleration from a number of degrees per second squared.

degreesPerSecondSquared: Float -> AngularAcceleration.AngularAcceleration
-}
degreesPerSecondSquared : Float -> Elm.Expression
degreesPerSecondSquared degreesPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularAcceleration" ]
             , name = "degreesPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "AngularAcceleration" ]
                               "AngularAcceleration"
                               []
                          )
                     )
             }
        )
        [ Elm.float degreesPerSecondSquaredArg ]


{-| Convert an angular acceleration to a number of degrees per second squared.

inDegreesPerSecondSquared: AngularAcceleration.AngularAcceleration -> Float
-}
inDegreesPerSecondSquared : Elm.Expression -> Elm.Expression
inDegreesPerSecondSquared inDegreesPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularAcceleration" ]
             , name = "inDegreesPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "AngularAcceleration" ]
                              "AngularAcceleration"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inDegreesPerSecondSquaredArg ]


{-| Construct an angular acceleration from a number of turns per second squared.

turnsPerSecondSquared: Float -> AngularAcceleration.AngularAcceleration
-}
turnsPerSecondSquared : Float -> Elm.Expression
turnsPerSecondSquared turnsPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularAcceleration" ]
             , name = "turnsPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "AngularAcceleration" ]
                               "AngularAcceleration"
                               []
                          )
                     )
             }
        )
        [ Elm.float turnsPerSecondSquaredArg ]


{-| Convert an angular acceleration to a number of turns per second squared.

inTurnsPerSecondSquared: AngularAcceleration.AngularAcceleration -> Float
-}
inTurnsPerSecondSquared : Elm.Expression -> Elm.Expression
inTurnsPerSecondSquared inTurnsPerSecondSquaredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "AngularAcceleration" ]
             , name = "inTurnsPerSecondSquared"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "AngularAcceleration" ]
                              "AngularAcceleration"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inTurnsPerSecondSquaredArg ]


annotation_ :
    { angularAcceleration : Type.Annotation
    , radiansPerSecondSquared : Type.Annotation
    }
annotation_ =
    { angularAcceleration =
        Type.alias
            moduleName_
            "AngularAcceleration"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith
                     [ "AngularAcceleration" ]
                     "RadiansPerSecondSquared"
                     []
                 ]
            )
    , radiansPerSecondSquared =
        Type.alias
            moduleName_
            "RadiansPerSecondSquared"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "AngularSpeed" ] "RadiansPerSecond" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    }


call_ :
    { radiansPerSecondSquared : Elm.Expression -> Elm.Expression
    , inRadiansPerSecondSquared : Elm.Expression -> Elm.Expression
    , degreesPerSecondSquared : Elm.Expression -> Elm.Expression
    , inDegreesPerSecondSquared : Elm.Expression -> Elm.Expression
    , turnsPerSecondSquared : Elm.Expression -> Elm.Expression
    , inTurnsPerSecondSquared : Elm.Expression -> Elm.Expression
    }
call_ =
    { radiansPerSecondSquared =
        \radiansPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularAcceleration" ]
                     , name = "radiansPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularAcceleration" ]
                                       "AngularAcceleration"
                                       []
                                  )
                             )
                     }
                )
                [ radiansPerSecondSquaredArg ]
    , inRadiansPerSecondSquared =
        \inRadiansPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularAcceleration" ]
                     , name = "inRadiansPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularAcceleration" ]
                                      "AngularAcceleration"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inRadiansPerSecondSquaredArg ]
    , degreesPerSecondSquared =
        \degreesPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularAcceleration" ]
                     , name = "degreesPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularAcceleration" ]
                                       "AngularAcceleration"
                                       []
                                  )
                             )
                     }
                )
                [ degreesPerSecondSquaredArg ]
    , inDegreesPerSecondSquared =
        \inDegreesPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularAcceleration" ]
                     , name = "inDegreesPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularAcceleration" ]
                                      "AngularAcceleration"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inDegreesPerSecondSquaredArg ]
    , turnsPerSecondSquared =
        \turnsPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularAcceleration" ]
                     , name = "turnsPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "AngularAcceleration" ]
                                       "AngularAcceleration"
                                       []
                                  )
                             )
                     }
                )
                [ turnsPerSecondSquaredArg ]
    , inTurnsPerSecondSquared =
        \inTurnsPerSecondSquaredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "AngularAcceleration" ]
                     , name = "inTurnsPerSecondSquared"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "AngularAcceleration" ]
                                      "AngularAcceleration"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inTurnsPerSecondSquaredArg ]
    }


values_ :
    { radiansPerSecondSquared : Elm.Expression
    , inRadiansPerSecondSquared : Elm.Expression
    , degreesPerSecondSquared : Elm.Expression
    , inDegreesPerSecondSquared : Elm.Expression
    , turnsPerSecondSquared : Elm.Expression
    , inTurnsPerSecondSquared : Elm.Expression
    }
values_ =
    { radiansPerSecondSquared =
        Elm.value
            { importFrom = [ "AngularAcceleration" ]
            , name = "radiansPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "AngularAcceleration" ]
                              "AngularAcceleration"
                              []
                         )
                    )
            }
    , inRadiansPerSecondSquared =
        Elm.value
            { importFrom = [ "AngularAcceleration" ]
            , name = "inRadiansPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "AngularAcceleration" ]
                             "AngularAcceleration"
                             []
                         ]
                         Type.float
                    )
            }
    , degreesPerSecondSquared =
        Elm.value
            { importFrom = [ "AngularAcceleration" ]
            , name = "degreesPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "AngularAcceleration" ]
                              "AngularAcceleration"
                              []
                         )
                    )
            }
    , inDegreesPerSecondSquared =
        Elm.value
            { importFrom = [ "AngularAcceleration" ]
            , name = "inDegreesPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "AngularAcceleration" ]
                             "AngularAcceleration"
                             []
                         ]
                         Type.float
                    )
            }
    , turnsPerSecondSquared =
        Elm.value
            { importFrom = [ "AngularAcceleration" ]
            , name = "turnsPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "AngularAcceleration" ]
                              "AngularAcceleration"
                              []
                         )
                    )
            }
    , inTurnsPerSecondSquared =
        Elm.value
            { importFrom = [ "AngularAcceleration" ]
            , name = "inTurnsPerSecondSquared"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "AngularAcceleration" ]
                             "AngularAcceleration"
                             []
                         ]
                         Type.float
                    )
            }
    }