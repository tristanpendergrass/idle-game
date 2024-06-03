module Gen.IdleGame.Views.MasteryUnlocks exposing (call_, moduleName_, render, renderCheckpoint, values_)

{-| 
@docs moduleName_, render, renderCheckpoint, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Views", "MasteryUnlocks" ]


{-| render: IdleGame.Views.MasteryUnlocks.Html IdleGame.Views.MasteryUnlocks.FrontendMsg -}
render : Elm.Expression
render =
    Elm.value
        { importFrom = [ "IdleGame", "Views", "MasteryUnlocks" ]
        , name = "render"
        , annotation =
            Just
                (Type.namedWith
                     [ "IdleGame", "Views", "MasteryUnlocks" ]
                     "Html"
                     [ Type.namedWith
                         [ "IdleGame", "Views", "MasteryUnlocks" ]
                         "FrontendMsg"
                         []
                     ]
                )
        }


{-| renderCheckpoint: 
    { number : Int, label : String, isActive : Bool }
    -> IdleGame.Views.MasteryUnlocks.Html IdleGame.Views.MasteryUnlocks.FrontendMsg
-}
renderCheckpoint :
    { number : Int, label : String, isActive : Bool } -> Elm.Expression
renderCheckpoint renderCheckpointArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Views", "MasteryUnlocks" ]
             , name = "renderCheckpoint"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "number", Type.int )
                              , ( "label", Type.string )
                              , ( "isActive", Type.bool )
                              ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Views", "MasteryUnlocks" ]
                               "Html"
                               [ Type.namedWith
                                   [ "IdleGame", "Views", "MasteryUnlocks" ]
                                   "FrontendMsg"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "number" (Elm.int renderCheckpointArg.number)
            , Tuple.pair "label" (Elm.string renderCheckpointArg.label)
            , Tuple.pair "isActive" (Elm.bool renderCheckpointArg.isActive)
            ]
        ]


call_ : { renderCheckpoint : Elm.Expression -> Elm.Expression }
call_ =
    { renderCheckpoint =
        \renderCheckpointArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Views", "MasteryUnlocks" ]
                     , name = "renderCheckpoint"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "number", Type.int )
                                      , ( "label", Type.string )
                                      , ( "isActive", Type.bool )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Views", "MasteryUnlocks" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "IdleGame"
                                           , "Views"
                                           , "MasteryUnlocks"
                                           ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderCheckpointArg ]
    }


values_ : { render : Elm.Expression, renderCheckpoint : Elm.Expression }
values_ =
    { render =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "MasteryUnlocks" ]
            , name = "render"
            , annotation =
                Just
                    (Type.namedWith
                         [ "IdleGame", "Views", "MasteryUnlocks" ]
                         "Html"
                         [ Type.namedWith
                             [ "IdleGame", "Views", "MasteryUnlocks" ]
                             "FrontendMsg"
                             []
                         ]
                    )
            }
    , renderCheckpoint =
        Elm.value
            { importFrom = [ "IdleGame", "Views", "MasteryUnlocks" ]
            , name = "renderCheckpoint"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "number", Type.int )
                             , ( "label", Type.string )
                             , ( "isActive", Type.bool )
                             ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Views", "MasteryUnlocks" ]
                              "Html"
                              [ Type.namedWith
                                  [ "IdleGame", "Views", "MasteryUnlocks" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }