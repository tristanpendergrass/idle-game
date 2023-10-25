module Evergreen.V12.IdleGame.Resource exposing (..)


type Kind
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment


type alias Record a =
    { manure : a
    , soot : a
    , greenhouseDirt : a
    , washWater : a
    , emptyBottles : a
    , scrap : a
    , ectoplasm : a
    , parchment : a
    }


type alias Diff =
    Record Int
