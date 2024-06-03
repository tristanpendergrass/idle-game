module Gen.Energy exposing (annotation_, call_, inJoules, inKilojoules, inKilowattHours, inMegajoules, joules, kilojoules, kilowattHours, megajoules, moduleName_, values_)

{-| 
@docs moduleName_, joules, inJoules, kilojoules, inKilojoules, megajoules, inMegajoules, kilowattHours, inKilowattHours, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Energy" ]


{-| Construct an energy value from a number of joules.

joules: Float -> Energy.Energy
-}
joules : Float -> Elm.Expression
joules joulesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "joules"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Energy" ] "Energy" [])
                     )
             }
        )
        [ Elm.float joulesArg ]


{-| Convert an energy value to a number of joules.

inJoules: Energy.Energy -> Float
-}
inJoules : Elm.Expression -> Elm.Expression
inJoules inJoulesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "inJoules"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Energy" ] "Energy" [] ]
                          Type.float
                     )
             }
        )
        [ inJoulesArg ]


{-| Construct an energy value from a number of kilojoules.

kilojoules: Float -> Energy.Energy
-}
kilojoules : Float -> Elm.Expression
kilojoules kilojoulesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "kilojoules"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Energy" ] "Energy" [])
                     )
             }
        )
        [ Elm.float kilojoulesArg ]


{-| Convert an energy value to a number of kilojoules.

inKilojoules: Energy.Energy -> Float
-}
inKilojoules : Elm.Expression -> Elm.Expression
inKilojoules inKilojoulesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "inKilojoules"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Energy" ] "Energy" [] ]
                          Type.float
                     )
             }
        )
        [ inKilojoulesArg ]


{-| Construct an energy value from a number of megajoules.

megajoules: Float -> Energy.Energy
-}
megajoules : Float -> Elm.Expression
megajoules megajoulesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "megajoules"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Energy" ] "Energy" [])
                     )
             }
        )
        [ Elm.float megajoulesArg ]


{-| Convert an energy value to a number of megajoules.

inMegajoules: Energy.Energy -> Float
-}
inMegajoules : Elm.Expression -> Elm.Expression
inMegajoules inMegajoulesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "inMegajoules"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Energy" ] "Energy" [] ]
                          Type.float
                     )
             }
        )
        [ inMegajoulesArg ]


{-| Construct an energy value from a number of kilowatt hours.

    Energy.kilowattHours 1
    --> Energy.megajoules 3.6

kilowattHours: Float -> Energy.Energy
-}
kilowattHours : Float -> Elm.Expression
kilowattHours kilowattHoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "kilowattHours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Energy" ] "Energy" [])
                     )
             }
        )
        [ Elm.float kilowattHoursArg ]


{-| Convert an energy value to a number of kilowatt hours.

inKilowattHours: Energy.Energy -> Float
-}
inKilowattHours : Elm.Expression -> Elm.Expression
inKilowattHours inKilowattHoursArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Energy" ]
             , name = "inKilowattHours"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Energy" ] "Energy" [] ]
                          Type.float
                     )
             }
        )
        [ inKilowattHoursArg ]


annotation_ : { energy : Type.Annotation, joules : Type.Annotation }
annotation_ =
    { energy =
        Type.alias
            moduleName_
            "Energy"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Energy" ] "Joules" [] ]
            )
    , joules =
        Type.alias
            moduleName_
            "Joules"
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
    { joules : Elm.Expression -> Elm.Expression
    , inJoules : Elm.Expression -> Elm.Expression
    , kilojoules : Elm.Expression -> Elm.Expression
    , inKilojoules : Elm.Expression -> Elm.Expression
    , megajoules : Elm.Expression -> Elm.Expression
    , inMegajoules : Elm.Expression -> Elm.Expression
    , kilowattHours : Elm.Expression -> Elm.Expression
    , inKilowattHours : Elm.Expression -> Elm.Expression
    }
call_ =
    { joules =
        \joulesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "joules"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Energy" ] "Energy" [])
                             )
                     }
                )
                [ joulesArg ]
    , inJoules =
        \inJoulesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "inJoules"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Energy" ] "Energy" [] ]
                                  Type.float
                             )
                     }
                )
                [ inJoulesArg ]
    , kilojoules =
        \kilojoulesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "kilojoules"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Energy" ] "Energy" [])
                             )
                     }
                )
                [ kilojoulesArg ]
    , inKilojoules =
        \inKilojoulesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "inKilojoules"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Energy" ] "Energy" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilojoulesArg ]
    , megajoules =
        \megajoulesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "megajoules"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Energy" ] "Energy" [])
                             )
                     }
                )
                [ megajoulesArg ]
    , inMegajoules =
        \inMegajoulesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "inMegajoules"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Energy" ] "Energy" [] ]
                                  Type.float
                             )
                     }
                )
                [ inMegajoulesArg ]
    , kilowattHours =
        \kilowattHoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "kilowattHours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Energy" ] "Energy" [])
                             )
                     }
                )
                [ kilowattHoursArg ]
    , inKilowattHours =
        \inKilowattHoursArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Energy" ]
                     , name = "inKilowattHours"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Energy" ] "Energy" [] ]
                                  Type.float
                             )
                     }
                )
                [ inKilowattHoursArg ]
    }


values_ :
    { joules : Elm.Expression
    , inJoules : Elm.Expression
    , kilojoules : Elm.Expression
    , inKilojoules : Elm.Expression
    , megajoules : Elm.Expression
    , inMegajoules : Elm.Expression
    , kilowattHours : Elm.Expression
    , inKilowattHours : Elm.Expression
    }
values_ =
    { joules =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "joules"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Energy" ] "Energy" [])
                    )
            }
    , inJoules =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "inJoules"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Energy" ] "Energy" [] ]
                         Type.float
                    )
            }
    , kilojoules =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "kilojoules"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Energy" ] "Energy" [])
                    )
            }
    , inKilojoules =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "inKilojoules"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Energy" ] "Energy" [] ]
                         Type.float
                    )
            }
    , megajoules =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "megajoules"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Energy" ] "Energy" [])
                    )
            }
    , inMegajoules =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "inMegajoules"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Energy" ] "Energy" [] ]
                         Type.float
                    )
            }
    , kilowattHours =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "kilowattHours"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Energy" ] "Energy" [])
                    )
            }
    , inKilowattHours =
        Elm.value
            { importFrom = [ "Energy" ]
            , name = "inKilowattHours"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Energy" ] "Energy" [] ]
                         Type.float
                    )
            }
    }