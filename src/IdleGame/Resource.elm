module IdleGame.Resource exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Views.Icon as Icon exposing (Icon)


type
    Kind
    -- Don't forget to update `allResources` when you add stuff here!
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment
    | Hex1
    | Jinx1
    | Curse1
    | Hex2
    | Jinx2
    | Curse2
    | Hex3
    | Jinx3
    | Curse3


allResources : List Kind
allResources =
    -- Don't forget to add to `allSpells` when you add a spell here!
    [ Manure
    , Soot
    , GreenhouseDirt
    , WashWater
    , EmptyBottle
    , Scrap
    , Ectoplasm
    , Parchment
    , Hex1
    , Jinx1
    , Curse1
    , Hex2
    , Jinx2
    , Curse2
    , Hex3
    , Jinx3
    , Curse3
    ]


type alias Record a =
    { manure : a
    , soot : a
    , greenhouseDirt : a
    , washWater : a
    , emptyBottles : a
    , scrap : a
    , ectoplasm : a
    , parchment : a
    , hex1 : a
    , jinx1 : a
    , curse1 : a
    , hex2 : a
    , jinx2 : a
    , curse2 : a
    , hex3 : a
    , jinx3 : a
    , curse3 : a
    }


getByKind : Kind -> Record a -> a
getByKind kind data =
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
            data.emptyBottles

        Scrap ->
            data.scrap

        Ectoplasm ->
            data.ectoplasm

        Parchment ->
            data.parchment

        Hex1 ->
            data.hex1

        Jinx1 ->
            data.jinx1

        Curse1 ->
            data.curse1

        Hex2 ->
            data.hex2

        Jinx2 ->
            data.jinx2

        Curse2 ->
            data.curse2

        Hex3 ->
            data.hex3

        Jinx3 ->
            data.jinx3

        Curse3 ->
            data.curse3


setByKind : Kind -> a -> Record a -> Record a
setByKind kind value data =
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
            { data | emptyBottles = value }

        Scrap ->
            { data | scrap = value }

        Ectoplasm ->
            { data | ectoplasm = value }

        Parchment ->
            { data | parchment = value }

        Hex1 ->
            { data | hex1 = value }

        Jinx1 ->
            { data | jinx1 = value }

        Curse1 ->
            { data | curse1 = value }

        Hex2 ->
            { data | hex2 = value }

        Jinx2 ->
            { data | jinx2 = value }

        Curse2 ->
            { data | curse2 = value }

        Hex3 ->
            { data | hex3 = value }

        Jinx3 ->
            { data | jinx3 = value }

        Curse3 ->
            { data | curse3 = value }


updateByKind : Kind -> (a -> a) -> Record a -> Record a
updateByKind kind update data =
    setByKind kind (update (getByKind kind data)) data


type Purchasing
    = Purchasable Coin
    | NotPurchasable


type alias Stats =
    { title : String
    , icon : Icon
    , purchasing : Purchasing
    }


allStats : Record Stats
allStats =
    { manure = manureStats
    , soot = sootStats
    , greenhouseDirt = greenhouseDirtStats
    , washWater = washWaterStats
    , emptyBottles = emptyBottleStats
    , scrap = scrapStats
    , ectoplasm = ectoplasmStats
    , parchment = parchmentStats
    , hex1 = hex1Stats
    , jinx1 = jinx1Stats
    , curse1 = curse1Stats
    , hex2 = hex2Stats
    , jinx2 = jinx2Stats
    , curse2 = curse2Stats
    , hex3 = hex3Stats
    , jinx3 = jinx3Stats
    , curse3 = curse3Stats
    }


manureStats : Stats
manureStats =
    { title = "Manure"
    , icon = Icon.manure
    , purchasing = NotPurchasable
    }


sootStats : Stats
sootStats =
    { title = "Soot"
    , icon = Icon.soot
    , purchasing = NotPurchasable
    }


greenhouseDirtStats : Stats
greenhouseDirtStats =
    { title = "Greenhouse Dirt"
    , icon = Icon.greenhouseDirt
    , purchasing = NotPurchasable
    }


washWaterStats : Stats
washWaterStats =
    { title = "Wash Water"
    , icon = Icon.washWater
    , purchasing = NotPurchasable
    }


emptyBottleStats : Stats
emptyBottleStats =
    { title = "Empty Bottle"
    , icon = Icon.emptyBottle
    , purchasing = NotPurchasable
    }


scrapStats : Stats
scrapStats =
    { title = "Scrap"
    , icon = Icon.scrap
    , purchasing = NotPurchasable
    }


ectoplasmStats : Stats
ectoplasmStats =
    { title = "Ectoplasm"
    , icon = Icon.ectoplasm
    , purchasing = NotPurchasable
    }


