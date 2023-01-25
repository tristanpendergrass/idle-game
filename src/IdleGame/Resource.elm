module IdleGame.Resource exposing (..)


type
    Resource
    -- Don't forget to update `allResources` when you add stuff here!
    = Manure
    | Ore
    | Ingot
    | Ruby
    | Stick


allResources : List Resource
allResources =
    [ Manure, Ore, Ingot, Ruby, Stick ]


type alias ResourceConfig =
    { string : String
    , getter : Resources -> Int
    , setter : Int -> Resources -> Resources
    }


getConfig : Resource -> ResourceConfig
getConfig resource =
    case resource of
        Manure ->
            { string = "Manure"
            , getter = .manure
            , setter = \amount resources -> { resources | manure = amount }
            }

        Ore ->
            { string = "Ore"
            , getter = .ore
            , setter = \amount resources -> { resources | ore = amount }
            }

        Ingot ->
            { string = "Ingot"
            , getter = .ingots
            , setter = \amount resources -> { resources | ingots = amount }
            }

        Ruby ->
            { string = "Ruby"
            , getter = .rubies
            , setter = \amount resources -> { resources | rubies = amount }
            }

        Stick ->
            { string = "Stick"
            , getter = .sticks
            , setter = \amount resources -> { resources | sticks = amount }
            }


toString : Resource -> String
toString resource =
    (getConfig resource).string


type alias Resources =
    { manure : Int
    , ore : Int
    , ingots : Int
    , rubies : Int
    , sticks : Int
    }


type alias ResourcesDiff =
    -- I don't know if it will always make sense for this type alias and Resources to be the same shape but for now it is and saves us work
    Resources


createResources : Resources
createResources =
    { manure = 0
    , ore = 0
    , ingots = 0
    , rubies = 0
    , sticks = 0
    }


getAmount : Resource -> Resources -> Int
getAmount resource =
    (getConfig resource).getter


addResource : Resource -> Int -> Resources -> Resources
addResource resource amount resources =
    let
        oldAmount =
            (getConfig resource).getter resources
    in
    (getConfig resource).setter (oldAmount + amount) resources


getDiff : { original : Resources, current : Resources } -> ResourcesDiff
getDiff { original, current } =
    { manure = current.manure - original.manure
    , ore = current.ore - original.ore
    , ingots = current.ingots - original.ingots
    , rubies = current.rubies - original.rubies
    , sticks = current.sticks - original.sticks
    }


mapDiff : (Int -> Resource -> a) -> Resources -> List a
mapDiff fn diff =
    [ Manure, Ore, Ingot, Ruby, Stick ]
        |> List.map
            (\resource ->
                let
                    amount =
                        (getConfig resource).getter diff
                in
                fn amount resource
            )


isEmptyDiff : ResourcesDiff -> Bool
isEmptyDiff resourcesDiff =
    [ Manure, Ore, Ingot, Ruby, Stick ]
        |> List.map (\resource -> getAmount resource resourcesDiff)
        |> List.all ((==) 0)


mapResources : (Int -> Resource -> a) -> Resources -> List a
mapResources fn resources =
    [ Manure, Ore, Ingot, Ruby, Stick ]
        |> List.map
            (\resource ->
                let
                    amount =
                        (getConfig resource).getter resources
                in
                fn amount resource
            )
