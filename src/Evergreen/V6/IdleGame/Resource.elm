module Evergreen.V6.IdleGame.Resource exposing (..)


type Kind
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment


type alias Amounts =
    { manure : Int
    , soot : Int
    , greenhouseDirt : Int
    , washWater : Int
    , emptyBottles : Int
    , scrap : Int
    , ectoplasm : Int
    , parchment : Int
    }


type alias Diff =
    Amounts
