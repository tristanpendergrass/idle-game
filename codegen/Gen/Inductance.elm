module Gen.Inductance exposing (annotation_, call_, caseOf_, henries, inHenries, inKilohenries, inMicrohenries, inMillihenries, inNanohenries, kilohenries, make_, microhenries, millihenries, moduleName_, nanohenries, values_)

{-| 
@docs moduleName_, henries, inHenries, nanohenries, inNanohenries, microhenries, inMicrohenries, millihenries, inMillihenries, kilohenries, inKilohenries, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Inductance" ]


{-| Construct an inductance from a number of henries.

henries: Float -> Inductance.Inductance
-}
henries : Float -> Elm.Expression
henries henriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "henries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Inductance" ] "Inductance" [])
                     )
             }
        )
        [ Elm.float henriesArg ]


{-| Convert an inductance to a number of henries.

inHenries: Inductance.Inductance -> Float
-}
inHenries : Elm.Expression -> Elm.Expression
inHenries inHenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "inHenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                          Type.float
                     )
             }
        )
        [ inHenriesArg ]


{-| Construct an inductance from a number of nanohenries.

nanohenries: Float -> Inductance.Inductance
-}
nanohenries : Float -> Elm.Expression
nanohenries nanohenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "nanohenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Inductance" ] "Inductance" [])
                     )
             }
        )
        [ Elm.float nanohenriesArg ]


{-| Convert an inductance to a number of nanohenries.

inNanohenries: Inductance.Inductance -> Float
-}
inNanohenries : Elm.Expression -> Elm.Expression
inNanohenries inNanohenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "inNanohenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                          Type.float
                     )
             }
        )
        [ inNanohenriesArg ]


{-| Construct an inductance from a number of microhenries.

microhenries: Float -> Inductance.Inductance
-}
microhenries : Float -> Elm.Expression
microhenries microhenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "microhenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Inductance" ] "Inductance" [])
                     )
             }
        )
        [ Elm.float microhenriesArg ]


{-| Convert an inductance to a number of microhenries.

inMicrohenries: Inductance.Inductance -> Float
-}
inMicrohenries : Elm.Expression -> Elm.Expression
inMicrohenries inMicrohenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "inMicrohenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                          Type.float
                     )
             }
        )
        [ inMicrohenriesArg ]


{-| Construct an inductance from a number of millihenries.

millihenries: Float -> Inductance.Inductance
-}
millihenries : Float -> Elm.Expression
millihenries millihenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "millihenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Inductance" ] "Inductance" [])
                     )
             }
        )
        [ Elm.float millihenriesArg ]


{-| Convert an inductance to a number of millihenries.

inMillihenries: Inductance.Inductance -> Float
-}
inMillihenries : Elm.Expression -> Elm.Expression
inMillihenries inMillihenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "inMillihenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                          Type.float
                     )
             }
        )
        [ inMillihenriesArg ]


{-| Construct an inductance from a number of kilohenries.

kilohenries: Float -> Inductance.Inductance
-}
kilohenries : Float -> Elm.Expression
kilohenries kilohenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "kilohenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Inductance" ] "Inductance" [])
                     )
             }
        )
        [ Elm.float kilohenriesArg ]


{-| Convert an inductance to a number of kilohenries.

inKilohenries: Inductance.Inductance -> Float
-}
inKilohenries : Elm.Expression -> Elm.Expression
inKilohenries inKilohenriesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Inductance" ]
             , name = "inKilohenries"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                          Type.float
                     )
             }
        )
        [ inKilohenriesArg ]


annotation_ : { inductance : Type.Annotation, henries : Type.Annotation }
annotation_ =
    { inductance =
        Type.alias
            moduleName_
            "Inductance"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Inductance" ] "Henries" [] ]
            )
    , henries = Type.namedWith [ "Inductance" ] "Henries" []
    }


make_ : { rate : Elm.Expression -> Elm.Expression -> Elm.Expression }
make_ =
    { rate =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "Rate"
                     , annotation = Just (Type.namedWith [] "Henries" [])
                     }
                )
                [ ar0, ar1 ]
    }


