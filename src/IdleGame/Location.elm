module IdleGame.Location exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)


allLocations : List Location
allLocations =
    [ Location1, Location2 ]


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


type alias Stats =
    { title : String
    }


getStats : Location -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { location1 = { title = "Location 1" }
    , location2 = { title = "Location 2" }
    }
