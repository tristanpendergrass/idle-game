module Gen.IdleGame.Game exposing (activityIsActive, addActivityTagToMods, addCoin, addMxp, addXp, adjustResource, annotation_, applyEffect, applyEffects, applyEvent, applyIntervalMods, attemptPurchaseResource, calculateActivityMxp, call_, caseOf_, combatReward, createDev, createProd, diff, getActivityListItems, getActivityMods, getAllIntervalMods, getAllMods, getMasteryIntervalMods, getMasteryRewards, getMaxPurchase, getModdedDuration, getPurchaseEffects, getShopItemIntervalMods, getShopItemMods, getTimePassesData, getToastForErr, make_, mapGeneratorResult, moduleName_, priceToPurchaseResource, probabilityGenerator, setActivity, setSeed, tick, toggleActivity, values_)

{-| 
@docs moduleName_, getMaxPurchase, getAllIntervalMods, getAllMods, addActivityTagToMods, getActivityMods, getMasteryRewards, getMasteryIntervalMods, getShopItemIntervalMods, getShopItemMods, getTimePassesData, diff, addCoin, adjustResource, addMxp, addXp, applyEffect, calculateActivityMxp, probabilityGenerator, mapGeneratorResult, applyEffects, getToastForErr, applyEvent, priceToPurchaseResource, setSeed, attemptPurchaseResource, getPurchaseEffects, tick, combatReward, getModdedDuration, applyIntervalMods, setActivity, activityIsActive, toggleActivity, getActivityListItems, createDev, createProd, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "Game" ]


{-| getMaxPurchase: IdleGame.Coin.Coin -> IdleGame.Game.Game -> Int -}
getMaxPurchase : Elm.Expression -> Elm.Expression -> Elm.Expression
getMaxPurchase getMaxPurchaseArg getMaxPurchaseArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getMaxPurchase"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          Type.int
                     )
             }
        )
        [ getMaxPurchaseArg, getMaxPurchaseArg0 ]


{-| getAllIntervalMods: IdleGame.Game.Game -> List IdleGame.Game.IntervalMod -}
getAllIntervalMods : Elm.Expression -> Elm.Expression
getAllIntervalMods getAllIntervalModsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getAllIntervalMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "IntervalMod"
                                    []
                               )
                          )
                     )
             }
        )
        [ getAllIntervalModsArg ]


{-| getAllMods: IdleGame.Game.Game -> List IdleGame.Mod.Mod -}
getAllMods : Elm.Expression -> Elm.Expression
getAllMods getAllModsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getAllMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                          (Type.list
                               (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          )
                     )
             }
        )
        [ getAllModsArg ]


{-| addActivityTagToMods: IdleGame.Game.Activity -> List IdleGame.Mod.Mod -> List IdleGame.Mod.Mod -}
addActivityTagToMods : Elm.Expression -> List Elm.Expression -> Elm.Expression
addActivityTagToMods addActivityTagToModsArg addActivityTagToModsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "addActivityTagToMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                          , Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          ]
                          (Type.list
                               (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          )
                     )
             }
        )
        [ addActivityTagToModsArg, Elm.list addActivityTagToModsArg0 ]


{-| getActivityMods: IdleGame.Game.Game -> List IdleGame.Mod.Mod -}
getActivityMods : Elm.Expression -> Elm.Expression
getActivityMods getActivityModsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getActivityMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                          (Type.list
                               (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          )
                     )
             }
        )
        [ getActivityModsArg ]


{-| getMasteryRewards: 
    IdleGame.Game.Game
    -> IdleGame.Game.Activity
    -> List IdleGame.Activity.MasteryReward
-}
getMasteryRewards : Elm.Expression -> Elm.Expression -> Elm.Expression
getMasteryRewards getMasteryRewardsArg getMasteryRewardsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getMasteryRewards"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "Activity" ]
                                    "MasteryReward"
                                    []
                               )
                          )
                     )
             }
        )
        [ getMasteryRewardsArg, getMasteryRewardsArg0 ]


{-| getMasteryIntervalMods: IdleGame.Game.Game -> List IdleGame.Game.IntervalMod -}
getMasteryIntervalMods : Elm.Expression -> Elm.Expression
getMasteryIntervalMods getMasteryIntervalModsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getMasteryIntervalMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "IntervalMod"
                                    []
                               )
                          )
                     )
             }
        )
        [ getMasteryIntervalModsArg ]


{-| getShopItemIntervalMods: IdleGame.Game.Game -> List IdleGame.Game.IntervalMod -}
getShopItemIntervalMods : Elm.Expression -> Elm.Expression
getShopItemIntervalMods getShopItemIntervalModsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getShopItemIntervalMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "IntervalMod"
                                    []
                               )
                          )
                     )
             }
        )
        [ getShopItemIntervalModsArg ]


{-| getShopItemMods: IdleGame.Game.Game -> List IdleGame.Mod.Mod -}
getShopItemMods : Elm.Expression -> Elm.Expression
getShopItemMods getShopItemModsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getShopItemMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                          (Type.list
                               (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          )
                     )
             }
        )
        [ getShopItemModsArg ]


{-| getTimePassesData: IdleGame.Game.Game -> IdleGame.Game.Game -> Maybe IdleGame.Game.TimePassesData -}
getTimePassesData : Elm.Expression -> Elm.Expression -> Elm.Expression
getTimePassesData getTimePassesDataArg getTimePassesDataArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getTimePassesData"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "TimePassesData"
                                    []
                               )
                          )
                     )
             }
        )
        [ getTimePassesDataArg, getTimePassesDataArg0 ]


{-| diff: List a -> List a -> List a -}
diff : List Elm.Expression -> List Elm.Expression -> Elm.Expression
diff diffArg diffArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "diff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list (Type.var "a"), Type.list (Type.var "a") ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ Elm.list diffArg, Elm.list diffArg0 ]


