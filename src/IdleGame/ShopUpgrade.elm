module IdleGame.ShopUpgrade exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Views.Icon as Icon exposing (Icon)
import Percent exposing (Percent)


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
    { kind = kind, percentChange = percentChange, label = IntervalModLabel percentChange }


getStats : ShopUpgrade -> Stats
getStats kind =
    case kind of
        Glasses ->
            glassesStats


type alias OwnedItems =
    ShopUpgradeRecord Bool


type Reward
    = ShopItemMod (List Mod)
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
            [ Mod.coinBuff (Percent.float 0.1) ]
    , description = "+10% coin from all sources"
    }
