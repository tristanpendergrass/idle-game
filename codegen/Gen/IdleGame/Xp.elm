module Gen.IdleGame.Xp exposing (annotation_, call_, caseOf_, defaultSchedule, int, level, levelHelp, levelPercent, levelPercentHelp, make_, moduleName_, toInt, values_)

{-| 
@docs moduleName_, defaultSchedule, levelPercentHelp, levelPercent, levelHelp, level, toInt, int, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Xp" ]


{-| defaultSchedule: IdleGame.Xp.LevelingSchedule -}
defaultSchedule : Elm.Expression
defaultSchedule =
    Elm.value
        { importFrom = [ "IdleGame", "Xp" ]
        , name = "defaultSchedule"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "Xp" ] "LevelingSchedule" [])
        }


{-| levelPercentHelp: IdleGame.Xp.LevelingSchedule -> IdleGame.Xp.Xp -> Int -> Float -}
levelPercentHelp : Elm.Expression -> Elm.Expression -> Int -> Elm.Expression
levelPercentHelp levelPercentHelpArg levelPercentHelpArg0 levelPercentHelpArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Xp" ]
             , name = "levelPercentHelp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Xp" ]
                              "LevelingSchedule"
                              []
                          , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.int
                          ]
                          Type.float
                     )
             }
        )
        [ levelPercentHelpArg
        , levelPercentHelpArg0
        , Elm.int levelPercentHelpArg1
        ]


{-| levelPercent: IdleGame.Xp.LevelingSchedule -> IdleGame.Xp.Xp -> Percent.Percent -}
levelPercent : Elm.Expression -> Elm.Expression -> Elm.Expression
levelPercent levelPercentArg levelPercentArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Xp" ]
             , name = "levelPercent"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Xp" ]
                              "LevelingSchedule"
                              []
                          , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          ]
                          (Type.namedWith [ "Percent" ] "Percent" [])
                     )
             }
        )
        [ levelPercentArg, levelPercentArg0 ]


{-| levelHelp: IdleGame.Xp.LevelingSchedule -> IdleGame.Xp.Xp -> Int -> Int -}
levelHelp : Elm.Expression -> Elm.Expression -> Int -> Elm.Expression
levelHelp levelHelpArg levelHelpArg0 levelHelpArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Xp" ]
             , name = "levelHelp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Xp" ]
                              "LevelingSchedule"
                              []
                          , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.int
                          ]
                          Type.int
                     )
             }
        )
        [ levelHelpArg, levelHelpArg0, Elm.int levelHelpArg1 ]


{-| level: IdleGame.Xp.LevelingSchedule -> IdleGame.Xp.Xp -> Int -}
level : Elm.Expression -> Elm.Expression -> Elm.Expression
level levelArg levelArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Xp" ]
             , name = "level"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Xp" ]
                              "LevelingSchedule"
                              []
                          , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          ]
                          Type.int
                     )
             }
        )
        [ levelArg, levelArg0 ]


{-| toInt: IdleGame.Xp.Xp -> Int -}
toInt : Elm.Expression -> Elm.Expression
toInt toIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Xp" ]
             , name = "toInt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] ]
                          Type.int
                     )
             }
        )
        [ toIntArg ]


{-| int: Int -> IdleGame.Xp.Xp -}
int : Int -> Elm.Expression
int intArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Xp" ]
             , name = "int"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "IdleGame", "Xp" ] "Xp" [])
                     )
             }
        )
        [ Elm.int intArg ]


annotation_ :
    { levelingSchedule : Type.Annotation
    , xp : Type.Annotation
    , level : Type.Annotation
    , point : Type.Annotation
    , level_ : Type.Annotation
    }
annotation_ =
    { levelingSchedule =
        Type.alias
            moduleName_
            "LevelingSchedule"
            []
            (Type.namedWith
                 [ "Array" ]
                 "Array"
                 [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] ]
            )
    , xp =
        Type.alias
            moduleName_
            "Xp"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.float, Type.namedWith [ "IdleGame", "Xp" ] "Point" [] ]
            )
    , level =
        Type.alias
            moduleName_
            "Level"
            []
            (Type.namedWith
                 [ "Quantity" ]
                 "Quantity"
                 [ Type.int, Type.namedWith [ "IdleGame", "Xp" ] "Level_" [] ]
            )
    , point = Type.namedWith [ "IdleGame", "Xp" ] "Point" []
    , level_ = Type.namedWith [ "IdleGame", "Xp" ] "Level_" []
    }


