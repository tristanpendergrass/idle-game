module Gen.IdleGame.PerfTesting.Test7Days exposing (moduleName_, test7Days, values_)

{-| 
@docs moduleName_, test7Days, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "PerfTesting", "Test7Days" ]


{-| test7Days: IdleGame.PerfTesting.Test7Days.Test -}
test7Days : Elm.Expression
test7Days =
    Elm.value
        { importFrom = [ "IdleGame", "PerfTesting", "Test7Days" ]
        , name = "test7Days"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "PerfTesting", "Test7Days" ]
                     "Test"
                     []
                )
        }


values_ : { test7Days : Elm.Expression }
values_ =
    { test7Days =
        Elm.value
            { importFrom = [ "IdleGame", "PerfTesting", "Test7Days" ]
            , name = "test7Days"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "PerfTesting", "Test7Days" ]
                         "Test"
                         []
                    )
            }
    }