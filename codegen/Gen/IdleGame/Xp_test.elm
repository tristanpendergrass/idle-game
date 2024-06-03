module Gen.IdleGame.Xp_test exposing (call_, isAboutEqualTo, levelTest, moduleName_, skillLevelPercentTest, values_)

{-| 
@docs moduleName_, skillLevelPercentTest, levelTest, isAboutEqualTo, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Xp_test" ]


{-| skillLevelPercentTest: IdleGame.Xp_test.Test -}
skillLevelPercentTest : Elm.Expression
skillLevelPercentTest =
    Elm.value
        { importFrom = [ "IdleGame", "Xp_test" ]
        , name = "skillLevelPercentTest"
        , annotation = Just (Type.namedWith [ "IdleGame", "Xp_test" ] "Test" [])
        }


{-| levelTest: IdleGame.Xp_test.Test -}
levelTest : Elm.Expression
levelTest =
    Elm.value
        { importFrom = [ "IdleGame", "Xp_test" ]
        , name = "levelTest"
        , annotation = Just (Type.namedWith [ "IdleGame", "Xp_test" ] "Test" [])
        }


{-| isAboutEqualTo: Float -> Float -> IdleGame.Xp_test.Expectation -}
isAboutEqualTo : Float -> Float -> Elm.Expression
isAboutEqualTo isAboutEqualToArg isAboutEqualToArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Xp_test" ]
             , name = "isAboutEqualTo"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float, Type.float ]
                          (Type.namedWith
                               [ "IdleGame", "Xp_test" ]
                               "Expectation"
                               []
                          )
                     )
             }
        )
        [ Elm.float isAboutEqualToArg, Elm.float isAboutEqualToArg0 ]


call_ : { isAboutEqualTo : Elm.Expression -> Elm.Expression -> Elm.Expression }
call_ =
    { isAboutEqualTo =
        \isAboutEqualToArg isAboutEqualToArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Xp_test" ]
                     , name = "isAboutEqualTo"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float, Type.float ]
                                  (Type.namedWith
                                       [ "IdleGame", "Xp_test" ]
                                       "Expectation"
                                       []
                                  )
                             )
                     }
                )
                [ isAboutEqualToArg, isAboutEqualToArg0 ]
    }


values_ :
    { skillLevelPercentTest : Elm.Expression
    , levelTest : Elm.Expression
    , isAboutEqualTo : Elm.Expression
    }
values_ =
    { skillLevelPercentTest =
        Elm.value
            { importFrom = [ "IdleGame", "Xp_test" ]
            , name = "skillLevelPercentTest"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Xp_test" ] "Test" [])
            }
    , levelTest =
        Elm.value
            { importFrom = [ "IdleGame", "Xp_test" ]
            , name = "levelTest"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Xp_test" ] "Test" [])
            }
    , isAboutEqualTo =
        Elm.value
            { importFrom = [ "IdleGame", "Xp_test" ]
            , name = "isAboutEqualTo"
            , annotation =
                Just
                    (Type.function
                         [ Type.float, Type.float ]
                         (Type.namedWith
                              [ "IdleGame", "Xp_test" ]
                              "Expectation"
                              []
                         )
                    )
            }
    }