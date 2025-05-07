module IdleGame.Kinds exposing (..)

import Duration
import IdleGame.Coin
import IdleGame.Views.Icon


type Skill
    = HerbGathering
    | WildMagic


allSkills : List Skill
allSkills =
    [ HerbGathering
    , WildMagic
    ]


type alias SkillRecord a =
    { herbGathering : a
    , wildMagic : a
    }


skillRecord : a -> SkillRecord a
skillRecord a =
    { herbGathering = a
    , wildMagic = a
    }


getBySkill : Skill -> SkillRecord a -> a
getBySkill kind data =
    case kind of
        HerbGathering ->
            data.herbGathering

        WildMagic ->
            data.wildMagic


setBySkill : Skill -> a -> SkillRecord a -> SkillRecord a
setBySkill kind value data =
    case kind of
        HerbGathering ->
            { data | herbGathering = value }

        WildMagic ->
            { data | wildMagic = value }


type alias SkillStats =
    { title : String, icon : IdleGame.Views.Icon.Icon }


mapSkills :
    (a -> a)
    -> SkillRecord a
    -> SkillRecord a
mapSkills fn record =
    { herbGathering = fn record.herbGathering
    , wildMagic = fn record.wildMagic
    }


skillStats : SkillRecord SkillStats
skillStats =
    { herbGathering = { title = "Herb Gathering", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams }
    , wildMagic = { title = "Wild Magic", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams }
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
    | Parchment


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
    , Parchment
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
    , parchment : a
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
    , parchment = a
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

        Parchment ->
            data.parchment


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

        Parchment ->
            { data | parchment = value }


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
    , parchment = fn record.parchment
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
    , parchment = { title = "Parchment", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams, price = IdleGame.Coin.zero }
    }


getResourceStats : Resource -> ResourceStats
getResourceStats kind =
    getByResource kind resourceStats



-- ACTIVITIES


type Activity
    = GatherSage
    | GatherNettle
    | GatherSorrel
    | GatherMugwort
    | GatherYarrow
    | GatherThyme
    | GatherFennel
    | GatherBelladonna
    | GatherHenbane


allActivities : List Activity
allActivities =
    [ GatherSage
    , GatherNettle
    , GatherSorrel
    , GatherMugwort
    , GatherYarrow
    , GatherThyme
    , GatherFennel
    , GatherBelladonna
    , GatherHenbane
    ]


type alias ActivityRecord a =
    { gatherSage : a
    , gatherNettle : a
    , gatherSorrel : a
    , gatherMugwort : a
    , gatherYarrow : a
    , gatherThyme : a
    , gatherFennel : a
    , gatherBelladonna : a
    , gatherHenbane : a
    }


activityRecord : a -> ActivityRecord a
activityRecord a =
    { gatherSage = a
    , gatherNettle = a
    , gatherSorrel = a
    , gatherMugwort = a
    , gatherYarrow = a
    , gatherThyme = a
    , gatherFennel = a
    , gatherBelladonna = a
    , gatherHenbane = a
    }


getByActivity : Activity -> ActivityRecord a -> a
getByActivity kind data =
    case kind of
        GatherSage ->
            data.gatherSage

        GatherNettle ->
            data.gatherNettle

        GatherSorrel ->
            data.gatherSorrel

        GatherMugwort ->
            data.gatherMugwort

        GatherYarrow ->
            data.gatherYarrow

        GatherThyme ->
            data.gatherThyme

        GatherFennel ->
            data.gatherFennel

        GatherBelladonna ->
            data.gatherBelladonna

        GatherHenbane ->
            data.gatherHenbane


setByActivity : Activity -> a -> ActivityRecord a -> ActivityRecord a
setByActivity kind value data =
    case kind of
        GatherSage ->
            { data | gatherSage = value }

        GatherNettle ->
            { data | gatherNettle = value }

        GatherSorrel ->
            { data | gatherSorrel = value }

        GatherMugwort ->
            { data | gatherMugwort = value }

        GatherYarrow ->
            { data | gatherYarrow = value }

        GatherThyme ->
            { data | gatherThyme = value }

        GatherFennel ->
            { data | gatherFennel = value }

        GatherBelladonna ->
            { data | gatherBelladonna = value }

        GatherHenbane ->
            { data | gatherHenbane = value }


