module IdleGame.Skill exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)


updateBySkill : Skill -> (a -> a) -> SkillRecord a -> SkillRecord a
updateBySkill skill fn record =
    setBySkill skill (fn (getBySkill skill record)) record
