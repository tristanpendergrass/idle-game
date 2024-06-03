module Gen.Torque exposing (annotation_, call_, inNewtonMeters, inPoundFeet, moduleName_, newtonMeters, poundFeet, values_)

{-| 
@docs moduleName_, newtonMeters, inNewtonMeters, poundFeet, inPoundFeet, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Torque" ]


{-| Construct a torque value from a number of newton-meters.

newtonMeters: Float -> Torque.Torque
-}
newtonMeters : Float -> Elm.Expression
newtonMeters newtonMetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Torque" ]
             , name = "newtonMeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Torque" ] "Torque" [])
                     )
             }
        )
        [ Elm.float newtonMetersArg ]


{-| Convert a torque value to a number of newton-meters.

inNewtonMeters: Torque.Torque -> Float
-}
inNewtonMeters : Elm.Expression -> Elm.Expression
inNewtonMeters inNewtonMetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Torque" ]
             , name = "inNewtonMeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Torque" ] "Torque" [] ]
                          Type.float
                     )
             }
        )
        [ inNewtonMetersArg ]


{-| Construct a torque value from a number of pound-feet (sometimes called foot-pounds).

poundFeet: Float -> Torque.Torque
-}
poundFeet : Float -> Elm.Expression
poundFeet poundFeetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Torque" ]
             , name = "poundFeet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Torque" ] "Torque" [])
                     )
             }
        )
        [ Elm.float poundFeetArg ]


{-| Convert a torque value to a number of pound-feet (sometimes called foot-pounds).

inPoundFeet: Torque.Torque -> Float
-}
inPoundFeet : Elm.Expression -> Elm.Expression
inPoundFeet inPoundFeetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Torque" ]
             , name = "inPoundFeet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Torque" ] "Torque" [] ]
                          Type.float
                     )
             }
        )
        [ inPoundFeetArg ]


annotation_ : { torque : Type.Annotation, newtonMeters : Type.Annotation }
annotation_ =
    { torque =
        Type.alias
            moduleName_
            "Torque"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Torque" ] "NewtonMeters" [] ]
            )
    , newtonMeters =
        Type.alias
            moduleName_
            "NewtonMeters"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Product"
                 [ Type.namedWith [ "Force" ] "Newtons" []
                 , Type.namedWith [ "Length" ] "Meters" []
                 ]
            )
    }


call_ :
    { newtonMeters : Elm.Expression -> Elm.Expression
    , inNewtonMeters : Elm.Expression -> Elm.Expression
    , poundFeet : Elm.Expression -> Elm.Expression
    , inPoundFeet : Elm.Expression -> Elm.Expression
    }
call_ =
    { newtonMeters =
        \newtonMetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Torque" ]
                     , name = "newtonMeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Torque" ] "Torque" [])
                             )
                     }
                )
                [ newtonMetersArg ]
    , inNewtonMeters =
        \inNewtonMetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Torque" ]
                     , name = "inNewtonMeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Torque" ] "Torque" [] ]
                                  Type.float
                             )
                     }
                )
                [ inNewtonMetersArg ]
    , poundFeet =
        \poundFeetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Torque" ]
                     , name = "poundFeet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Torque" ] "Torque" [])
                             )
                     }
                )
                [ poundFeetArg ]
    , inPoundFeet =
        \inPoundFeetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Torque" ]
                     , name = "inPoundFeet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Torque" ] "Torque" [] ]
                                  Type.float
                             )
                     }
                )
                [ inPoundFeetArg ]
    }


values_ :
    { newtonMeters : Elm.Expression
    , inNewtonMeters : Elm.Expression
    , poundFeet : Elm.Expression
    , inPoundFeet : Elm.Expression
    }
values_ =
    { newtonMeters =
        Elm.value
            { importFrom = [ "Torque" ]
            , name = "newtonMeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Torque" ] "Torque" [])
                    )
            }
    , inNewtonMeters =
        Elm.value
            { importFrom = [ "Torque" ]
            , name = "inNewtonMeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Torque" ] "Torque" [] ]
                         Type.float
                    )
            }
    , poundFeet =
        Elm.value
            { importFrom = [ "Torque" ]
            , name = "poundFeet"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Torque" ] "Torque" [])
                    )
            }
    , inPoundFeet =
        Elm.value
            { importFrom = [ "Torque" ]
            , name = "inPoundFeet"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Torque" ] "Torque" [] ]
                         Type.float
                    )
            }
    }