mapActivities : (a -> a) -> ActivityRecord a -> ActivityRecord a
mapActivities fn record =
    { gatherSage = fn record.gatherSage
    , gatherNettle = fn record.gatherNettle
    , gatherSorrel = fn record.gatherSorrel
    , gatherMugwort = fn record.gatherMugwort
    , gatherYarrow = fn record.gatherYarrow
    , gatherThyme = fn record.gatherThyme
    , gatherFennel = fn record.gatherFennel
    , gatherBelladonna = fn record.gatherBelladonna
    , gatherHenbane = fn record.gatherHenbane
    }


type alias ActivityStats =
    { skill : Skill
    , title : String
    , image : String
    , level : Int
    , duration : Duration.Duration
    , type_ : String
    , coin : Maybe Int
    , resourceGains : List ( Int, Resource )
    }


activityStats : ActivityRecord ActivityStats
activityStats =
    { gatherSage =
        { skill = HerbGathering
        , title = "Gather Sage"
        , image = "/activities/herbGathering/gatherSage.webp"
        , level = 1
        , duration = Duration.seconds 5
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Sage ) ]
        }
    , gatherNettle =
        { skill = HerbGathering
        , title = "Gather Nettle"
        , image = "/activities/herbGathering/gatherNettle.webp"
        , level = 1
        , duration = Duration.seconds 5
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Nettle ) ]
        }
    , gatherSorrel =
        { skill = HerbGathering
        , title = "Gather Sorrel"
        , image = "/activities/herbGathering/gatherSorrel.webp"
        , level = 2
        , duration = Duration.seconds 10
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Sorrel ) ]
        }
    , gatherMugwort =
        { skill = HerbGathering
        , title = "Gather Mugwort"
        , image = "/activities/herbGathering/gatherMugwort.webp"
        , level = 3
        , duration = Duration.seconds 15
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Mugwort ) ]
        }
    , gatherYarrow =
        { skill = HerbGathering
        , title = "Gather Yarrow"
        , image = "/activities/herbGathering/gatherYarrow.webp"
        , level = 4
        , duration = Duration.seconds 20
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Yarrow ) ]
        }
    , gatherThyme =
        { skill = HerbGathering
        , title = "Gather Thyme"
        , image = "/activities/herbGathering/gatherThyme.webp"
        , level = 5
        , duration = Duration.seconds 25
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Thyme ) ]
        }
    , gatherFennel =
        { skill = HerbGathering
        , title = "Gather Fennel"
        , image = "/activities/herbGathering/gatherFennel.webp"
        , level = 6
        , duration = Duration.seconds 30
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Fennel ) ]
        }
    , gatherBelladonna =
        { skill = HerbGathering
        , title = "Gather Belladonna"
        , image = "/activities/herbGathering/gatherBelladonna.webp"
        , level = 7
        , duration = Duration.seconds 35
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Belladonna ) ]
        }
    , gatherHenbane =
        { skill = HerbGathering
        , title = "Gather Henbane"
        , image = "/activities/herbGathering/gatherHenbane.webp"
        , level = 8
        , duration = Duration.seconds 40
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Henbane ) ]
        }
    }


getActivityStats : Activity -> ActivityStats
getActivityStats kind =
    getByActivity kind activityStats



-- SHOP UPGRADES


type ShopUpgrade
    = Glasses


allShopUpgrades : List ShopUpgrade
allShopUpgrades =
    [ Glasses ]


type alias ShopUpgradeRecord a =
    { glasses : a }


shopUpgradeRecord : a -> ShopUpgradeRecord a
shopUpgradeRecord a =
    { glasses = a }


getByShopUpgrade : ShopUpgrade -> ShopUpgradeRecord glasses -> glasses
getByShopUpgrade kind data =
    case kind of
        Glasses ->
            data.glasses


setByShopUpgrade : ShopUpgrade -> value -> ShopUpgradeRecord value -> ShopUpgradeRecord value
setByShopUpgrade kind value data =
    case kind of
        Glasses ->
            { data | glasses = value }


mapShopUpgrades :
    (getByShopUpgrade -> getByShopUpgrade)
    -> ShopUpgradeRecord getByShopUpgrade
    -> ShopUpgradeRecord getByShopUpgrade
mapShopUpgrades fn record =
    let
        foldFn el accum =
            setByShopUpgrade el (fn (getByShopUpgrade el accum)) accum
    in
    List.foldl foldFn record allShopUpgrades
