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



-- RESOURCES


type Resource
    = Sage
    | Nettle
    | Sorrel
    | Mugwort
    | Yarrow
    | Thyme
    | Fennel
    | Belladonna
    | Henbane


allResources : List Resource
allResources =
    [ Sage
    , Nettle
    , Sorrel
    , Mugwort
    , Yarrow
    , Thyme
    , Fennel
    , Belladonna
    , Henbane
    ]


type alias ResourceRecord a =
    { sage : a
    , nettle : a
    , sorrel : a
    , mugwort : a
    , yarrow : a
    , thyme : a
    , fennel : a
    , belladonna : a
    , henbane : a
    }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { sage = a
    , nettle = a
    , sorrel = a
    , mugwort = a
    , yarrow = a
    , thyme = a
    , fennel = a
    , belladonna = a
    , henbane = a
    }


getByResource : Resource -> ResourceRecord a -> a
getByResource kind data =
    case kind of
        Sage ->
            data.sage

        Nettle ->
            data.nettle

        Sorrel ->
            data.sorrel

        Mugwort ->
            data.mugwort

        Yarrow ->
            data.yarrow

        Thyme ->
            data.thyme

        Fennel ->
            data.fennel

        Belladonna ->
            data.belladonna

        Henbane ->
            data.henbane


setByResource : Resource -> a -> ResourceRecord a -> ResourceRecord a
setByResource kind value data =
    case kind of
        Sage ->
            { data | sage = value }

        Nettle ->
            { data | nettle = value }

        Sorrel ->
            { data | sorrel = value }

        Mugwort ->
            { data | mugwort = value }

        Yarrow ->
            { data | yarrow = value }

        Thyme ->
            { data | thyme = value }

        Fennel ->
            { data | fennel = value }

        Belladonna ->
            { data | belladonna = value }

        Henbane ->
            { data | henbane = value }


mapResources : (a -> a) -> ResourceRecord a -> ResourceRecord a
mapResources fn record =
    { sage = fn record.sage
    , nettle = fn record.nettle
    , sorrel = fn record.sorrel
    , mugwort = fn record.mugwort
    , yarrow = fn record.yarrow
    , thyme = fn record.thyme
    , fennel = fn record.fennel
    , belladonna = fn record.belladonna
    , henbane = fn record.henbane
    }


type alias ResourceStats =
    { title : String
    , icon : IdleGame.Views.Icon.Icon
    , price : IdleGame.Coin.Coin
    }


resourceStats : ResourceRecord ResourceStats
resourceStats =
    { sage = { title = "Sage", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , nettle = { title = "Nettle", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , sorrel = { title = "Sorrel", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , mugwort = { title = "Mugwort", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , yarrow = { title = "Yarrow", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , thyme = { title = "Thyme", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , fennel = { title = "Fennel", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , belladonna = { title = "Belladonna", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    , henbane = { title = "Henbane", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    }


getResourceStats : Resource -> ResourceStats
getResourceStats kind =
    getByResource kind resourceStats