{-| addCoin: 
    IdleGame.Coin.Coin
    -> IdleGame.Game.Game
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectValue
-}
addCoin : Elm.Expression -> Elm.Expression -> Elm.Expression
addCoin addCoinArg addCoinArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "addCoin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "Result" ]
                               "Result"
                               [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                               , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectValue"
                                   []
                               ]
                          )
                     )
             }
        )
        [ addCoinArg, addCoinArg0 ]


{-| adjustResource: 
    IdleGame.Game.Resource
    -> Int
    -> IdleGame.Game.Game
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectValue
-}
adjustResource : Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
adjustResource adjustResourceArg adjustResourceArg0 adjustResourceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "adjustResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Resource" []
                          , Type.int
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "Result" ]
                               "Result"
                               [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                               , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectValue"
                                   []
                               ]
                          )
                     )
             }
        )
        [ adjustResourceArg, Elm.int adjustResourceArg0, adjustResourceArg1 ]


{-| addMxp: 
    IdleGame.Game.Activity
    -> IdleGame.Xp.Xp
    -> IdleGame.Game.Game
    -> IdleGame.Game.Game
-}
addMxp : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
addMxp addMxpArg addMxpArg0 addMxpArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "addMxp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                          , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                     )
             }
        )
        [ addMxpArg, addMxpArg0, addMxpArg1 ]


{-| addXp: 
    IdleGame.Game.Skill
    -> IdleGame.Xp.Xp
    -> IdleGame.Game.Game
    -> IdleGame.Game.Game
-}
addXp : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
addXp addXpArg addXpArg0 addXpArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "addXp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Skill" []
                          , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                     )
             }
        )
        [ addXpArg, addXpArg0, addXpArg1 ]


{-| applyEffect: 
    IdleGame.Effect.Effect
    -> Int
    -> IdleGame.Game.Game
    -> IdleGame.Game.ApplyEffectResultGenerator
-}
applyEffect : Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
applyEffect applyEffectArg applyEffectArg0 applyEffectArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "applyEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                          , Type.int
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game" ]
                               "ApplyEffectResultGenerator"
                               []
                          )
                     )
             }
        )
        [ applyEffectArg, Elm.int applyEffectArg0, applyEffectArg1 ]


{-| calculateActivityMxp: IdleGame.Game.Activity -> IdleGame.Game.Game -> IdleGame.Xp.Xp -}
calculateActivityMxp : Elm.Expression -> Elm.Expression -> Elm.Expression
calculateActivityMxp calculateActivityMxpArg calculateActivityMxpArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "calculateActivityMxp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith [ "IdleGame", "Xp" ] "Xp" [])
                     )
             }
        )
        [ calculateActivityMxpArg, calculateActivityMxpArg0 ]


{-| probabilityGenerator: Percent.Percent -> Random.Generator Bool -}
probabilityGenerator : Elm.Expression -> Elm.Expression
probabilityGenerator probabilityGeneratorArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "probabilityGenerator"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Percent" ] "Percent" [] ]
                          (Type.namedWith [ "Random" ] "Generator" [ Type.bool ]
                          )
                     )
             }
        )
        [ probabilityGeneratorArg ]


{-| mapGeneratorResult: 
    (a -> Random.Generator (Result.Result e a))
    -> Random.Generator (Result.Result e a)
    -> Random.Generator (Result.Result e a)
-}
mapGeneratorResult :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapGeneratorResult mapGeneratorResultArg mapGeneratorResultArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "mapGeneratorResult"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "Random" ]
                                 "Generator"
                                 [ Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.var "e", Type.var "a" ]
                                 ]
                              )
                          , Type.namedWith
                              [ "Random" ]
                              "Generator"
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "e", Type.var "a" ]
                              ]
                          ]
                          (Type.namedWith
                               [ "Random" ]
                               "Generator"
                               [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "e", Type.var "a" ]
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapGeneratorResultUnpack" mapGeneratorResultArg
        , mapGeneratorResultArg0
        ]


{-| applyEffects: 
    List IdleGame.Mod.Mod
    -> List IdleGame.Effect.Effect
    -> Int
    -> IdleGame.Game.Game
    -> IdleGame.Game.ApplyEffectsResultGenerator
-}
applyEffects :
    List Elm.Expression
    -> List Elm.Expression
    -> Int
    -> Elm.Expression
    -> Elm.Expression
applyEffects applyEffectsArg applyEffectsArg0 applyEffectsArg1 applyEffectsArg2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "applyEffects"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          , Type.list
                              (Type.namedWith
                                 [ "IdleGame", "Effect" ]
                                 "Effect"
                                 []
                              )
                          , Type.int
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "IdleGame", "Game" ]
                               "ApplyEffectsResultGenerator"
                               []
                          )
                     )
             }
        )
        [ Elm.list applyEffectsArg
        , Elm.list applyEffectsArg0
        , Elm.int applyEffectsArg1
        , applyEffectsArg2
        ]


{-| getToastForErr: IdleGame.EffectErr.EffectErr -> IdleGame.Game.Toast -}
getToastForErr : Elm.Expression -> Elm.Expression
getToastForErr getToastForErrArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getToastForErr"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "IdleGame", "EffectErr" ]
                              "EffectErr"
                              []
                          ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Toast" [])
                     )
             }
        )
        [ getToastForErrArg ]


{-| applyEvent: 
    List IdleGame.Mod.Mod
    -> IdleGame.Game.Event
    -> Random.Generator ( IdleGame.Game.Game, List IdleGame.Game.Toast )
    -> Random.Generator ( IdleGame.Game.Game, List IdleGame.Game.Toast )
-}
applyEvent :
    List Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
