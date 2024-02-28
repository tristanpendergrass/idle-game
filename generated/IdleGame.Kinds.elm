module IdleGame.Kinds exposing (..)


{- !! Generated code, do not edit by hand !! -}


{- Resources -}


type Resource
    = Manure
    | Soot
    | GreenhouseDirt
    | WashWater
    | EmptyBottle
    | Scrap
    | Ectoplasm
    | Parchment


allResources : List Resource
allResources =
    [ Manure
    , Soot
    , GreenhouseDirt
    , WashWater
    , EmptyBottle
    , Scrap
    , Ectoplasm
    , Parchment
    ]


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


resourceRecord : a -> ResourceRecord a
resourceRecord a =
    { manure = a
    , soot = a
    , greenhouseDirt = a
    , washWater = a
    , emptyBottle = a
    , scrap = a
    , ectoplasm = a
    , parchment = a
    }


getByResource : Resource -> ResourceRecord parchment -> parchment
getByResource kind data =
    case kind of
        Manure ->
            data.manure

        Soot ->
            data.soot

        GreenhouseDirt ->
            data.greenhouseDirt

        WashWater ->
            data.washWater

        EmptyBottle ->
            data.emptyBottle

        Scrap ->
            data.scrap

        Ectoplasm ->
            data.ectoplasm

        Parchment ->
            data.parchment


setByResource :
    Resource -> value -> ResourceRecord value -> ResourceRecord value
setByResource kind value data =
    case kind of
        Manure ->
            { data | manure = value }

        Soot ->
            { data | soot = value }

        GreenhouseDirt ->
            { data | greenhouseDirt = value }

        WashWater ->
            { data | washWater = value }

        EmptyBottle ->
            { data | emptyBottle = value }

        Scrap ->
            { data | scrap = value }

        Ectoplasm ->
            { data | ectoplasm = value }

        Parchment ->
            { data | parchment = value }


{- Skills -}


type Skill
    = Chores
    | Hexes
    | Weathermancing


allSkills : List Skill
allSkills =
    [ Chores, Hexes, Weathermancing ]


type alias SkillRecord a =
    { chores : a, hexes : a, weathermancing : a }


skillRecord : a -> SkillRecord a
skillRecord a =
    { chores = a, hexes = a, weathermancing = a }


getBySkill : Skill -> SkillRecord weathermancing -> weathermancing
getBySkill kind data =
    case kind of
        Chores ->
            data.chores

        Hexes ->
            data.hexes

        Weathermancing ->
            data.weathermancing


setBySkill : Skill -> value -> SkillRecord value -> SkillRecord value
setBySkill kind value data =
    case kind of
        Chores ->
            { data | chores = value }

        Hexes ->
            { data | hexes = value }

        Weathermancing ->
            { data | weathermancing = value }


{- Activities -}


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


allActivities : List Activity
allActivities =
    [ CleanStables
    , CleanBigBubba
    , SweepChimneys
    , WaterGreenhousePlants
    , WashAndIronRobes
    , OrganizePotionIngredients
    , RepairInstruments
    , FlushDrainDemons
    , OrganizeSpellBooks
    , StudyHex1
    , StudyJinx1
    , StudyCurse1
    , StudyHex2
    , StudyJinx2
    , StudyCurse2
    , StudyHex3
    , StudyJinx3
    , StudyCurse3
    , ExploreSchoolGrounds
    , ExploreSecretGarden
    , FightPrefect
    , FightBookWyrm
    , FightWhisperingWind
    , StudyWind
    , StudyWater
    , StudySun
    ]


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


activityRecord : a -> ActivityRecord a
activityRecord a =
    { cleanStables = a
    , cleanBigBubba = a
    , sweepChimneys = a
    , waterGreenhousePlants = a
    , washAndIronRobes = a
    , organizePotionIngredients = a
    , repairInstruments = a
    , flushDrainDemons = a
    , organizeSpellBooks = a
    , studyHex1 = a
    , studyJinx1 = a
    , studyCurse1 = a
    , studyHex2 = a
    , studyJinx2 = a
    , studyCurse2 = a
    , studyHex3 = a
    , studyJinx3 = a
    , studyCurse3 = a
    , exploreSchoolGrounds = a
    , exploreSecretGarden = a
    , fightPrefect = a
    , fightBookWyrm = a
    , fightWhisperingWind = a
    , studyWind = a
    , studyWater = a
    , studySun = a
    }


