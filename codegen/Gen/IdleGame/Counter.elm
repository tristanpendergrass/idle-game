module Gen.IdleGame.Counter exposing (add, annotation_, call_, caseOf_, create, getValue, isZero, make_, moduleName_, multiplyBy, subtract, values_)

{-| 
@docs moduleName_, isZero, multiplyBy, getValue, subtract, add, create, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Counter" ]


{-| isZero: IdleGame.Counter.Counter -> Bool -}
isZero : Elm.Expression -> Elm.Expression
isZero isZeroArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Counter" ]
             , name = "isZero"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Counter" ]
                              "Counter"
                              []
                          ]
                          Type.bool
                     )
             }
        )
        [ isZeroArg ]


{-| multiplyBy: Float -> IdleGame.Counter.Counter -> IdleGame.Counter.Counter -}
multiplyBy : Float -> Elm.Expression -> Elm.Expression
multiplyBy multiplyByArg multiplyByArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Counter" ]
             , name = "multiplyBy"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float
                          , Type.namedWith
                              [ "IdleGame", "Counter" ]
                              "Counter"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                          )
                     )
             }
        )
        [ Elm.float multiplyByArg, multiplyByArg0 ]


{-| getValue: IdleGame.Counter.Counter -> Int -}
getValue : Elm.Expression -> Elm.Expression
getValue getValueArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Counter" ]
             , name = "getValue"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Counter" ]
                              "Counter"
                              []
                          ]
                          Type.int
                     )
             }
        )
        [ getValueArg ]


{-| subtract: IdleGame.Counter.Counter -> IdleGame.Counter.Counter -> IdleGame.Counter.Counter -}
subtract : Elm.Expression -> Elm.Expression -> Elm.Expression
subtract subtractArg subtractArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Counter" ]
             , name = "subtract"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Counter" ]
                              "Counter"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Counter" ]
                              "Counter"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                          )
                     )
             }
        )
        [ subtractArg, subtractArg0 ]


{-| add: IdleGame.Counter.Counter -> IdleGame.Counter.Counter -> IdleGame.Counter.Counter -}
add : Elm.Expression -> Elm.Expression -> Elm.Expression
add addArg addArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Counter" ]
             , name = "add"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Counter" ]
                              "Counter"
                              []
                          , Type.namedWith
                              [ "IdleGame", "Counter" ]
                              "Counter"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                          )
                     )
             }
        )
        [ addArg, addArg0 ]


{-| create: Int -> IdleGame.Counter.Counter -}
create : Int -> Elm.Expression
create createArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Counter" ]
             , name = "create"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                          )
                     )
             }
        )
        [ Elm.int createArg ]


annotation_ : { counter : Type.Annotation }
annotation_ =
    { counter = Type.namedWith [ "IdleGame", "Counter" ] "Counter" [] }


make_ : { counter : Elm.Expression -> Elm.Expression }
make_ =
    { counter =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Counter" ]
                     , name = "Counter"
                     , annotation = Just (Type.namedWith [] "Counter" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { counter :
        Elm.Expression
        -> { counterTags_0_0 | counter : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { counter =
        \counterExpression counterTags ->
            Elm.Case.custom
                counterExpression
                (Type.namedWith [ "IdleGame", "Counter" ] "Counter" [])
                [ Elm.Case.branch1
                    "Counter"
                    ( "basicsFloat", Type.float )
                    counterTags.counter
                ]
    }


call_ :
    { isZero : Elm.Expression -> Elm.Expression
    , multiplyBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getValue : Elm.Expression -> Elm.Expression
    , subtract : Elm.Expression -> Elm.Expression -> Elm.Expression
    , add : Elm.Expression -> Elm.Expression -> Elm.Expression
    , create : Elm.Expression -> Elm.Expression
    }
call_ =
    { isZero =
        \isZeroArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Counter" ]
                     , name = "isZero"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Counter" ]
                                      "Counter"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ isZeroArg ]
    , multiplyBy =
        \multiplyByArg multiplyByArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Counter" ]
                     , name = "multiplyBy"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float
                                  , Type.namedWith
                                      [ "IdleGame", "Counter" ]
                                      "Counter"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Counter" ]
                                       "Counter"
                                       []
                                  )
                             )
                     }
                )
                [ multiplyByArg, multiplyByArg0 ]
    , getValue =
        \getValueArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Counter" ]
                     , name = "getValue"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Counter" ]
                                      "Counter"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ getValueArg ]
    , subtract =
        \subtractArg subtractArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Counter" ]
                     , name = "subtract"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Counter" ]
                                      "Counter"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Counter" ]
                                      "Counter"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Counter" ]
                                       "Counter"
                                       []
                                  )
                             )
                     }
                )
                [ subtractArg, subtractArg0 ]
    , add =
        \addArg addArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Counter" ]
                     , name = "add"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Counter" ]
                                      "Counter"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Counter" ]
                                      "Counter"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Counter" ]
                                       "Counter"
                                       []
                                  )
                             )
                     }
                )
                [ addArg, addArg0 ]
    , create =
        \createArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Counter" ]
                     , name = "create"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "IdleGame", "Counter" ]
                                       "Counter"
                                       []
                                  )
                             )
                     }
                )
                [ createArg ]
    }


values_ :
    { isZero : Elm.Expression
    , multiplyBy : Elm.Expression
    , getValue : Elm.Expression
    , subtract : Elm.Expression
    , add : Elm.Expression
    , create : Elm.Expression
    }
values_ =
    { isZero =
        Elm.value
            { importFrom = [ "IdleGame", "Counter" ]
            , name = "isZero"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                         ]
                         Type.bool
                    )
            }
    , multiplyBy =
        Elm.value
            { importFrom = [ "IdleGame", "Counter" ]
            , name = "multiplyBy"
            , annotation =
                Just
                    (Type.function
                         [ Type.float
                         , Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                         ]
                         (Type.namedWith [ "IdleGame", "Counter" ] "Counter" [])
                    )
            }
    , getValue =
        Elm.value
            { importFrom = [ "IdleGame", "Counter" ]
            , name = "getValue"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                         ]
                         Type.int
                    )
            }
    , subtract =
        Elm.value
            { importFrom = [ "IdleGame", "Counter" ]
            , name = "subtract"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                         , Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                         ]
                         (Type.namedWith [ "IdleGame", "Counter" ] "Counter" [])
                    )
            }
    , add =
        Elm.value
            { importFrom = [ "IdleGame", "Counter" ]
            , name = "add"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                         , Type.namedWith [ "IdleGame", "Counter" ] "Counter" []
                         ]
                         (Type.namedWith [ "IdleGame", "Counter" ] "Counter" [])
                    )
            }
    , create =
        Elm.value
            { importFrom = [ "IdleGame", "Counter" ]
            , name = "create"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "IdleGame", "Counter" ] "Counter" [])
                    )
            }
    }