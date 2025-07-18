module IdleGame.ShopUpgrade exposing (..)

import Html exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect
import IdleGame.Kinds exposing (..)
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
    , mods : List Mod
    , description : String
    }


intervalMod : Activity -> Percent -> IntervalModParams
intervalMod kind percentChange =
    { activity = kind, percentChange = percentChange, label = IntervalModLabel percentChange, count = 1 }


getStats : ShopUpgrade -> Stats
getStats kind =
    case kind of
        Glasses ->
            glassesStats


type alias OwnedItems =
    ShopUpgradeRecord Bool


toOwnedItems : ShopUpgradeRecord Bool -> List ShopUpgrade
toOwnedItems shopItems =
    allShopUpgrades
        |> List.filter (\kind -> getByShopUpgrade kind shopItems)


glassesStats : Stats
glassesStats =
    { title = "Glasses"
    , icon = Icon.readingGlasses
    , price = Coin.int 50
    , mods = []
    , description = "+10% coin from all sources"
    }
