module Evergreen.V17.IdleGame.Kinds exposing (..)


type Resource
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment


type Monster
    = Prefect
    | BookWyrm
    | WhisperingWind


type Quest
    = MendCrackedBell
    | ChopFirewood


type Activity
    = CleanStables
    | CleanBigBubba
    | SweepChimneys
    | WaterGreenhousePlants
    | WashAndIronRobes
    | OrganizePotionIngredients
    | RepairInstruments
    | FlushDrainDemons
    | OrganizeSpellBooks
    | StudyHex1
    | StudyJinx1
    | StudyCurse1
    | StudyHex2
    | StudyJinx2
    | StudyCurse2
    | StudyHex3
    | StudyJinx3
    | StudyCurse3
    | ExploreSchoolGrounds
    | ExploreSecretGarden
    | FightPrefect
    | FightBookWyrm
    | FightWhisperingWind
    | StudyWind
    | StudyWater
    | StudySun


type Skill
    = Chores
    | Hexes
    | Weathermancing


type alias ResourceRecord a =
    { manure : a
    , soot : a
    , greenhouseDirt : a
    , washWater : a
    , emptyBottle : a
    , scrap : a
    , ectoplasm : a
    , parchment : a
    }


type alias SkillRecord a =
    { chores : a
    , hexes : a
    , weathermancing : a
    }


type alias ActivityRecord a =
    { cleanStables : a
    , cleanBigBubba : a
    , sweepChimneys : a
    , waterGreenhousePlants : a
    , washAndIronRobes : a
    , organizePotionIngredients : a
    , repairInstruments : a
    , flushDrainDemons : a
    , organizeSpellBooks : a
    , studyHex1 : a
    , studyJinx1 : a
    , studyCurse1 : a
    , studyHex2 : a
    , studyJinx2 : a
    , studyCurse2 : a
    , studyHex3 : a
    , studyJinx3 : a
    , studyCurse3 : a
    , exploreSchoolGrounds : a
    , exploreSecretGarden : a
    , fightPrefect : a
    , fightBookWyrm : a
    , fightWhisperingWind : a
    , studyWind : a
    , studyWater : a
    , studySun : a
    }


type alias MonsterRecord a =
    { prefect : a
    , bookWyrm : a
    , whisperingWind : a
    }


type alias QuestRecord a =
    { mendCrackedBell : a
    , chopFirewood : a
    }


type alias LocationRecord a =
    { schoolGrounds : a
    , secretGarden : a
    }


type alias ShopUpgradeRecord a =
    { shovel : a
    , book : a
    , keyring : a
    , readingGlasses : a
    , oversizedBag : a
    }


type Spell
    = Hex1
    | Hex2
    | Hex3
    | Jinx1
    | Jinx2
    | Jinx3
    | Curse1
    | Curse2
    | Curse3
    | Wind
    | Water
    | Sun


type ShopUpgrade
    = Shovel
    | Book
    | Keyring
    | ReadingGlasses
    | OversizedBag


type Location
    = SchoolGrounds
    | SecretGarden
