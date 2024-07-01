module Gen.IdleGame.Test exposing (annotation_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Test" ]


annotation_ : { test : Type.Annotation }
annotation_ =
    { test =
        Type.alias
            moduleName_
            "Test"
            []
            (Type.record
                 [ ( "costs"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                   )
                 , ( "gains"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                   )
                 , ( "label", Type.string )
                 ]
            )
    }


make_ :
    { test :
        { costs : Elm.Expression
        , gains : Elm.Expression
        , label : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { test =
        \test_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Test" ]
                     "Test"
                     []
                     (Type.record
                          [ ( "costs"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                            )
                          , ( "gains"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                            )
                          , ( "label", Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "costs" test_args.costs
                     , Tuple.pair "gains" test_args.gains
                     , Tuple.pair "label" test_args.label
                     ]
                )
    }