getByActivity : Activity -> ActivityRecord studySun -> studySun
getByActivity kind data =
    case kind of
        CleanStables ->
            data.cleanStables

        CleanBigBubba ->
            data.cleanBigBubba

        SweepChimneys ->
            data.sweepChimneys

        WaterGreenhousePlants ->
            data.waterGreenhousePlants

        WashAndIronRobes ->
            data.washAndIronRobes

        OrganizePotionIngredients ->
            data.organizePotionIngredients

        RepairInstruments ->
            data.repairInstruments

        FlushDrainDemons ->
            data.flushDrainDemons

        OrganizeSpellBooks ->
            data.organizeSpellBooks

        StudyHex1 ->
            data.studyHex1

        StudyJinx1 ->
            data.studyJinx1

        StudyCurse1 ->
            data.studyCurse1

        StudyHex2 ->
            data.studyHex2

        StudyJinx2 ->
            data.studyJinx2

        StudyCurse2 ->
            data.studyCurse2

        StudyHex3 ->
            data.studyHex3

        StudyJinx3 ->
            data.studyJinx3

        StudyCurse3 ->
            data.studyCurse3

        ExploreSchoolGrounds ->
            data.exploreSchoolGrounds

        ExploreSecretGarden ->
            data.exploreSecretGarden

        FightPrefect ->
            data.fightPrefect

        FightBookWyrm ->
            data.fightBookWyrm

        FightWhisperingWind ->
            data.fightWhisperingWind

        StudyWind ->
            data.studyWind

        StudyWater ->
            data.studyWater

        StudySun ->
            data.studySun


setByActivity :
    Activity -> value -> ActivityRecord value -> ActivityRecord value
setByActivity kind value data =
    case kind of
        CleanStables ->
            { data | cleanStables = value }

        CleanBigBubba ->
            { data | cleanBigBubba = value }

        SweepChimneys ->
            { data | sweepChimneys = value }

        WaterGreenhousePlants ->
            { data | waterGreenhousePlants = value }

        WashAndIronRobes ->
            { data | washAndIronRobes = value }

        OrganizePotionIngredients ->
            { data | organizePotionIngredients = value }

        RepairInstruments ->
            { data | repairInstruments = value }

        FlushDrainDemons ->
            { data | flushDrainDemons = value }

        OrganizeSpellBooks ->
            { data | organizeSpellBooks = value }

        StudyHex1 ->
            { data | studyHex1 = value }

        StudyJinx1 ->
            { data | studyJinx1 = value }

        StudyCurse1 ->
            { data | studyCurse1 = value }

        StudyHex2 ->
            { data | studyHex2 = value }

        StudyJinx2 ->
            { data | studyJinx2 = value }

        StudyCurse2 ->
            { data | studyCurse2 = value }

        StudyHex3 ->
            { data | studyHex3 = value }

        StudyJinx3 ->
            { data | studyJinx3 = value }

        StudyCurse3 ->
            { data | studyCurse3 = value }

        ExploreSchoolGrounds ->
            { data | exploreSchoolGrounds = value }

        ExploreSecretGarden ->
            { data | exploreSecretGarden = value }

        FightPrefect ->
            { data | fightPrefect = value }

        FightBookWyrm ->
            { data | fightBookWyrm = value }

        FightWhisperingWind ->
            { data | fightWhisperingWind = value }

        StudyWind ->
            { data | studyWind = value }

        StudyWater ->
            { data | studyWater = value }

        StudySun ->
            { data | studySun = value }


{- Spells -}


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


allSpells : List Spell
allSpells =
    [ Hex1
    , Hex2
    , Hex3
    , Jinx1
    , Jinx2
    , Jinx3
    , Curse1
    , Curse2
    , Curse3
    , Wind
    , Water
    , Sun
    ]


type alias SpellRecord a =
    { hex1 : a
    , hex2 : a
    , hex3 : a
    , jinx1 : a
    , jinx2 : a
    , jinx3 : a
    , curse1 : a
    , curse2 : a
    , curse3 : a
    , wind : a
    , water : a
    , sun : a
    }


spellRecord : a -> SpellRecord a
spellRecord a =
    { hex1 = a
    , hex2 = a
    , hex3 = a
    , jinx1 = a
    , jinx2 = a
    , jinx3 = a
    , curse1 = a
    , curse2 = a
    , curse3 = a
    , wind = a
    , water = a
    , sun = a
    }


getBySpell : Spell -> SpellRecord sun -> sun
getBySpell kind data =
    case kind of
        Hex1 ->
            data.hex1

        Hex2 ->
            data.hex2

        Hex3 ->
            data.hex3

        Jinx1 ->
            data.jinx1

        Jinx2 ->
            data.jinx2

        Jinx3 ->
            data.jinx3

        Curse1 ->
            data.curse1

        Curse2 ->
            data.curse2

        Curse3 ->
            data.curse3

        Wind ->
            data.wind

        Water ->
            data.water

        Sun ->
            data.sun


