module Kinds exposing (..)


type Resource
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment


type alias ResourceRecord a =
    { manure : a
    , soot : a
    , greenhousedirt : a
    , washwater : a
    , emptybottle : a
    , scrap : a
    , ectoplasm : a
    , parchment : a
    }