module Gen.IdleGame.Views.FastForward exposing (moduleName_, render, values_)

{-| 
@docs moduleName_, render, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "FastForward" ]


{-| render: IdleGame.Views.FastForward.Html IdleGame.Views.FastForward.FrontendMsg -}
render : Elm.Expression
render =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "FastForward" ]
        , name = "render"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "FastForward" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "FastForward" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


values_ : { render : Elm.Expression }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "FastForward" ]
            , name = "render"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "FastForward" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "FastForward" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    }