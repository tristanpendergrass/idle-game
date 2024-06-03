module Gen.Area exposing (acre, acres, annotation_, call_, hectare, hectares, inAcres, inHectares, inSquareCentimeters, inSquareFeet, inSquareInches, inSquareKilometers, inSquareMeters, inSquareMiles, inSquareMillimeters, inSquareYards, moduleName_, squareCentimeter, squareCentimeters, squareFeet, squareFoot, squareInch, squareInches, squareKilometer, squareKilometers, squareMeter, squareMeters, squareMile, squareMiles, squareMillimeter, squareMillimeters, squareYard, squareYards, values_)

{-| 
@docs moduleName_, squareMeters, inSquareMeters, squareMillimeters, inSquareMillimeters, squareCentimeters, inSquareCentimeters, hectares, inHectares, squareKilometers, inSquareKilometers, squareInches, inSquareInches, squareFeet, inSquareFeet, squareYards, inSquareYards, acres, inAcres, squareMiles, inSquareMiles, squareMeter, squareMillimeter, squareCentimeter, hectare, squareKilometer, squareInch, squareFoot, squareYard, acre, squareMile, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Area" ]


{-| Construct an area from a number of square meters.

squareMeters: Float -> Area.Area
-}
squareMeters : Float -> Elm.Expression
squareMeters squareMetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareMeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareMetersArg ]


{-| Convert an area to a number of square meters.

inSquareMeters: Area.Area -> Float
-}
inSquareMeters : Elm.Expression -> Elm.Expression
inSquareMeters inSquareMetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareMeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareMetersArg ]


{-| Construct an area from a number of square millimeters.

squareMillimeters: Float -> Area.Area
-}
squareMillimeters : Float -> Elm.Expression
squareMillimeters squareMillimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareMillimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareMillimetersArg ]


{-| Convert an area to a number of square millimeters.

inSquareMillimeters: Area.Area -> Float
-}
inSquareMillimeters : Elm.Expression -> Elm.Expression
inSquareMillimeters inSquareMillimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareMillimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareMillimetersArg ]


{-| Construct an area from a number of square centimeters.

squareCentimeters: Float -> Area.Area
-}
squareCentimeters : Float -> Elm.Expression
squareCentimeters squareCentimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareCentimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareCentimetersArg ]


{-| Convert an area to a number of square centimeters.

inSquareCentimeters: Area.Area -> Float
-}
inSquareCentimeters : Elm.Expression -> Elm.Expression
inSquareCentimeters inSquareCentimetersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareCentimeters"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareCentimetersArg ]


{-| Construct an area from a number of hectares.

hectares: Float -> Area.Area
-}
hectares : Float -> Elm.Expression
hectares hectaresArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "hectares"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float hectaresArg ]


{-| Convert an area to a number of hectares.

inHectares: Area.Area -> Float
-}
inHectares : Elm.Expression -> Elm.Expression
inHectares inHectaresArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inHectares"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inHectaresArg ]


{-| Construct an area from a number of square kilometers.

squareKilometers: Float -> Area.Area
-}
squareKilometers : Float -> Elm.Expression
squareKilometers squareKilometersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareKilometers"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareKilometersArg ]


{-| Convert an area to a number of square kilometers.

inSquareKilometers: Area.Area -> Float
-}
inSquareKilometers : Elm.Expression -> Elm.Expression
inSquareKilometers inSquareKilometersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareKilometers"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareKilometersArg ]


{-| Construct an area from a number of square inches.

squareInches: Float -> Area.Area
-}
squareInches : Float -> Elm.Expression
squareInches squareInchesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareInches"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareInchesArg ]


{-| Convert an area to a number of square inches.

inSquareInches: Area.Area -> Float
-}
inSquareInches : Elm.Expression -> Elm.Expression
inSquareInches inSquareInchesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareInches"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareInchesArg ]


{-| Construct an area from a number of square feet.

squareFeet: Float -> Area.Area
-}
squareFeet : Float -> Elm.Expression
squareFeet squareFeetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareFeet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareFeetArg ]


{-| Convert an area to a number of square feet.

inSquareFeet: Area.Area -> Float
-}
inSquareFeet : Elm.Expression -> Elm.Expression
inSquareFeet inSquareFeetArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareFeet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareFeetArg ]


