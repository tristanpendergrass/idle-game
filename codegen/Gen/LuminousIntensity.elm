module Gen.LuminousIntensity exposing (annotation_, call_, candelas, inCandelas, moduleName_, values_)

{-| 
@docs moduleName_, candelas, inCandelas, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "LuminousIntensity" ]


{-| Construct a luminous intensity value from a number of candelas. One candela
is roughly equivalent to the luminous intensity of a single wax candle.

candelas: Float -> LuminousIntensity.LuminousIntensity
-}
candelas : Float -> Elm.Expression
candelas candelasArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "LuminousIntensity" ]
             , name = "candelas"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith
                               [ "LuminousIntensity" ]
                               "LuminousIntensity"
                               []
                          )
                     )
             }
        )
        [ Elm.float candelasArg ]


{-| Convert a luminous intensity to a number of candelas. For example, to
compute the luminous intensity of a light bulb with an output of 470 lumens
which emits light equally in all directions:

    LuminousFlux.lumens 470
        |> Quantity.per (SolidAngle.spats 1)
        |> LuminousIntensity.inCandelas
    --> 37.4014

If the same amount of light was emitted over a hemisphere instead of a full
sphere, the luminous intensity would be twice as great:

    LuminousFlux.lumens 470
        |> Quantity.per (SolidAngle.spats 0.5)
        |> LuminousIntensity.inCandelas
    --> 74.8028

inCandelas: LuminousIntensity.LuminousIntensity -> Float
-}
inCandelas : Elm.Expression -> Elm.Expression
inCandelas inCandelasArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "LuminousIntensity" ]
             , name = "inCandelas"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "LuminousIntensity" ]
                              "LuminousIntensity"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ inCandelasArg ]


annotation_ :
    { candelas : Type.Annotation, luminousIntensity : Type.Annotation }
annotation_ =
    { candelas =
        Type.alias
            moduleName_
            "Candelas"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "LuminousFlux" ] "Lumens" []
                 , Type.namedWith [ "SolidAngle" ] "Steradians" []
                 ]
            )
    , luminousIntensity =
        Type.alias
            moduleName_
            "LuminousIntensity"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith [ "LuminousIntensity" ] "Candelas" []
                 ]
            )
    }


call_ :
    { candelas : Elm.Expression -> Elm.Expression
    , inCandelas : Elm.Expression -> Elm.Expression
    }
call_ =
    { candelas =
        \candelasArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "LuminousIntensity" ]
                     , name = "candelas"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "LuminousIntensity" ]
                                       "LuminousIntensity"
                                       []
                                  )
                             )
                     }
                )
                [ candelasArg ]
    , inCandelas =
        \inCandelasArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "LuminousIntensity" ]
                     , name = "inCandelas"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "LuminousIntensity" ]
                                      "LuminousIntensity"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inCandelasArg ]
    }


values_ : { candelas : Elm.Expression, inCandelas : Elm.Expression }
values_ =
    { candelas =
        Elm.value
            { importFrom = [ "LuminousIntensity" ]
            , name = "candelas"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith
                              [ "LuminousIntensity" ]
                              "LuminousIntensity"
                              []
                         )
                    )
            }
    , inCandelas =
        Elm.value
            { importFrom = [ "LuminousIntensity" ]
            , name = "inCandelas"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "LuminousIntensity" ]
                             "LuminousIntensity"
                             []
                         ]
                         Type.float
                    )
            }
    }