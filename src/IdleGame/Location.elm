module IdleGame.Location exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import Random


allLocations : List Location
allLocations =
    [ Location1, Location2 ]



-- Record


type alias Record a =
    { location1 : a
    , location2 : a
    }


createRecord : a -> Record a
createRecord d =
    Record d d


getByKind : Location -> Record a -> a
getByKind kind record =
    case kind of
        Location1 ->
            record.location1

        Location2 ->
            record.location2


setByKind : Location -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        Location1 ->
            { record | location1 = value }

        Location2 ->
            { record | location2 = value }


updateByKind : Location -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record



-- Stats


type alias Stats =
    { title : String
    , monsters : Monster.Record Bool
    , resources : Resource.Record Bool
    , quests : Quest.Record Bool
    , exploreActivity : Activity
    }


getStats : Location -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    let
        monstersFromList : List Monster -> Monster.Record Bool
        monstersFromList =
            List.foldl
                (\monster accum ->
                    Monster.setByKind monster True accum
                )
                (Monster.createRecord False)

        resourcesFromList : List Resource -> Resource.Record Bool
        resourcesFromList =
            List.foldl
                (\resource accum ->
                    Resource.setByKind resource True accum
                )
                (Resource.createRecord False)

        questsFromList : List Quest -> Quest.Record Bool
        questsFromList =
            List.foldl
                (\quest accum ->
                    Quest.setByKind quest True accum
                )
                (Quest.createRecord False)
    in
    { location1 =
        { title = "Location 1"
        , monsters = monstersFromList [ Monster1 ]
        , resources = resourcesFromList [ Parchment ]
        , quests = questsFromList [ Quest1, Quest2 ]
        , exploreActivity = ExploreLocation1
        }
    , location2 =
        { title = "Location 2"
        , monsters = monstersFromList [ Monster2 ]
        , resources = resourcesFromList [ WashWater ]
        , quests = questsFromList []
        , exploreActivity = ExploreLocation2
        }
    }



-- State


type alias State =
    { foundMonsters : Monster.Record Bool
    , foundResources : Resource.Record Bool
    , foundQuests : Quest.Record Bool
    }


createState : State
createState =
    { foundMonsters = Monster.createRecord False
    , foundResources = Resource.createRecord False
    , foundQuests = Quest.createRecord False
    }


setMonsterToFound : Monster -> State -> State
setMonsterToFound monster state =
    { state
        | foundMonsters =
            Monster.setByKind monster True state.foundMonsters
    }


setResourceToFound : Resource -> State -> State
setResourceToFound resource state =
    { state
        | foundResources =
            Resource.setByKind resource True state.foundResources
    }


setQuestToFound : Quest -> State -> State
setQuestToFound quest state =
    { state
        | foundQuests =
            Quest.setByKind quest True state.foundQuests
    }



-- Utils


getLabel : Location -> String
getLabel kind =
    (getStats kind).title


findMonsterGenerator : Location -> State -> Random.Generator State
findMonsterGenerator location state =
    case findableMonsters location state of
        -- If there's at least one monster to find, pick one at random and set it to found
        first :: rest ->
            Random.uniform first rest
                |> Random.map (\monster -> setMonsterToFound monster state)

        -- Otherwise, return the state unchanged
        [] ->
            Random.constant state


findableMonsters : Location -> State -> List Monster
findableMonsters location state =
    Monster.allMonsters
        |> List.filter
            (\monster ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        Monster.getByKind monster (getStats location).monsters

                    isFound : Bool
                    isFound =
                        Monster.getByKind monster state.foundMonsters
                in
                isAtLocation && not isFound
            )


foundMonsters : Location -> State -> List Monster
foundMonsters location state =
    Monster.allMonsters
        |> List.filter
            (\monster ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        Monster.getByKind monster (getStats location).monsters

                    isFound : Bool
                    isFound =
                        Monster.getByKind monster state.foundMonsters
                in
                isAtLocation && isFound
            )


monstersAtLocation : Location -> List Monster
monstersAtLocation location =
    Monster.allMonsters
        |> List.filter (\monster -> Monster.getByKind monster (getStats location).monsters)


findResourceGenerator : Location -> State -> Random.Generator State
findResourceGenerator location state =
    case findableResources location state of
        -- If there's at least one resource to find, pick one at random and set it to found
        first :: rest ->
            Random.uniform first rest
                |> Random.map (\resource -> setResourceToFound resource state)

        -- Otherwise, return the state unchanged
        [] ->
            Random.constant state


findableResources : Location -> State -> List Resource
findableResources location state =
    Resource.allResources
        |> List.filter
            (\resource ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        Resource.getByKind resource (getStats location).resources

                    isFound : Bool
                    isFound =
                        Resource.getByKind resource state.foundResources
                in
                isAtLocation && not isFound
            )


foundResources : Location -> State -> List Resource
foundResources location state =
    Resource.allResources
        |> List.filter
            (\resource ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        Resource.getByKind resource (getStats location).resources

                    isFound : Bool
                    isFound =
                        Resource.getByKind resource state.foundResources
                in
                isAtLocation && isFound
            )


resourcesAtLocation : Location -> List Resource
resourcesAtLocation location =
    Resource.allResources
        |> List.filter (\resource -> Resource.getByKind resource (getStats location).resources)


findQuestGenerator : Location -> State -> Random.Generator State
findQuestGenerator location state =
    case findableQuests location state of
        -- If there's at least one quest to find, pick one at random and set it to found
        first :: rest ->
            Random.uniform first rest
                |> Random.map (\quest -> setQuestToFound quest state)

        -- Otherwise, return the state unchanged
        [] ->
            Random.constant state


findableQuests : Location -> State -> List Quest
findableQuests location state =
    Quest.allQuests
        |> List.filter
            (\quest ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        Quest.getByKind quest (getStats location).quests

                    isFound : Bool
                    isFound =
                        Quest.getByKind quest state.foundQuests
                in
                isAtLocation && not isFound
            )


foundQuests : Location -> State -> List Quest
foundQuests location state =
    Quest.allQuests
        |> List.filter
            (\quest ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        Quest.getByKind quest (getStats location).quests

                    isFound : Bool
                    isFound =
                        Quest.getByKind quest state.foundQuests
                in
                isAtLocation && isFound
            )


questsAtLocation : Location -> List Quest
questsAtLocation location =
    Quest.allQuests
        |> List.filter (\quest -> Quest.getByKind quest (getStats location).quests)