parchmentStats : Stats
parchmentStats =
    { title = "Parchment"
    , icon = Icon.parchment
    , purchasing = Purchasable (Coin.int 10)
    }


hex1Stats : Stats
hex1Stats =
    { title = "Hex I"
    , icon = Icon.letter "Hx1"
    , purchasing = NotPurchasable
    }


jinx1Stats : Stats
jinx1Stats =
    { title = "Jinx I"
    , icon = Icon.letter "Jx1"
    , purchasing = NotPurchasable
    }


curse1Stats : Stats
curse1Stats =
    { title = "Curse I"
    , icon = Icon.letter "Cs1"
    , purchasing = NotPurchasable
    }


hex2Stats : Stats
hex2Stats =
    { title = "Hex II"
    , icon = Icon.letter "Hx2"
    , purchasing = NotPurchasable
    }


jinx2Stats : Stats
jinx2Stats =
    { title = "Jinx II"
    , icon = Icon.letter "Jx2"
    , purchasing = NotPurchasable
    }


curse2Stats : Stats
curse2Stats =
    { title = "Curse II"
    , icon = Icon.letter "Cs2"
    , purchasing = NotPurchasable
    }


hex3Stats : Stats
hex3Stats =
    { title = "Hex III"
    , icon = Icon.letter "Hx3"
    , purchasing = NotPurchasable
    }


jinx3Stats : Stats
jinx3Stats =
    { title = "Jinx III"
    , icon = Icon.letter "Jx3"
    , purchasing = NotPurchasable
    }


curse3Stats : Stats
curse3Stats =
    { title = "Curse III"
    , icon = Icon.letter "Cs3"
    , purchasing = NotPurchasable
    }


getStats : Kind -> Stats
getStats kind =
    getByKind kind allStats


type alias Diff =
    -- I don't know if it will always make sense for this type alias and Amounts to be the same shape but for now it is and saves us work
    Record Int


emptyResourceRecord : Record Int
emptyResourceRecord =
    { manure = 0
    , soot = 0
    , greenhouseDirt = 0
    , washWater = 0
    , emptyBottles = 0
    , scrap = 0
    , ectoplasm = 0
    , parchment = 0
    , hex1 = 0
    , jinx1 = 0
    , curse1 = 0
    , hex2 = 0
    , jinx2 = 0
    , curse2 = 0
    , hex3 = 0
    , jinx3 = 0
    , curse3 = 0
    }


add : Kind -> Int -> Record Int -> Result EffectErr (Record Int)
add resource amount resources =
    let
        oldAmount : Int
        oldAmount =
            getByKind resource resources

        newAmount : Int
        newAmount =
            oldAmount + amount
    in
    if newAmount >= 0 then
        Ok (setByKind resource newAmount resources)

    else
        Err EffectErr.NegativeAmount


getDiff : { original : Record Int, current : Record Int } -> Diff
getDiff { original, current } =
    -- TODO: improvements definitely possible here. Make Diff a List with only elements that were different present? Automate so we dont have to modify this function when adding new Kinds of resources?
    { manure = current.manure - original.manure
    , soot = current.soot - original.soot
    , greenhouseDirt = current.greenhouseDirt - original.greenhouseDirt
    , washWater = current.washWater - original.washWater
    , emptyBottles = current.emptyBottles - original.emptyBottles
    , scrap = current.scrap - original.scrap
    , ectoplasm = current.ectoplasm - original.ectoplasm
    , parchment = current.parchment - original.parchment
    , hex1 = current.hex1 - original.hex1
    , jinx1 = current.jinx1 - original.jinx1
    , curse1 = current.curse1 - original.curse1
    , hex2 = current.hex2 - original.hex2
    , jinx2 = current.jinx2 - original.jinx2
    , curse2 = current.curse2 - original.curse2
    , hex3 = current.hex3 - original.hex3
    , jinx3 = current.jinx3 - original.jinx3
    , curse3 = current.curse3 - original.curse3
    }


mapDiff : (Int -> Kind -> a) -> Record Int -> List a
mapDiff fn diff =
    allResources
        |> List.map
            (\resource ->
                let
                    amount : Int
                    amount =
                        getByKind resource diff
                in
                fn amount resource
            )


isEmptyDiff : Diff -> Bool
isEmptyDiff resourcesDiff =
    allResources
        |> List.map (\resource -> getByKind resource resourcesDiff)
        |> List.all ((==) 0)


mapResources : (Int -> Kind -> a) -> Record Int -> List a
mapResources fn resources =
    allResources
        |> List.map
            (\resource ->
                let
                    amount : Int
                    amount =
                        getByKind resource resources
                in
                fn amount resource
            )


toList : Record Int -> List ( Kind, Int )
toList resources =
    allResources
        |> List.map
            (\resource ->
                let
                    amount : Int
                    amount =
                        getByKind resource resources
                in
                ( resource, amount )
            )
