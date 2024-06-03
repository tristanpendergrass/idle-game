module Gen.IdleGame.Coin exposing (annotation_, call_, caseOf_, int, make_, moduleName_, toInt, values_)

{-| 
@docs moduleName_, toInt, int, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Coin" ]


{-| toInt: IdleGame.Coin.Coin -> Int -}
toInt : Elm.Expression -> Elm.Expression
toInt toIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Coin" ]
             , name = "toInt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" [] ]
                          Type.int
                     )
             }
        )
        [ toIntArg ]


{-| int: Int -> IdleGame.Coin.Coin -}
int : Int -> Elm.Expression
int intArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Coin" ]
             , name = "int"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                     )
             }
        )
        [ Elm.int intArg ]


annotation_ : { coin : Type.Annotation, singleCoin : Type.Annotation }
annotation_ =
    { coin =
        Type.alias
            moduleName_
            "Coin"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float
                 , Type.namedWith [ "IdleGame", "Coin" ] "SingleCoin" []
                 ]
            )
    , singleCoin = Type.namedWith [ "IdleGame", "Coin" ] "SingleCoin" []
    }


make_ : { singleCoin : Elm.Expression }
make_ =
    { singleCoin =
        Elm.value
            { importFrom = [ "IdleGame", "Coin" ]
            , name = "SingleCoin"
            , annotation = Just (Type.namedWith [] "SingleCoin" [])
            }
    }


caseOf_ :
    { singleCoin :
        Elm.Expression
        -> { singleCoinTags_0_0 | singleCoin : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { singleCoin =
        \singleCoinExpression singleCoinTags ->
            Elm.Case.custom
                singleCoinExpression
                (Type.namedWith [ "IdleGame", "Coin" ] "SingleCoin" [])
                [ Elm.Case.branch0 "SingleCoin" singleCoinTags.singleCoin ]
    }


call_ :
    { toInt : Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    }
call_ =
    { toInt =
        \toIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Coin" ]
                     , name = "toInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Coin" ]
                                      "Coin"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ toIntArg ]
    , int =
        \intArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Coin" ]
                     , name = "int"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "IdleGame", "Coin" ]
                                       "Coin"
                                       []
                                  )
                             )
                     }
                )
                [ intArg ]
    }


values_ : { toInt : Elm.Expression, int : Elm.Expression }
values_ =
    { toInt =
        Elm.value
            { importFrom = [ "IdleGame", "Coin" ]
            , name = "toInt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" [] ]
                         Type.int
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "IdleGame", "Coin" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                    )
            }
    }