applyEvent applyEventArg applyEventArg0 applyEventArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "applyEvent"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                          , Type.namedWith [ "IdleGame", "Game" ] "Event" []
                          , Type.namedWith
                              [ "Random" ]
                              "Generator"
                              [ Type.tuple
                                    (Type.namedWith
                                         [ "IdleGame", "Game" ]
                                         "Game"
                                         []
                                    )
                                    (Type.list
                                         (Type.namedWith
                                              [ "IdleGame", "Game" ]
                                              "Toast"
                                              []
                                         )
                                    )
                              ]
                          ]
                          (Type.namedWith
                               [ "Random" ]
                               "Generator"
                               [ Type.tuple
                                   (Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                   )
                                   (Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Game" ]
                                         "Toast"
                                         []
                                      )
                                   )
                               ]
                          )
                     )
             }
        )
        [ Elm.list applyEventArg, applyEventArg0, applyEventArg1 ]


{-| priceToPurchaseResource: 
    Int
    -> ( IdleGame.Game.Resource, IdleGame.Coin.Coin )
    -> IdleGame.Game.Game
    -> IdleGame.Coin.Coin
-}
priceToPurchaseResource :
    Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
priceToPurchaseResource priceToPurchaseResourceArg priceToPurchaseResourceArg0 priceToPurchaseResourceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "priceToPurchaseResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.tuple
                              (Type.namedWith
                                 [ "IdleGame", "Game" ]
                                 "Resource"
                                 []
                              )
                              (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                     )
             }
        )
        [ Elm.int priceToPurchaseResourceArg
        , priceToPurchaseResourceArg0
        , priceToPurchaseResourceArg1
        ]


{-| setSeed: Random.Seed -> IdleGame.Game.Game -> IdleGame.Game.Game -}
setSeed : Elm.Expression -> Elm.Expression -> Elm.Expression
setSeed setSeedArg setSeedArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "setSeed"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Random" ] "Seed" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                     )
             }
        )
        [ setSeedArg, setSeedArg0 ]


{-| attemptPurchaseResource: 
    Int
    -> IdleGame.Game.Resource
    -> IdleGame.Game.Game
    -> Result.Result IdleGame.EffectErr.EffectErr IdleGame.Game.ApplyEffectsValue
-}
attemptPurchaseResource :
    Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
attemptPurchaseResource attemptPurchaseResourceArg attemptPurchaseResourceArg0 attemptPurchaseResourceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "attemptPurchaseResource"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith [ "IdleGame", "Game" ] "Resource" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith
                               [ "Result" ]
                               "Result"
                               [ Type.namedWith
                                   [ "IdleGame", "EffectErr" ]
                                   "EffectErr"
                                   []
                               , Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ApplyEffectsValue"
                                   []
                               ]
                          )
                     )
             }
        )
        [ Elm.int attemptPurchaseResourceArg
        , attemptPurchaseResourceArg0
        , attemptPurchaseResourceArg1
        ]


{-| getPurchaseEffects: Int -> IdleGame.Game.Resource -> List IdleGame.Effect.Effect -}
getPurchaseEffects : Int -> Elm.Expression -> Elm.Expression
getPurchaseEffects getPurchaseEffectsArg getPurchaseEffectsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getPurchaseEffects"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith [ "IdleGame", "Game" ] "Resource" []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "Effect" ]
                                    "Effect"
                                    []
                               )
                          )
                     )
             }
        )
        [ Elm.int getPurchaseEffectsArg, getPurchaseEffectsArg0 ]


{-| tick: 
    Duration.Duration
    -> IdleGame.Game.Game
    -> ( IdleGame.Game.Game, List IdleGame.Game.Toast )
-}
tick : Elm.Expression -> Elm.Expression -> Elm.Expression
tick tickArg tickArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "tick"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Duration" ] "Duration" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                               (Type.list
                                    (Type.namedWith
                                         [ "IdleGame", "Game" ]
                                         "Toast"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ tickArg, tickArg0 ]


{-| combatReward: List IdleGame.Effect.Effect -}
combatReward : Elm.Expression
combatReward =
    Elm.value
        { importFrom = [ "IdleGame", "Game" ]
        , name = "combatReward"
        , annotation =
            Just
                (Type.list (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                )
        }


{-| getModdedDuration: IdleGame.Game.Game -> IdleGame.Game.Activity -> Duration.Duration -}
getModdedDuration : Elm.Expression -> Elm.Expression -> Elm.Expression
getModdedDuration getModdedDurationArg getModdedDurationArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getModdedDuration"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                          ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ getModdedDurationArg, getModdedDurationArg0 ]


{-| applyIntervalMods: List IdleGame.Game.IntervalMod -> Duration.Duration -> Duration.Duration -}
applyIntervalMods : List Elm.Expression -> Elm.Expression -> Elm.Expression
applyIntervalMods applyIntervalModsArg applyIntervalModsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "applyIntervalMods"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "IdleGame", "Game" ]
                                 "IntervalMod"
                                 []
                              )
                          , Type.namedWith [ "Duration" ] "Duration" []
                          ]
                          (Type.namedWith [ "Duration" ] "Duration" [])
                     )
             }
        )
        [ Elm.list applyIntervalModsArg, applyIntervalModsArg0 ]


{-| setActivity: 
    Maybe ( IdleGame.Game.Activity, IdleGame.Timer.Timer )
    -> IdleGame.Game.Game
    -> IdleGame.Game.Game
-}
setActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
setActivity setActivityArg setActivityArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "setActivity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe
                              (Type.tuple
                                 (Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "Activity"
                                    []
                                 )
                                 (Type.namedWith
                                    [ "IdleGame", "Timer" ]
                                    "Timer"
                                    []
                                 )
                              )
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                     )
             }
        )
        [ setActivityArg, setActivityArg0 ]


{-| activityIsActive: IdleGame.Game.Activity -> IdleGame.Game.Game -> Bool -}
activityIsActive : Elm.Expression -> Elm.Expression -> Elm.Expression
activityIsActive activityIsActiveArg activityIsActiveArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "activityIsActive"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          Type.bool
                     )
             }
        )
        [ activityIsActiveArg, activityIsActiveArg0 ]


