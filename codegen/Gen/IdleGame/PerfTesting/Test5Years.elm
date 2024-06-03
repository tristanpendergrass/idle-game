module Gen.IdleGame.PerfTesting.Test5Years exposing (moduleName_, test5Years, values_)

{-| 
@docs moduleName_, test5Years, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "PerfTesting", "Test5Years" ]


{-| {-| Demonstrates how fast calculating even 5 years of ticks is if you use a high enough tick duration.
-}

test5Years: IdleGame.PerfTesting.Test5Years.Test
-}
test5Years : Elm.Expression
test5Years =
    Elm.value
        { importFrom = [ "IdleGame", "PerfTesting", "Test5Years" ]
        , name = "test5Years"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "PerfTesting", "Test5Years" ]
                     "Test"
                     []
                )
        }


values_ : { test5Years : Elm.Expression }
values_ =
    { test5Years =
        Elm.value
            { importFrom = [ "IdleGame", "PerfTesting", "Test5Years" ]
            , name = "test5Years"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "PerfTesting", "Test5Years" ]
                         "Test"
                         []
                    )
            }
    }