module IdleGame.Kinds exposing (..)

import Duration
import Icons.Chores1
import Icons.HerbGathering
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
    { herbGathering = { title = "Herb Gathering", icon = Icons.HerbGathering.icon }
    , wildMagic = { title = "Wild Magic", icon = Icons.Chores1.icon }
    }


getSkillStats : Skill -> SkillStats
getSkillStats kind =
    getBySkill kind skillStats



-- RESOURCES


type Resource
    = Sage
    | Nettle
    | Sorrel
    | Parchment
    | SpellHerbSense
    | SpellBloom


allResources : List Resource
allResources =
    [ Sage
    , Nettle
    , Sorrel
    , Parchment
    , SpellHerbSense
    , SpellBloom
    ]


type alias ResourceRecord a =
    { sage : a
    , nettle : a
    , sorrel : a
    , parchment : a
    , herbSenseScroll : a
    , bloomScroll : a
    }


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { sage = a
    , nettle = a
    , sorrel = a
    , parchment = a
    , herbSenseScroll = a
    , bloomScroll = a
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

        Parchment ->
            data.parchment

        SpellHerbSense ->
            data.herbSenseScroll

        SpellBloom ->
            data.bloomScroll


setByResource : Resource -> a -> ResourceRecord a -> ResourceRecord a
setByResource kind value data =
    case kind of
        Sage ->
            { data | sage = value }

        Nettle ->
            { data | nettle = value }

        Sorrel ->
            { data | sorrel = value }

        Parchment ->
            { data | parchment = value }

        SpellHerbSense ->
            { data | herbSenseScroll = value }

        SpellBloom ->
            { data | bloomScroll = value }


mapResources : (a -> a) -> ResourceRecord a -> ResourceRecord a
mapResources fn record =
    { sage = fn record.sage
    , nettle = fn record.nettle
    , sorrel = fn record.sorrel
    , parchment = fn record.parchment
    , herbSenseScroll = fn record.herbSenseScroll
    , bloomScroll = fn record.bloomScroll
    }


type alias ResourceStats =
    { title : String
    , icon : IdleGame.Views.Icon.Icon
    , buyPrice : Maybe IdleGame.Coin.Coin
    , sellPrice : Maybe IdleGame.Coin.Coin
    , inventoryLimit : InventoryLimit
    }


type InventoryLimit
    = InventoryUnlimited -- Not marked as limited in the UI, and intended to be effectively unlimited; may actually be limited for technical reasons
    | InventoryLimited Int


resourceStats : ResourceRecord ResourceStats
resourceStats =
    { sage = { title = "Sage", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1), inventoryLimit = InventoryLimited 9 }
    , nettle = { title = "Nettle", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1), inventoryLimit = InventoryLimited 99 }
    , sorrel = { title = "Sorrel", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1), inventoryLimit = InventoryLimited 99 }
    , parchment = { title = "Parchment", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams, buyPrice = Just (IdleGame.Coin.int 2), sellPrice = Just (IdleGame.Coin.int 1), inventoryLimit = InventoryUnlimited }
    , herbSenseScroll = { title = "Herb Sense", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Nothing, inventoryLimit = InventoryLimited 99 }
    , bloomScroll = { title = "Bloom", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialBiotech IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Nothing, inventoryLimit = InventoryLimited 99 }
    }


getResourceStats : Resource -> ResourceStats
getResourceStats kind =
    getByResource kind resourceStats



-- ACTIVITIES


type Activity
    = GatherSage
    | GatherNettle
    | GatherSorrel
    | CraftSpellHerbSense
    | CraftSpellBloom


allActivities : List Activity
allActivities =
    [ GatherSage
    , GatherNettle
    , GatherSorrel
    , CraftSpellHerbSense
    , CraftSpellBloom
    ]


type alias ActivityRecord a =
    { gatherSage : a
    , gatherNettle : a
    , gatherSorrel : a
    , craftSpellHerbSense : a
    , craftSpellBloom : a
    }


activityRecord : a -> ActivityRecord a
activityRecord a =
    { gatherSage = a
    , gatherNettle = a
    , gatherSorrel = a
    , craftSpellHerbSense = a
    , craftSpellBloom = a
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

        CraftSpellHerbSense ->
            data.craftSpellHerbSense

        CraftSpellBloom ->
            data.craftSpellBloom


setByActivity : Activity -> a -> ActivityRecord a -> ActivityRecord a
setByActivity kind value data =
    case kind of
        GatherSage ->
            { data | gatherSage = value }

        GatherNettle ->
            { data | gatherNettle = value }

        GatherSorrel ->
            { data | gatherSorrel = value }

        CraftSpellHerbSense ->
            { data | craftSpellHerbSense = value }

        CraftSpellBloom ->
            { data | craftSpellBloom = value }


mapActivities : (a -> a) -> ActivityRecord a -> ActivityRecord a
mapActivities fn record =
    { gatherSage = fn record.gatherSage
    , gatherNettle = fn record.gatherNettle
    , gatherSorrel = fn record.gatherSorrel
    , craftSpellHerbSense = fn record.craftSpellHerbSense
    , craftSpellBloom = fn record.craftSpellBloom
    }


type alias ActivityStats =
    { skill : Skill
    , title : String
    , idLabel : String -- used for things like Dom elements that need to refer to the activity
    , image : String
    , level : Int
    , duration : Duration.Duration
    , type_ : String
    , coin : Maybe Int
    , resourceGains : List ( Int, Resource )
    , spellAssignmentSlots : Int
    }


activityStats : ActivityRecord ActivityStats
activityStats =
    { gatherSage =
        { skill = HerbGathering
        , title = "Gather Sage"
        , idLabel = "gather-sage"
        , image = "/activities/herbGathering/gatherSage.webp"
        , level = 1
        , duration = Duration.seconds 4
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Sage ) ]
        , spellAssignmentSlots = 1
        }
    , gatherNettle =
        { skill = HerbGathering
        , title = "Gather Nettle"
        , idLabel = "gather-nettle"
        , image = "/activities/herbGathering/gatherNettle.webp"
        , level = 1
        , duration = Duration.seconds 5
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Nettle ) ]
        , spellAssignmentSlots = 1
        }
    , gatherSorrel =
        { skill = HerbGathering
        , title = "Gather Sorrel"
        , idLabel = "gather-sorrel"
        , image = "/activities/herbGathering/gatherSorrel.webp"
        , level = 2
        , duration = Duration.seconds 10
        , type_ = "Gather"
        , coin = Nothing
        , resourceGains = [ ( 1, Sorrel ) ]
        , spellAssignmentSlots = 1
        }
    , craftSpellHerbSense =
        { skill = WildMagic
        , title = "Herb Sense"
        , idLabel = "craft-spell-herb-sense"
        , image = "/activities/wildMagic/craftSpellHerbSense.webp"
        , level = 1
        , duration = Duration.seconds 5
        , type_ = "Craft Spell"
        , coin = Nothing
        , resourceGains = [ ( 1, SpellHerbSense ) ]
        , spellAssignmentSlots = 1
        }
    , craftSpellBloom =
        { skill = WildMagic
        , title = "Bloom"
        , idLabel = "craft-spell-bloom"
        , image = "/activities/wildMagic/craftSpellBloom.webp"
        , level = 2
        , duration = Duration.seconds 10
        , type_ = "Craft Spell"
        , coin = Nothing
        , resourceGains = [ ( 1, SpellBloom ) ]
        , spellAssignmentSlots = 1
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
