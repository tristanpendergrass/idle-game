module Gen.Voltage exposing (annotation_, call_, inVolts, moduleName_, values_, volts)

{-| 
@docs moduleName_, volts, inVolts, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Voltage" ]


{-| Construct a voltage from a number of volts.

volts: Float -> Voltage.Voltage
-}
volts : Float -> Elm.Expression
volts voltsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Voltage" ]
             , name = "volts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Voltage" ] "Voltage" [])
                     )
             }
        )
        [ Elm.float voltsArg ]


{-| Convert a voltage to a number of volts.

inVolts: Voltage.Voltage -> Float
-}
inVolts : Elm.Expression -> Elm.Expression
inVolts inVoltsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Voltage" ]
             , name = "inVolts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Voltage" ] "Voltage" [] ]
                          Type.float
                     )
             }
        )
        [ inVoltsArg ]


annotation_ : { voltage : Type.Annotation, volts : Type.Annotation }
annotation_ =
    { voltage =
        Type.alias
            moduleName_
            "Voltage"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Voltage" ] "Volts" [] ]
            )
    , volts =
        Type.alias
            moduleName_
            "Volts"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Power" ] "Watts" []
                 , Type.namedWith [ "Current" ] "Amperes" []
                 ]
            )
    }


call_ :
    { volts : Elm.Expression -> Elm.Expression
    , inVolts : Elm.Expression -> Elm.Expression
    }
call_ =
    { volts =
        \voltsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Voltage" ]
                     , name = "volts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Voltage" ] "Voltage" [])
                             )
                     }
                )
                [ voltsArg ]
    , inVolts =
        \inVoltsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Voltage" ]
                     , name = "inVolts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Voltage" ] "Voltage" [] ]
                                  Type.float
                             )
                     }
                )
                [ inVoltsArg ]
    }


values_ : { volts : Elm.Expression, inVolts : Elm.Expression }
values_ =
    { volts =
        Elm.value
            { importFrom = [ "Voltage" ]
            , name = "volts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Voltage" ] "Voltage" [])
                    )
            }
    , inVolts =
        Elm.value
            { importFrom = [ "Voltage" ]
            , name = "inVolts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Voltage" ] "Voltage" [] ]
                         Type.float
                    )
            }
    }