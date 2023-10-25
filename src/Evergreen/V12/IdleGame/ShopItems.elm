module Evergreen.V12.IdleGame.ShopItems exposing (..)


type alias OwnedItems =
    { shovel : Bool
    , book : Bool
    , keyring : Bool
    , readingGlasses : Bool
    , oversizedBag : Bool
    }


type ShopItems
    = ShopItems OwnedItems


type Kind
    = Shovel
    | Book
    | Keyring
    | ReadingGlasses
    | OversizedBag
