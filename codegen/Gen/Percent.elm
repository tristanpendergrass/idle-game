module Gen.Percent exposing (annotation_, call_, capAtHundred, caseOf_, float, increaseByPercent, make_, moduleName_, toFloat, toMultiplier, toPercentage, values_, zero)

{-| 
@docs moduleName_, increaseByPercent, capAtHundred, toMultiplier, toPercentage, toFloat, zero, float, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Percent" ]


{-| increaseByPercent: Percent.Percent -> Float -> Float -}
increaseByPercent : Elm.Expression -> Float -> Elm.Expression
increaseByPercent increaseByPercentArg increaseByPercentArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Percent" ]
             , name = "increaseByPercent"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" []
                          , Type.float
                          ]
                          Type.float
                     )
             }
        )
        [ increaseByPercentArg, Elm.float increaseByPercentArg0 ]


{-| capAtHundred: Percent.Percent -> Percent.Percent -}
capAtHundred : Elm.Expression -> Elm.Expression
capAtHundred capAtHundredArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Percent" ]
             , name = "capAtHundred"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "Percent" ] "Percent" [])
                     )
             }
        )
        [ capAtHundredArg ]


{-| toMultiplier: Percent.Percent -> Float -}
toMultiplier : Elm.Expression -> Elm.Expression
toMultiplier toMultiplierArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Percent" ]
             , name = "toMultiplier"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          Type.float
                     )
             }
        )
        [ toMultiplierArg ]


{-| toPercentage: Percent.Percent -> Float -}
toPercentage : Elm.Expression -> Elm.Expression
toPercentage toPercentageArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Percent" ]
             , name = "toPercentage"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          Type.float
                     )
             }
        )
        [ toPercentageArg ]


{-| toFloat: Percent.Percent -> Float -}
toFloat : Elm.Expression -> Elm.Expression
toFloat toFloatArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Percent" ]
             , name = "toFloat"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          Type.float
                     )
             }
        )
        [ toFloatArg ]


{-| zero: Percent.Percent -}
zero : Elm.Expression
zero =
    Elm.value
        { importFrom = [ "Percent" ]
        , name = "zero"
        , annotation = Just (Type.namedWith [ "Percent" ] "Percent" [])
        }


{-| float: Float -> Percent.Percent -}
float : Float -> Elm.Expression
float floatArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Percent" ]
             , name = "float"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float ]
                          (Type.namedWith [ "Percent" ] "Percent" [])
                     )
             }
        )
        [ Elm.float floatArg ]


annotation_ : { percent : Type.Annotation, percentile : Type.Annotation }
annotation_ =
    { percent =
        Type.alias
            moduleName_
            "Percent"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "Percent" ] "Percentile" [] ]
            )
    , percentile = Type.namedWith [ "Percent" ] "Percentile" []
    }


make_ : { percentile : Elm.Expression }
make_ =
    { percentile =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "Percentile"
            , annotation = Just (Type.namedWith [] "Percentile" [])
            }
    }


caseOf_ :
    { percentile :
        Elm.Expression
        -> { percentileTags_0_0 | percentile : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { percentile =
        \percentileExpression percentileTags ->
            Elm.Case.custom
                percentileExpression
                (Type.namedWith [ "Percent" ] "Percentile" [])
                [ Elm.Case.branch0 "Percentile" percentileTags.percentile ]
    }


call_ :
    { increaseByPercent : Elm.Expression -> Elm.Expression -> Elm.Expression
    , capAtHundred : Elm.Expression -> Elm.Expression
    , toMultiplier : Elm.Expression -> Elm.Expression
    , toPercentage : Elm.Expression -> Elm.Expression
    , toFloat : Elm.Expression -> Elm.Expression
    , float : Elm.Expression -> Elm.Expression
    }
call_ =
    { increaseByPercent =
        \increaseByPercentArg increaseByPercentArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Percent" ]
                     , name = "increaseByPercent"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" []
                                  , Type.float
                                  ]
                                  Type.float
                             )
                     }
                )
                [ increaseByPercentArg, increaseByPercentArg0 ]
    , capAtHundred =
        \capAtHundredArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Percent" ]
                     , name = "capAtHundred"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith [ "Percent" ] "Percent" [])
                             )
                     }
                )
                [ capAtHundredArg ]
    , toMultiplier =
        \toMultiplierArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Percent" ]
                     , name = "toMultiplier"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  Type.float
                             )
                     }
                )
                [ toMultiplierArg ]
    , toPercentage =
        \toPercentageArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Percent" ]
                     , name = "toPercentage"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  Type.float
                             )
                     }
                )
                [ toPercentageArg ]
    , toFloat =
        \toFloatArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Percent" ]
                     , name = "toFloat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  Type.float
                             )
                     }
                )
                [ toFloatArg ]
    , float =
        \floatArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Percent" ]
                     , name = "float"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float ]
                                  (Type.namedWith [ "Percent" ] "Percent" [])
                             )
                     }
                )
                [ floatArg ]
    }


values_ :
    { increaseByPercent : Elm.Expression
    , capAtHundred : Elm.Expression
    , toMultiplier : Elm.Expression
    , toPercentage : Elm.Expression
    , toFloat : Elm.Expression
    , zero : Elm.Expression
    , float : Elm.Expression
    }
values_ =
    { increaseByPercent =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "increaseByPercent"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" []
                         , Type.float
                         ]
                         Type.float
                    )
            }
    , capAtHundred =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "capAtHundred"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "Percent" ] "Percent" [])
                    )
            }
    , toMultiplier =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "toMultiplier"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         Type.float
                    )
            }
    , toPercentage =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "toPercentage"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         Type.float
                    )
            }
    , toFloat =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "toFloat"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         Type.float
                    )
            }
    , zero =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "zero"
            , annotation = Just (Type.namedWith [ "Percent" ] "Percent" [])
            }
    , float =
        Elm.value
            { importFrom = [ "Percent" ]
            , name = "float"
            , annotation =
                Just
                    (Type.function
                         [ Type.float ]
                         (Type.namedWith [ "Percent" ] "Percent" [])
                    )
            }
    }