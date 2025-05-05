module IdleGame.Kinds exposing (..)

import Duration
import IdleGame.Coin
import IdleGame.Views.Icon


type Skill
    = HerbGathering
    | WildMagic
    | Soup


allSkills : List Skill
allSkills =
    [ HerbGathering
    , WildMagic
    , Soup
    ]


type alias SkillRecord a =
    { herbGathering : a
    , wildMagic : a
    , soup : a
    }


skillRecord : a -> SkillRecord a
skillRecord a =
    { herbGathering = a
    , wildMagic = a
    , soup = a
    }


getBySkill : Skill -> SkillRecord a -> a
getBySkill kind data =
    case kind of
        HerbGathering ->
            data.herbGathering

        WildMagic ->
            data.wildMagic

        Soup ->
            data.soup


setBySkill : Skill -> a -> SkillRecord a -> SkillRecord a
setBySkill kind value data =
    case kind of
        HerbGathering ->
            { data | herbGathering = value }

        WildMagic ->
            { data | wildMagic = value }

        Soup ->
            { data | soup = value }


type alias SkillStats =
    { title : String, icon : IdleGame.Views.Icon.Icon }


mapSkills :
    (a -> a)
    -> SkillRecord a
    -> SkillRecord a
mapSkills fn record =
    { herbGathering = fn record.herbGathering
    , wildMagic = fn record.wildMagic
    , soup = fn record.soup
    }


skillStats : SkillRecord SkillStats
skillStats =
    { herbGathering = { title = "Herb Gathering", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams }
    , wildMagic = { title = "Wild Magic", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams }
    , soup = { title = "Soup", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialWorkspaces IdleGame.Views.Icon.defaultParams }
    }


getSkillStats : Skill -> SkillStats
getSkillStats kind =
    getBySkill kind skillStats
