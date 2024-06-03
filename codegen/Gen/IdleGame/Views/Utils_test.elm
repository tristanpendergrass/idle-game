module Gen.IdleGame.Views.Utils_test exposing (floatToStringSuite, getDurationStringSuite, moduleName_, values_)

{-| 
@docs moduleName_, floatToStringSuite, getDurationStringSuite, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Utils_test" ]


{-| floatToStringSuite: IdleGame.Views.Utils_test.Test -}
floatToStringSuite : Elm.Expression
floatToStringSuite =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Utils_test" ]
        , name = "floatToStringSuite"
        , annotation =
            Just
                (Type.namedWith [ "IdleGame", "Views", "Utils_test" ] "Test" [])
        }


{-| getDurationStringSuite: IdleGame.Views.Utils_test.Test -}
getDurationStringSuite : Elm.Expression
getDurationStringSuite =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "Utils_test" ]
        , name = "getDurationStringSuite"
        , annotation =
            Just
                (Type.namedWith [ "IdleGame", "Views", "Utils_test" ] "Test" [])
        }


values_ :
    { floatToStringSuite : Elm.Expression
    , getDurationStringSuite : Elm.Expression
    }
values_ =
    { floatToStringSuite =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils_test" ]
            , name = "floatToStringSuite"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "Utils_test" ]
                         "Test"
                         []
                    )
            }
    , getDurationStringSuite =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Utils_test" ]
            , name = "getDurationStringSuite"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "Utils_test" ]
                         "Test"
                         []
                    )
            }
    }