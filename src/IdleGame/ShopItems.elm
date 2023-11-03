module IdleGame.ShopItems exposing (..)

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


type Kind
    = Shovel
    | Book
    | Keyring
    | ReadingGlasses
    | OversizedBag


allKinds : List Kind
allKinds =
    [ Shovel, Keyring, Book, ReadingGlasses, OversizedBag ]


type alias Stats =
    { title : String
    , icon : Icon
    , price : Coin
    , reward : Reward
    , description : String
    , getter : OwnedItems -> Bool
    , setter : Bool -> OwnedItems -> OwnedItems
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
    , getter = .shovel
    , setter = \owned ownedItems -> { ownedItems | shovel = owned }
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
    , getter = .book
    , setter = \owned ownedItems -> { ownedItems | book = owned }
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
    , getter = .keyring
    , setter = \owned ownedItems -> { ownedItems | keyring = owned }
    }


readingGlassesStats : Stats
readingGlassesStats =
    { title = "Reading Glasses"
    , icon = Icon.readingGlasses
    , price = Coin.int 3000
    , reward = ShopItemMod [ Mod.powerBuff 5 ]
    , description = "+5 Combat Power"
    , getter = .readingGlasses
    , setter = \owned ownedItems -> { ownedItems | readingGlasses = owned }
    }


oversizedBagStats : Stats
oversizedBagStats =
    { title = "OversizedBag"
    , icon = Icon.oversizedBag
    , price = Coin.int 5000
    , reward =
        ShopItemMod
            [ Mod.coinBuff 1
                |> Mod.withTags [ Effect.SkillTag Skill.Chores ]
            ]
    , description = "Earn double coin from chores"
    , getter = .oversizedBag
    , setter = \owned ownedItems -> { ownedItems | oversizedBag = owned }
    }


getStats : Kind -> Stats
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
    { shovel : Bool
    , book : Bool
    , keyring : Bool
    , readingGlasses : Bool
    , oversizedBag : Bool
    }


type ShopItems
    = ShopItems OwnedItems


type Reward
    = ShopItemMod (List Mod)
    | ShopItemIntervalMod (List IntervalMod)


create : ShopItems
create =
    ShopItems
        { shovel = False
        , book = False
        , keyring = False
        , readingGlasses = False
        , oversizedBag = False
        }


addItem : Kind -> ShopItems -> ShopItems
addItem kind (ShopItems ownedItems) =
    (getStats kind).setter True ownedItems
        |> ShopItems


isOwned : Kind -> ShopItems -> Bool
isOwned kind (ShopItems ownedItems) =
    (getStats kind).getter ownedItems


toOwnedItems : ShopItems -> List Kind
toOwnedItems shopItems =
    allKinds
        |> List.filter (\kind -> isOwned kind shopItems)
