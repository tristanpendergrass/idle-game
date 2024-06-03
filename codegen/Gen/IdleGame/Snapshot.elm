module Gen.IdleGame.Snapshot exposing (annotation_, call_, caseOf_, createTick, dEBUG_addTime, fromTuple, getTime, getTimeDifference, getValue, make_, map, moduleName_, tickUntil, values_)

{-| 
@docs moduleName_, dEBUG_addTime, getTimeDifference, tickUntil, getValue, getTime, map, fromTuple, createTick, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Snapshot" ]


{-| {-| This function should only be referened from e.g. debug panel. It sets the time without updating the state.
Under normal circumstances that would cause bugs where the game gets out of sync
-}

dEBUG_addTime: 
    Duration.Duration
    -> IdleGame.Snapshot.Snapshot t
    -> IdleGame.Snapshot.Snapshot t
-}
dEBUG_addTime : Elm.Expression -> Elm.Expression -> Elm.Expression
dEBUG_addTime dEBUG_addTimeArg dEBUG_addTimeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "dEBUG_addTime"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Snapshot" ]
                               "Snapshot"
                               [ Type.var "t" ]
                          )
                     )
             }
        )
        [ dEBUG_addTimeArg, dEBUG_addTimeArg0 ]


{-| getTimeDifference: IdleGame.Snapshot.Snapshot t -> IdleGame.Snapshot.Snapshot a -> Time.Posix -}
getTimeDifference : Elm.Expression -> Elm.Expression -> Elm.Expression
getTimeDifference getTimeDifferenceArg getTimeDifferenceArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "getTimeDifference"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                          , Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ getTimeDifferenceArg, getTimeDifferenceArg0 ]


{-| tickUntil: 
    IdleGame.Snapshot.Tick t
    -> Time.Posix
    -> IdleGame.Snapshot.Snapshot t
    -> IdleGame.Snapshot.Snapshot t
-}
tickUntil : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
tickUntil tickUntilArg tickUntilArg0 tickUntilArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "tickUntil"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Tick"
                              [ Type.var "t" ]
                          , Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Snapshot" ]
                               "Snapshot"
                               [ Type.var "t" ]
                          )
                     )
             }
        )
        [ tickUntilArg, tickUntilArg0, tickUntilArg1 ]


{-| getValue: IdleGame.Snapshot.Snapshot t -> t -}
getValue : Elm.Expression -> Elm.Expression
getValue getValueArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "getValue"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                          ]
                          (Type.var "t")
                     )
             }
        )
        [ getValueArg ]


{-| getTime: IdleGame.Snapshot.Snapshot t -> Time.Posix -}
getTime : Elm.Expression -> Elm.Expression
getTime getTimeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "getTime"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ getTimeArg ]


{-| map: (t -> a) -> IdleGame.Snapshot.Snapshot t -> IdleGame.Snapshot.Snapshot a -}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "t" ] (Type.var "a")
                          , Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Snapshot" ]
                               "Snapshot"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


{-| fromTuple: ( Time.Posix, t ) -> IdleGame.Snapshot.Snapshot t -}
fromTuple : Elm.Expression -> Elm.Expression
fromTuple fromTupleArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "fromTuple"
             , annotation =
                 Just
                     (Type.function
                          [ Type.tuple
                              (Type.namedWith [ "Time" ] "Posix" [])
                              (Type.var "t")
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Snapshot" ]
                               "Snapshot"
                               [ Type.var "t" ]
                          )
                     )
             }
        )
        [ fromTupleArg ]


{-| createTick: Duration.Duration -> (Duration.Duration -> t -> t) -> IdleGame.Snapshot.Tick t -}
createTick :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
createTick createTickArg createTickArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Snapshot" ]
             , name = "createTick"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" []
                          , Type.function
                              [ Type.namedWith [ "Duration" ] "Duration" []
                              , Type.var "t"
                              ]
                              (Type.var "t")
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Snapshot" ]
                               "Tick"
                               [ Type.var "t" ]
                          )
                     )
             }
        )
        [ createTickArg
        , Elm.functionReduced
            "createTickUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (createTickArg0 functionReducedUnpack)
            )
        ]


annotation_ :
    { snapshot : Type.Annotation -> Type.Annotation
    , tick : Type.Annotation -> Type.Annotation
    }
annotation_ =
    { snapshot =
        \snapshotArg0 ->
            Type.namedWith
                [ "IdleGame", "Snapshot" ]
                "Snapshot"
                [ snapshotArg0 ]
    , tick =
        \tickArg0 ->
            Type.namedWith [ "IdleGame", "Snapshot" ] "Tick" [ tickArg0 ]
    }


