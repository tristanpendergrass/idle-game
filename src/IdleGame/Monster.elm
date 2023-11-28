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
        SchoolGrounds ->
            [ Prefect
            , BookWyrm
            ]

        SecretGarden ->
            [ WhisperingWind
            ]


allMonsters : List Monster
allMonsters =
    [ Prefect
    , BookWyrm
    , WhisperingWind
    ]


type alias Record a =
    { prefect : a
    , bookWyrm : a
    , whisperingWind : a
    }


createRecord : a -> Record a
createRecord d =
    { prefect = d
    , bookWyrm = d
    , whisperingWind = d
    }


getByKind : Monster -> Record a -> a
getByKind kind record =
    case kind of
        Prefect ->
            record.prefect

        BookWyrm ->
            record.bookWyrm

        WhisperingWind ->
            record.whisperingWind


setByKind : Monster -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        Prefect ->
            { record | prefect = value }

        BookWyrm ->
            { record | bookWyrm = value }

        WhisperingWind ->
            { record | whisperingWind = value }


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
    { prefect = Stats "Prefect" Icon.underConstruction
    , bookWyrm = Stats "Book Wyrm" Icon.underConstruction
    , whisperingWind = Stats "Whispering Wind" Icon.underConstruction
    }



-- Utils


getLabel : Monster -> String
getLabel monster =
    (getStats monster).title
