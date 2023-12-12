module IdleGame.Location exposing (..)

import Duration exposing (Duration)
import Fuzz exposing (frequency)
import Html.Attributes exposing (download)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import Json.Decode exposing (maybe)
import Maybe.Extra
import Percent exposing (Percent)
import Quantity exposing (Quantity(..))
import Random
import Random.Extra


totalExplorationDuration : Duration
totalExplorationDuration =
    -- How long it should take of exploring a location to find all the stuff
    Duration.days 2


exploreActivityDuration : Duration
exploreActivityDuration =
    -- How often an exploration effect happens when exploring
    Duration.seconds 4



-- Stats


type SingleResource
    = SingleResource


type alias ResourcesPerSecond =
    Quantity.Rate SingleResource Duration.Seconds


type alias ResourceFrequency =
    Quantity Float ResourcesPerSecond


resourcesPerSecond : Float -> ResourceFrequency
resourcesPerSecond =
    Quantity


resourcesPerHour : Float -> ResourceFrequency
resourcesPerHour numResourcesPerHour =
    resourcesPerSecond (numResourcesPerHour / 3600)


inResourcesPerSecond : ResourceFrequency -> Float
inResourcesPerSecond (Quantity freq) =
    freq


inResourcesPerActivityDuration : ResourceFrequency -> Float
inResourcesPerActivityDuration (Quantity freq) =
    freq * Duration.inSeconds exploreActivityDuration


type alias Stats =
    { title : String
    , monsters : MonsterRecord Bool
    , resources : ResourceRecord (Maybe ResourceFrequency)
    , quests : QuestRecord Bool
    , exploreActivity : Activity
    }


getStats : Location -> Stats
getStats kind =
    getByLocation kind allStats


allStats : LocationRecord Stats
allStats =
    let
        monstersFromList : List Monster -> MonsterRecord Bool
        monstersFromList =
            List.foldl
                (\monster accum ->
                    setByMonster monster True accum
                )
                (monsterRecord False)

        resourcesFromList : List ( Resource, ResourceFrequency ) -> ResourceRecord (Maybe ResourceFrequency)
        resourcesFromList =
            List.foldl
                (\( resource, frequency ) accum ->
                    setByResource resource (Just frequency) accum
                )
                (resourceRecord Nothing)

        questsFromList : List Quest -> QuestRecord Bool
        questsFromList =
            List.foldl
                (\quest accum ->
                    setByQuest quest True accum
                )
                (questRecord False)
    in
    { schoolGrounds =
        { title = "School Grounds"
        , monsters = monstersFromList [ Prefect, BookWyrm ]
        , resources = resourcesFromList [ ( Parchment, resourcesPerHour 1 ) ]
        , quests = questsFromList [ MendCrackedBell, ChopFirewood ]
        , exploreActivity = ExploreSchoolGrounds
        }
    , secretGarden =
        { title = "Secret Garden"
        , monsters = monstersFromList [ WhisperingWind ]
        , resources = resourcesFromList [ ( WashWater, resourcesPerHour 1 ) ]
        , quests = questsFromList []
        , exploreActivity = ExploreSecretGarden
        }
    }



-- State


type alias State =
    { foundMonsters : MonsterRecord Bool
    , foundResources : ResourceRecord Bool
    , foundQuests : QuestRecord Bool
    , discoveryTimer : Timer -- When this ticks over, you discover something
    }


getInterval : Location -> Duration
getInterval location =
    let
        totalThingsToDiscover : Int
        totalThingsToDiscover =
            List.length (monstersAtLocation location) + List.length (resourcesAtLocation location) + List.length (questsAtLocation location)
    in
    Quantity.divideBy (toFloat totalThingsToDiscover) totalExplorationDuration


createState : State
createState =
    { foundMonsters = monsterRecord False
    , foundResources = resourceRecord False
    , foundQuests = questRecord False
    , discoveryTimer = Timer.create
    }