{-| Construct an area from a number of square yards.

squareYards: Float -> Area.Area
-}
squareYards : Float -> Elm.Expression
squareYards squareYardsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareYards"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareYardsArg ]


{-| Convert an area to a number of square yards.

inSquareYards: Area.Area -> Float
-}
inSquareYards : Elm.Expression -> Elm.Expression
inSquareYards inSquareYardsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareYards"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareYardsArg ]


{-| Construct an area from a number of acres.

acres: Float -> Area.Area
-}
acres : Float -> Elm.Expression
acres acresArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "acres"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float acresArg ]


{-| Convert an area to a number of acres.

inAcres: Area.Area -> Float
-}
inAcres : Elm.Expression -> Elm.Expression
inAcres inAcresArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inAcres"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inAcresArg ]


{-| Construct an area from a number of square miles.

squareMiles: Float -> Area.Area
-}
squareMiles : Float -> Elm.Expression
squareMiles squareMilesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "squareMiles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Area" ] "Area" [])
                     )
             }
        )
        [ Elm.float squareMilesArg ]


{-| Convert an area to a number of square miles.

inSquareMiles: Area.Area -> Float
-}
inSquareMiles : Elm.Expression -> Elm.Expression
inSquareMiles inSquareMilesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Area" ]
             , name = "inSquareMiles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Area" ] "Area" [] ]
                          Type.float
                     )
             }
        )
        [ inSquareMilesArg ]


{-| squareMeter: Area.Area -}
squareMeter : Elm.Expression
squareMeter =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareMeter"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| squareMillimeter: Area.Area -}
squareMillimeter : Elm.Expression
squareMillimeter =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareMillimeter"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| squareCentimeter: Area.Area -}
squareCentimeter : Elm.Expression
squareCentimeter =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareCentimeter"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| hectare: Area.Area -}
hectare : Elm.Expression
hectare =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "hectare"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| squareKilometer: Area.Area -}
squareKilometer : Elm.Expression
squareKilometer =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareKilometer"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| squareInch: Area.Area -}
squareInch : Elm.Expression
squareInch =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareInch"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| squareFoot: Area.Area -}
squareFoot : Elm.Expression
squareFoot =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareFoot"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| squareYard: Area.Area -}
squareYard : Elm.Expression
squareYard =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareYard"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| acre: Area.Area -}
acre : Elm.Expression
acre =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "acre"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


{-| squareMile: Area.Area -}
squareMile : Elm.Expression
squareMile =
    Elm.value
        { importFrom = [ "Area" ]
        , name = "squareMile"
        , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
        }


annotation_ : { area : Type.Annotation, squareMeters : Type.Annotation }
annotation_ =
    { area =
        Type.alias
            moduleName_
            "Area"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Area" ] "SquareMeters" [] ]
            )
    , squareMeters =
        Type.alias
            moduleName_
            "SquareMeters"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Squared"
                 [ Type.namedWith [ "Length" ] "Meters" [] ]
            )
    }


call_ :
    { squareMeters : Elm.Expression -> Elm.Expression
    , inSquareMeters : Elm.Expression -> Elm.Expression
    , squareMillimeters : Elm.Expression -> Elm.Expression
    , inSquareMillimeters : Elm.Expression -> Elm.Expression
    , squareCentimeters : Elm.Expression -> Elm.Expression
    , inSquareCentimeters : Elm.Expression -> Elm.Expression
    , hectares : Elm.Expression -> Elm.Expression
    , inHectares : Elm.Expression -> Elm.Expression
    , squareKilometers : Elm.Expression -> Elm.Expression
    , inSquareKilometers : Elm.Expression -> Elm.Expression
    , squareInches : Elm.Expression -> Elm.Expression
    , inSquareInches : Elm.Expression -> Elm.Expression
    , squareFeet : Elm.Expression -> Elm.Expression
    , inSquareFeet : Elm.Expression -> Elm.Expression
    , squareYards : Elm.Expression -> Elm.Expression
    , inSquareYards : Elm.Expression -> Elm.Expression
    , acres : Elm.Expression -> Elm.Expression
    , inAcres : Elm.Expression -> Elm.Expression
    , squareMiles : Elm.Expression -> Elm.Expression
    , inSquareMiles : Elm.Expression -> Elm.Expression
    }