caseOf_ :
    { henries :
        Elm.Expression
        -> { henriesTags_0_0
            | rate : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { henries =
        \henriesExpression henriesTags ->
            Elm.Case.custom
                henriesExpression
                (Type.namedWith [ "Inductance" ] "Henries" [])
                [ Elm.Case.branch2
                    "Rate"
                    ( "voltageVolts", Type.namedWith [ "Voltage" ] "Volts" [] )
                    ( "quantityRate"
                    , Type.namedWith
                          [ "Quantity" ]
                          "Rate"
                          [ Type.namedWith [ "Current" ] "Amperes" []
                          , Type.namedWith [ "Duration" ] "Seconds" []
                          ]
                    )
                    henriesTags.rate
                ]
    }


call_ :
    { henries : Elm.Expression -> Elm.Expression
    , inHenries : Elm.Expression -> Elm.Expression
    , nanohenries : Elm.Expression -> Elm.Expression
    , inNanohenries : Elm.Expression -> Elm.Expression
    , microhenries : Elm.Expression -> Elm.Expression
    , inMicrohenries : Elm.Expression -> Elm.Expression
    , millihenries : Elm.Expression -> Elm.Expression
    , inMillihenries : Elm.Expression -> Elm.Expression
    , kilohenries : Elm.Expression -> Elm.Expression
    , inKilohenries : Elm.Expression -> Elm.Expression
    }
call_ =
    { henries =
        \henriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "henries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Inductance" ]
                                       "Inductance"
                                       []
                                  )
                             )
                     }
                )
                [ henriesArg ]
    , inHenries =
        \inHenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "inHenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Inductance" ]
                                      "Inductance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inHenriesArg ]
    , nanohenries =
        \nanohenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "nanohenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Inductance" ]
                                       "Inductance"
                                       []
                                  )
                             )
                     }
                )
                [ nanohenriesArg ]
    , inNanohenries =
        \inNanohenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "inNanohenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Inductance" ]
                                      "Inductance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inNanohenriesArg ]
    , microhenries =
        \microhenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "microhenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Inductance" ]
                                       "Inductance"
                                       []
                                  )
                             )
                     }
                )
                [ microhenriesArg ]
    , inMicrohenries =
        \inMicrohenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "inMicrohenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Inductance" ]
                                      "Inductance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMicrohenriesArg ]
    , millihenries =
        \millihenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "millihenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Inductance" ]
                                       "Inductance"
                                       []
                                  )
                             )
                     }
                )
                [ millihenriesArg ]
    , inMillihenries =
        \inMillihenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "inMillihenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Inductance" ]
                                      "Inductance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMillihenriesArg ]
    , kilohenries =
        \kilohenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "kilohenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Inductance" ]
                                       "Inductance"
                                       []
                                  )
                             )
                     }
                )
                [ kilohenriesArg ]
    , inKilohenries =
        \inKilohenriesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Inductance" ]
                     , name = "inKilohenries"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Inductance" ]
                                      "Inductance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inKilohenriesArg ]
    }


values_ :
    { henries : Elm.Expression
    , inHenries : Elm.Expression
    , nanohenries : Elm.Expression
    , inNanohenries : Elm.Expression
    , microhenries : Elm.Expression
    , inMicrohenries : Elm.Expression
    , millihenries : Elm.Expression
    , inMillihenries : Elm.Expression
    , kilohenries : Elm.Expression
    , inKilohenries : Elm.Expression
    }
values_ =
    { henries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "henries"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Inductance" ] "Inductance" [])
                    )
            }
    , inHenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "inHenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                         Type.float
                    )
            }
    , nanohenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "nanohenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Inductance" ] "Inductance" [])
                    )
            }
    , inNanohenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "inNanohenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                         Type.float
                    )
            }
    , microhenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "microhenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Inductance" ] "Inductance" [])
                    )
            }
    , inMicrohenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "inMicrohenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                         Type.float
                    )
            }
    , millihenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "millihenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Inductance" ] "Inductance" [])
                    )
            }
    , inMillihenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "inMillihenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                         Type.float
                    )
            }
    , kilohenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "kilohenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Inductance" ] "Inductance" [])
                    )
            }
    , inKilohenries =
        Elm.value
            { importFrom = [ "Inductance" ]
            , name = "inKilohenries"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Inductance" ] "Inductance" [] ]
                         Type.float
                    )
            }
    }