module IdleGame.ShopUpgrade exposing (..)

import Html exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon, book, readingGlasses)
import List.Extra
import Percent exposing (Percent)


type alias Record a =
    { shovel : a
    , keyring : a
    , book : a
    , readingGlasses : a
    , oversizedBag : a
    }


createRecord : a -> Record a
createRecord a =
    { shovel = a
    , keyring = a
    , book = a
    , readingGlasses = a
    , oversizedBag = a
    }



-- getByKind : Resource -> Record a -> a
-- getByKind kind data =
--     case kind of
--         Manure ->
--             data.manure
--         Soot ->
--             data.soot
--         GreenhouseDirt ->
--             data.greenhouseDirt
--         WashWater ->
--             data.washWater
--         EmptyBottle ->
--             data.emptyBottles
--         Scrap ->
--             data.scrap
--         Ectoplasm ->
--             data.ectoplasm
--         Parchment ->
--             data.parchment
-- setByKind : Resource -> a -> Record a -> Record a
-- setByKind kind value data =
--     case kind of
--         Manure ->
--             { data | manure = value }
--         Soot ->
--             { data | soot = value }
--         GreenhouseDirt ->
--             { data | greenhouseDirt = value }
--         WashWater ->
--             { data | washWater = value }
--         EmptyBottle ->
--             { data | emptyBottles = value }
--         Scrap ->
--             { data | scrap = value }
--         Ectoplasm ->
--             { data | ectoplasm = value }
--         Parchment ->
--             { data | parchment = value }


getByKind : ShopUpgrade -> Record a -> a
getByKind kind data =
    case kind of
        Shovel ->
            data.shovel

        Keyring ->
            data.keyring

        Book ->
            data.book

        ReadingGlasses ->
            data.readingGlasses

        OversizedBag ->
            data.oversizedBag


setByKind : ShopUpgrade -> a -> Record a -> Record a
setByKind kind value data =
    case kind of
        Shovel ->
            { data | shovel = value }

        Keyring ->
            { data | keyring = value }

        Book ->
            { data | book = value }

        ReadingGlasses ->
            { data | readingGlasses = value }

        OversizedBag ->
            { data | oversizedBag = value }


allShopUpgrades : List ShopUpgrade
allShopUpgrades =
    [ Shovel, Keyring, Book, ReadingGlasses, OversizedBag ]


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


dummyReward : Reward
dummyReward =
    ShopItemIntervalMod [ intervalMod CleanStables (Percent.float 0.1) ]


shovelStats : Stats
shovelStats =
    { title = "Shovel"
    , icon = Icon.shovel
    , price = Coin.int 50
    , reward =
        ShopItemIntervalMod
            [ intervalMod CleanStables (Percent.float 0.05)
            , intervalMod CleanBigBubba (Percent.float 0.05)
            ]
    , description = "+5% faster at Clean Stables and Clean Big Bubba's Stall"
    }


bookStats : Stats
bookStats =
    { title = "Spellbook (2022)"
    , icon = Icon.book
    , price = Coin.int 6000
    , reward =
        ShopItemIntervalMod
            (List.map (\activity -> intervalMod activity (Percent.float 0.1)) Activity.allHexes)
    , description = "+10% faster at studying Hexes"
    }


keyringStats : Stats
keyringStats =
    { title = "Keyring"
    , icon = Icon.keyring
    , price = Coin.int 5000
    , reward =
        ShopItemIntervalMod
            (List.map (\activity -> intervalMod activity (Percent.float 0.1)) Activity.allChores)
    , description = "+10% faster at all Chores"
    }


readingGlassesStats : Stats
readingGlassesStats =
    { title = "Reading Glasses"
    , icon = Icon.readingGlasses
    , price = Coin.int 3000
    , reward = ShopItemMod [ Mod.powerBuff 5 ]
    , description = "+5 Combat Power"
    }


oversizedBagStats : Stats
oversizedBagStats =
    { title = "OversizedBag"
    , icon = Icon.oversizedBag
    , price = Coin.int 5000
    , reward =
        ShopItemMod
            [ Mod.coinBuff 1
                |> Mod.withTags [ Effect.SkillTag Chores ]
            ]
    , description = "Earn double coin from chores"
    }


getStats : ShopUpgrade -> Stats
getStats kind =
    case kind of
        Shovel ->
            shovelStats

        Book ->
            bookStats

        Keyring ->
            keyringStats

        ReadingGlasses ->
            readingGlassesStats

        OversizedBag ->
            oversizedBagStats


type alias OwnedItems =
    Record Bool


type Reward
    = ShopItemMod (List Mod)
    | ShopItemIntervalMod (List IntervalMod)


toOwnedItems : Record Bool -> List ShopUpgrade
toOwnedItems shopItems =
    allShopUpgrades
        |> List.filter (\kind -> getByKind kind shopItems)
