module Gen.Force exposing (annotation_, call_, inKilonewtons, inKips, inMeganewtons, inNewtons, inPounds, kilonewtons, kips, meganewtons, moduleName_, newtons, pounds, values_)

{-| 
@docs moduleName_, newtons, inNewtons, kilonewtons, inKilonewtons, meganewtons, inMeganewtons, pounds, inPounds, kips, inKips, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Force" ]


{-| Construct a force value from a number of newtons.

newtons: Float -> Force.Force
-}
newtons : Float -> Elm.Expression
newtons newtonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "newtons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Force" ] "Force" [])
                     )
             }
        )
        [ Elm.float newtonsArg ]


{-| Convert a force value to a number of newtons.

inNewtons: Force.Force -> Float
-}
inNewtons : Elm.Expression -> Elm.Expression
inNewtons inNewtonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "inNewtons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Force" ] "Force" [] ]
                          Type.float
                     )
             }
        )
        [ inNewtonsArg ]


{-| Construct a force value from a number of kilonewtons.

kilonewtons: Float -> Force.Force
-}
kilonewtons : Float -> Elm.Expression
kilonewtons kilonewtonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "kilonewtons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Force" ] "Force" [])
                     )
             }
        )
        [ Elm.float kilonewtonsArg ]


{-| Convert a force value to a number of kilonewtons.

inKilonewtons: Force.Force -> Float
-}
inKilonewtons : Elm.Expression -> Elm.Expression
inKilonewtons inKilonewtonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "inKilonewtons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Force" ] "Force" [] ]
                          Type.float
                     )
             }
        )
        [ inKilonewtonsArg ]


{-| Construct a force value from a number of meganewtons.

meganewtons: Float -> Force.Force
-}
meganewtons : Float -> Elm.Expression
meganewtons meganewtonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "meganewtons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Force" ] "Force" [])
                     )
             }
        )
        [ Elm.float meganewtonsArg ]


{-| Convert a force value to a number of meganewtons.

inMeganewtons: Force.Force -> Float
-}
inMeganewtons : Elm.Expression -> Elm.Expression
inMeganewtons inMeganewtonsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "inMeganewtons"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Force" ] "Force" [] ]
                          Type.float
                     )
             }
        )
        [ inMeganewtonsArg ]


{-| Construct a force value from a number of pounds force. One pound force is
the force required to accelerate one [pound mass][1] at a rate of [one gee][2].

[1]: Mass#pounds
[2]: Acceleration#gees

pounds: Float -> Force.Force
-}
pounds : Float -> Elm.Expression
pounds poundsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "pounds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Force" ] "Force" [])
                     )
             }
        )
        [ Elm.float poundsArg ]


{-| Convert a force value to a number of pounds force.

inPounds: Force.Force -> Float
-}
inPounds : Elm.Expression -> Elm.Expression
inPounds inPoundsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "inPounds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Force" ] "Force" [] ]
                          Type.float
                     )
             }
        )
        [ inPoundsArg ]


{-| Construct a force value from a number of kips (kilopounds force).

    Force.kips 2
    --> Force.pounds 2000

kips: Float -> Force.Force
-}
kips : Float -> Elm.Expression
kips kipsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "kips"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Force" ] "Force" [])
                     )
             }
        )
        [ Elm.float kipsArg ]


{-| Convert a force value to a number of kips.

inKips: Force.Force -> Float
-}
inKips : Elm.Expression -> Elm.Expression
inKips inKipsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Force" ]
             , name = "inKips"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Force" ] "Force" [] ]
                          Type.float
                     )
             }
        )
        [ inKipsArg ]


annotation_ : { force : Type.Annotation, newtons : Type.Annotation }
annotation_ =
    { force =
        Type.alias
            moduleName_
            "Force"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Force" ] "Newtons" [] ]
            )
    , newtons =
        Type.alias
            moduleName_
            "Newtons"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Product"
                 [ Type.namedWith [ "Mass" ] "Kilograms" []
                 , Type.namedWith [ "Acceleration" ] "MetersPerSecondSquared" []
                 ]
            )
    }


call_ :
    { newtons : Elm.Expression -> Elm.Expression
    , inNewtons : Elm.Expression -> Elm.Expression
    , kilonewtons : Elm.Expression -> Elm.Expression
    , inKilonewtons : Elm.Expression -> Elm.Expression
    , meganewtons : Elm.Expression -> Elm.Expression
    , inMeganewtons : Elm.Expression -> Elm.Expression
    , pounds : Elm.Expression -> Elm.Expression
    , inPounds : Elm.Expression -> Elm.Expression
    , kips : Elm.Expression -> Elm.Expression
    , inKips : Elm.Expression -> Elm.Expression
    }
call_ =
    { newtons =
        \newtonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "newtons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Force" ] "Force" [])
                             )
                     }
                )
                [ newtonsArg ]
    , inNewtons =
        \inNewtonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "inNewtons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Force" ] "Force" [] ]
                                  Type.float
                             )
                     }
                )
                [ inNewtonsArg ]
    , kilonewtons =
        \kilonewtonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "kilonewtons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Force" ] "Force" [])
                             )
                     }
                )
                [ kilonewtonsArg ]
    , inKilonewtons =
        \inKilonewtonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "inKilonewtons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Force" ] "Force" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilonewtonsArg ]
    , meganewtons =
        \meganewtonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "meganewtons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Force" ] "Force" [])
                             )
                     }
                )
                [ meganewtonsArg ]
    , inMeganewtons =
        \inMeganewtonsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "inMeganewtons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Force" ] "Force" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMeganewtonsArg ]
    , pounds =
        \poundsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "pounds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Force" ] "Force" [])
                             )
                     }
                )
                [ poundsArg ]
    , inPounds =
        \inPoundsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "inPounds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Force" ] "Force" [] ]
                                  Type.float
                             )
                     }
                )
                [ inPoundsArg ]
    , kips =
        \kipsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "kips"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Force" ] "Force" [])
                             )
                     }
                )
                [ kipsArg ]
    , inKips =
        \inKipsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Force" ]
                     , name = "inKips"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Force" ] "Force" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKipsArg ]
    }


values_ :
    { newtons : Elm.Expression
    , inNewtons : Elm.Expression
    , kilonewtons : Elm.Expression
    , inKilonewtons : Elm.Expression
    , meganewtons : Elm.Expression
    , inMeganewtons : Elm.Expression
    , pounds : Elm.Expression
    , inPounds : Elm.Expression
    , kips : Elm.Expression
    , inKips : Elm.Expression
    }
values_ =
    { newtons =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "newtons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Force" ] "Force" [])
                    )
            }
    , inNewtons =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "inNewtons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Force" ] "Force" [] ]
                         Type.float
                    )
            }
    , kilonewtons =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "kilonewtons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Force" ] "Force" [])
                    )
            }
    , inKilonewtons =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "inKilonewtons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Force" ] "Force" [] ]
                         Type.float
                    )
            }
    , meganewtons =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "meganewtons"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Force" ] "Force" [])
                    )
            }
    , inMeganewtons =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "inMeganewtons"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Force" ] "Force" [] ]
                         Type.float
                    )
            }
    , pounds =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "pounds"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Force" ] "Force" [])
                    )
            }
    , inPounds =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "inPounds"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Force" ] "Force" [] ]
                         Type.float
                    )
            }
    , kips =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "kips"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Force" ] "Force" [])
                    )
            }
    , inKips =
        Elm.value
            { importFrom = [ "Force" ]
            , name = "inKips"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Force" ] "Force" [] ]
                         Type.float
                    )
            }
    }