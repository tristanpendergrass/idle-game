module IdleGame.Location exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Monster as Monster
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
    in
    { location1 =
        { title = "Location 1"
        , monsters = monstersFromList [ Monster1 ]
        , exploreActivity = ExploreLocation1
        }
    , location2 =
        { title = "Location 2"
        , monsters = monstersFromList [ Monster2 ]
        , exploreActivity = ExploreLocation2
        }
    }



-- State


type alias State =
    { foundMonsters : Monster.Record Bool
    }


createState : State
createState =
    { foundMonsters = Monster.createRecord False
    }


setMonsterToFound : Monster -> State -> State
setMonsterToFound monster state =
    { state
        | foundMonsters =
            Monster.setByKind monster True state.foundMonsters
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