setBySpell : Spell -> value -> SpellRecord value -> SpellRecord value
setBySpell kind value data =
    case kind of
        Hex1 ->
            { data | hex1 = value }

        Hex2 ->
            { data | hex2 = value }

        Hex3 ->
            { data | hex3 = value }

        Jinx1 ->
            { data | jinx1 = value }

        Jinx2 ->
            { data | jinx2 = value }

        Jinx3 ->
            { data | jinx3 = value }

        Curse1 ->
            { data | curse1 = value }

        Curse2 ->
            { data | curse2 = value }

        Curse3 ->
            { data | curse3 = value }

        Wind ->
            { data | wind = value }

        Water ->
            { data | water = value }

        Sun ->
            { data | sun = value }


{- Locations -}


type Location
    = SchoolGrounds
    | SecretGarden


allLocations : List Location
allLocations =
    [ SchoolGrounds, SecretGarden ]


type alias LocationRecord a =
    { schoolGrounds : a, secretGarden : a }


locationRecord : a -> LocationRecord a
locationRecord a =
    { schoolGrounds = a, secretGarden = a }


getByLocation : Location -> LocationRecord secretGarden -> secretGarden
getByLocation kind data =
    case kind of
        SchoolGrounds ->
            data.schoolGrounds

        SecretGarden ->
            data.secretGarden


setByLocation :
    Location -> value -> LocationRecord value -> LocationRecord value
setByLocation kind value data =
    case kind of
        SchoolGrounds ->
            { data | schoolGrounds = value }

        SecretGarden ->
            { data | secretGarden = value }


{- Monsters -}


type Monster
    = Prefect
    | BookWyrm
    | WhisperingWind


allMonsters : List Monster
allMonsters =
    [ Prefect, BookWyrm, WhisperingWind ]


type alias MonsterRecord a =
    { prefect : a, bookWyrm : a, whisperingWind : a }


monsterRecord : a -> MonsterRecord a
monsterRecord a =
    { prefect = a, bookWyrm = a, whisperingWind = a }


getByMonster : Monster -> MonsterRecord whisperingWind -> whisperingWind
getByMonster kind data =
    case kind of
        Prefect ->
            data.prefect

        BookWyrm ->
            data.bookWyrm

        WhisperingWind ->
            data.whisperingWind


setByMonster : Monster -> value -> MonsterRecord value -> MonsterRecord value
setByMonster kind value data =
    case kind of
        Prefect ->
            { data | prefect = value }

        BookWyrm ->
            { data | bookWyrm = value }

        WhisperingWind ->
            { data | whisperingWind = value }


{- Shop Upgrades -}


type ShopUpgrade
    = Shovel
    | Book
    | Keyring
    | ReadingGlasses
    | OversizedBag


allShopUpgrades : List ShopUpgrade
allShopUpgrades =
    [ Shovel, Book, Keyring, ReadingGlasses, OversizedBag ]


type alias ShopUpgradeRecord a =
    { shovel : a, book : a, keyring : a, readingGlasses : a, oversizedBag : a }


shopUpgradeRecord : a -> ShopUpgradeRecord a
shopUpgradeRecord a =
    { shovel = a, book = a, keyring = a, readingGlasses = a, oversizedBag = a }


getByShopUpgrade : ShopUpgrade -> ShopUpgradeRecord oversizedBag -> oversizedBag
getByShopUpgrade kind data =
    case kind of
        Shovel ->
            data.shovel

        Book ->
            data.book

        Keyring ->
            data.keyring

        ReadingGlasses ->
            data.readingGlasses

        OversizedBag ->
            data.oversizedBag


setByShopUpgrade :
    ShopUpgrade -> value -> ShopUpgradeRecord value -> ShopUpgradeRecord value
setByShopUpgrade kind value data =
    case kind of
        Shovel ->
            { data | shovel = value }

        Book ->
            { data | book = value }

        Keyring ->
            { data | keyring = value }

        ReadingGlasses ->
            { data | readingGlasses = value }

        OversizedBag ->
            { data | oversizedBag = value }


{- Quests -}


type Quest
    = MendCrackedBell
    | ChopFirewood


allQuests : List Quest
allQuests =
    [ MendCrackedBell, ChopFirewood ]


type alias QuestRecord a =
    { mendCrackedBell : a, chopFirewood : a }


questRecord : a -> QuestRecord a
questRecord a =
    { mendCrackedBell = a, chopFirewood = a }


getByQuest : Quest -> QuestRecord chopFirewood -> chopFirewood
getByQuest kind data =
    case kind of
        MendCrackedBell ->
            data.mendCrackedBell

        ChopFirewood ->
            data.chopFirewood


setByQuest : Quest -> value -> QuestRecord value -> QuestRecord value
setByQuest kind value data =
    case kind of
        MendCrackedBell ->
            { data | mendCrackedBell = value }

        ChopFirewood ->
            { data | chopFirewood = value }