{-| toggleActivity: IdleGame.Game.Activity -> IdleGame.Game.Game -> IdleGame.Game.Game -}
toggleActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
toggleActivity toggleActivityArg toggleActivityArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "toggleActivity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                     )
             }
        )
        [ toggleActivityArg, toggleActivityArg0 ]


{-| getActivityListItems: IdleGame.Game.Skill -> IdleGame.Game.Game -> List IdleGame.Game.ActivityListItem -}
getActivityListItems : Elm.Expression -> Elm.Expression -> Elm.Expression
getActivityListItems getActivityListItemsArg getActivityListItemsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "getActivityListItems"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "IdleGame", "Game" ] "Skill" []
                          , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "IdleGame", "Game" ]
                                    "ActivityListItem"
                                    []
                               )
                          )
                     )
             }
        )
        [ getActivityListItemsArg, getActivityListItemsArg0 ]


{-| createDev: Random.Seed -> IdleGame.Game.Game -}
createDev : Elm.Expression -> Elm.Expression
createDev createDevArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "createDev"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Random" ] "Seed" [] ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                     )
             }
        )
        [ createDevArg ]


{-| createProd: Random.Seed -> IdleGame.Game.Game -}
createProd : Elm.Expression -> Elm.Expression
createProd createProdArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "IdleGame", "Game" ]
             , name = "createProd"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Random" ] "Seed" [] ]
                          (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                     )
             }
        )
        [ createProdArg ]


annotation_ :
    { applyEffectResultGenerator : Type.Annotation
    , applyEffectValue : Type.Annotation
    , applyEffectsResultGenerator : Type.Annotation
    , applyEffectsValue : Type.Annotation
    , event : Type.Annotation
    , activityStatus : Type.Annotation
    , activityListItem : Type.Annotation
    }
