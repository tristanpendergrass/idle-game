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
    { anatomy = anatomyStats
    , medicalEthics = medicalEthicsStats
    }


anatomyStats : Stats
anatomyStats =
    { title = "Anatomy"
    , icon = Icon.chores
    }


medicalEthicsStats : Stats
medicalEthicsStats =
    { title = "Medical Ethics"
    , icon = Icon.hexes
    }
