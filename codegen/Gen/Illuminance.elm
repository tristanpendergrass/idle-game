module Gen.Illuminance exposing (annotation_, call_, footCandles, inFootCandles, inLux, lux, moduleName_, values_)

{-| 
@docs moduleName_, lux, inLux, footCandles, inFootCandles, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Illuminance" ]


{-| Construct an illuminance value from a number of lux. One lux is equal to one
lumen per square meter. See [here][wp-lux-illuminance] for a table of
illuminance values in lux for common environments.

[wp-lux-illuminance]: https://en.wikipedia.org/wiki/Lux#Illuminance

lux: Float -> Illuminance.Illuminance
-}
lux : Float -> Elm.Expression
lux luxArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Illuminance" ]
             , name = "lux"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Illuminance" ] "Illuminance" [])
                     )
             }
        )
        [ Elm.float luxArg ]


{-| Convert an illuminance value to a number of lux.

inLux: Illuminance.Illuminance -> Float
-}
inLux : Elm.Expression -> Elm.Expression
inLux inLuxArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Illuminance" ]
             , name = "inLux"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Illuminance" ] "Illuminance" [] ]
                          Type.float
                     )
             }
        )
        [ inLuxArg ]


{-| Construct an illuminance value from a number of
[foot-candles][wp-foot-candles]. One foot-candle is equal to one lumen per
square foot.

[wp-foot-candles]: https://en.wikipedia.org/wiki/Foot-candle

footCandles: Float -> Illuminance.Illuminance
-}
footCandles : Float -> Elm.Expression
footCandles footCandlesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Illuminance" ]
             , name = "footCandles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Illuminance" ] "Illuminance" [])
                     )
             }
        )
        [ Elm.float footCandlesArg ]


{-| Convert an illuminance value to a number of foot-candles.

inFootCandles: Illuminance.Illuminance -> Float
-}
inFootCandles : Elm.Expression -> Elm.Expression
inFootCandles inFootCandlesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Illuminance" ]
             , name = "inFootCandles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Illuminance" ] "Illuminance" [] ]
                          Type.float
                     )
             }
        )
        [ inFootCandlesArg ]


annotation_ : { illuminance : Type.Annotation, lux : Type.Annotation }
annotation_ =
    { illuminance =
        Type.alias
            moduleName_
            "Illuminance"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Illuminance" ] "Lux" [] ]
            )
    , lux =
        Type.alias
            moduleName_
            "Lux"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "LuminousFlux" ] "Lumens" []
                 , Type.namedWith [ "Area" ] "SquareMeters" []
                 ]
            )
    }


call_ :
    { lux : Elm.Expression -> Elm.Expression
    , inLux : Elm.Expression -> Elm.Expression
    , footCandles : Elm.Expression -> Elm.Expression
    , inFootCandles : Elm.Expression -> Elm.Expression
    }
call_ =
    { lux =
        \luxArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Illuminance" ]
                     , name = "lux"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Illuminance" ]
                                       "Illuminance"
                                       []
                                  )
                             )
                     }
                )
                [ luxArg ]
    , inLux =
        \inLuxArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Illuminance" ]
                     , name = "inLux"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Illuminance" ]
                                      "Illuminance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inLuxArg ]
    , footCandles =
        \footCandlesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Illuminance" ]
                     , name = "footCandles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Illuminance" ]
                                       "Illuminance"
                                       []
                                  )
                             )
                     }
                )
                [ footCandlesArg ]
    , inFootCandles =
        \inFootCandlesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Illuminance" ]
                     , name = "inFootCandles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Illuminance" ]
                                      "Illuminance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inFootCandlesArg ]
    }


values_ :
    { lux : Elm.Expression
    , inLux : Elm.Expression
    , footCandles : Elm.Expression
    , inFootCandles : Elm.Expression
    }
values_ =
    { lux =
        Elm.value
            { importFrom = [ "Illuminance" ]
            , name = "lux"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Illuminance" ] "Illuminance" [])
                    )
            }
    , inLux =
        Elm.value
            { importFrom = [ "Illuminance" ]
            , name = "inLux"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Illuminance" ] "Illuminance" [] ]
                         Type.float
                    )
            }
    , footCandles =
        Elm.value
            { importFrom = [ "Illuminance" ]
            , name = "footCandles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Illuminance" ] "Illuminance" [])
                    )
            }
    , inFootCandles =
        Elm.value
            { importFrom = [ "Illuminance" ]
            , name = "inFootCandles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Illuminance" ] "Illuminance" [] ]
                         Type.float
                    )
            }
    }