annotation_ =
    { applyEffectResultGenerator =
        Type.alias
            moduleName_
            "ApplyEffectResultGenerator"
            []
            (Type.namedWith
                 [ "Random" ]
                 "Generator"
                 [ Type.namedWith
                     [ "Result" ]
                     "Result"
                     [ Type.namedWith [ "IdleGame", "EffectErr" ] "EffectErr" []
                     , Type.namedWith
                           [ "IdleGame", "Game" ]
                           "ApplyEffectValue"
                           []
                     ]
                 ]
            )
    , applyEffectValue =
        Type.alias
            moduleName_
            "ApplyEffectValue"
            []
            (Type.record
                 [ ( "game", Type.namedWith [ "IdleGame", "Game" ] "Game" [] )
                 , ( "toasts"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Game" ] "Toast" [])
                   )
                 , ( "additionalEffects"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                   )
                 , ( "additionalMods"
                   , Type.list (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                   )
                 ]
            )
    , applyEffectsResultGenerator =
        Type.alias
            moduleName_
            "ApplyEffectsResultGenerator"
            []
            (Type.namedWith
                 [ "Random" ]
                 "Generator"
                 [ Type.namedWith
                     [ "Result" ]
                     "Result"
                     [ Type.namedWith [ "IdleGame", "EffectErr" ] "EffectErr" []
                     , Type.namedWith
                           [ "IdleGame", "Game" ]
                           "ApplyEffectsValue"
                           []
                     ]
                 ]
            )
    , applyEffectsValue =
        Type.alias
            moduleName_
            "ApplyEffectsValue"
            []
            (Type.record
                 [ ( "game", Type.namedWith [ "IdleGame", "Game" ] "Game" [] )
                 , ( "toasts"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Game" ] "Toast" [])
                   )
                 ]
            )
    , event =
        Type.alias
            moduleName_
            "Event"
            []
            (Type.record
                 [ ( "effects"
                   , Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                   )
                 , ( "count", Type.int )
                 ]
            )
    , activityStatus =
        Type.alias
            moduleName_
            "ActivityStatus"
            []
            (Type.maybe (Type.namedWith [ "IdleGame", "Timer" ] "Timer" []))
    , activityListItem =
        Type.namedWith [ "IdleGame", "Game" ] "ActivityListItem" []
    }


make_ :
    { applyEffectValue :
        { game : Elm.Expression
        , toasts : Elm.Expression
        , additionalEffects : Elm.Expression
        , additionalMods : Elm.Expression
        }
        -> Elm.Expression
    , applyEffectsValue :
        { game : Elm.Expression, toasts : Elm.Expression } -> Elm.Expression
    , event :
        { effects : Elm.Expression, count : Elm.Expression } -> Elm.Expression
    , lockedActivity : Elm.Expression -> Elm.Expression
    , activityListItem : Elm.Expression -> Elm.Expression
    }
make_ =
    { applyEffectValue =
        \applyEffectValue_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Game" ]
                     "ApplyEffectValue"
                     []
                     (Type.record
                          [ ( "game"
                            , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                            )
                          , ( "toasts"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Toast"
                                       []
                                  )
                            )
                          , ( "additionalEffects"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                            )
                          , ( "additionalMods"
                            , Type.list
                                  (Type.namedWith [ "IdleGame", "Mod" ] "Mod" []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "game" applyEffectValue_args.game
                     , Tuple.pair "toasts" applyEffectValue_args.toasts
                     , Tuple.pair
                         "additionalEffects"
                         applyEffectValue_args.additionalEffects
                     , Tuple.pair
                         "additionalMods"
                         applyEffectValue_args.additionalMods
                     ]
                )
    , applyEffectsValue =
        \applyEffectsValue_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Game" ]
                     "ApplyEffectsValue"
                     []
                     (Type.record
                          [ ( "game"
                            , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                            )
                          , ( "toasts"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Toast"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "game" applyEffectsValue_args.game
                     , Tuple.pair "toasts" applyEffectsValue_args.toasts
                     ]
                )
    , event =
        \event_args ->
            Elm.withType
                (Type.alias
                     [ "IdleGame", "Game" ]
                     "Event"
                     []
                     (Type.record
                          [ ( "effects"
                            , Type.list
                                  (Type.namedWith
                                       [ "IdleGame", "Effect" ]
                                       "Effect"
                                       []
                                  )
                            )
                          , ( "count", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "effects" event_args.effects
                     , Tuple.pair "count" event_args.count
                     ]
                )
    , lockedActivity =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "LockedActivity"
                     , annotation =
                         Just (Type.namedWith [] "ActivityListItem" [])
                     }
                )
                [ ar0 ]
    , activityListItem =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "ActivityListItem"
                     , annotation =
                         Just (Type.namedWith [] "ActivityListItem" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { activityListItem :
        Elm.Expression
        -> { activityListItemTags_0_0
            | lockedActivity : Elm.Expression -> Elm.Expression
            , activityListItem : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { activityListItem =
        \activityListItemExpression activityListItemTags ->
            Elm.Case.custom
                activityListItemExpression
                (Type.namedWith [ "IdleGame", "Game" ] "ActivityListItem" [])
                [ Elm.Case.branch1
                    "LockedActivity"
                    ( "one"
                    , Type.tuple
                          (Type.namedWith [ "IdleGame", "Game" ] "Skill" [])
                          Type.int
                    )
                    activityListItemTags.lockedActivity
                , Elm.Case.branch1
                    "ActivityListItem"
                    ( "idleGameGameActivity"
                    , Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                    )
                    activityListItemTags.activityListItem
                ]
    }


call_ :
    { getMaxPurchase : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getAllIntervalMods : Elm.Expression -> Elm.Expression
    , getAllMods : Elm.Expression -> Elm.Expression
    , addActivityTagToMods : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getActivityMods : Elm.Expression -> Elm.Expression
    , getMasteryRewards : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getMasteryIntervalMods : Elm.Expression -> Elm.Expression
    , getShopItemIntervalMods : Elm.Expression -> Elm.Expression
    , getShopItemMods : Elm.Expression -> Elm.Expression
    , getTimePassesData : Elm.Expression -> Elm.Expression -> Elm.Expression
    , diff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , addCoin : Elm.Expression -> Elm.Expression -> Elm.Expression
    , adjustResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , addMxp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , addXp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , applyEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , calculateActivityMxp : Elm.Expression -> Elm.Expression -> Elm.Expression
    , probabilityGenerator : Elm.Expression -> Elm.Expression
    , mapGeneratorResult : Elm.Expression -> Elm.Expression -> Elm.Expression
    , applyEffects :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , getToastForErr : Elm.Expression -> Elm.Expression
    , applyEvent :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , priceToPurchaseResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , setSeed : Elm.Expression -> Elm.Expression -> Elm.Expression
    , attemptPurchaseResource :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getPurchaseEffects : Elm.Expression -> Elm.Expression -> Elm.Expression
    , tick : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getModdedDuration : Elm.Expression -> Elm.Expression -> Elm.Expression
    , applyIntervalMods : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
    , activityIsActive : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toggleActivity : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getActivityListItems : Elm.Expression -> Elm.Expression -> Elm.Expression
    , createDev : Elm.Expression -> Elm.Expression
    , createProd : Elm.Expression -> Elm.Expression
    }
call_ =
    { getMaxPurchase =
        \getMaxPurchaseArg getMaxPurchaseArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getMaxPurchase"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Coin" ]
                                      "Coin"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ getMaxPurchaseArg, getMaxPurchaseArg0 ]
    , getAllIntervalMods =
        \getAllIntervalModsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getAllIntervalMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "IntervalMod"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getAllIntervalModsArg ]
    , getAllMods =
        \getAllModsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getAllMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Mod" ]
                                            "Mod"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getAllModsArg ]
    , addActivityTagToMods =
        \addActivityTagToModsArg addActivityTagToModsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "addActivityTagToMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Activity"
                                      []
                                  , Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Mod" ]
                                         "Mod"
                                         []
                                      )
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Mod" ]
                                            "Mod"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ addActivityTagToModsArg, addActivityTagToModsArg0 ]
    , getActivityMods =
        \getActivityModsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getActivityMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Mod" ]
                                            "Mod"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getActivityModsArg ]
    , getMasteryRewards =
        \getMasteryRewardsArg getMasteryRewardsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getMasteryRewards"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Activity" ]
                                            "MasteryReward"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getMasteryRewardsArg, getMasteryRewardsArg0 ]
    , getMasteryIntervalMods =
        \getMasteryIntervalModsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getMasteryIntervalMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "IntervalMod"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getMasteryIntervalModsArg ]
    , getShopItemIntervalMods =
        \getShopItemIntervalModsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getShopItemIntervalMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "IntervalMod"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getShopItemIntervalModsArg ]
    , getShopItemMods =
        \getShopItemModsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getShopItemMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Mod" ]
                                            "Mod"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getShopItemModsArg ]
    , getTimePassesData =
        \getTimePassesDataArg getTimePassesDataArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getTimePassesData"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "TimePassesData"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getTimePassesDataArg, getTimePassesDataArg0 ]
    , diff =
        \diffArg diffArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "diff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list (Type.var "a")
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ diffArg, diffArg0 ]
    , addCoin =
        \addCoinArg addCoinArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "addCoin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Coin" ]
                                      "Coin"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.namedWith
                                           [ "IdleGame", "EffectErr" ]
                                           "EffectErr"
                                           []
                                       , Type.namedWith
                                           [ "IdleGame", "Game" ]
                                           "ApplyEffectValue"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ addCoinArg, addCoinArg0 ]
    , adjustResource =
        \adjustResourceArg adjustResourceArg0 adjustResourceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "adjustResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Resource"
                                      []
                                  , Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.namedWith
                                           [ "IdleGame", "EffectErr" ]
                                           "EffectErr"
                                           []
                                       , Type.namedWith
                                           [ "IdleGame", "Game" ]
                                           "ApplyEffectValue"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ adjustResourceArg, adjustResourceArg0, adjustResourceArg1 ]
    , addMxp =
        \addMxpArg addMxpArg0 addMxpArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "addMxp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Activity"
                                      []
                                  , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Game"
                                       []
                                  )
                             )
                     }
                )
                [ addMxpArg, addMxpArg0, addMxpArg1 ]
    , addXp =
        \addXpArg addXpArg0 addXpArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "addXp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Skill"
                                      []
                                  , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Game"
                                       []
                                  )
                             )
                     }
                )
                [ addXpArg, addXpArg0, addXpArg1 ]
    , applyEffect =
        \applyEffectArg applyEffectArg0 applyEffectArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "applyEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Effect" ]
                                      "Effect"
                                      []
                                  , Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "ApplyEffectResultGenerator"
                                       []
                                  )
                             )
                     }
                )
                [ applyEffectArg, applyEffectArg0, applyEffectArg1 ]
    , calculateActivityMxp =
        \calculateActivityMxpArg calculateActivityMxpArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "calculateActivityMxp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Activity"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith [ "IdleGame", "Xp" ] "Xp" [])
                             )
                     }
                )
                [ calculateActivityMxpArg, calculateActivityMxpArg0 ]
    , probabilityGenerator =
        \probabilityGeneratorArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "probabilityGenerator"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Percent" ] "Percent" [] ]
                                  (Type.namedWith
                                       [ "Random" ]
                                       "Generator"
                                       [ Type.bool ]
                                  )
                             )
                     }
                )
                [ probabilityGeneratorArg ]
    , mapGeneratorResult =
        \mapGeneratorResultArg mapGeneratorResultArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "mapGeneratorResult"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "Random" ]
                                         "Generator"
                                         [ Type.namedWith
                                               [ "Result" ]
                                               "Result"
                                               [ Type.var "e", Type.var "a" ]
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Random" ]
                                      "Generator"
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "e", Type.var "a" ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Random" ]
                                       "Generator"
                                       [ Type.namedWith
                                           [ "Result" ]
                                           "Result"
                                           [ Type.var "e", Type.var "a" ]
                                       ]
                                  )
                             )
                     }
                )
                [ mapGeneratorResultArg, mapGeneratorResultArg0 ]
    , applyEffects =
        \applyEffectsArg applyEffectsArg0 applyEffectsArg1 applyEffectsArg2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "applyEffects"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Mod" ]
                                         "Mod"
                                         []
                                      )
                                  , Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Effect" ]
                                         "Effect"
                                         []
                                      )
                                  , Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "ApplyEffectsResultGenerator"
                                       []
                                  )
                             )
                     }
                )
                [ applyEffectsArg
                , applyEffectsArg0
                , applyEffectsArg1
                , applyEffectsArg2
                ]
    , getToastForErr =
        \getToastForErrArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getToastForErr"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "EffectErr" ]
                                      "EffectErr"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Toast"
                                       []
                                  )
                             )
                     }
                )
                [ getToastForErrArg ]
    , applyEvent =
        \applyEventArg applyEventArg0 applyEventArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "applyEvent"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Mod" ]
                                         "Mod"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Event"
                                      []
                                  , Type.namedWith
                                      [ "Random" ]
                                      "Generator"
                                      [ Type.tuple
                                            (Type.namedWith
                                                 [ "IdleGame", "Game" ]
                                                 "Game"
                                                 []
                                            )
                                            (Type.list
                                                 (Type.namedWith
                                                      [ "IdleGame", "Game" ]
                                                      "Toast"
                                                      []
                                                 )
                                            )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Random" ]
                                       "Generator"
                                       [ Type.tuple
                                           (Type.namedWith
                                              [ "IdleGame", "Game" ]
                                              "Game"
                                              []
                                           )
                                           (Type.list
                                              (Type.namedWith
                                                 [ "IdleGame", "Game" ]
                                                 "Toast"
                                                 []
                                              )
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ applyEventArg, applyEventArg0, applyEventArg1 ]
    , priceToPurchaseResource =
        \priceToPurchaseResourceArg priceToPurchaseResourceArg0 priceToPurchaseResourceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "priceToPurchaseResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.tuple
                                      (Type.namedWith
                                         [ "IdleGame", "Game" ]
                                         "Resource"
                                         []
                                      )
                                      (Type.namedWith
                                         [ "IdleGame", "Coin" ]
                                         "Coin"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Coin" ]
                                       "Coin"
                                       []
                                  )
                             )
                     }
                )
                [ priceToPurchaseResourceArg
                , priceToPurchaseResourceArg0
                , priceToPurchaseResourceArg1
                ]
    , setSeed =
        \setSeedArg setSeedArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "setSeed"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Random" ] "Seed" []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Game"
                                       []
                                  )
                             )
                     }
                )
                [ setSeedArg, setSeedArg0 ]
    , attemptPurchaseResource =
        \attemptPurchaseResourceArg attemptPurchaseResourceArg0 attemptPurchaseResourceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "attemptPurchaseResource"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Resource"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.namedWith
                                           [ "IdleGame", "EffectErr" ]
                                           "EffectErr"
                                           []
                                       , Type.namedWith
                                           [ "IdleGame", "Game" ]
                                           "ApplyEffectsValue"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ attemptPurchaseResourceArg
                , attemptPurchaseResourceArg0
                , attemptPurchaseResourceArg1
                ]
    , getPurchaseEffects =
        \getPurchaseEffectsArg getPurchaseEffectsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getPurchaseEffects"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Resource"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Effect" ]
                                            "Effect"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getPurchaseEffectsArg, getPurchaseEffectsArg0 ]
    , tick =
        \tickArg tickArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "tick"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Duration" ] "Duration" []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "Game"
                                            []
                                       )
                                       (Type.list
                                            (Type.namedWith
                                                 [ "IdleGame", "Game" ]
                                                 "Toast"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ tickArg, tickArg0 ]
    , getModdedDuration =
        \getModdedDurationArg getModdedDurationArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getModdedDuration"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Activity"
                                      []
                                  ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ getModdedDurationArg, getModdedDurationArg0 ]
    , applyIntervalMods =
        \applyIntervalModsArg applyIntervalModsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "applyIntervalMods"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "IdleGame", "Game" ]
                                         "IntervalMod"
                                         []
                                      )
                                  , Type.namedWith [ "Duration" ] "Duration" []
                                  ]
                                  (Type.namedWith [ "Duration" ] "Duration" [])
                             )
                     }
                )
                [ applyIntervalModsArg, applyIntervalModsArg0 ]
    , setActivity =
        \setActivityArg setActivityArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "setActivity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe
                                      (Type.tuple
                                         (Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "Activity"
                                            []
                                         )
                                         (Type.namedWith
                                            [ "IdleGame", "Timer" ]
                                            "Timer"
                                            []
                                         )
                                      )
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Game"
                                       []
                                  )
                             )
                     }
                )
                [ setActivityArg, setActivityArg0 ]
    , activityIsActive =
        \activityIsActiveArg activityIsActiveArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "activityIsActive"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Activity"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ activityIsActiveArg, activityIsActiveArg0 ]
    , toggleActivity =
        \toggleActivityArg toggleActivityArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "toggleActivity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Activity"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Game"
                                       []
                                  )
                             )
                     }
                )
                [ toggleActivityArg, toggleActivityArg0 ]
    , getActivityListItems =
        \getActivityListItemsArg getActivityListItemsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "getActivityListItems"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Skill"
                                      []
                                  , Type.namedWith
                                      [ "IdleGame", "Game" ]
                                      "Game"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "IdleGame", "Game" ]
                                            "ActivityListItem"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getActivityListItemsArg, getActivityListItemsArg0 ]
    , createDev =
        \createDevArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "createDev"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Random" ] "Seed" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Game"
                                       []
                                  )
                             )
                     }
                )
                [ createDevArg ]
    , createProd =
        \createProdArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "IdleGame", "Game" ]
                     , name = "createProd"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Random" ] "Seed" [] ]
                                  (Type.namedWith
                                       [ "IdleGame", "Game" ]
                                       "Game"
                                       []
                                  )
                             )
                     }
                )
                [ createProdArg ]
    }


