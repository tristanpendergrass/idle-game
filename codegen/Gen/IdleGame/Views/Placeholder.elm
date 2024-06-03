module Gen.IdleGame.Views.Placeholder exposing (call_, moduleName_, placeholder, values_)

{-| 
@docs moduleName_, placeholder, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "Placeholder" ]


{-| placeholder: 
    List (IdleGame.Views.Placeholder.Attribute msg)
    -> IdleGame.Views.Placeholder.Html msg
-}
placeholder : List Elm.Expression -> Elm.Expression
placeholder placeholderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "Placeholder" ]
             , name = "placeholder"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "IdleGame", "Views", "Placeholder" ]
                                 "Attribute"
                                 [ Type.var "msg" ]
                              )
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "Placeholder" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.list placeholderArg ]


call_ : { placeholder : Elm.Expression -> Elm.Expression }
call_ =
    { placeholder =
        \placeholderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "Placeholder" ]
                     , name = "placeholder"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Views", "Placeholder" ]
                                         "Attribute"
                                         [ Type.var "msg" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "Placeholder" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ placeholderArg ]
    }


values_ : { placeholder : Elm.Expression }
values_ =
    { placeholder =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "Placeholder" ]
            , name = "placeholder"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "IdleGame", "Views", "Placeholder" ]
                                "Attribute"
                                [ Type.var "msg" ]
                             )
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "Placeholder" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    }