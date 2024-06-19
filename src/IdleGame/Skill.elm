module IdleGame.Skill exposing (..)

import IdleGame.Kinds exposing (..)


updateBySkill : Skill -> (a -> a) -> SkillRecord a -> SkillRecord a
updateBySkill skill fn record =
    setBySkill skill (fn (getBySkill skill record)) record
