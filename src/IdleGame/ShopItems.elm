module IdleGame.ShopItems exposing (..)

import Html exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Mod as Event
import IdleGame.Views.Icon as Icon exposing (Icon, book, readingGlasses)
import List.Extra
import Percent exposing (Percent)


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
    , price : Coin
    , unlockLevel : Int
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
    ShopItemIntervalMod [ intervalMod IdleGame.Kinds.Activities.CleanStables (Percent.fromFloat 0.1) ]


shovelStats : Stats
shovelStats =
    { title = "Shovel"
    , icon = Icon.shovel
    , price = Coin.int 50
    , unlockLevel = 1
    , reward =
        ShopItemIntervalMod
            [ intervalMod IdleGame.Kinds.Activities.CleanStables (Percent.fromFloat 0.05)
            , intervalMod IdleGame.Kinds.Activities.CleanBigBubba (Percent.fromFloat 0.05)
            ]
    , description = "+5% faster at Clean Stables and Clean Big Bubba's Stall"
    , getter = .shovel
    , setter = \owned ownedItems -> { ownedItems | shovel = owned }
    }


beginnerDualWieldingStats : Stats
beginnerDualWieldingStats =
    { title = "Beginner Dual Wielding"
    , icon = Icon.book
    , price = Coin.int 6000
    , unlockLevel = 35

    -- , reward = ShopItemIntervalMod [ { kind = Activity.WaterGreenhousePlants, percentChange = 1.0 } ]
    , reward =
        ShopItemIntervalMod
            [ intervalMod IdleGame.Kinds.Activities.CleanStables (Percent.fromFloat 1.0) ]
    , description = "+100% faster at Water Greenhouse Plants"
    , getter = .beginnerDualWielding
    , setter = \owned ownedItems -> { ownedItems | beginnerDualWielding = owned }
    }


keyringStats : Stats
keyringStats =
    { title = "Keyring"
    , icon = Icon.keyring
    , price = Coin.int 10000
    , unlockLevel = 1

    -- , reward =
    -- ShopItemIntervalMod
    -- (List.map (\choreKind -> { kind = choreKind, percentChange = 0.1 }) Activity.allKinds)
    , reward =
        ShopItemIntervalMod
            [ intervalMod IdleGame.Kinds.Activities.CleanStables (Percent.fromFloat 1.0) ]
    , description = "+10% faster at All Chores"
    , getter = .keyring
    , setter = \owned ownedItems -> { ownedItems | keyring = owned }
    }


readingGlassesStats : Stats
readingGlassesStats =
    { title = "Reading Glasses"
    , icon = Icon.readingGlasses
    , price = Coin.int 3000
    , unlockLevel = 55
    , reward =
        ShopItemIntervalMod
            [ intervalMod IdleGame.Kinds.Activities.CleanStables (Percent.fromFloat 1.0) ]

    -- , reward =
    --     ShopItemMod
    --         [ Event.choresMxpBuff 0.2
    --             |> Event.withSource Event.ShopItem
    --             |> Event.modWithTags
    --                 [ Event.ChoreTag Activity.OrganizePotionIngredients
    --                 ]
    --         , Event.choresMxpBuff 0.2
    --             |> Event.withSource Event.ShopItem
    --             |> Event.modWithTags
    --                 [ Event.ChoreTag Activity.OrganizeSpellBooks
    --                 ]
    --         ]
    , description = "+20% Mastery XP from Organize Potion Ingredients and Organize Spell Books"
    , getter = .readingGlasses
    , setter = \owned ownedItems -> { ownedItems | readingGlasses = owned }
    }


oversizedBagStats : Stats
oversizedBagStats =
    { title = "OversizedBag"
    , icon = Icon.oversizedBag
    , price = Coin.int 5000
    , unlockLevel = 65
    , reward =
        ShopItemIntervalMod
            [ intervalMod IdleGame.Kinds.Activities.CleanStables (Percent.fromFloat 1.0) ]

    -- , reward =
    --     ShopItemMod
    --         [ Event.successBuff 0.75
    --             |> Event.withSource Event.ShopItem
    --             |> Event.modWithTags
    --                 [ Event.ChoreTag Activity.RepairInstruments ]
    --         ]
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
