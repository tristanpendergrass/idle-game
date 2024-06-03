module Gen.IdleGame.Mocks exposing (moduleName_, timePassesModal, values_)

{-| 
@docs moduleName_, timePassesModal, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Mocks" ]


{-| timePassesModal: IdleGame.Mocks.Modal -}
timePassesModal : Elm.Expression
timePassesModal =
    Elm.value
        { importFrom = [ "IdleGame", "Mocks" ]
        , name = "timePassesModal"
        , annotation = Just (Type.namedWith [ "IdleGame", "Mocks" ] "Modal" [])
        }


values_ : { timePassesModal : Elm.Expression }
values_ =
    { timePassesModal =
        Elm.value
            { importFrom = [ "IdleGame", "Mocks" ]
            , name = "timePassesModal"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Mocks" ] "Modal" [])
            }
    }