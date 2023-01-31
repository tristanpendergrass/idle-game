module IdleGame.ShopItems exposing (..)

import IdleGame.Views.Icon as Icon exposing (Icon)


type Item
    = Item1
    | Item2


type alias ViewItem =
    { title : String, icon : Icon, price : Int, owned : Bool }


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


toList : ShopItems -> List ViewItem
toList (ShopItems ownedItems) =
    [ Item1, Item2 ]
        |> List.map
            (\item ->
                case item of
                    Item1 ->
                        { title = "Item 1", icon = Icon.Bag, price = 5, owned = ownedItems.item1 }

                    Item2 ->
                        { title = "Item 2", icon = Icon.Botany, price = 10, owned = ownedItems.item2 }
            )
