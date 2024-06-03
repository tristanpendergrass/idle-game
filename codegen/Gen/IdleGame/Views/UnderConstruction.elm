module Gen.IdleGame.Views.UnderConstruction exposing (moduleName_, render, values_)

{-| 
@docs moduleName_, render, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "UnderConstruction" ]


{-| render: IdleGame.Views.UnderConstruction.Html IdleGame.Views.UnderConstruction.FrontendMsg -}
render : Elm.Expression
render =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "UnderConstruction" ]
        , name = "render"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "UnderConstruction" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "UnderConstruction" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


values_ : { render : Elm.Expression }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "UnderConstruction" ]
            , name = "render"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "UnderConstruction" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "UnderConstruction" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    }