make_ : { point : Elm.Expression, level_ : Elm.Expression }
make_ =
    { point =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "Point"
            , annotation = Just (Type.namedWith [] "Point" [])
            }
    , level_ =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "Level_"
            , annotation = Just (Type.namedWith [] "Level_" [])
            }
    }


caseOf_ :
    { point :
        Elm.Expression
        -> { pointTags_0_0 | point : Elm.Expression }
        -> Elm.Expression
    , level_ :
        Elm.Expression
        -> { level_Tags_1_0 | level_ : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { point =
        \pointExpression pointTags ->
            Elm.Case.custom
                pointExpression
                (Type.namedWith [ "IdleGame", "Xp" ] "Point" [])
                [ Elm.Case.branch0 "Point" pointTags.point ]
    , level_ =
        \level_Expression level_Tags ->
            Elm.Case.custom
                level_Expression
                (Type.namedWith [ "IdleGame", "Xp" ] "Level_" [])
                [ Elm.Case.branch0 "Level_" level_Tags.level_ ]
    }


call_ :
    { levelPercentHelp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , levelPercent : Elm.Expression -> Elm.Expression -> Elm.Expression
    , levelHelp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , level : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toInt : Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    }
call_ =
    { levelPercentHelp =
        \levelPercentHelpArg levelPercentHelpArg0 levelPercentHelpArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Xp" ]
                     , name = "levelPercentHelp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Xp" ]
                                      "LevelingSchedule"
                                      []
                                  , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.int
                                  ]
                                  Type.float
                             )
                     }
                )
                [ levelPercentHelpArg
                , levelPercentHelpArg0
                , levelPercentHelpArg1
                ]
    , levelPercent =
        \levelPercentArg levelPercentArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Xp" ]
                     , name = "levelPercent"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Xp" ]
                                      "LevelingSchedule"
                                      []
                                  , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  ]
                                  (Type.namedWith [ "Percent" ] "Percent" [])
                             )
                     }
                )
                [ levelPercentArg, levelPercentArg0 ]
    , levelHelp =
        \levelHelpArg levelHelpArg0 levelHelpArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Xp" ]
                     , name = "levelHelp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Xp" ]
                                      "LevelingSchedule"
                                      []
                                  , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.int
                                  ]
                                  Type.int
                             )
                     }
                )
                [ levelHelpArg, levelHelpArg0, levelHelpArg1 ]
    , level =
        \levelArg levelArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Xp" ]
                     , name = "level"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Xp" ]
                                      "LevelingSchedule"
                                      []
                                  , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ levelArg, levelArg0 ]
    , toInt =
        \toIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Xp" ]
                     , name = "toInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ toIntArg ]
    , int =
        \intArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Xp" ]
                     , name = "int"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith [ "IdleGame", "Xp" ] "Xp" [])
                             )
                     }
                )
                [ intArg ]
    }


values_ :
    { defaultSchedule : Elm.Expression
    , levelPercentHelp : Elm.Expression
    , levelPercent : Elm.Expression
    , levelHelp : Elm.Expression
    , level : Elm.Expression
    , toInt : Elm.Expression
    , int : Elm.Expression
    }
values_ =
    { defaultSchedule =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "defaultSchedule"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "Xp" ] "LevelingSchedule" [])
            }
    , levelPercentHelp =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "levelPercentHelp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Xp" ]
                             "LevelingSchedule"
                             []
                         , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.int
                         ]
                         Type.float
                    )
            }
    , levelPercent =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "levelPercent"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Xp" ]
                             "LevelingSchedule"
                             []
                         , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         ]
                         (Type.namedWith [ "Percent" ] "Percent" [])
                    )
            }
    , levelHelp =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "levelHelp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Xp" ]
                             "LevelingSchedule"
                             []
                         , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.int
                         ]
                         Type.int
                    )
            }
    , level =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "level"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Xp" ]
                             "LevelingSchedule"
                             []
                         , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         ]
                         Type.int
                    )
            }
    , toInt =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "toInt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Xp" ] "Xp" [] ]
                         Type.int
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "IdleGame", "Xp" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "IdleGame", "Xp" ] "Xp" [])
                    )
            }
    }