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


allResources : List Kind
allResources =
    [ Manure, Soot, GreenhouseDirt, WashWater, EmptyBottle, Scrap, Ectoplasm, Parchment ]


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
