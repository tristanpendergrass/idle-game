module IdleGame.Monster exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event exposing (Event)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Locations exposing (Location)
import IdleGame.Kinds.Monsters exposing (Monster)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)


allMonstersByLocation : Location -> List Monster
allMonstersByLocation location =
    case location of
        IdleGame.Kinds.Locations.Location1 ->
            [ IdleGame.Kinds.Monsters.Monster1
            , IdleGame.Kinds.Monsters.Monster2
            ]

        _ ->
            []


allMonsters : List Monster
allMonsters =
    [ IdleGame.Kinds.Monsters.Monster1
    , IdleGame.Kinds.Monsters.Monster2
    ]


type alias Record a =
    { monster1 : a
    , monster2 : a
    }


createRecord : a -> Record a
createRecord d =
    Record d d


getByKind : Monster -> Record a -> a
getByKind kind record =
    case kind of
        IdleGame.Kinds.Monsters.Monster1 ->
            record.monster1

        IdleGame.Kinds.Monsters.Monster2 ->
            record.monster2


setByKind : Monster -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        IdleGame.Kinds.Monsters.Monster1 ->
            { record | monster1 = value }

        IdleGame.Kinds.Monsters.Monster2 ->
            { record | monster2 = value }


updateByKind : Monster -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record


type alias Stats =
    { title : String
    , image : Icon
    }


getStats : Monster -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { monster1 = { title = "Monster 1", image = Icon.letter "M1" }
    , monster2 = { title = "Monster 2", image = Icon.letter "M2" }
    }