call_ =
    { squareMeters =
        \squareMetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareMeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareMetersArg ]
    , inSquareMeters =
        \inSquareMetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareMeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareMetersArg ]
    , squareMillimeters =
        \squareMillimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareMillimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareMillimetersArg ]
    , inSquareMillimeters =
        \inSquareMillimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareMillimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareMillimetersArg ]
    , squareCentimeters =
        \squareCentimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareCentimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareCentimetersArg ]
    , inSquareCentimeters =
        \inSquareCentimetersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareCentimeters"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareCentimetersArg ]
    , hectares =
        \hectaresArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "hectares"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ hectaresArg ]
    , inHectares =
        \inHectaresArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inHectares"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inHectaresArg ]
    , squareKilometers =
        \squareKilometersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareKilometers"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareKilometersArg ]
    , inSquareKilometers =
        \inSquareKilometersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareKilometers"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareKilometersArg ]
    , squareInches =
        \squareInchesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareInches"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareInchesArg ]
    , inSquareInches =
        \inSquareInchesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareInches"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareInchesArg ]
    , squareFeet =
        \squareFeetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareFeet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareFeetArg ]
    , inSquareFeet =
        \inSquareFeetArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareFeet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareFeetArg ]
    , squareYards =
        \squareYardsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareYards"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareYardsArg ]
    , inSquareYards =
        \inSquareYardsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareYards"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareYardsArg ]
    , acres =
        \acresArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "acres"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ acresArg ]
    , inAcres =
        \inAcresArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inAcres"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inAcresArg ]
    , squareMiles =
        \squareMilesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "squareMiles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Area" ] "Area" [])
                             )
                     }
                )
                [ squareMilesArg ]
    , inSquareMiles =
        \inSquareMilesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Area" ]
                     , name = "inSquareMiles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Area" ] "Area" [] ]
                                  Type.float
                             )
                     }
                )
                [ inSquareMilesArg ]
    }


values_ :
    { squareMeters : Elm.Expression
    , inSquareMeters : Elm.Expression
    , squareMillimeters : Elm.Expression
    , inSquareMillimeters : Elm.Expression
    , squareCentimeters : Elm.Expression
    , inSquareCentimeters : Elm.Expression
    , hectares : Elm.Expression
    , inHectares : Elm.Expression
    , squareKilometers : Elm.Expression
    , inSquareKilometers : Elm.Expression
    , squareInches : Elm.Expression
    , inSquareInches : Elm.Expression
    , squareFeet : Elm.Expression
    , inSquareFeet : Elm.Expression
    , squareYards : Elm.Expression
    , inSquareYards : Elm.Expression
    , acres : Elm.Expression
    , inAcres : Elm.Expression
    , squareMiles : Elm.Expression
    , inSquareMiles : Elm.Expression
    , squareMeter : Elm.Expression
    , squareMillimeter : Elm.Expression
    , squareCentimeter : Elm.Expression
    , hectare : Elm.Expression
    , squareKilometer : Elm.Expression
    , squareInch : Elm.Expression
    , squareFoot : Elm.Expression
    , squareYard : Elm.Expression
    , acre : Elm.Expression
    , squareMile : Elm.Expression
    }
values_ =
    { squareMeters =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareMeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareMeters =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareMeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareMillimeters =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareMillimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareMillimeters =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareMillimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareCentimeters =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareCentimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareCentimeters =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareCentimeters"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , hectares =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "hectares"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inHectares =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inHectares"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareKilometers =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareKilometers"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareKilometers =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareKilometers"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareInches =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareInches"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareInches =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareInches"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareFeet =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareFeet"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareFeet =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareFeet"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareYards =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareYards"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareYards =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareYards"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , acres =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "acres"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inAcres =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inAcres"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareMiles =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareMiles"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Area" ] "Area" [])
                    )
            }
    , inSquareMiles =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "inSquareMiles"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Area" ] "Area" [] ]
                         Type.float
                    )
            }
    , squareMeter =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareMeter"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , squareMillimeter =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareMillimeter"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , squareCentimeter =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareCentimeter"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , hectare =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "hectare"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , squareKilometer =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareKilometer"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , squareInch =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareInch"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , squareFoot =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareFoot"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , squareYard =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareYard"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , acre =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "acre"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    , squareMile =
        Elm.value
            { importFrom = [ "Area" ]
            , name = "squareMile"
            , annotation = Just (Type.namedWith [ "Area" ] "Area" [])
            }
    }