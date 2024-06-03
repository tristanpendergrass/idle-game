module Gen.LuminousFlux exposing (annotation_, call_, inLumens, lumens, moduleName_, values_)

{-| 
@docs moduleName_, lumens, inLumens, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "LuminousFlux" ]


{-| Construct a luminous flux value from a number of lumens. See
[here][wp-luminous-flux-examples] and [here][wp-lumen-lighting] for the number
of lumens emitted by some common light sources.

[wp-luminous-flux-examples]: https://en.wikipedia.org/wiki/Luminous_flux#Examples
[wp-lumen-lighting]: https://en.wikipedia.org/wiki/Lumen_(unit)#Lighting

lumens: Float -> LuminousFlux.LuminousFlux
-}
lumens : Float -> Elm.Expression
lumens lumensArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "LuminousFlux" ]
             , name = "lumens"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "LuminousFlux" ] "LuminousFlux" [])
                     )
             }
        )
        [ Elm.float lumensArg ]


{-| Convert a luminous flux value to a number of lumens.

inLumens: LuminousFlux.LuminousFlux -> Float
-}
inLumens : Elm.Expression -> Elm.Expression
inLumens inLumensArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "LuminousFlux" ]
             , name = "inLumens"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "LuminousFlux" ] "LuminousFlux" []
                          ]
                          Type.float
                     )
             }
        )
        [ inLumensArg ]


annotation_ : { lumens : Type.Annotation, luminousFlux : Type.Annotation }
annotation_ =
    { lumens = Type.namedWith [ "LuminousFlux" ] "Lumens" []
    , luminousFlux =
        Type.alias
            moduleName_
            "LuminousFlux"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "LuminousFlux" ] "Lumens" [] ]
            )
    }


call_ :
    { lumens : Elm.Expression -> Elm.Expression
    , inLumens : Elm.Expression -> Elm.Expression
    }
call_ =
    { lumens =
        \lumensArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "LuminousFlux" ]
                     , name = "lumens"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "LuminousFlux" ]
                                       "LuminousFlux"
                                       []
                                  )
                             )
                     }
                )
                [ lumensArg ]
    , inLumens =
        \inLumensArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "LuminousFlux" ]
                     , name = "inLumens"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "LuminousFlux" ]
                                      "LuminousFlux"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inLumensArg ]
    }


values_ : { lumens : Elm.Expression, inLumens : Elm.Expression }
values_ =
    { lumens =
        Elm.value
            { importFrom = [ "LuminousFlux" ]
            , name = "lumens"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "LuminousFlux" ] "LuminousFlux" [])
                    )
            }
    , inLumens =
        Elm.value
            { importFrom = [ "LuminousFlux" ]
            , name = "inLumens"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "LuminousFlux" ] "LuminousFlux" [] ]
                         Type.float
                    )
            }
    }