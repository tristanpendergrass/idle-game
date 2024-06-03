module Gen.Molarity exposing (annotation_, call_, centimolesPerLiter, decimolesPerLiter, inCentimolesPerLiter, inDecimolesPerLiter, inMicromolesPerLiter, inMillimolesPerLiter, inMolesPerCubicMeter, inMolesPerLiter, micromolesPerLiter, millimolesPerLiter, moduleName_, molesPerCubicMeter, molesPerLiter, values_)

{-| 
@docs moduleName_, molesPerCubicMeter, inMolesPerCubicMeter, molesPerLiter, inMolesPerLiter, decimolesPerLiter, inDecimolesPerLiter, centimolesPerLiter, inCentimolesPerLiter, millimolesPerLiter, inMillimolesPerLiter, micromolesPerLiter, inMicromolesPerLiter, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Molarity" ]


{-| Construct a molarity from a number of moles per cubic meter.

molesPerCubicMeter: Float -> Molarity.Molarity
-}
molesPerCubicMeter : Float -> Elm.Expression
molesPerCubicMeter molesPerCubicMeterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "molesPerCubicMeter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Molarity" ] "Molarity" [])
                     )
             }
        )
        [ Elm.float molesPerCubicMeterArg ]


{-| Convert a molarity to a number of moles per cubic meter.

inMolesPerCubicMeter: Molarity.Molarity -> Float
-}
inMolesPerCubicMeter : Elm.Expression -> Elm.Expression
inMolesPerCubicMeter inMolesPerCubicMeterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "inMolesPerCubicMeter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                          Type.float
                     )
             }
        )
        [ inMolesPerCubicMeterArg ]


{-| Construct a molarity from a number of moles per liter.

molesPerLiter: Float -> Molarity.Molarity
-}
molesPerLiter : Float -> Elm.Expression
molesPerLiter molesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "molesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Molarity" ] "Molarity" [])
                     )
             }
        )
        [ Elm.float molesPerLiterArg ]


{-| Convert a molarity to a number of moles per liter.

inMolesPerLiter: Molarity.Molarity -> Float
-}
inMolesPerLiter : Elm.Expression -> Elm.Expression
inMolesPerLiter inMolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "inMolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                          Type.float
                     )
             }
        )
        [ inMolesPerLiterArg ]


{-| Construct a molarity from a number of decimoles per liter.

decimolesPerLiter: Float -> Molarity.Molarity
-}
decimolesPerLiter : Float -> Elm.Expression
decimolesPerLiter decimolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "decimolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Molarity" ] "Molarity" [])
                     )
             }
        )
        [ Elm.float decimolesPerLiterArg ]


{-| Convert a molarity to a number of decimoles per liter.

inDecimolesPerLiter: Molarity.Molarity -> Float
-}
inDecimolesPerLiter : Elm.Expression -> Elm.Expression
inDecimolesPerLiter inDecimolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "inDecimolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                          Type.float
                     )
             }
        )
        [ inDecimolesPerLiterArg ]


{-| Construct a molarity from a number of centimoles per liter.

centimolesPerLiter: Float -> Molarity.Molarity
-}
centimolesPerLiter : Float -> Elm.Expression
centimolesPerLiter centimolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "centimolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Molarity" ] "Molarity" [])
                     )
             }
        )
        [ Elm.float centimolesPerLiterArg ]


{-| Convert a molarity to a number of centimoles per liter.

inCentimolesPerLiter: Molarity.Molarity -> Float
-}
inCentimolesPerLiter : Elm.Expression -> Elm.Expression
inCentimolesPerLiter inCentimolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "inCentimolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                          Type.float
                     )
             }
        )
        [ inCentimolesPerLiterArg ]


{-| Construct a molarity from a number of millimoles per liter.

millimolesPerLiter: Float -> Molarity.Molarity
-}
millimolesPerLiter : Float -> Elm.Expression
millimolesPerLiter millimolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "millimolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Molarity" ] "Molarity" [])
                     )
             }
        )
        [ Elm.float millimolesPerLiterArg ]


{-| Convert a molarity to a number of millimoles per liter.

inMillimolesPerLiter: Molarity.Molarity -> Float
-}
inMillimolesPerLiter : Elm.Expression -> Elm.Expression
inMillimolesPerLiter inMillimolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "inMillimolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                          Type.float
                     )
             }
        )
        [ inMillimolesPerLiterArg ]


{-| Construct a molarity from a number of micromoles per liter.

micromolesPerLiter: Float -> Molarity.Molarity
-}
micromolesPerLiter : Float -> Elm.Expression
micromolesPerLiter micromolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "micromolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Molarity" ] "Molarity" [])
                     )
             }
        )
        [ Elm.float micromolesPerLiterArg ]


{-| Convert a molarity to a number of micromoles per liter.

inMicromolesPerLiter: Molarity.Molarity -> Float
-}
inMicromolesPerLiter : Elm.Expression -> Elm.Expression
inMicromolesPerLiter inMicromolesPerLiterArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Molarity" ]
             , name = "inMicromolesPerLiter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                          Type.float
                     )
             }
        )
        [ inMicromolesPerLiterArg ]


annotation_ :
    { molarity : Type.Annotation, molesPerCubicMeter : Type.Annotation }
