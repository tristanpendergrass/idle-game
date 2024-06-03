module Gen.Current exposing (amperes, annotation_, call_, inAmperes, inMilliamperes, milliamperes, moduleName_, values_)

{-| 
@docs moduleName_, amperes, inAmperes, milliamperes, inMilliamperes, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Current" ]


{-| Construct a current from a number of amperes.

amperes: Float -> Current.Current
-}
amperes : Float -> Elm.Expression
amperes amperesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Current" ]
             , name = "amperes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Current" ] "Current" [])
                     )
             }
        )
        [ Elm.float amperesArg ]


{-| Convert a current to a number of amperes.

    Charge.coulombs 10
        |> Quantity.per (Duration.seconds 2)
        |> Current.inAmperes
    --> 5

inAmperes: Current.Current -> Float
-}
inAmperes : Elm.Expression -> Elm.Expression
inAmperes inAmperesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Current" ]
             , name = "inAmperes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Current" ] "Current" [] ]
                          Type.float
                     )
             }
        )
        [ inAmperesArg ]


{-| Construct a current from a number of milliamperes.

    Current.milliamperes 500
    --> Current.amperes 0.5

milliamperes: Float -> Current.Current
-}
milliamperes : Float -> Elm.Expression
milliamperes milliamperesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Current" ]
             , name = "milliamperes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Current" ] "Current" [])
                     )
             }
        )
        [ Elm.float milliamperesArg ]


{-| Convert a current to number of milliamperes.

    Current.amperes 2 |> Current.inMilliamperes
    --> 2000

inMilliamperes: Current.Current -> Float
-}
inMilliamperes : Elm.Expression -> Elm.Expression
inMilliamperes inMilliamperesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Current" ]
             , name = "inMilliamperes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Current" ] "Current" [] ]
                          Type.float
                     )
             }
        )
        [ inMilliamperesArg ]


annotation_ : { current : Type.Annotation, amperes : Type.Annotation }
annotation_ =
    { current =
        Type.alias
            moduleName_
            "Current"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Current" ] "Amperes" [] ]
            )
    , amperes =
        Type.alias
            moduleName_
            "Amperes"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Charge" ] "Coulombs" []
                 , Type.namedWith [ "Duration" ] "Seconds" []
                 ]
            )
    }


call_ :
    { amperes : Elm.Expression -> Elm.Expression
    , inAmperes : Elm.Expression -> Elm.Expression
    , milliamperes : Elm.Expression -> Elm.Expression
    , inMilliamperes : Elm.Expression -> Elm.Expression
    }
call_ =
    { amperes =
        \amperesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Current" ]
                     , name = "amperes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Current" ] "Current" [])
                             )
                     }
                )
                [ amperesArg ]
    , inAmperes =
        \inAmperesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Current" ]
                     , name = "inAmperes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Current" ] "Current" [] ]
                                  Type.float
                             )
                     }
                )
                [ inAmperesArg ]
    , milliamperes =
        \milliamperesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Current" ]
                     , name = "milliamperes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Current" ] "Current" [])
                             )
                     }
                )
                [ milliamperesArg ]
    , inMilliamperes =
        \inMilliamperesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Current" ]
                     , name = "inMilliamperes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Current" ] "Current" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMilliamperesArg ]
    }


values_ :
    { amperes : Elm.Expression
    , inAmperes : Elm.Expression
    , milliamperes : Elm.Expression
    , inMilliamperes : Elm.Expression
    }
values_ =
    { amperes =
        Elm.value
            { importFrom = [ "Current" ]
            , name = "amperes"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Current" ] "Current" [])
                    )
            }
    , inAmperes =
        Elm.value
            { importFrom = [ "Current" ]
            , name = "inAmperes"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Current" ] "Current" [] ]
                         Type.float
                    )
            }
    , milliamperes =
        Elm.value
            { importFrom = [ "Current" ]
            , name = "milliamperes"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Current" ] "Current" [])
                    )
            }
    , inMilliamperes =
        Elm.value
            { importFrom = [ "Current" ]
            , name = "inMilliamperes"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Current" ] "Current" [] ]
                         Type.float
                    )
            }
    }