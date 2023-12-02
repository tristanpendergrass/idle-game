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


allResources : List Resource
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
    , greenhouseDirt : a
    , washWater : a
    , emptyBottle : a
    , scrap : a
    , ectoplasm : a
    , parchment : a
    }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { manure = a
    , soot = a
    , greenhouseDirt = a
    , washWater = a
    , emptyBottle = a
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
            data.greenhouseDirt

        WashWater ->
            data.washWater

        EmptyBottle ->
            data.emptyBottle

        Scrap ->
            data.scrap

        Ectoplasm ->
            data.ectoplasm

        Parchment ->
            data.parchment


setByKindResource :
    Resource -> value -> ResourceRecord value -> ResourceRecord value
setByKindResource kind value data =
    case kind of
        Manure ->
            { data | manure = value }

        Soot ->
            { data | soot = value }

        GreenhouseDirt ->
            { data | greenhouseDirt = value }

        WashWater ->
            { data | washWater = value }

        EmptyBottle ->
            { data | emptyBottle = value }

        Scrap ->
            { data | scrap = value }

        Ectoplasm ->
            { data | ectoplasm = value }

        Parchment ->
            { data | parchment = value }