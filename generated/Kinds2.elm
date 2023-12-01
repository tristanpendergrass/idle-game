module Kinds2 exposing (..)


{- !! Generated code, do not edit by hand -}


{- Resources -}


type Resource
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment
    | Foobar


allResources : List String
allResources =
    [ "Manure"
    , "Soot"
    , "GreenhouseDirt"
    , "WashWater"
    , "EmptyBottle"
    , "Scrap"
    , "Ectoplasm"
    , "Parchment"
    , "Foobar"
    ]


type alias ResourceRecord a =
    { manure : a
    , soot : a
    , greenhousedirt : a
    , washwater : a
    , emptybottle : a
    , scrap : a
    , ectoplasm : a
    , parchment : a
    , foobar : a
    }