setMonsterToFound : Monster -> State -> State
setMonsterToFound monster state =
    { state
        | foundMonsters =
            setByMonster monster True state.foundMonsters
    }


setResourceToFound : Resource -> State -> State
setResourceToFound resource state =
    { state
        | foundResources =
            setByResource resource True state.foundResources
    }


setQuestToFound : Quest -> State -> State
setQuestToFound quest state =
    { state
        | foundQuests =
            setByQuest quest True state.foundQuests
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


type Discoverable
    = DiscoverMonster Monster
    | DiscoverQuest Quest
    | DiscoverResource Resource


explorationGenerator : Location -> State -> Random.Generator ExploreResult
explorationGenerator location state =
    gatherGenerator location state
        |> Random.andThen
            (\gatherResult ->
                discoveryGenerator location gatherResult.state
                    |> Random.map
                        (\discoveryResult ->
                            { state = discoveryResult.state
                            , effects = List.concat [ gatherResult.effects, discoveryResult.effects ]
                            , toasts = List.concat [ gatherResult.toasts, discoveryResult.toasts ]
                            }
                        )
            )


gatherResource : Resource -> ExploreResult -> ExploreResult
gatherResource resource result =
    { result
        | effects = Effect.gainResource 1 resource :: result.effects
        , toasts = GainedResource 1 resource :: result.toasts
    }


probability : Random.Generator Float
probability =
    Random.float 0 1


frequencyGenerator : ResourceFrequency -> Random.Generator Bool
frequencyGenerator resourceFrequency =
    let
        resourcesPerActivityDuration : Float
        resourcesPerActivityDuration =
            inResourcesPerActivityDuration resourceFrequency
    in
    Random.map (\p -> Debug.log "foobar p" p < Debug.log "foobar other p" resourcesPerActivityDuration) probability


didGatherGenerator : Resource -> Location -> State -> Random.Generator (Maybe Resource)
didGatherGenerator resource location state =
    let
        isFound : Bool
        isFound =
            getByResource resource state.foundResources

        locationStats : Stats
        locationStats =
            getStats location

        maybeFrequency : Maybe ResourceFrequency
        maybeFrequency =
            getByResource resource locationStats.resources
    in
    if isFound then
        case maybeFrequency of
            Nothing ->
                Random.constant Nothing

            Just resourceFrequency ->
                frequencyGenerator resourceFrequency
                    |> Random.map
                        (\didGather ->
                            if didGather then
                                Just resource

                            else
                                Nothing
                        )

    else
        Random.constant Nothing


gatherGenerator : Location -> State -> Random.Generator ExploreResult
gatherGenerator location state =
    let
        candidates : List Resource
        candidates =
            foundResources location state
    in
    Debug.log "foobar candidates" candidates
        |> List.map (\resource -> didGatherGenerator resource location state)
        |> Random.Extra.sequence
        |> Random.map
            (\didGatherResults ->
                let
                    gatheredResources : List Resource
                    gatheredResources =
                        List.filterMap identity didGatherResults
                in
                List.foldl gatherResource { state = state, effects = [], toasts = [] } gatheredResources
            )


discoveryGenerator : Location -> State -> Random.Generator ExploreResult
discoveryGenerator location state =
    let
        ( newDiscoveryTimer, discoveryCount ) =
            Timer.increment (getInterval location) exploreActivityDuration state.discoveryTimer
    in
    explorationGeneratorHelper discoveryCount location { state = { state | discoveryTimer = newDiscoveryTimer }, effects = [], toasts = [] }


applyDiscovery : Discoverable -> ExploreResult -> ExploreResult
applyDiscovery discovery result =
    case discovery of
        DiscoverMonster monster ->
            { result
                | state = setMonsterToFound monster result.state
                , toasts = DiscoveredMonster monster :: result.toasts
            }

        DiscoverQuest quest ->
            { result
                | state = setQuestToFound quest result.state
                , toasts = DiscoveredQuest quest :: result.toasts
            }

        DiscoverResource resource ->
            { result
                | state = setResourceToFound resource result.state
                , effects = List.concat [ result.effects, [ Effect.gainResource 1 resource ] ]
                , toasts = List.concat [ result.toasts, [ DiscoveredResource resource ] ]
            }


explorationGeneratorHelper : Int -> Location -> ExploreResult -> Random.Generator ExploreResult
explorationGeneratorHelper count location result =
    if count < 1 then
        Random.constant result

    else
        discoverGenerator location result.state
            |> Random.andThen
                (\maybeDiscovery ->
                    let
                        newCount : Int
                        newCount =
                            count - 1
                    in
                    case maybeDiscovery of
                        Nothing ->
                            explorationGeneratorHelper newCount location result

                        Just discovery ->
                            explorationGeneratorHelper newCount location (applyDiscovery discovery result)
                )


discoverGenerator : Location -> State -> Random.Generator (Maybe Discoverable)
discoverGenerator location state =
    let
        discoverables : List Discoverable
        discoverables =
            List.concat
                [ List.map DiscoverMonster (monstersAtLocation location)
                , List.map DiscoverQuest (questsAtLocation location)
                , List.map DiscoverResource (resourcesAtLocation location)
                ]
    in
    case discoverables of
        [] ->
            Random.constant Nothing

        first :: rest ->
            Random.uniform first rest
                |> Random.map Just


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
    allMonsters
        |> List.filter
            (\monster ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        getByMonster monster (getStats location).monsters

                    isFound : Bool
                    isFound =
                        getByMonster monster state.foundMonsters
                in
                isAtLocation && not isFound
            )


foundMonsters : Location -> State -> List Monster
foundMonsters location state =
    allMonsters
        |> List.filter
            (\monster ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        getByMonster monster (getStats location).monsters

                    isFound : Bool
                    isFound =
                        getByMonster monster state.foundMonsters
                in
                isAtLocation && isFound
            )


monstersAtLocation : Location -> List Monster
monstersAtLocation location =
    allMonsters
        |> List.filter (\monster -> getByMonster monster (getStats location).monsters)


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
    allResources
        |> List.filter
            (\resource ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        getByResource resource (getStats location).resources
                            |> Maybe.Extra.isJust

                    isFound : Bool
                    isFound =
                        getByResource resource state.foundResources
                in
                isAtLocation && not isFound
            )


foundResources : Location -> State -> List Resource
foundResources location state =
    allResources
        |> List.filter
            (\resource ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        getByResource resource (getStats location).resources
                            |> Maybe.Extra.isJust

                    isFound : Bool
                    isFound =
                        getByResource resource state.foundResources
                in
                isAtLocation && isFound
            )


resourcesAtLocation : Location -> List Resource
resourcesAtLocation location =
    allResources
        |> List.filter (\resource -> Maybe.Extra.isJust (getByResource resource (getStats location).resources))


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
    allQuests
        |> List.filter
            (\quest ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        getByQuest quest (getStats location).quests

                    isFound : Bool
                    isFound =
                        getByQuest quest state.foundQuests
                in
                isAtLocation && not isFound
            )


foundQuests : Location -> State -> List Quest
foundQuests location state =
    allQuests
        |> List.filter
            (\quest ->
                let
                    isAtLocation : Bool
                    isAtLocation =
                        getByQuest quest (getStats location).quests

                    isFound : Bool
                    isFound =
                        getByQuest quest state.foundQuests
                in
                isAtLocation && isFound
            )


questsAtLocation : Location -> List Quest
questsAtLocation location =
    allQuests
        |> List.filter (\quest -> getByQuest quest (getStats location).quests)


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


updateByKindLocation : Location -> (a -> a) -> LocationRecord a -> LocationRecord a
updateByKindLocation location fn record =
    setByLocation location (fn (getByLocation location record)) record
