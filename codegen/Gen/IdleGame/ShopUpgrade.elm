module Gen.IdleGame.ShopUpgrade exposing (allShopUpgrades, annotation_, call_, caseOf_, getStats, glassesStats, intervalMod, make_, moduleName_, toOwnedItems, values_)

{-| 
@docs moduleName_, glassesStats, toOwnedItems, getStats, intervalMod, allShopUpgrades, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "ShopUpgrade" ]


{-| glassesStats: IdleGame.ShopUpgrade.Stats -}
glassesStats : Elm.Expression
glassesStats =
    Elm.value
        { importFrom = [ "IdleGame", "ShopUpgrade" ]
        , name = "glassesStats"
        , annotation =
            Just (Type.namedWith [ "IdleGame", "ShopUpgrade" ] "Stats" [])
        }


{-| toOwnedItems: 
    IdleGame.ShopUpgrade.ShopUpgradeRecord Bool
    -> List IdleGame.ShopUpgrade.ShopUpgrade
-}
toOwnedItems : Elm.Expression -> Elm.Expression
toOwnedItems toOwnedItemsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "ShopUpgrade" ]
             , name = "toOwnedItems"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "ShopUpgrade" ]
                              "ShopUpgradeRecord"
                              [ Type.bool ]
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "ShopUpgrade" ]
                                    "ShopUpgrade"
                                    []
                               )
                          )
                     )
             }
        )
        [ toOwnedItemsArg ]


{-| getStats: IdleGame.ShopUpgrade.ShopUpgrade -> IdleGame.ShopUpgrade.Stats -}
getStats : Elm.Expression -> Elm.Expression
getStats getStatsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "ShopUpgrade" ]
             , name = "getStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "ShopUpgrade" ]
                              "ShopUpgrade"
                              []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "ShopUpgrade" ]
                               "Stats"
                               []
                          )
                     )
             }
        )
        [ getStatsArg ]


{-| intervalMod: 
    IdleGame.ShopUpgrade.Activity
    -> Percent.Percent
    -> IdleGame.ShopUpgrade.IntervalMod
-}
intervalMod : Elm.Expression -> Elm.Expression -> Elm.Expression
intervalMod intervalModArg intervalModArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "ShopUpgrade" ]
             , name = "intervalMod"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "ShopUpgrade" ]
                              "Activity"
                              []
                          , Type.namedWith [ "Percent" ] "Percent" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "ShopUpgrade" ]
                               "IntervalMod"
                               []
                          )
                     )
             }
        )
        [ intervalModArg, intervalModArg0 ]


{-| allShopUpgrades: List IdleGame.ShopUpgrade.ShopUpgrade -}
allShopUpgrades : Elm.Expression
allShopUpgrades =
    Elm.value
        { importFrom = [ "IdleGame", "ShopUpgrade" ]
        , name = "allShopUpgrades"
        , annotation =
            Just
                (Type.list
                     (Type.namedWith
                          [ "IdleGame", "ShopUpgrade" ]
                          "ShopUpgrade"
                          []
                     )
                )
        }


annotation_ :
    { ownedItems : Type.Annotation
    , stats : Type.Annotation
    , reward : Type.Annotation
    }
annotation_ =
    { ownedItems =
        Type.alias
            moduleName_
            "OwnedItems"
            []
            (Type.namedWith
                 [ "IdleGame", "ShopUpgrade" ]
                 "ShopUpgradeRecord"
                 [ Type.bool ]
            )
    , stats =
        Type.alias
            moduleName_
            "Stats"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "icon"
                   , Type.namedWith [ "IdleGame", "Views", "Icon" ] "Icon" []
                   )
                 , ( "price", Type.namedWith [ "IdleGame", "Coin" ] "Coin" [] )
                 , ( "reward"
                   , Type.namedWith [ "IdleGame", "ShopUpgrade" ] "Reward" []
                   )
                 , ( "description", Type.string )
                 ]
            )
    , reward = Type.namedWith [ "IdleGame", "ShopUpgrade" ] "Reward" []
    }


make_ :
    { stats :
        { title : Elm.Expression
        , icon : Elm.Expression
        , price : Elm.Expression
        , reward : Elm.Expression
        , description : Elm.Expression
        }
        -> Elm.Expression
    , shopItemMod : Elm.Expression -> Elm.Expression
    , shopItemIntervalMod : Elm.Expression -> Elm.Expression
    }
