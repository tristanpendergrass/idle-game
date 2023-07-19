module IdleGame.Resource exposing (..)

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


type Err
    = NegativeAmount


allResources : List Kind
allResources =
    [ Manure, Soot, GreenhouseDirt, WashWater, EmptyBottle, Scrap, Ectoplasm, Parchment ]


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


type alias Stats =
    { title : String
    , icon : Icon
    , getter : Amounts -> Int
    , setter : Int -> Amounts -> Amounts
    }


getStats : Kind -> Stats
getStats kind =
    case kind of
        Manure ->
            { title = "Manure"
            , icon = Icon.manure
            , getter = .manure
            , setter = \amount resources -> { resources | manure = amount }
            }

        Soot ->
            { title = "Soot"
            , icon = Icon.soot
            , getter = .soot
            , setter = \amount resources -> { resources | soot = amount }
            }

        GreenhouseDirt ->
            { title = "Greenhouse Dirt"
            , icon = Icon.greenhouseDirt
            , getter = .greenhouseDirt
            , setter = \amount resources -> { resources | greenhouseDirt = amount }
            }

        WashWater ->
            { title = "Wash Water"
            , icon = Icon.washWater
            , getter = .washWater
            , setter = \amount resources -> { resources | washWater = amount }
            }

        EmptyBottle ->
            { title = "Empty Bottle"
            , icon = Icon.emptyBottle
            , getter = .emptyBottles
            , setter = \amount resources -> { resources | emptyBottles = amount }
            }

        Scrap ->
            { title = "Scrap"
            , icon = Icon.scrap
            , getter = .scrap
            , setter = \amount resources -> { resources | scrap = amount }
            }

        Ectoplasm ->
            { title = "Ectoplasm"
            , icon = Icon.ectoplasm
            , getter = .ectoplasm
            , setter = \amount resources -> { resources | ectoplasm = amount }
            }

        Parchment ->
            { title = "Parchment"
            , icon = Icon.parchment
            , getter = .parchment
            , setter = \amount resources -> { resources | parchment = amount }
            }


type alias Diff =
    -- I don't know if it will always make sense for this type alias and Amounts to be the same shape but for now it is and saves us work
    Amounts


createResources : Amounts
createResources =
    { manure = 0
    , soot = 0
    , greenhouseDirt = 0
    , washWater = 0
    , emptyBottles = 0
    , scrap = 0
    , ectoplasm = 0
    , parchment = 0
    }


getByKind : Kind -> Amounts -> Int
getByKind resource =
    (getStats resource).getter


add : Kind -> Int -> Amounts -> Result Err Amounts
add resource amount resources =
    let
        oldAmount : Int
        oldAmount =
            (getStats resource).getter resources

        newAmount : Int
        newAmount =
            oldAmount + amount
    in
    if newAmount >= 0 then
        Ok ((getStats resource).setter newAmount resources)

    else
        Err NegativeAmount


getDiff : { original : Amounts, current : Amounts } -> Diff
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


mapDiff : (Int -> Kind -> a) -> Amounts -> List a
mapDiff fn diff =
    allResources
        |> List.map
            (\resource ->
                let
                    amount =
                        (getStats resource).getter diff
                in
                fn amount resource
            )


isEmptyDiff : Diff -> Bool
isEmptyDiff resourcesDiff =
    allResources
        |> List.map (\resource -> getByKind resource resourcesDiff)
        |> List.all ((==) 0)


mapResources : (Int -> Kind -> a) -> Amounts -> List a
mapResources fn resources =
    allResources
        |> List.map
            (\resource ->
                let
                    amount =
                        (getStats resource).getter resources
                in
                fn amount resource
            )


toList : Amounts -> List ( Kind, Int )
toList resources =
    allResources
        |> List.map
            (\resource ->
                let
                    amount =
                        (getStats resource).getter resources
                in
                ( resource, amount )
            )