values_ :
    { getMaxPurchase : Elm.Expression
    , getAllIntervalMods : Elm.Expression
    , getAllMods : Elm.Expression
    , addActivityTagToMods : Elm.Expression
    , getActivityMods : Elm.Expression
    , getMasteryRewards : Elm.Expression
    , getMasteryIntervalMods : Elm.Expression
    , getShopItemIntervalMods : Elm.Expression
    , getShopItemMods : Elm.Expression
    , getTimePassesData : Elm.Expression
    , diff : Elm.Expression
    , addCoin : Elm.Expression
    , adjustResource : Elm.Expression
    , addMxp : Elm.Expression
    , addXp : Elm.Expression
    , applyEffect : Elm.Expression
    , calculateActivityMxp : Elm.Expression
    , probabilityGenerator : Elm.Expression
    , mapGeneratorResult : Elm.Expression
    , applyEffects : Elm.Expression
    , getToastForErr : Elm.Expression
    , applyEvent : Elm.Expression
    , priceToPurchaseResource : Elm.Expression
    , setSeed : Elm.Expression
    , attemptPurchaseResource : Elm.Expression
    , getPurchaseEffects : Elm.Expression
    , tick : Elm.Expression
    , combatReward : Elm.Expression
    , getModdedDuration : Elm.Expression
    , applyIntervalMods : Elm.Expression
    , setActivity : Elm.Expression
    , activityIsActive : Elm.Expression
    , toggleActivity : Elm.Expression
    , getActivityListItems : Elm.Expression
    , createDev : Elm.Expression
    , createProd : Elm.Expression
    }
