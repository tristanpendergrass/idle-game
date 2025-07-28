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
    | SpellHerbSense
    | SpellBloom


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
    , SpellHerbSense
    , SpellBloom
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
    , spellHerbSense : a
    , spellBloom : a
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
    , spellHerbSense = a
    , spellBloom = a
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

        SpellHerbSense ->
            data.spellHerbSense

        SpellBloom ->
            data.spellBloom


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

        SpellHerbSense ->
            { data | spellHerbSense = value }

        SpellBloom ->
            { data | spellBloom = value }


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
    , spellHerbSense = fn record.spellHerbSense
    , spellBloom = fn record.spellBloom
    }


type alias ResourceStats =
    { title : String
    , icon : IdleGame.Views.Icon.Icon
    , buyPrice : Maybe IdleGame.Coin.Coin
    , sellPrice : Maybe IdleGame.Coin.Coin
    }


resourceStats : ResourceRecord ResourceStats
resourceStats =
    { sage = { title = "Sage", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , nettle = { title = "Nettle", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , sorrel = { title = "Sorrel", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , mugwort = { title = "Mugwort", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , yarrow = { title = "Yarrow", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , thyme = { title = "Thyme", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , fennel = { title = "Fennel", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , belladonna = { title = "Belladonna", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , henbane = { title = "Henbane", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Just (IdleGame.Coin.int 1) }
    , parchment = { title = "Parchment", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams, buyPrice = Just (IdleGame.Coin.int 2), sellPrice = Just (IdleGame.Coin.int 1) }
    , spellHerbSense = { title = "Herb Sense", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Nothing }
    , spellBloom = { title = "Bloom", icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialBiotech IdleGame.Views.Icon.defaultParams, buyPrice = Nothing, sellPrice = Nothing }
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
    | CraftSpellHerbSense
    | CraftSpellBloom


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
    , CraftSpellHerbSense
    , CraftSpellBloom
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
    , craftSpellHerbSense : a
    , craftSpellBloom : a
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

        CraftSpellHerbSense ->
            { data | craftSpellHerbSense = value }

        CraftSpellBloom ->
            { data | craftSpellBloom = value }


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
    , craftSpellHerbSense = fn record.craftSpellHerbSense
    , craftSpellBloom = fn record.craftSpellBloom
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
        , duration = Duration.seconds 4
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
    , craftSpellHerbSense =
        { skill = WildMagic
        , title = "Herb Sense"
        , image = "/activities/wildMagic/craftSpellHerbSense.webp"
        , level = 1
        , duration = Duration.seconds 5
        , type_ = "Craft Spell"
        , coin = Nothing
        , resourceGains = [ ( 1, SpellHerbSense ) ]
        }
    , craftSpellBloom =
        { skill = WildMagic
        , title = "Bloom"
        , image = "/activities/wildMagic/craftSpellBloom.webp"
        , level = 2
        , duration = Duration.seconds 10
        , type_ = "Craft Spell"
        , coin = Nothing
        , resourceGains = [ ( 1, SpellBloom ) ]
        }
    }


getActivityStats : Activity -> ActivityStats
getActivityStats kind =
    getByActivity kind activityStats



-- QUESTS


type Quest
    = GatherSupplies
    | StudyAncientTexts  
    | PrepareHerbalRemedies
    | ResearchAnatomy
    | CraftMedicalInstruments
    | CollectBotanicalSpecimens


allQuests : List Quest
allQuests =
    [ GatherSupplies
    , StudyAncientTexts
    , PrepareHerbalRemedies
    , ResearchAnatomy
    , CraftMedicalInstruments
    , CollectBotanicalSpecimens
    ]


type alias QuestRecord a =
    { gatherSupplies : a
    , studyAncientTexts : a
    , prepareHerbalRemedies : a
    , researchAnatomy : a
    , craftMedicalInstruments : a
    , collectBotanicalSpecimens : a
    }


questRecord : a -> QuestRecord a
questRecord a =
    { gatherSupplies = a
    , studyAncientTexts = a
    , prepareHerbalRemedies = a
    , researchAnatomy = a
    , craftMedicalInstruments = a
    , collectBotanicalSpecimens = a
    }


getByQuest : Quest -> QuestRecord a -> a
getByQuest kind data =
    case kind of
        GatherSupplies ->
            data.gatherSupplies

        StudyAncientTexts ->
            data.studyAncientTexts

        PrepareHerbalRemedies ->
            data.prepareHerbalRemedies

        ResearchAnatomy ->
            data.researchAnatomy

        CraftMedicalInstruments ->
            data.craftMedicalInstruments

        CollectBotanicalSpecimens ->
            data.collectBotanicalSpecimens


setByQuest : Quest -> a -> QuestRecord a -> QuestRecord a
setByQuest kind value data =
    case kind of
        GatherSupplies ->
            { data | gatherSupplies = value }

        StudyAncientTexts ->
            { data | studyAncientTexts = value }

        PrepareHerbalRemedies ->
            { data | prepareHerbalRemedies = value }

        ResearchAnatomy ->
            { data | researchAnatomy = value }

        CraftMedicalInstruments ->
            { data | craftMedicalInstruments = value }

        CollectBotanicalSpecimens ->
            { data | collectBotanicalSpecimens = value }


mapQuests : (a -> a) -> QuestRecord a -> QuestRecord a
mapQuests fn record =
    { gatherSupplies = fn record.gatherSupplies
    , studyAncientTexts = fn record.studyAncientTexts
    , prepareHerbalRemedies = fn record.prepareHerbalRemedies
    , researchAnatomy = fn record.researchAnatomy
    , craftMedicalInstruments = fn record.craftMedicalInstruments
    , collectBotanicalSpecimens = fn record.collectBotanicalSpecimens
    }


type alias QuestStats =
    { name : String
    , description : String
    , resourceRequirements : ResourceRecord Int
    , coinReward : IdleGame.Coin.Coin
    , icon : IdleGame.Views.Icon.Icon
    }


questStats : QuestRecord QuestStats
questStats =
    { gatherSupplies = 
        { name = "Gather Medical Supplies"
        , description = "Collect essential herbs and materials needed for your medical studies"
        , resourceRequirements = 
            { sage = 10
            , nettle = 5
            , sorrel = 0
            , mugwort = 0
            , yarrow = 0
            , thyme = 0
            , fennel = 0
            , belladonna = 0
            , henbane = 0
            , parchment = 3
            , spellHerbSense = 0
            , spellBloom = 0
            }
        , coinReward = IdleGame.Coin.int 50
        , icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams
        }
    , studyAncientTexts = 
        { name = "Study Ancient Medical Texts"
        , description = "Research historical medical knowledge from old parchments"
        , resourceRequirements = 
            { sage = 0
            , nettle = 0
            , sorrel = 0
            , mugwort = 0
            , yarrow = 0
            , thyme = 0
            , fennel = 0
            , belladonna = 0
            , henbane = 0
            , parchment = 15
            , spellHerbSense = 0
            , spellBloom = 0
            }
        , coinReward = IdleGame.Coin.int 75
        , icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams
        }
    , prepareHerbalRemedies = 
        { name = "Prepare Herbal Remedies"
        , description = "Craft healing potions using various herbs and magical enhancements"
        , resourceRequirements = 
            { sage = 5
            , nettle = 3
            , sorrel = 3
            , mugwort = 2
            , yarrow = 4
            , thyme = 2
            , fennel = 0
            , belladonna = 0
            , henbane = 0
            , parchment = 0
            , spellHerbSense = 1
            , spellBloom = 1
            }
        , coinReward = IdleGame.Coin.int 100
        , icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialBiotech IdleGame.Views.Icon.defaultParams
        }
    , researchAnatomy = 
        { name = "Research Human Anatomy"
        , description = "Study the human body using preserved specimens and detailed documentation"
        , resourceRequirements = 
            { sage = 8
            , nettle = 0
            , sorrel = 0
            , mugwort = 0
            , yarrow = 0
            , thyme = 0
            , fennel = 0
            , belladonna = 3
            , henbane = 2
            , parchment = 20
            , spellHerbSense = 0
            , spellBloom = 0
            }
        , coinReward = IdleGame.Coin.int 125
        , icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialScience IdleGame.Views.Icon.defaultParams
        }
    , craftMedicalInstruments = 
        { name = "Craft Medical Instruments"
        , description = "Create precise tools for medical examination and treatment"
        , resourceRequirements = 
            { sage = 0
            , nettle = 0
            , sorrel = 2
            , mugwort = 5
            , yarrow = 3
            , thyme = 4
            , fennel = 6
            , belladonna = 0
            , henbane = 0
            , parchment = 5
            , spellHerbSense = 2
            , spellBloom = 0
            }
        , coinReward = IdleGame.Coin.int 150
        , icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialSummarize IdleGame.Views.Icon.defaultParams
        }
    , collectBotanicalSpecimens = 
        { name = "Collect Botanical Specimens"
        , description = "Gather rare plants and document their medicinal properties"
        , resourceRequirements = 
            { sage = 2
            , nettle = 2
            , sorrel = 4
            , mugwort = 3
            , yarrow = 2
            , thyme = 3
            , fennel = 4
            , belladonna = 5
            , henbane = 3
            , parchment = 8
            , spellHerbSense = 1
            , spellBloom = 2
            }
        , coinReward = IdleGame.Coin.int 200
        , icon = IdleGame.Views.Icon.IconMaterial IdleGame.Views.Icon.MaterialBiotech IdleGame.Views.Icon.defaultParams
        }
    }


getQuestStats : Quest -> QuestStats
getQuestStats kind =
    getByQuest kind questStats



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
