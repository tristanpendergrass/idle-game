module Gen.Capacitance exposing (annotation_, call_, farads, inFarads, inMicrofarads, inNanofarads, inPicofarads, microfarads, moduleName_, nanofarads, picofarads, values_)

{-| 
@docs moduleName_, farads, inFarads, picofarads, inPicofarads, nanofarads, inNanofarads, microfarads, inMicrofarads, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Capacitance" ]


{-| Construct capacitance from a number of farads.

farads: Float -> Capacitance.Capacitance
-}
farads : Float -> Elm.Expression
farads faradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "farads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                     )
             }
        )
        [ Elm.float faradsArg ]


{-| Convert capacitance to a number of farads.

inFarads: Capacitance.Capacitance -> Float
-}
inFarads : Elm.Expression -> Elm.Expression
inFarads inFaradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "inFarads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                          Type.float
                     )
             }
        )
        [ inFaradsArg ]


{-| Construct capacitance from a number of picofarads.

picofarads: Float -> Capacitance.Capacitance
-}
picofarads : Float -> Elm.Expression
picofarads picofaradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "picofarads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                     )
             }
        )
        [ Elm.float picofaradsArg ]


{-| Convert a capacitance to a number of picofarads.

inPicofarads: Capacitance.Capacitance -> Float
-}
inPicofarads : Elm.Expression -> Elm.Expression
inPicofarads inPicofaradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "inPicofarads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                          Type.float
                     )
             }
        )
        [ inPicofaradsArg ]


{-| Construct a capacitance from a number of nanofarads

nanofarads: Float -> Capacitance.Capacitance
-}
nanofarads : Float -> Elm.Expression
nanofarads nanofaradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "nanofarads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                     )
             }
        )
        [ Elm.float nanofaradsArg ]


{-| Convert a capacitance to a number of nanofarads

inNanofarads: Capacitance.Capacitance -> Float
-}
inNanofarads : Elm.Expression -> Elm.Expression
inNanofarads inNanofaradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "inNanofarads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                          Type.float
                     )
             }
        )
        [ inNanofaradsArg ]


{-| Construct a capacitance from a number of microfarads.

microfarads: Float -> Capacitance.Capacitance
-}
microfarads : Float -> Elm.Expression
microfarads microfaradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "microfarads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                     )
             }
        )
        [ Elm.float microfaradsArg ]


{-| Convert a capacitance to a number of microfarads

inMicrofarads: Capacitance.Capacitance -> Float
-}
inMicrofarads : Elm.Expression -> Elm.Expression
inMicrofarads inMicrofaradsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Capacitance" ]
             , name = "inMicrofarads"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                          Type.float
                     )
             }
        )
        [ inMicrofaradsArg ]


annotation_ : { capacitance : Type.Annotation, farads : Type.Annotation }
annotation_ =
    { capacitance =
        Type.alias
            moduleName_
            "Capacitance"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Capacitance" ] "Farads" [] ]
            )
    , farads = Type.namedWith [ "Capacitance" ] "Farads" []
    }


call_ :
    { farads : Elm.Expression -> Elm.Expression
    , inFarads : Elm.Expression -> Elm.Expression
    , picofarads : Elm.Expression -> Elm.Expression
    , inPicofarads : Elm.Expression -> Elm.Expression
    , nanofarads : Elm.Expression -> Elm.Expression
    , inNanofarads : Elm.Expression -> Elm.Expression
    , microfarads : Elm.Expression -> Elm.Expression
    , inMicrofarads : Elm.Expression -> Elm.Expression
    }
call_ =
    { farads =
        \faradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "farads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Capacitance" ]
                                       "Capacitance"
                                       []
                                  )
                             )
                     }
                )
                [ faradsArg ]
    , inFarads =
        \inFaradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "inFarads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Capacitance" ]
                                      "Capacitance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inFaradsArg ]
    , picofarads =
        \picofaradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "picofarads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Capacitance" ]
                                       "Capacitance"
                                       []
                                  )
                             )
                     }
                )
                [ picofaradsArg ]
    , inPicofarads =
        \inPicofaradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "inPicofarads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Capacitance" ]
                                      "Capacitance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inPicofaradsArg ]
    , nanofarads =
        \nanofaradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "nanofarads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Capacitance" ]
                                       "Capacitance"
                                       []
                                  )
                             )
                     }
                )
                [ nanofaradsArg ]
    , inNanofarads =
        \inNanofaradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "inNanofarads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Capacitance" ]
                                      "Capacitance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inNanofaradsArg ]
    , microfarads =
        \microfaradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "microfarads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith
                                       [ "Capacitance" ]
                                       "Capacitance"
                                       []
                                  )
                             )
                     }
                )
                [ microfaradsArg ]
    , inMicrofarads =
        \inMicrofaradsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Capacitance" ]
                     , name = "inMicrofarads"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Capacitance" ]
                                      "Capacitance"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMicrofaradsArg ]
    }


values_ :
    { farads : Elm.Expression
    , inFarads : Elm.Expression
    , picofarads : Elm.Expression
    , inPicofarads : Elm.Expression
    , nanofarads : Elm.Expression
    , inNanofarads : Elm.Expression
    , microfarads : Elm.Expression
    , inMicrofarads : Elm.Expression
    }
values_ =
    { farads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "farads"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                    )
            }
    , inFarads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "inFarads"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                         Type.float
                    )
            }
    , picofarads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "picofarads"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                    )
            }
    , inPicofarads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "inPicofarads"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                         Type.float
                    )
            }
    , nanofarads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "nanofarads"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                    )
            }
    , inNanofarads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "inNanofarads"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                         Type.float
                    )
            }
    , microfarads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "microfarads"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Capacitance" ] "Capacitance" [])
                    )
            }
    , inMicrofarads =
        Elm.value
            { importFrom = [ "Capacitance" ]
            , name = "inMicrofarads"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Capacitance" ] "Capacitance" [] ]
                         Type.float
                    )
            }
    }