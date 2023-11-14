module IdleGame.Monster exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)


allMonstersByLocation : Location -> List Monster
allMonstersByLocation location =
    case location of
        Location1 ->
            [ Monster1
            , Monster2
            ]

        _ ->
            []


allMonsters : List Monster
allMonsters =
    [ Monster1
    , Monster2
    ]


type alias Record a =
    { monster1 : a
    , monster2 : a
    }


createRecord : a -> Record a
createRecord d =
    { monster1 = d
    , monster2 = d
    }


getByKind : Monster -> Record a -> a
getByKind kind record =
    case kind of
        Monster1 ->
            record.monster1

        Monster2 ->
            record.monster2


setByKind : Monster -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        Monster1 ->
            { record | monster1 = value }

        Monster2 ->
            { record | monster2 = value }


updateByKind : Monster -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record


type alias Stats =
    { title : String
    , icon : Icon
    }


getStats : Monster -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { monster1 = { title = "Monster 1", icon = Icon.fromString "M1" }
    , monster2 = { title = "Monster 2", icon = Icon.fromString "M2" }
    }
