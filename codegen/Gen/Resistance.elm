module Gen.Resistance exposing (annotation_, call_, inOhms, moduleName_, ohms, values_)

{-| 
@docs moduleName_, ohms, inOhms, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Resistance" ]


{-| Construct a resistance from a number of ohms.

ohms: Float -> Resistance.Resistance
-}
ohms : Float -> Elm.Expression
ohms ohmsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Resistance" ]
             , name = "ohms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Resistance" ] "Resistance" [])
                     )
             }
        )
        [ Elm.float ohmsArg ]


{-| Convert a resistance to a number of ohms.

inOhms: Resistance.Resistance -> Float
-}
inOhms : Elm.Expression -> Elm.Expression
inOhms inOhmsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Resistance" ]
             , name = "inOhms"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Resistance" ] "Resistance" [] ]
                          Type.float
                     )
             }
        )
        [ inOhmsArg ]


annotation_ : { resistance : Type.Annotation, ohms : Type.Annotation }
annotation_ =
    { resistance =
        Type.alias
            moduleName_
            "Resistance"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Resistance" ] "Ohms" [] ]
            )
    , ohms =
        Type.alias
            moduleName_
            "Ohms"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Voltage" ] "Volts" []
                 , Type.namedWith [ "Current" ] "Amperes" []
                 ]
            )
    }


call_ :
    { ohms : Elm.Expression -> Elm.Expression
    , inOhms : Elm.Expression -> Elm.Expression
    }
call_ =
    { ohms =
        \ohmsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Resistance" ]
                     , name = "ohms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Resistance" ]
                                       "Resistance"
                                       []
                                  )
                             )
                     }
                )
                [ ohmsArg ]
    , inOhms =
        \inOhmsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Resistance" ]
                     , name = "inOhms"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Resistance" ]
                                      "Resistance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inOhmsArg ]
    }


values_ : { ohms : Elm.Expression, inOhms : Elm.Expression }
values_ =
    { ohms =
        Elm.value
            { importFrom = [ "Resistance" ]
            , name = "ohms"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Resistance" ] "Resistance" [])
                    )
            }
    , inOhms =
        Elm.value
            { importFrom = [ "Resistance" ]
            , name = "inOhms"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Resistance" ] "Resistance" [] ]
                         Type.float
                    )
            }
    }