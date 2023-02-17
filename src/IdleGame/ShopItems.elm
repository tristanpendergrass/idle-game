module IdleGame.ShopItems exposing (..)

import Html exposing (..)
import IdleGame.Chore as Chore
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event exposing (Event)
import IdleGame.GameTypes exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon, book, readingGlasses)
import List.Extra


type Kind
    = Shovel
    | BeginnerDualWielding
    | Keyring
    | ReadingGlasses
    | OversizedBag


allKinds : List Kind
allKinds =
    [ Shovel, BeginnerDualWielding, ReadingGlasses, OversizedBag, Keyring ]


type alias Stats =
    { title : String
    , icon : Icon
    , price : Counter
    , unlockLevel : Int
    , reward : Reward
    , description : String
    , getter : OwnedItems -> Bool
    , setter : Bool -> OwnedItems -> OwnedItems
    }


dummyReward : Reward
dummyReward =
    ShopItemIntervalMod [ { kind = CleanStables, percentChange = 0.1 } ]


shovelStats =
    { title = "Shovel"
    , icon = Icon.shovel
    , price = Counter.create 50
    , unlockLevel = 1
    , reward =
        ShopItemIntervalMod
            [ { kind = CleanStables, percentChange = 0.05 }
            , { kind = CleanBigBubba, percentChange = 0.05 }
            ]
    , description = "+5% faster at Clean Stables and Clean Big Bubba's Stall"
    , getter = .shovel
    , setter = \owned ownedItems -> { ownedItems | shovel = owned }
    }


beginnerDualWieldingStats =
    { title = "Beginner Dual Wielding"
    , icon = Icon.book
    , price = Counter.create 6000
    , unlockLevel = 35
    , reward = ShopItemIntervalMod [ { kind = WaterGreenhousePlants, percentChange = 1.0 } ]
    , description = "+100% faster at Water Greenhouse Plants"
    , getter = .beginnerDualWielding
    , setter = \owned ownedItems -> { ownedItems | beginnerDualWielding = owned }
    }


keyringStats =
    { title = "Keyring"
    , icon = Icon.keyring
    , price = Counter.create 10000
    , unlockLevel = 1
    , reward =
        ShopItemIntervalMod
            (List.map (\choreKind -> { kind = choreKind, percentChange = 0.1 }) Chore.allKinds)
    , description = "+10% faster at All Chores"
    , getter = .keyring
    , setter = \owned ownedItems -> { ownedItems | keyring = owned }
    }


readingGlassesStats =
    { title = "Reading Glasses"
    , icon = Icon.readingGlasses
    , price = Counter.create 3000
    , unlockLevel = 55
    , reward =
        ShopItemMod
            [ Event.choresMxpBuff 0.2
                |> Event.withSource Event.ShopItem
                |> Event.modWithTags
                    [ Event.ChoreTag OrganizePotionIngredients
                    ]
            , Event.choresMxpBuff 0.2
                |> Event.withSource Event.ShopItem
                |> Event.modWithTags
                    [ Event.ChoreTag OrganizeSpellBooks
                    ]
            ]
    , description = "+20% Mastery XP from Organize Potion Ingredients and Organize Spell Books"
    , getter = .readingGlasses
    , setter = \owned ownedItems -> { ownedItems | readingGlasses = owned }
    }


oversizedBagStats =
    { title = "OversizedBag"
    , icon = Icon.oversizedBag
    , price = Counter.create 5000
    , unlockLevel = 65
    , reward =
        ShopItemMod
            [ Event.successBuff 0.75
                |> Event.withSource Event.ShopItem
                |> Event.modWithTags
                    [ Event.ChoreTag RepairInstruments ]
            ]
    , description = "Always receive item from Repair Instruments"
    , getter = .oversizedBag
    , setter = \owned ownedItems -> { ownedItems | oversizedBag = owned }
    }


getStats : Kind -> Stats
getStats kind =
    case kind of
        Shovel ->
            shovelStats

        BeginnerDualWielding ->
            beginnerDualWieldingStats

        Keyring ->
            keyringStats

        ReadingGlasses ->
            readingGlassesStats

        OversizedBag ->
            oversizedBagStats


type alias OwnedItems =
    { shovel : Bool
    , beginnerDualWielding : Bool
    , keyring : Bool
    , readingGlasses : Bool
    , oversizedBag : Bool
    }


type ShopItems
    = ShopItems OwnedItems


type Reward
    = ShopItemMod (List Event.Mod)
    | ShopItemIntervalMod (List IntervalMod)


create : ShopItems
create =
    ShopItems
        { shovel = False
        , beginnerDualWielding = False
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
