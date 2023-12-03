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


type alias Stats =
    { title : String
    , icon : Icon
    }


getStats : Monster -> Stats
getStats kind =
    getByMonster kind allStats


allStats : MonsterRecord Stats
allStats =
    { prefect = Stats "Prefect" Icon.underConstruction
    , bookWyrm = Stats "Book Wyrm" Icon.underConstruction
    , whisperingWind = Stats "Whispering Wind" Icon.underConstruction
    }



-- Utils


getLabel : Monster -> String
getLabel monster =
    (getStats monster).title
