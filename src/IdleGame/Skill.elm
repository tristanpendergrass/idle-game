module IdleGame.Skill exposing (..)

import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)


getLabel : Skill -> String
getLabel kind =
    case kind of
        Chores ->
            "Chores"

        Hexes ->
            "Hexes"

        Weathermancing ->
            "Weathermancing"


getIcon : Skill -> Icon
getIcon kind =
    case kind of
        Chores ->
            Icon.chores

        Hexes ->
            Icon.hexes

        Weathermancing ->
            Icon.weathermancing


updateByKindSkill : Skill -> (a -> a) -> SkillRecord a -> SkillRecord a
updateByKindSkill skill fn record =
    setBySkill skill (fn (getBySkill skill record)) record
