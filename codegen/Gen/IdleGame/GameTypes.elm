module Gen.IdleGame.GameTypes exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "GameTypes" ]


annotation_ :
    { intervalMod : Type.Annotation
    , cardImage : Type.Annotation
    , intervalModLabel : Type.Annotation
    , toast : Type.Annotation
    }
annotation_ =
    { intervalMod =
        Type.alias
            moduleName_
            "IntervalMod"
            []
            (Type.record
                 [ ( "kind"
                   , Type.namedWith [ "IdleGame", "GameTypes" ] "Activity" []
                   )
                 , ( "percentChange"
                   , Type.namedWith [ "Percent" ] "Percent" []
                   )
                 , ( "label"
                   , Type.namedWith
                         [ "IdleGame", "GameTypes" ]
                         "IntervalModLabel"
                         []
                   )
                 ]
            )
    , cardImage = Type.namedWith [ "IdleGame", "GameTypes" ] "CardImage" []
    , intervalModLabel =
        Type.namedWith [ "IdleGame", "GameTypes" ] "IntervalModLabel" []
    , toast = Type.namedWith [ "IdleGame", "GameTypes" ] "Toast" []
    }


make_ :
    { intervalMod :
        { kind : Elm.Expression
        , percentChange : Elm.Expression
        , label : Elm.Expression
        }
        -> Elm.Expression
    , cardLandscape : Elm.Expression -> Elm.Expression
    , cardIcon : Elm.Expression -> Elm.Expression
    , intervalModLabel : Elm.Expression -> Elm.Expression
    , gainedCoin : Elm.Expression -> Elm.Expression
    , gainedResource : Elm.Expression -> Elm.Expression -> Elm.Expression
    , negativeAmountErr : Elm.Expression
    }
make_ =
    { intervalMod =
        \intervalMod_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "GameTypes" ]
                     "IntervalMod"
                     []
                     (Type.record
                          [ ( "kind"
                            , Type.namedWith
                                  [ "IdleGame", "GameTypes" ]
                                  "Activity"
                                  []
                            )
                          , ( "percentChange"
                            , Type.namedWith [ "Percent" ] "Percent" []
                            )
                          , ( "label"
                            , Type.namedWith
                                  [ "IdleGame", "GameTypes" ]
                                  "IntervalModLabel"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "kind" intervalMod_args.kind
                     , Tuple.pair "percentChange" intervalMod_args.percentChange
                     , Tuple.pair "label" intervalMod_args.label
                     ]
                )
    , cardLandscape =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "GameTypes" ]
                     , name = "CardLandscape"
                     , annotation = Just (Type.namedWith [] "CardImage" [])
                     }
                )
                [ ar0 ]
    , cardIcon =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "GameTypes" ]
                     , name = "CardIcon"
                     , annotation = Just (Type.namedWith [] "CardImage" [])
                     }
                )
                [ ar0 ]
    , intervalModLabel =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "GameTypes" ]
                     , name = "IntervalModLabel"
                     , annotation =
                         Just (Type.namedWith [] "IntervalModLabel" [])
                     }
                )
                [ ar0 ]
    , gainedCoin =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "GameTypes" ]
                     , name = "GainedCoin"
                     , annotation = Just (Type.namedWith [] "Toast" [])
                     }
                )
                [ ar0 ]
    , gainedResource =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "GameTypes" ]
                     , name = "GainedResource"
                     , annotation = Just (Type.namedWith [] "Toast" [])
                     }
                )
                [ ar0, ar1 ]
    , negativeAmountErr =
        Elm.value
            { importFrom = [ "IdleGame", "GameTypes" ]
            , name = "NegativeAmountErr"
            , annotation = Just (Type.namedWith [] "Toast" [])
            }
    }


caseOf_ :
    { cardImage :
        Elm.Expression
        -> { cardImageTags_0_0
            | cardLandscape : Elm.Expression -> Elm.Expression
            , cardIcon : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , intervalModLabel :
        Elm.Expression
        -> { intervalModLabelTags_1_0
            | intervalModLabel : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , toast :
        Elm.Expression
        -> { toastTags_2_0
            | gainedCoin : Elm.Expression -> Elm.Expression
            , gainedResource :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , negativeAmountErr : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { cardImage =
        \cardImageExpression cardImageTags ->
            Elm.Case.custom
                cardImageExpression
                (Type.namedWith [ "IdleGame", "GameTypes" ] "CardImage" [])
                [ Elm.Case.branch1
                    "CardLandscape"
                    ( "stringString", Type.string )
                    cardImageTags.cardLandscape
                , Elm.Case.branch1
                    "CardIcon"
                    ( "idleGameViewsIconIcon"
                    , Type.namedWith [ "IdleGame", "Views", "Icon" ] "Icon" []
                    )
                    cardImageTags.cardIcon
                ]
    , intervalModLabel =
        \intervalModLabelExpression intervalModLabelTags ->
            Elm.Case.custom
                intervalModLabelExpression
                (Type.namedWith
                     [ "IdleGame", "GameTypes" ]
                     "IntervalModLabel"
                     []
                )
                [ Elm.Case.branch1
                    "IntervalModLabel"
                    ( "percentPercent"
                    , Type.namedWith [ "Percent" ] "Percent" []
                    )
                    intervalModLabelTags.intervalModLabel
                ]
    , toast =
        \toastExpression toastTags ->
            Elm.Case.custom
                toastExpression
                (Type.namedWith [ "IdleGame", "GameTypes" ] "Toast" [])
                [ Elm.Case.branch1
                    "GainedCoin"
                    ( "idleGameCoinCoin"
                    , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                    )
                    toastTags.gainedCoin
                , Elm.Case.branch2
                    "GainedResource"
                    ( "basicsInt", Type.int )
                    ( "idleGameGameTypesResource"
                    , Type.namedWith [ "IdleGame", "GameTypes" ] "Resource" []
                    )
                    toastTags.gainedResource
                , Elm.Case.branch0
                    "NegativeAmountErr"
                    toastTags.negativeAmountErr
                ]
    }