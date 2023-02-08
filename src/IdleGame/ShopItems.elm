module IdleGame.ShopItems exposing (..)

import IdleGame.Chore as Chore
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
    [ Shovel, BeginnerDualWielding, Keyring, ReadingGlasses, OversizedBag ]


type alias ViewItem =
    { kind : Kind
    , title : String
    , description : String
    , icon : Icon
    , price : Int
    , owned : Bool
    }


type alias Stats =
    { title : String
    , icon : Icon
    , price : Int
    , unlockLevel : Int
    , reward : Reward
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
            , price = 50
            , unlockLevel = 1
            , reward =
                ShopItemIntervalMod
                    [ { kind = CleanStables, percentChange = 0.05 }
                    , { kind = CleanBigBubba, percentChange = 0.05 }
                    ]
            , getter = .shovel
            , setter = \owned ownedItems -> { ownedItems | shovel = owned }
            }

        BeginnerDualWielding ->
            { title = "Beginner Dual Wielding"
            , icon = Icon.book
            , price = 1000
            , unlockLevel = 35
            , reward = ShopItemIntervalMod [ { kind = WaterGreenhousePlants, percentChange = 1.0 } ]
            , getter = .beginnerDualWielding
            , setter = \owned ownedItems -> { ownedItems | beginnerDualWielding = owned }
            }

        Keyring ->
            { title = "Keyring"
            , icon = Icon.keyring
            , price = 1500
            , unlockLevel = 1
            , reward =
                ShopItemIntervalMod
                    (List.map (\choreKind -> { kind = choreKind, percentChange = 0.1 }) Chore.allKinds)
            , getter = .keyring
            , setter = \owned ownedItems -> { ownedItems | keyring = owned }
            }

        ReadingGlasses ->
            { title = "Reading Glasses"
            , icon = Icon.readingGlasses
            , price = 3000
            , unlockLevel = 55
            , reward =
                ShopItemMod
                    (Event.choresMxpBuff 0.2
                        |> Event.withSource Event.ShopItem
                        |> Event.modWithTags
                            [ Event.ChoreTag OrganizePotionIngredients
                            , Event.ChoreTag OrganizeSpellBooks
                            ]
                    )
            , getter = .readingGlasses
            , setter = \owned ownedItems -> { ownedItems | readingGlasses = owned }
            }

        OversizedBag ->
            { title = "OversizedBag"
            , icon = Icon.oversizedBag
            , price = 5000
            , unlockLevel = 1
            , reward =
                ShopItemMod
                    (Event.successBuff 0.75
                        |> Event.withSource Event.ShopItem
                        |> Event.modWithTags
                            [ Event.ChoreTag RepairInstruments ]
                    )
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
    = ShopItemMod Event.Mod
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