make_ : { snapshot : Elm.Expression -> Elm.Expression }
make_ =
    { snapshot =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "Snapshot"
                     , annotation =
                         Just (Type.namedWith [] "Snapshot" [ Type.var "t" ])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { snapshot :
        Elm.Expression
        -> { snapshotTags_0_0 | snapshot : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { snapshot =
        \snapshotExpression snapshotTags ->
            Elm.Case.custom
                snapshotExpression
                (Type.namedWith
                     [ "IdleGame", "Snapshot" ]
                     "Snapshot"
                     [ Type.var "t" ]
                )
                [ Elm.Case.branch1
                    "Snapshot"
                    ( "one"
                    , Type.tuple
                          (Type.namedWith [ "Time" ] "Posix" [])
                          (Type.var "t")
                    )
                    snapshotTags.snapshot
                ]
    }


call_ :
    { dEBUG_addTime : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getTimeDifference : Elm.Expression -> Elm.Expression -> Elm.Expression
    , tickUntil :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getValue : Elm.Expression -> Elm.Expression
    , getTime : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromTuple : Elm.Expression -> Elm.Expression
    , createTick : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { dEBUG_addTime =
        \dEBUG_addTimeArg dEBUG_addTimeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "dEBUG_addTime"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Snapshot"
                                      [ Type.var "t" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Snapshot" ]
                                       "Snapshot"
                                       [ Type.var "t" ]
                                  )
                             )
                     }
                )
                [ dEBUG_addTimeArg, dEBUG_addTimeArg0 ]
    , getTimeDifference =
        \getTimeDifferenceArg getTimeDifferenceArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "getTimeDifference"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Snapshot"
                                      [ Type.var "t" ]
                                  , Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Snapshot"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ getTimeDifferenceArg, getTimeDifferenceArg0 ]
    , tickUntil =
        \tickUntilArg tickUntilArg0 tickUntilArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "tickUntil"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Tick"
                                      [ Type.var "t" ]
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Snapshot"
                                      [ Type.var "t" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Snapshot" ]
                                       "Snapshot"
                                       [ Type.var "t" ]
                                  )
                             )
                     }
                )
                [ tickUntilArg, tickUntilArg0, tickUntilArg1 ]
    , getValue =
        \getValueArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "getValue"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Snapshot"
                                      [ Type.var "t" ]
                                  ]
                                  (Type.var "t")
                             )
                     }
                )
                [ getValueArg ]
    , getTime =
        \getTimeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "getTime"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Snapshot"
                                      [ Type.var "t" ]
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ getTimeArg ]
    , map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "t" ]
                                      (Type.var "a")
                                  , Type.namedWith
                                      [ "IdleGame", "Snapshot" ]
                                      "Snapshot"
                                      [ Type.var "t" ]
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Snapshot" ]
                                       "Snapshot"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ mapArg, mapArg0 ]
    , fromTuple =
        \fromTupleArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "fromTuple"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.tuple
                                      (Type.namedWith [ "Time" ] "Posix" [])
                                      (Type.var "t")
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Snapshot" ]
                                       "Snapshot"
                                       [ Type.var "t" ]
                                  )
                             )
                     }
                )
                [ fromTupleArg ]
    , createTick =
        \createTickArg createTickArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Snapshot" ]
                     , name = "createTick"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.function
                                      [ Type.namedWith
                                            [ "Duration" ]
                                            "Duration"
                                            []
                                      , Type.var "t"
                                      ]
                                      (Type.var "t")
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Snapshot" ]
                                       "Tick"
                                       [ Type.var "t" ]
                                  )
                             )
                     }
                )
                [ createTickArg, createTickArg0 ]
    }


values_ :
    { dEBUG_addTime : Elm.Expression
    , getTimeDifference : Elm.Expression
    , tickUntil : Elm.Expression
    , getValue : Elm.Expression
    , getTime : Elm.Expression
    , map : Elm.Expression
    , fromTuple : Elm.Expression
    , createTick : Elm.Expression
    }
values_ =
    { dEBUG_addTime =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "dEBUG_addTime"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Snapshot"
                             [ Type.var "t" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                         )
                    )
            }
    , getTimeDifference =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "getTimeDifference"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Snapshot"
                             [ Type.var "t" ]
                         , Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Snapshot"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , tickUntil =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "tickUntil"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Tick"
                             [ Type.var "t" ]
                         , Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Snapshot"
                             [ Type.var "t" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                         )
                    )
            }
    , getValue =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "getValue"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Snapshot"
                             [ Type.var "t" ]
                         ]
                         (Type.var "t")
                    )
            }
    , getTime =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "getTime"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Snapshot"
                             [ Type.var "t" ]
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "t" ] (Type.var "a")
                         , Type.namedWith
                             [ "IdleGame", "Snapshot" ]
                             "Snapshot"
                             [ Type.var "t" ]
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "a" ]
                         )
                    )
            }
    , fromTuple =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "fromTuple"
            , annotation =
                Just
                    (Type.function
                         [ Type.tuple
                             (Type.namedWith [ "Time" ] "Posix" [])
                             (Type.var "t")
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Snapshot"
                              [ Type.var "t" ]
                         )
                    )
            }
    , createTick =
        Elm.value
            { importFrom = [ "IdleGame", "Snapshot" ]
            , name = "createTick"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" []
                         , Type.function
                             [ Type.namedWith [ "Duration" ] "Duration" []
                             , Type.var "t"
                             ]
                             (Type.var "t")
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Snapshot" ]
                              "Tick"
                              [ Type.var "t" ]
                         )
                    )
            }
    }