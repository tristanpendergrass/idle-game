module Evergreen.V6.IdleGame.ShopItems exposing (..)


type alias OwnedItems =
    { shovel : Bool
    , beginnerDualWielding : Bool
    , keyring : Bool
    , readingGlasses : Bool
    , oversizedBag : Bool
    }


type ShopItems
    = ShopItems OwnedItems


type Kind
    = Shovel
    | BeginnerDualWielding
    | Keyring
    | ReadingGlasses
    | OversizedBag
