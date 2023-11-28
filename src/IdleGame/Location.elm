module IdleGame.Location exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Random


allLocations : List Location
allLocations =
    [ SchoolGrounds, SecretGarden ]



-- Record


type alias Record a =
    { schoolGrounds : a
    , secretGarden : a
    }


createRecord : a -> Record a
createRecord d =
    Record d d


getByKind : Location -> Record a -> a
getByKind kind record =
    case kind of
        SchoolGrounds ->
            record.schoolGrounds

        SecretGarden ->
            record.secretGarden


setByKind : Location -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        SchoolGrounds ->
            { record | schoolGrounds = value }

        SecretGarden ->
            { record | secretGarden = value }


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
    { schoolGrounds =
        { title = "School Grounds"
        , monsters = monstersFromList [ Prefect, BookWyrm ]
        , resources = resourcesFromList [ Parchment ]
        , quests = questsFromList [ MendCrackedBell, ChopFirewood ]
        , exploreActivity = ExploreSchoolGrounds
        }
    , secretGarden =
        { title = "Secret Garden"
        , monsters = monstersFromList [ WhisperingWind ]
        , resources = resourcesFromList [ WashWater ]
        , quests = questsFromList []
        , exploreActivity = ExploreSecretGarden
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


type alias ExploreResult =
    { state : State
    , effects : List Effect.TaggedEffect
    , toasts : List Toast
    }


explorationGenerator : Location -> State -> Random.Generator ExploreResult
explorationGenerator location state =
    let
        initialResult : ExploreResult
        initialResult =
            { state = state
            , effects = []
            , toasts = []
            }
    in
    findMonsterGenerator location initialResult
        |> Random.andThen (findResourceGenerator location)
        |> Random.andThen (gatherResourceGenerator location)
        |> Random.andThen (findQuestGenerator location)


findMonsterGenerator : Location -> ExploreResult -> Random.Generator ExploreResult
findMonsterGenerator location result =
    case findableMonsters location result.state of
        -- If there's at least one monster to find, pick one at random and set it to found
        first :: rest ->
            Random.uniform first rest
                |> Random.map
                    (\monster ->
                        { state = setMonsterToFound monster result.state
                        , effects = List.concat [ result.effects, [] ]
                        , toasts = List.concat [ result.toasts, [ DiscoveredMonster monster ] ]
                        }
                    )

        -- Otherwise, return the state unchanged
        [] ->
            Random.constant result


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


findResourceGenerator : Location -> ExploreResult -> Random.Generator ExploreResult
findResourceGenerator location result =
    case findableResources location result.state of
        -- If there's at least one resource to find, pick one at random and set it to found
        first :: rest ->
            Random.uniform first rest
                |> Random.map
                    (\resource ->
                        { state = setResourceToFound resource result.state
                        , effects = List.concat [ result.effects, [ Effect.gainResource 1 resource ] ]
                        , toasts = List.concat [ result.toasts, [ DiscoveredResource resource ] ]
                        }
                    )

        -- Otherwise, return the state unchanged
        [] ->
            Random.constant result


gatherResourceGenerator : Location -> ExploreResult -> Random.Generator ExploreResult
gatherResourceGenerator location result =
    case foundResources location result.state of
        first :: rest ->
            Random.uniform first rest
                |> Random.map
                    (\resource ->
                        let
                            amount : Int
                            amount =
                                1
                        in
                        { state = result.state
                        , effects = List.concat [ result.effects, [ Effect.gainResource amount resource ] ]
                        , toasts = List.concat [ result.toasts, [] ]
                        }
                    )

        [] ->
            Random.constant result


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


findQuestGenerator : Location -> ExploreResult -> Random.Generator ExploreResult
findQuestGenerator location result =
    case findableQuests location result.state of
        -- If there's at least one quest to find, pick one at random and set it to found
        first :: rest ->
            Random.uniform first rest
                |> Random.map
                    (\quest ->
                        { state = setQuestToFound quest result.state
                        , effects = List.concat [ result.effects, [] ]
                        , toasts = List.concat [ result.toasts, [ DiscoveredQuest quest ] ]
                        }
                    )

        -- Otherwise, return the state unchanged
        [] ->
            Random.constant result


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


getCompletion : Location -> State -> Percent
getCompletion location state =
    let
        numerator : Int
        numerator =
            List.length (foundMonsters location state)
                + List.length (foundResources location state)
                + List.length (foundQuests location state)

        denominator : Int
        denominator =
            List.length (monstersAtLocation location)
                + List.length (resourcesAtLocation location)
                + List.length (questsAtLocation location)
    in
    Percent.float (toFloat numerator / toFloat denominator)
