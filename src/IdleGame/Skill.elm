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
    { anatomy = { title = "Anatomy", icon = Icon.chores }
    , biochemistry = { title = "Biochemistry", icon = Icon.chores }
    , physiology = { title = "Physiology", icon = Icon.chores }
    , pharmacology = { title = "Pharmacology", icon = Icon.chores }
    , microbiology = { title = "Microbiology", icon = Icon.chores }
    , pathology = { title = "Pathology", icon = Icon.chores }
    , medicalEthics = { title = "Medical Ethics", icon = Icon.chores }
    }
