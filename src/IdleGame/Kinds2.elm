module IdleGame.Kinds2 exposing (..)


{- !! Generated code, do not edit by hand !! -}


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


allResources : List manure
allResources =
    [ Manure
    , Soot
    , GreenhouseDirt
    , WashWater
    , EmptyBottle
    , Scrap
    , Ectoplasm
    , Parchment
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
    }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { manure = a
    , soot = a
    , greenhousedirt = a
    , washwater = a
    , emptybottle = a
    , scrap = a
    , ectoplasm = a
    , parchment = a
    }


getByKindResource : Resource -> ResourceRecord parchment -> parchment
getByKindResource kind data =
    case kind of
        Manure ->
            data.manure

        Soot ->
            data.soot

        GreenhouseDirt ->
            data.greenhousedirt

        WashWater ->
            data.washwater

        EmptyBottle ->
            data.emptybottle

        Scrap ->
            data.scrap

        Ectoplasm ->
            data.ectoplasm

        Parchment ->
            data.parchment