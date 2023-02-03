module IdleGame.Resource exposing (..)


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
    , getter : Amounts -> Int
    , setter : Int -> Amounts -> Amounts
    }


getStats : Kind -> Stats
getStats kind =
    case kind of
        Manure ->
            { title = "Manure"
            , getter = .manure
            , setter = \amount resources -> { resources | manure = amount }
            }

        Soot ->
            { title = "Soot"
            , getter = .soot
            , setter = \amount resources -> { resources | soot = amount }
            }

        GreenhouseDirt ->
            { title = "Greenhouse Dirt"
            , getter = .greenhouseDirt
            , setter = \amount resources -> { resources | greenhouseDirt = amount }
            }

        WashWater ->
            { title = "Wash Water"
            , getter = .washWater
            , setter = \amount resources -> { resources | washWater = amount }
            }

        EmptyBottle ->
            { title = "Empty Bottle"
            , getter = .emptyBottles
            , setter = \amount resources -> { resources | emptyBottles = amount }
            }

        Scrap ->
            { title = "Scrap"
            , getter = .scrap
            , setter = \amount resources -> { resources | scrap = amount }
            }

        Ectoplasm ->
            { title = "Ectoplasm"
            , getter = .ectoplasm
            , setter = \amount resources -> { resources | ectoplasm = amount }
            }

        Parchment ->
            { title = "Parchment"
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


getAmount : Kind -> Amounts -> Int
getAmount resource =
    (getStats resource).getter


addResource : Kind -> Int -> Amounts -> Amounts
addResource resource amount resources =
    let
        oldAmount =
            (getStats resource).getter resources
    in
    (getStats resource).setter (oldAmount + amount) resources


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
        |> List.map (\resource -> getAmount resource resourcesDiff)
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
