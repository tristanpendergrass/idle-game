module IdleGame.ShopItems exposing (..)

import IdleGame.Event as Event exposing (Event)
import IdleGame.GameTypes exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon, howToWater, readingGlasses)
import List.Extra


type Kind
    = Shovel
    | HowToWater
    | Keyring
    | ReadingGlasses
    | CoatWithHiddenPockets


allKinds : List Kind
allKinds =
    [ Shovel, HowToWater, Keyring, ReadingGlasses, CoatWithHiddenPockets ]


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
    ShopItemIntervalMod { kind = CleanStables, percentChange = 0.1 }


getStats : Kind -> Stats
getStats kind =
    case kind of
        Shovel ->
            { title = "Shovel"
            , icon = Icon.shovel
            , price = 50
            , unlockLevel = 1
            , reward = dummyReward
            , getter = .shovel
            , setter = \owned ownedItems -> { ownedItems | shovel = owned }
            }

        HowToWater ->
            { title = "How to Dual-wield Watering Cans"
            , icon = Icon.howToWater
            , price = 1000
            , unlockLevel = 35
            , reward = dummyReward
            , getter = .howToWater
            , setter = \owned ownedItems -> { ownedItems | howToWater = owned }
            }

        Keyring ->
            { title = "Keyring"
            , icon = Icon.keyring
            , price = 1500
            , unlockLevel = 1
            , reward = dummyReward
            , getter = .keyring
            , setter = \owned ownedItems -> { ownedItems | keyring = owned }
            }

        ReadingGlasses ->
            { title = "Reading Glasses"
            , icon = Icon.readingGlasses
            , price = 3000
            , unlockLevel = 55
            , reward = dummyReward
            , getter = .readingGlasses
            , setter = \owned ownedItems -> { ownedItems | readingGlasses = owned }
            }

        CoatWithHiddenPockets ->
            { title = "Coat With Hidden Pockets"
            , icon = Icon.coatWithHiddenPockets
            , price = 5000
            , unlockLevel = 1
            , reward = dummyReward
            , getter = .coatWithHiddenPockets
            , setter = \owned ownedItems -> { ownedItems | coatWithHiddenPockets = owned }
            }


type alias OwnedItems =
    { shovel : Bool
    , howToWater : Bool
    , keyring : Bool
    , readingGlasses : Bool
    , coatWithHiddenPockets : Bool
    }


type ShopItems
    = ShopItems OwnedItems


type Reward
    = ShopItemMod Event.Mod
    | ShopItemIntervalMod IntervalMod


create : ShopItems
create =
    ShopItems
        { shovel = False
        , howToWater = False
        , keyring = False
        , readingGlasses = False
        , coatWithHiddenPockets = False
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
