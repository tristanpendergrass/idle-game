module Gen.IdleGame.PerfTesting.Test60Days exposing (moduleName_, test60Days, values_)

{-| 
@docs moduleName_, test60Days, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "PerfTesting", "Test60Days" ]


{-| test60Days: IdleGame.PerfTesting.Test60Days.Test -}
test60Days : Elm.Expression
test60Days =
    Elm.value
        { importFrom = [ "IdleGame", "PerfTesting", "Test60Days" ]
        , name = "test60Days"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "PerfTesting", "Test60Days" ]
                     "Test"
                     []
                )
        }


values_ : { test60Days : Elm.Expression }
values_ =
    { test60Days =
        Elm.value
            { importFrom = [ "IdleGame", "PerfTesting", "Test60Days" ]
            , name = "test60Days"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "PerfTesting", "Test60Days" ]
                         "Test"
                         []
                    )
            }
    }