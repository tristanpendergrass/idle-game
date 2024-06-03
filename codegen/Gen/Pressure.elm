module Gen.Pressure exposing (annotation_, atmospheres, call_, inAtmospheres, inKilopascals, inMegapascals, inPascals, inPoundsPerSquareInch, kilopascals, megapascals, moduleName_, pascals, poundsPerSquareInch, values_)

{-| 
@docs moduleName_, pascals, inPascals, kilopascals, inKilopascals, megapascals, inMegapascals, poundsPerSquareInch, inPoundsPerSquareInch, atmospheres, inAtmospheres, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pressure" ]


{-| Construct a pressure from a number of pascals.

pascals: Float -> Pressure.Pressure
-}
pascals : Float -> Elm.Expression
pascals pascalsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "pascals"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Pressure" ] "Pressure" [])
                     )
             }
        )
        [ Elm.float pascalsArg ]


{-| Convert a pressure to a number of pascals.

inPascals: Pressure.Pressure -> Float
-}
inPascals : Elm.Expression -> Elm.Expression
inPascals inPascalsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "inPascals"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                          Type.float
                     )
             }
        )
        [ inPascalsArg ]


{-| Construct a pressure from a number of kilopascals.

kilopascals: Float -> Pressure.Pressure
-}
kilopascals : Float -> Elm.Expression
kilopascals kilopascalsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "kilopascals"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Pressure" ] "Pressure" [])
                     )
             }
        )
        [ Elm.float kilopascalsArg ]


{-| Convert a pressure to a number of kilopascals.

inKilopascals: Pressure.Pressure -> Float
-}
inKilopascals : Elm.Expression -> Elm.Expression
inKilopascals inKilopascalsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "inKilopascals"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                          Type.float
                     )
             }
        )
        [ inKilopascalsArg ]


{-| Construct a pressure from a number of megapascals.

megapascals: Float -> Pressure.Pressure
-}
megapascals : Float -> Elm.Expression
megapascals megapascalsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "megapascals"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Pressure" ] "Pressure" [])
                     )
             }
        )
        [ Elm.float megapascalsArg ]


{-| Convert a pressure to a number of megapascals.

inMegapascals: Pressure.Pressure -> Float
-}
inMegapascals : Elm.Expression -> Elm.Expression
inMegapascals inMegapascalsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "inMegapascals"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                          Type.float
                     )
             }
        )
        [ inMegapascalsArg ]


{-| Construct a pressure from a number of pounds per square inch.

poundsPerSquareInch: Float -> Pressure.Pressure
-}
poundsPerSquareInch : Float -> Elm.Expression
poundsPerSquareInch poundsPerSquareInchArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "poundsPerSquareInch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Pressure" ] "Pressure" [])
                     )
             }
        )
        [ Elm.float poundsPerSquareInchArg ]


{-| Convert a pressure to a number of pounds per square inch.

inPoundsPerSquareInch: Pressure.Pressure -> Float
-}
inPoundsPerSquareInch : Elm.Expression -> Elm.Expression
inPoundsPerSquareInch inPoundsPerSquareInchArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "inPoundsPerSquareInch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                          Type.float
                     )
             }
        )
        [ inPoundsPerSquareInchArg ]


{-| Construct a pressure from a number of [atmospheres][1].

[1]: https://en.wikipedia.org/wiki/Atmosphere_(unit)

atmospheres: Float -> Pressure.Pressure
-}
atmospheres : Float -> Elm.Expression
atmospheres atmospheresArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "atmospheres"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Pressure" ] "Pressure" [])
                     )
             }
        )
        [ Elm.float atmospheresArg ]


{-| Convert a pressure to a number of atmospheres.

inAtmospheres: Pressure.Pressure -> Float
-}
inAtmospheres : Elm.Expression -> Elm.Expression
inAtmospheres inAtmospheresArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pressure" ]
             , name = "inAtmospheres"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                          Type.float
                     )
             }
        )
        [ inAtmospheresArg ]


