module IdleGame.ShopItems exposing (..)

import Html exposing (..)
import IdleGame.Chore as Chore
import IdleGame.Coin as Coin
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
    , price : Coin.Counter
    , unlockLevel : Int
    , reward : Reward
    , description : String
    , getter : OwnedItems -> Bool
    , setter : Bool -> OwnedItems -> OwnedItems
    }


dummyReward : Reward
dummyReward =
    ShopItemIntervalMod [ { kind = CleanStables, percentChange = 0.1 } ]


getStats : Kind -> Stats
getStats kind =
    case kind of
        Shovel ->
            { title = "Shovel"
            , icon = Icon.shovel
            , price = Coin.create 50
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

        BeginnerDualWielding ->
            { title = "Beginner Dual Wielding"
            , icon = Icon.book
            , price = Coin.create 6000
            , unlockLevel = 35
            , reward = ShopItemIntervalMod [ { kind = WaterGreenhousePlants, percentChange = 1.0 } ]
            , description = "+100% faster at Water Greenhouse Plants"
            , getter = .beginnerDualWielding
            , setter = \owned ownedItems -> { ownedItems | beginnerDualWielding = owned }
            }

        Keyring ->
            { title = "Keyring"
            , icon = Icon.keyring
            , price = Coin.create 10000
            , unlockLevel = 1
            , reward =
                ShopItemIntervalMod
                    (List.map (\choreKind -> { kind = choreKind, percentChange = 0.1 }) Chore.allKinds)
            , description = "+10% faster at All Chores"
            , getter = .keyring
            , setter = \owned ownedItems -> { ownedItems | keyring = owned }
            }

        ReadingGlasses ->
            { title = "Reading Glasses"
            , icon = Icon.readingGlasses
            , price = Coin.create 3000
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

        OversizedBag ->
            { title = "OversizedBag"
            , icon = Icon.oversizedBag
            , price = Coin.create 5000
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
