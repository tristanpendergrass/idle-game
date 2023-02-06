module IdleGame.ShopItems exposing (..)

import IdleGame.Event as Event exposing (Event)
import IdleGame.GameTypes exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)


type Item
    = Item1
    | Item2


type alias ViewItem =
    { item : Item
    , title : String
    , description : String
    , icon : Icon
    , price : Int
    , owned : Bool
    }


type alias OwnedItems =
    { item1 : Bool
    , item2 : Bool
    }


type ShopItems
    = ShopItems OwnedItems


getPrice : Item -> Int
getPrice item =
    case item of
        Item1 ->
            5

        Item2 ->
            10


hasItem : Item -> ShopItems -> Bool
hasItem item (ShopItems ownedItems) =
    case item of
        Item1 ->
            ownedItems.item1

        Item2 ->
            ownedItems.item2


type Reward
    = ShopItemMod Event.Mod
    | ShopItemIntervalMod IntervalMod


getReward : Item -> Reward
getReward item =
    case item of
        Item1 ->
            Event.choresXpBuff 0.75
                |> Event.withSource Event.ShopItem
                |> ShopItemMod

        Item2 ->
            ShopItemIntervalMod { kind = CleanStables, percentChange = 1.0 }


create : ShopItems
create =
    ShopItems { item1 = False, item2 = False }


addItem : Item -> ShopItems -> ShopItems
addItem item (ShopItems ownedItems) =
    case item of
        Item1 ->
            ShopItems { ownedItems | item1 = True }

        Item2 ->
            ShopItems { ownedItems | item2 = True }


isOwned : Item -> ShopItems -> Bool
isOwned item (ShopItems ownedItems) =
    case item of
        Item1 ->
            ownedItems.item1

        Item2 ->
            ownedItems.item2


toOwnedItems : ShopItems -> List Item
toOwnedItems shopItems =
    [ Item1, Item2 ]
        |> List.foldl
            (\item accum ->
                if isOwned item shopItems then
                    item :: accum

                else
                    accum
            )
            []


toList : ShopItems -> List ViewItem
toList (ShopItems ownedItems) =
    [ Item1, Item2 ]
        |> List.map
            (\item ->
                case item of
                    Item1 ->
                        { item = Item1
                        , title = "Item 1"
                        , description = "Foobar"
                        , icon = Icon.bag
                        , price = getPrice item
                        , owned = ownedItems.item1
                        }

                    Item2 ->
                        { item = Item2
                        , title = "Item 2"
                        , description = "Foobar 2"
                        , icon = Icon.botany
                        , price = getPrice item
                        , owned = ownedItems.item2
                        }
            )
