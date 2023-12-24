module IdleGame.Skill exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)


updateBySkill : Skill -> (a -> a) -> SkillRecord a -> SkillRecord a
updateBySkill skill fn record =
    setBySkill skill (fn (getBySkill skill record)) record



-- Stats


type alias Stats =
    { title : String
    , icon : Icon
    }


getStats : Skill -> Stats
getStats skill =
    getBySkill skill allStats


allStats : SkillRecord Stats
allStats =
    { chores = choresStats
    , hexes = hexesStats
    , weathermancing = weathermancingStats
    }


choresStats : Stats
choresStats =
    { title = "Chores"
    , icon = Icon.chores
    }


hexesStats : Stats
hexesStats =
    { title = "Hexes"
    , icon = Icon.hexes
    }


weathermancingStats : Stats
weathermancingStats =
    { title = "Weathermancing"
    , icon = Icon.weathermancing
    }
