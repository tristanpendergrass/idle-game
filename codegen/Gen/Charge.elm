module Gen.Charge exposing (ampereHours, annotation_, call_, coulombs, inAmpereHours, inCoulombs, inMilliampereHours, milliampereHours, moduleName_, values_)

{-| 
@docs moduleName_, coulombs, inCoulombs, ampereHours, inAmpereHours, milliampereHours, inMilliampereHours, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Charge" ]


{-| Construct a charge from a number of coulombs.

coulombs: Float -> Charge.Charge
-}
coulombs : Float -> Elm.Expression
coulombs coulombsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Charge" ]
             , name = "coulombs"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Charge" ] "Charge" [])
                     )
             }
        )
        [ Elm.float coulombsArg ]


{-| Convert a charge to a number of coulombs.

inCoulombs: Charge.Charge -> Float
-}
inCoulombs : Elm.Expression -> Elm.Expression
inCoulombs inCoulombsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Charge" ]
             , name = "inCoulombs"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Charge" ] "Charge" [] ]
                          Type.float
                     )
             }
        )
        [ inCoulombsArg ]


{-| Construct a charge from a number of ampere hours.

ampereHours: Float -> Charge.Charge
-}
ampereHours : Float -> Elm.Expression
ampereHours ampereHoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Charge" ]
             , name = "ampereHours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Charge" ] "Charge" [])
                     )
             }
        )
        [ Elm.float ampereHoursArg ]


{-| Convert a charge to a number of ampere hours.

inAmpereHours: Charge.Charge -> Float
-}
inAmpereHours : Elm.Expression -> Elm.Expression
inAmpereHours inAmpereHoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Charge" ]
             , name = "inAmpereHours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Charge" ] "Charge" [] ]
                          Type.float
                     )
             }
        )
        [ inAmpereHoursArg ]


{-| Construct a charge from a number of milliampere hours.

milliampereHours: Float -> Charge.Charge
-}
milliampereHours : Float -> Elm.Expression
milliampereHours milliampereHoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Charge" ]
             , name = "milliampereHours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Charge" ] "Charge" [])
                     )
             }
        )
        [ Elm.float milliampereHoursArg ]


{-| Convert a charge to a number of milliampere hours.

inMilliampereHours: Charge.Charge -> Float
-}
inMilliampereHours : Elm.Expression -> Elm.Expression
inMilliampereHours inMilliampereHoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Charge" ]
             , name = "inMilliampereHours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Charge" ] "Charge" [] ]
                          Type.float
                     )
             }
        )
        [ inMilliampereHoursArg ]


annotation_ : { charge : Type.Annotation, coulombs : Type.Annotation }
annotation_ =
    { charge =
        Type.alias
            moduleName_
            "Charge"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Charge" ] "Coulombs" [] ]
            )
    , coulombs = Type.namedWith [ "Charge" ] "Coulombs" []
    }


call_ :
    { coulombs : Elm.Expression -> Elm.Expression
    , inCoulombs : Elm.Expression -> Elm.Expression
    , ampereHours : Elm.Expression -> Elm.Expression
    , inAmpereHours : Elm.Expression -> Elm.Expression
    , milliampereHours : Elm.Expression -> Elm.Expression
    , inMilliampereHours : Elm.Expression -> Elm.Expression
    }
call_ =
    { coulombs =
        \coulombsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Charge" ]
                     , name = "coulombs"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Charge" ] "Charge" [])
                             )
                     }
                )
                [ coulombsArg ]
    , inCoulombs =
        \inCoulombsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Charge" ]
                     , name = "inCoulombs"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Charge" ] "Charge" [] ]
                                  Type.float
                             )
                     }
                )
                [ inCoulombsArg ]
    , ampereHours =
        \ampereHoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Charge" ]
                     , name = "ampereHours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Charge" ] "Charge" [])
                             )
                     }
                )
                [ ampereHoursArg ]
    , inAmpereHours =
        \inAmpereHoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Charge" ]
                     , name = "inAmpereHours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Charge" ] "Charge" [] ]
                                  Type.float
                             )
                     }
                )
                [ inAmpereHoursArg ]
    , milliampereHours =
        \milliampereHoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Charge" ]
                     , name = "milliampereHours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Charge" ] "Charge" [])
                             )
                     }
                )
                [ milliampereHoursArg ]
    , inMilliampereHours =
        \inMilliampereHoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Charge" ]
                     , name = "inMilliampereHours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Charge" ] "Charge" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMilliampereHoursArg ]
    }


values_ :
    { coulombs : Elm.Expression
    , inCoulombs : Elm.Expression
    , ampereHours : Elm.Expression
    , inAmpereHours : Elm.Expression
    , milliampereHours : Elm.Expression
    , inMilliampereHours : Elm.Expression
    }
values_ =
    { coulombs =
        Elm.value
            { importFrom = [ "Charge" ]
            , name = "coulombs"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Charge" ] "Charge" [])
                    )
            }
    , inCoulombs =
        Elm.value
            { importFrom = [ "Charge" ]
            , name = "inCoulombs"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Charge" ] "Charge" [] ]
                         Type.float
                    )
            }
    , ampereHours =
        Elm.value
            { importFrom = [ "Charge" ]
            , name = "ampereHours"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Charge" ] "Charge" [])
                    )
            }
    , inAmpereHours =
        Elm.value
            { importFrom = [ "Charge" ]
            , name = "inAmpereHours"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Charge" ] "Charge" [] ]
                         Type.float
                    )
            }
    , milliampereHours =
        Elm.value
            { importFrom = [ "Charge" ]
            , name = "milliampereHours"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Charge" ] "Charge" [])
                    )
            }
    , inMilliampereHours =
        Elm.value
            { importFrom = [ "Charge" ]
            , name = "inMilliampereHours"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Charge" ] "Charge" [] ]
                         Type.float
                    )
            }
    }