make_ =
    { stats =
        \stats_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "ShopUpgrade" ]
                     "Stats"
                     []
                     (Type.record
                          [ ( "title", Type.string )
                          , ( "icon"
                            , Type.namedWith
                                  [ "IdleGame", "Views", "Icon" ]
                                  "Icon"
                                  []
                            )
                          , ( "price"
                            , Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                            )
                          , ( "reward"
                            , Type.namedWith
                                  [ "IdleGame", "ShopUpgrade" ]
                                  "Reward"
                                  []
                            )
                          , ( "description", Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "title" stats_args.title
                     , Tuple.pair "icon" stats_args.icon
                     , Tuple.pair "price" stats_args.price
                     , Tuple.pair "reward" stats_args.reward
                     , Tuple.pair "description" stats_args.description
                     ]
                )
    , shopItemMod =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "ShopUpgrade" ]
                     , name = "ShopItemMod"
                     , annotation = Just (Type.namedWith [] "Reward" [])
                     }
                )
                [ ar0 ]
    , shopItemIntervalMod =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "ShopUpgrade" ]
                     , name = "ShopItemIntervalMod"
                     , annotation = Just (Type.namedWith [] "Reward" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { reward :
        Elm.Expression
        -> { rewardTags_0_0
            | shopItemMod : Elm.Expression -> Elm.Expression
            , shopItemIntervalMod : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { reward =
        \rewardExpression rewardTags ->
            Elm.Case.custom
                rewardExpression
                (Type.namedWith [ "IdleGame", "ShopUpgrade" ] "Reward" [])
                [ Elm.Case.branch1
                    "ShopItemMod"
                    ( "listList"
                    , Type.list (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                    )
                    rewardTags.shopItemMod
                , Elm.Case.branch1
                    "ShopItemIntervalMod"
                    ( "listList"
                    , Type.list
                          (Type.namedWith
                               [ "IdleGame", "ShopUpgrade" ]
                               "IntervalMod"
                               []
                          )
                    )
                    rewardTags.shopItemIntervalMod
                ]
    }


call_ :
    { toOwnedItems : Elm.Expression -> Elm.Expression
    , getStats : Elm.Expression -> Elm.Expression
    , intervalMod : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { toOwnedItems =
        \toOwnedItemsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "ShopUpgrade" ]
                     , name = "toOwnedItems"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "ShopUpgrade" ]
                                      "ShopUpgradeRecord"
                                      [ Type.bool ]
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "ShopUpgrade" ]
                                            "ShopUpgrade"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ toOwnedItemsArg ]
    , getStats =
        \getStatsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "ShopUpgrade" ]
                     , name = "getStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "ShopUpgrade" ]
                                      "ShopUpgrade"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "ShopUpgrade" ]
                                       "Stats"
                                       []
                                  )
                             )
                     }
                )
                [ getStatsArg ]
    , intervalMod =
        \intervalModArg intervalModArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "ShopUpgrade" ]
                     , name = "intervalMod"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "ShopUpgrade" ]
                                      "Activity"
                                      []
                                  , Type.namedWith [ "Percent" ] "Percent" []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "ShopUpgrade" ]
                                       "IntervalMod"
                                       []
                                  )
                             )
                     }
                )
                [ intervalModArg, intervalModArg0 ]
    }


values_ :
    { glassesStats : Elm.Expression
    , toOwnedItems : Elm.Expression
    , getStats : Elm.Expression
    , intervalMod : Elm.Expression
    , allShopUpgrades : Elm.Expression
    }
values_ =
    { glassesStats =
        Elm.value
            { importFrom = [ "IdleGame", "ShopUpgrade" ]
            , name = "glassesStats"
            , annotation =
                Just (Type.namedWith [ "IdleGame", "ShopUpgrade" ] "Stats" [])
            }
    , toOwnedItems =
        Elm.value
            { importFrom = [ "IdleGame", "ShopUpgrade" ]
            , name = "toOwnedItems"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "ShopUpgrade" ]
                             "ShopUpgradeRecord"
                             [ Type.bool ]
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "ShopUpgrade" ]
                                   "ShopUpgrade"
                                   []
                              )
                         )
                    )
            }
    , getStats =
        Elm.value
            { importFrom = [ "IdleGame", "ShopUpgrade" ]
            , name = "getStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "ShopUpgrade" ]
                             "ShopUpgrade"
                             []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "ShopUpgrade" ]
                              "Stats"
                              []
                         )
                    )
            }
    , intervalMod =
        Elm.value
            { importFrom = [ "IdleGame", "ShopUpgrade" ]
            , name = "intervalMod"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "ShopUpgrade" ]
                             "Activity"
                             []
                         , Type.namedWith [ "Percent" ] "Percent" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "ShopUpgrade" ]
                              "IntervalMod"
                              []
                         )
                    )
            }
    , allShopUpgrades =
        Elm.value
            { importFrom = [ "IdleGame", "ShopUpgrade" ]
            , name = "allShopUpgrades"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith
                              [ "IdleGame", "ShopUpgrade" ]
                              "ShopUpgrade"
                              []
                         )
                    )
            }
    }