values_ =
    { getMaxPurchase =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getMaxPurchase"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         Type.int
                    )
            }
    , getAllIntervalMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getAllIntervalMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "IntervalMod"
                                   []
                              )
                         )
                    )
            }
    , getAllMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getAllMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                         (Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         )
                    )
            }
    , addActivityTagToMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "addActivityTagToMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                         , Type.list
                             (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         ]
                         (Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         )
                    )
            }
    , getActivityMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getActivityMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                         (Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         )
                    )
            }
    , getMasteryRewards =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getMasteryRewards"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "Activity" ]
                                   "MasteryReward"
                                   []
                              )
                         )
                    )
            }
    , getMasteryIntervalMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getMasteryIntervalMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "IntervalMod"
                                   []
                              )
                         )
                    )
            }
    , getShopItemIntervalMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getShopItemIntervalMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "IntervalMod"
                                   []
                              )
                         )
                    )
            }
    , getShopItemMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getShopItemMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" [] ]
                         (Type.list
                              (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         )
                    )
            }
    , getTimePassesData =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getTimePassesData"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "TimePassesData"
                                   []
                              )
                         )
                    )
            }
    , diff =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "diff"
            , annotation =
                Just
                    (Type.function
                         [ Type.list (Type.var "a"), Type.list (Type.var "a") ]
                         (Type.list (Type.var "a"))
                    )
            }
    , addCoin =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "addCoin"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Coin" ] "Coin" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                  [ "IdleGame", "EffectErr" ]
                                  "EffectErr"
                                  []
                              , Type.namedWith
                                  [ "IdleGame", "Game" ]
                                  "ApplyEffectValue"
                                  []
                              ]
                         )
                    )
            }
    , adjustResource =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "adjustResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Resource" []
                         , Type.int
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                  [ "IdleGame", "EffectErr" ]
                                  "EffectErr"
                                  []
                              , Type.namedWith
                                  [ "IdleGame", "Game" ]
                                  "ApplyEffectValue"
                                  []
                              ]
                         )
                    )
            }
    , addMxp =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "addMxp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                         , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                    )
            }
    , addXp =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "addXp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Skill" []
                         , Type.namedWith [ "IdleGame", "Xp" ] "Xp" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                    )
            }
    , applyEffect =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "applyEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Effect" ] "Effect" []
                         , Type.int
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game" ]
                              "ApplyEffectResultGenerator"
                              []
                         )
                    )
            }
    , calculateActivityMxp =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "calculateActivityMxp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith [ "IdleGame", "Xp" ] "Xp" [])
                    )
            }
    , probabilityGenerator =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "probabilityGenerator"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Percent" ] "Percent" [] ]
                         (Type.namedWith [ "Random" ] "Generator" [ Type.bool ])
                    )
            }
    , mapGeneratorResult =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "mapGeneratorResult"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "Random" ]
                                "Generator"
                                [ Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.var "e", Type.var "a" ]
                                ]
                             )
                         , Type.namedWith
                             [ "Random" ]
                             "Generator"
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "e", Type.var "a" ]
                             ]
                         ]
                         (Type.namedWith
                              [ "Random" ]
                              "Generator"
                              [ Type.namedWith
                                  [ "Result" ]
                                  "Result"
                                  [ Type.var "e", Type.var "a" ]
                              ]
                         )
                    )
            }
    , applyEffects =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "applyEffects"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         , Type.list
                             (Type.namedWith
                                [ "IdleGame", "Effect" ]
                                "Effect"
                                []
                             )
                         , Type.int
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "IdleGame", "Game" ]
                              "ApplyEffectsResultGenerator"
                              []
                         )
                    )
            }
    , getToastForErr =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getToastForErr"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "IdleGame", "EffectErr" ]
                             "EffectErr"
                             []
                         ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Toast" [])
                    )
            }
    , applyEvent =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "applyEvent"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "IdleGame", "Mod" ] "Mod" [])
                         , Type.namedWith [ "IdleGame", "Game" ] "Event" []
                         , Type.namedWith
                             [ "Random" ]
                             "Generator"
                             [ Type.tuple
                                   (Type.namedWith
                                        [ "IdleGame", "Game" ]
                                        "Game"
                                        []
                                   )
                                   (Type.list
                                        (Type.namedWith
                                             [ "IdleGame", "Game" ]
                                             "Toast"
                                             []
                                        )
                                   )
                             ]
                         ]
                         (Type.namedWith
                              [ "Random" ]
                              "Generator"
                              [ Type.tuple
                                  (Type.namedWith
                                     [ "IdleGame", "Game" ]
                                     "Game"
                                     []
                                  )
                                  (Type.list
                                     (Type.namedWith
                                        [ "IdleGame", "Game" ]
                                        "Toast"
                                        []
                                     )
                                  )
                              ]
                         )
                    )
            }
    , priceToPurchaseResource =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "priceToPurchaseResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.tuple
                             (Type.namedWith
                                [ "IdleGame", "Game" ]
                                "Resource"
                                []
                             )
                             (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith [ "IdleGame", "Coin" ] "Coin" [])
                    )
            }
    , setSeed =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "setSeed"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Random" ] "Seed" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                    )
            }
    , attemptPurchaseResource =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "attemptPurchaseResource"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "IdleGame", "Game" ] "Resource" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith
                                  [ "IdleGame", "EffectErr" ]
                                  "EffectErr"
                                  []
                              , Type.namedWith
                                  [ "IdleGame", "Game" ]
                                  "ApplyEffectsValue"
                                  []
                              ]
                         )
                    )
            }
    , getPurchaseEffects =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getPurchaseEffects"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "IdleGame", "Game" ] "Resource" []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "Effect" ]
                                   "Effect"
                                   []
                              )
                         )
                    )
            }
    , tick =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "tick"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Duration" ] "Duration" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                              (Type.list
                                   (Type.namedWith
                                        [ "IdleGame", "Game" ]
                                        "Toast"
                                        []
                                   )
                              )
                         )
                    )
            }
    , combatReward =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "combatReward"
            , annotation =
                Just
                    (Type.list
                         (Type.namedWith [ "IdleGame", "Effect" ] "Effect" [])
                    )
            }
    , getModdedDuration =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getModdedDuration"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                         ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , applyIntervalMods =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "applyIntervalMods"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "IdleGame", "Game" ]
                                "IntervalMod"
                                []
                             )
                         , Type.namedWith [ "Duration" ] "Duration" []
                         ]
                         (Type.namedWith [ "Duration" ] "Duration" [])
                    )
            }
    , setActivity =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "setActivity"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe
                             (Type.tuple
                                (Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "Activity"
                                   []
                                )
                                (Type.namedWith
                                   [ "IdleGame", "Timer" ]
                                   "Timer"
                                   []
                                )
                             )
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                    )
            }
    , activityIsActive =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "activityIsActive"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         Type.bool
                    )
            }
    , toggleActivity =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "toggleActivity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Activity" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                    )
            }
    , getActivityListItems =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "getActivityListItems"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "IdleGame", "Game" ] "Skill" []
                         , Type.namedWith [ "IdleGame", "Game" ] "Game" []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "IdleGame", "Game" ]
                                   "ActivityListItem"
                                   []
                              )
                         )
                    )
            }
    , createDev =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "createDev"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Random" ] "Seed" [] ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                    )
            }
    , createProd =
        Elm.value
            { importFrom = [ "IdleGame", "Game" ]
            , name = "createProd"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Random" ] "Seed" [] ]
                         (Type.namedWith [ "IdleGame", "Game" ] "Game" [])
                    )
            }
    }