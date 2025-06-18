module IdleGame.ShopUpgrade exposing (..)

import Html exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (EffectType)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (EffectMod)
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon, book, readingGlasses)
import List.Extra
import Percent exposing (Percent)
import Types exposing (..)


allShopUpgrades : List ShopUpgrade
allShopUpgrades =
    [ Glasses ]


type alias Stats =
    { title : String
    , icon : Icon
    , price : Coin
    , reward : Reward
    , description : String
    }


intervalMod : Activity -> Percent -> IntervalMod
intervalMod kind percentChange =
    { kind = kind, percentChange = percentChange, label = IntervalModLabel percentChange, count = 1 }


getStats : ShopUpgrade -> Stats
getStats kind =
    case kind of
        Glasses ->
            glassesStats


type alias OwnedItems =
    ShopUpgradeRecord Bool


type Reward
    = ShopItemMod (List EffectMod)
    | ShopItemIntervalMod (List IntervalMod)


toOwnedItems : ShopUpgradeRecord Bool -> List ShopUpgrade
toOwnedItems shopItems =
    allShopUpgrades
        |> List.filter (\kind -> getByShopUpgrade kind shopItems)


glassesStats : Stats
glassesStats =
    { title = "Glasses"
    , icon = Icon.readingGlasses
    , price = Coin.int 50
    , reward =
        ShopItemMod
            []
    , description = "+10% coin from all sources"
    }