annotation_ : { pressure : Type.Annotation, pascals : Type.Annotation }
annotation_ =
    { pressure =
        Type.alias
            moduleName_
            "Pressure"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Pressure" ] "Pascals" [] ]
            )
    , pascals =
        Type.alias
            moduleName_
            "Pascals"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Rate"
                 [ Type.namedWith [ "Force" ] "Newtons" []
                 , Type.namedWith [ "Area" ] "SquareMeters" []
                 ]
            )
    }


call_ :
    { pascals : Elm.Expression -> Elm.Expression
    , inPascals : Elm.Expression -> Elm.Expression
    , kilopascals : Elm.Expression -> Elm.Expression
    , inKilopascals : Elm.Expression -> Elm.Expression
    , megapascals : Elm.Expression -> Elm.Expression
    , inMegapascals : Elm.Expression -> Elm.Expression
    , poundsPerSquareInch : Elm.Expression -> Elm.Expression
    , inPoundsPerSquareInch : Elm.Expression -> Elm.Expression
    , atmospheres : Elm.Expression -> Elm.Expression
    , inAtmospheres : Elm.Expression -> Elm.Expression
    }
call_ =
    { pascals =
        \pascalsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "pascals"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Pressure" ] "Pressure" [])
                             )
                     }
                )
                [ pascalsArg ]
    , inPascals =
        \inPascalsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "inPascals"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Pressure" ] "Pressure" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inPascalsArg ]
    , kilopascals =
        \kilopascalsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "kilopascals"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Pressure" ] "Pressure" [])
                             )
                     }
                )
                [ kilopascalsArg ]
    , inKilopascals =
        \inKilopascalsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "inKilopascals"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Pressure" ] "Pressure" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inKilopascalsArg ]
    , megapascals =
        \megapascalsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "megapascals"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Pressure" ] "Pressure" [])
                             )
                     }
                )
                [ megapascalsArg ]
    , inMegapascals =
        \inMegapascalsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "inMegapascals"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Pressure" ] "Pressure" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inMegapascalsArg ]
    , poundsPerSquareInch =
        \poundsPerSquareInchArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "poundsPerSquareInch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Pressure" ] "Pressure" [])
                             )
                     }
                )
                [ poundsPerSquareInchArg ]
    , inPoundsPerSquareInch =
        \inPoundsPerSquareInchArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "inPoundsPerSquareInch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Pressure" ] "Pressure" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inPoundsPerSquareInchArg ]
    , atmospheres =
        \atmospheresArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "atmospheres"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Pressure" ] "Pressure" [])
                             )
                     }
                )
                [ atmospheresArg ]
    , inAtmospheres =
        \inAtmospheresArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pressure" ]
                     , name = "inAtmospheres"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Pressure" ] "Pressure" []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ inAtmospheresArg ]
    }


values_ :
    { pascals : Elm.Expression
    , inPascals : Elm.Expression
    , kilopascals : Elm.Expression
    , inKilopascals : Elm.Expression
    , megapascals : Elm.Expression
    , inMegapascals : Elm.Expression
    , poundsPerSquareInch : Elm.Expression
    , inPoundsPerSquareInch : Elm.Expression
    , atmospheres : Elm.Expression
    , inAtmospheres : Elm.Expression
    }
values_ =
    { pascals =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "pascals"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Pressure" ] "Pressure" [])
                    )
            }
    , inPascals =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "inPascals"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                         Type.float
                    )
            }
    , kilopascals =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "kilopascals"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Pressure" ] "Pressure" [])
                    )
            }
    , inKilopascals =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "inKilopascals"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                         Type.float
                    )
            }
    , megapascals =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "megapascals"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Pressure" ] "Pressure" [])
                    )
            }
    , inMegapascals =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "inMegapascals"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                         Type.float
                    )
            }
    , poundsPerSquareInch =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "poundsPerSquareInch"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Pressure" ] "Pressure" [])
                    )
            }
    , inPoundsPerSquareInch =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "inPoundsPerSquareInch"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                         Type.float
                    )
            }
    , atmospheres =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "atmospheres"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Pressure" ] "Pressure" [])
                    )
            }
    , inAtmospheres =
        Elm.value
            { importFrom = [ "Pressure" ]
            , name = "inAtmospheres"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Pressure" ] "Pressure" [] ]
                         Type.float
                    )
            }
    }