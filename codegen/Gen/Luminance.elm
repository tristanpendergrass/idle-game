module Gen.Luminance exposing (annotation_, call_, footLamberts, inFootLamberts, inNits, moduleName_, nits, values_)

{-| 
@docs moduleName_, nits, inNits, footLamberts, inFootLamberts, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Luminance" ]


{-| Construct a luminance value from a number of nits. One nit is equal to one
[candela](LuminousIntensity) per square meter, or equivalently one
[lux](Illuminance) per [steradian](SolidAngle).

nits: Float -> Luminance.Luminance
-}
nits : Float -> Elm.Expression
nits nitsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Luminance" ]
             , name = "nits"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Luminance" ] "Luminance" [])
                     )
             }
        )
        [ Elm.float nitsArg ]


{-| Convert a luminance value to a number of nits.

inNits: Luminance.Luminance -> Float
-}
inNits : Elm.Expression -> Elm.Expression
inNits inNitsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Luminance" ]
             , name = "inNits"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Luminance" ] "Luminance" [] ]
                          Type.float
                     )
             }
        )
        [ inNitsArg ]


{-| Construct a luminance value from a number of
[foot-lamberts][wp-foot-lambert].

[wp-foot-lambert]: https://en.wikipedia.org/wiki/Foot-lambert

footLamberts: Float -> Luminance.Luminance
-}
footLamberts : Float -> Elm.Expression
footLamberts footLambertsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Luminance" ]
             , name = "footLamberts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Luminance" ] "Luminance" [])
                     )
             }
        )
        [ Elm.float footLambertsArg ]


{-| Convert a luminance value to a number of foot-lamberts.

inFootLamberts: Luminance.Luminance -> Float
-}
inFootLamberts : Elm.Expression -> Elm.Expression
inFootLamberts inFootLambertsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Luminance" ]
             , name = "inFootLamberts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Luminance" ] "Luminance" [] ]
                          Type.float
                     )
             }
        )
        [ inFootLambertsArg ]


annotation_ : { luminance : Type.Annotation, nits : Type.Annotation }
annotation_ =
    { luminance =
        Type.alias
            moduleName_
            "Luminance"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Luminance" ] "Nits" [] ]
            )
    , nits =
        Type.alias
            moduleName_
            "Nits"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "LuminousIntensity" ] "Candelas" []
                 , Type.namedWith [ "Area" ] "SquareMeters" []
                 ]
            )
    }


call_ :
    { nits : Elm.Expression -> Elm.Expression
    , inNits : Elm.Expression -> Elm.Expression
    , footLamberts : Elm.Expression -> Elm.Expression
    , inFootLamberts : Elm.Expression -> Elm.Expression
    }
call_ =
    { nits =
        \nitsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Luminance" ]
                     , name = "nits"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Luminance" ] "Luminance" []
                                  )
                             )
                     }
                )
                [ nitsArg ]
    , inNits =
        \inNitsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Luminance" ]
                     , name = "inNits"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Luminance" ]
                                      "Luminance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inNitsArg ]
    , footLamberts =
        \footLambertsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Luminance" ]
                     , name = "footLamberts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Luminance" ] "Luminance" []
                                  )
                             )
                     }
                )
                [ footLambertsArg ]
    , inFootLamberts =
        \inFootLambertsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Luminance" ]
                     , name = "inFootLamberts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Luminance" ]
                                      "Luminance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inFootLambertsArg ]
    }


values_ :
    { nits : Elm.Expression
    , inNits : Elm.Expression
    , footLamberts : Elm.Expression
    , inFootLamberts : Elm.Expression
    }
values_ =
    { nits =
        Elm.value
            { importFrom = [ "Luminance" ]
            , name = "nits"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Luminance" ] "Luminance" [])
                    )
            }
    , inNits =
        Elm.value
            { importFrom = [ "Luminance" ]
            , name = "inNits"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Luminance" ] "Luminance" [] ]
                         Type.float
                    )
            }
    , footLamberts =
        Elm.value
            { importFrom = [ "Luminance" ]
            , name = "footLamberts"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Luminance" ] "Luminance" [])
                    )
            }
    , inFootLamberts =
        Elm.value
            { importFrom = [ "Luminance" ]
            , name = "inFootLamberts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Luminance" ] "Luminance" [] ]
                         Type.float
                    )
            }
    }