annotation_ =
    { molarity =
        Type.alias
            moduleName_
            "Molarity"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith [ "Molarity" ] "MolesPerCubicMeter" []
                 ]
            )
    , molesPerCubicMeter =
        Type.alias
            moduleName_
            "MolesPerCubicMeter"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "SubstanceAmount" ] "Moles" []
                 , Type.namedWith [ "Volume" ] "CubicMeters" []
                 ]
            )
    }


call_ :
    { molesPerCubicMeter : Elm.Expression -> Elm.Expression
    , inMolesPerCubicMeter : Elm.Expression -> Elm.Expression
    , molesPerLiter : Elm.Expression -> Elm.Expression
    , inMolesPerLiter : Elm.Expression -> Elm.Expression
    , decimolesPerLiter : Elm.Expression -> Elm.Expression
    , inDecimolesPerLiter : Elm.Expression -> Elm.Expression
    , centimolesPerLiter : Elm.Expression -> Elm.Expression
    , inCentimolesPerLiter : Elm.Expression -> Elm.Expression
    , millimolesPerLiter : Elm.Expression -> Elm.Expression
    , inMillimolesPerLiter : Elm.Expression -> Elm.Expression
    , micromolesPerLiter : Elm.Expression -> Elm.Expression
    , inMicromolesPerLiter : Elm.Expression -> Elm.Expression
    }
call_ =
    { molesPerCubicMeter =
        \molesPerCubicMeterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "molesPerCubicMeter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Molarity" ] "Molarity" [])
                             )
                     }
                )
                [ molesPerCubicMeterArg ]
    , inMolesPerCubicMeter =
        \inMolesPerCubicMeterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "inMolesPerCubicMeter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Molarity" ] "Molarity" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMolesPerCubicMeterArg ]
    , molesPerLiter =
        \molesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "molesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Molarity" ] "Molarity" [])
                             )
                     }
                )
                [ molesPerLiterArg ]
    , inMolesPerLiter =
        \inMolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "inMolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Molarity" ] "Molarity" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMolesPerLiterArg ]
    , decimolesPerLiter =
        \decimolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "decimolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Molarity" ] "Molarity" [])
                             )
                     }
                )
                [ decimolesPerLiterArg ]
    , inDecimolesPerLiter =
        \inDecimolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "inDecimolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Molarity" ] "Molarity" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inDecimolesPerLiterArg ]
    , centimolesPerLiter =
        \centimolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "centimolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Molarity" ] "Molarity" [])
                             )
                     }
                )
                [ centimolesPerLiterArg ]
    , inCentimolesPerLiter =
        \inCentimolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "inCentimolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Molarity" ] "Molarity" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inCentimolesPerLiterArg ]
    , millimolesPerLiter =
        \millimolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "millimolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Molarity" ] "Molarity" [])
                             )
                     }
                )
                [ millimolesPerLiterArg ]
    , inMillimolesPerLiter =
        \inMillimolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "inMillimolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Molarity" ] "Molarity" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMillimolesPerLiterArg ]
    , micromolesPerLiter =
        \micromolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "micromolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Molarity" ] "Molarity" [])
                             )
                     }
                )
                [ micromolesPerLiterArg ]
    , inMicromolesPerLiter =
        \inMicromolesPerLiterArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Molarity" ]
                     , name = "inMicromolesPerLiter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Molarity" ] "Molarity" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMicromolesPerLiterArg ]
    }


values_ :
    { molesPerCubicMeter : Elm.Expression
    , inMolesPerCubicMeter : Elm.Expression
    , molesPerLiter : Elm.Expression
    , inMolesPerLiter : Elm.Expression
    , decimolesPerLiter : Elm.Expression
    , inDecimolesPerLiter : Elm.Expression
    , centimolesPerLiter : Elm.Expression
    , inCentimolesPerLiter : Elm.Expression
    , millimolesPerLiter : Elm.Expression
    , inMillimolesPerLiter : Elm.Expression
    , micromolesPerLiter : Elm.Expression
    , inMicromolesPerLiter : Elm.Expression
    }
values_ =
    { molesPerCubicMeter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "molesPerCubicMeter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Molarity" ] "Molarity" [])
                    )
            }
    , inMolesPerCubicMeter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "inMolesPerCubicMeter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                         Type.float
                    )
            }
    , molesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "molesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Molarity" ] "Molarity" [])
                    )
            }
    , inMolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "inMolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                         Type.float
                    )
            }
    , decimolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "decimolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Molarity" ] "Molarity" [])
                    )
            }
    , inDecimolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "inDecimolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                         Type.float
                    )
            }
    , centimolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "centimolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Molarity" ] "Molarity" [])
                    )
            }
    , inCentimolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "inCentimolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                         Type.float
                    )
            }
    , millimolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "millimolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Molarity" ] "Molarity" [])
                    )
            }
    , inMillimolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "inMillimolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                         Type.float
                    )
            }
    , micromolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "micromolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Molarity" ] "Molarity" [])
                    )
            }
    , inMicromolesPerLiter =
        Elm.value
            { importFrom = [ "Molarity" ]
            , name = "inMicromolesPerLiter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Molarity" ] "Molarity" [] ]
                         Type.float
                    )
            }
    }