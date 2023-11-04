module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)


allActivitiesBySkill : Skill -> List Activity
allActivitiesBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getStats kind).skill == skill
            )


allChores : List Activity
allChores =
    allActivitiesBySkill Chores


allHexes : List Activity
allHexes =
    allActivitiesBySkill Hexes


allAdventuring : List Activity
allAdventuring =
    allActivitiesBySkill Combat


getActivities : Skill -> List Activity
getActivities skill =
    case skill of
        Chores ->
            allChores

        Hexes ->
            allHexes

        Combat ->
            allAdventuring


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
    , ExploreLocation1
    , ExploreLocation2
    , FightMonster1
    , FightMonster2
    , FightMonster3
    , FightMonster4
    , FightMonster5
    , FightMonster6
    ]


type alias Record a =
    { cleanStables : a
    , cleanBigBubba : a
    , sweepChimneys : a
    , waterGreenhousePlants : a
    , washAndIronRobes : a
    , organizePotionIngredients : a
    , repairInstruments : a
    , flushDrainDemons : a
    , organizeSpellBooks : a
    , hex1 : a
    , jinx1 : a
    , curse1 : a
    , hex2 : a
    , jinx2 : a
    , curse2 : a
    , hex3 : a
    , jinx3 : a
    , curse3 : a
    , exploreLocation1 : a
    , exploreLocation2 : a
    , fightMonster1 : a
    , fightMonster2 : a
    , fightMonster3 : a
    , fightMonster4 : a
    , fightMonster5 : a
    , fightMonster6 : a
    }


createRecord : a -> Record a
createRecord d =
    { cleanStables = d
    , cleanBigBubba = d
    , sweepChimneys = d
    , waterGreenhousePlants = d
    , washAndIronRobes = d
    , organizePotionIngredients = d
    , repairInstruments = d
    , flushDrainDemons = d
    , organizeSpellBooks = d
    , hex1 = d
    , jinx1 = d
    , curse1 = d
    , hex2 = d
    , jinx2 = d
    , curse2 = d
    , hex3 = d
    , jinx3 = d
    , curse3 = d
    , exploreLocation1 = d
    , exploreLocation2 = d
    , fightMonster1 = d
    , fightMonster2 = d
    , fightMonster3 = d
    , fightMonster4 = d
    , fightMonster5 = d
    , fightMonster6 = d
    }


getByKind : Activity -> Record a -> a
getByKind kind record =
    case kind of
        CleanStables ->
            record.cleanStables

        CleanBigBubba ->
            record.cleanBigBubba

        SweepChimneys ->
            record.sweepChimneys

        WaterGreenhousePlants ->
            record.waterGreenhousePlants

        WashAndIronRobes ->
            record.washAndIronRobes

        OrganizePotionIngredients ->
            record.organizePotionIngredients

        RepairInstruments ->
            record.repairInstruments

        FlushDrainDemons ->
            record.flushDrainDemons

        OrganizeSpellBooks ->
            record.organizeSpellBooks

        StudyHex1 ->
            record.hex1

        StudyJinx1 ->
            record.jinx1

        StudyCurse1 ->
            record.curse1

        StudyHex2 ->
            record.hex2

        StudyJinx2 ->
            record.jinx2

        StudyCurse2 ->
            record.curse2

        StudyHex3 ->
            record.hex3

        StudyJinx3 ->
            record.jinx3

        StudyCurse3 ->
            record.curse3

        ExploreLocation1 ->
            record.exploreLocation1

        ExploreLocation2 ->
            record.exploreLocation2

        FightMonster1 ->
            record.fightMonster1

        FightMonster2 ->
            record.fightMonster2

        FightMonster3 ->
            record.fightMonster3

        FightMonster4 ->
            record.fightMonster4

        FightMonster5 ->
            record.fightMonster5

        FightMonster6 ->
            record.fightMonster6


setByKind : Activity -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        CleanStables ->
            { record | cleanStables = value }

        CleanBigBubba ->
            { record | cleanBigBubba = value }

        SweepChimneys ->
            { record | sweepChimneys = value }

        WaterGreenhousePlants ->
            { record | waterGreenhousePlants = value }

        WashAndIronRobes ->
            { record | washAndIronRobes = value }

        OrganizePotionIngredients ->
            { record | organizePotionIngredients = value }

        RepairInstruments ->
            { record | repairInstruments = value }

        FlushDrainDemons ->
            { record | flushDrainDemons = value }

        OrganizeSpellBooks ->
            { record | organizeSpellBooks = value }

        StudyHex1 ->
            { record | hex1 = value }

        StudyJinx1 ->
            { record | jinx1 = value }

        StudyCurse1 ->
            { record | curse1 = value }

        StudyHex2 ->
            { record | hex2 = value }

        StudyJinx2 ->
            { record | jinx2 = value }

        StudyCurse2 ->
            { record | curse2 = value }

        StudyHex3 ->
            { record | hex3 = value }

        StudyJinx3 ->
            { record | jinx3 = value }

        StudyCurse3 ->
            { record | curse3 = value }

        ExploreLocation1 ->
            { record | exploreLocation1 = value }

        ExploreLocation2 ->
            { record | exploreLocation2 = value }

        FightMonster1 ->
            { record | fightMonster1 = value }

        FightMonster2 ->
            { record | fightMonster2 = value }

        FightMonster3 ->
            { record | fightMonster3 = value }

        FightMonster4 ->
            { record | fightMonster4 = value }

        FightMonster5 ->
            { record | fightMonster5 = value }

        FightMonster6 ->
            { record | fightMonster6 = value }


updateByKind : Activity -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record


getBySpell : Spell -> Maybe Activity
getBySpell spell =
    List.Extra.find (\activity -> (getStats activity).teachesSpell == Just spell) allActivities


type ActivityImage
    = ActivityLandscape String
    | ActivityIcon Icon


type MasteryReward
    = SpellAvailable -- Spell can now be used
    | SecondaryEnabled -- Spell can be used as secondary
    | ImbueEnabled -- Spell can be embued with elements
    | IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Mod -- Apply mod to game


type alias Mastery =
    List ( Int, MasteryReward )


type alias Stats =
    { skill : Skill
    , title : String
    , image : ActivityImage
    , unlockRequirements : Maybe ( Skill, Int )
    , duration : Duration
    , effects : List Effect.TaggedEffect
    , mastery : Maybe Mastery
    , hasSpellSelector : Bool -- Does this activity support assigning a spell to empower it
    , teachesSpell : Maybe Spell -- Does this activity represent training a specific spell
    }


getStats : Activity -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { cleanStables = cleanStablesStats
    , cleanBigBubba = cleanBigBubbaStats
    , sweepChimneys = sweepChimneyStats
    , waterGreenhousePlants = waterGreenhousePlantsStats
    , washAndIronRobes = washAndIronRobesStats
    , organizePotionIngredients = organizePotionIngredientsStats
    , repairInstruments = repairInstrumentsStats
    , flushDrainDemons = flushDrainDemonsStats
    , organizeSpellBooks = organizeSpellBooksStats
    , hex1 = hex1Stats
    , jinx1 = jinx1Stats
    , curse1 = curse1Stats
    , hex2 = hex2Stats
    , jinx2 = jinx2Stats
    , curse2 = curse2Stats
    , hex3 = hex3Stats
    , jinx3 = jinx3Stats
    , curse3 = curse3Stats
    , exploreLocation1 = exploreLocation1Stats
    , exploreLocation2 = exploreLocation2Stats
    , fightMonster1 = fightMonster1Stats
    , fightMonster2 = fightMonster2Stats
    , fightMonster3 = fightMonster3Stats
    , fightMonster4 = fightMonster4Stats
    , fightMonster5 = fightMonster5Stats
    , fightMonster6 = fightMonster6Stats
    }



-- Chores


choreEffects :
    { activity : Activity
    , xp : Xp
    , coin : Coin
    , maybeResource : Maybe { resource : Resource, amount : Int, probability : Float }
    }
    -> List Effect.TaggedEffect
choreEffects { activity, xp, coin, maybeResource } =
    let
        choreTags : List Effect.Tag
        choreTags =
            [ Effect.ActivityTag activity, Effect.SkillTag Chores ]
    in
    [ { effect = Effect.GainXp { base = xp, multiplier = 1, skill = Chores }, tags = choreTags }
    , { effect = Effect.GainCoin { base = coin, multiplier = 1 }, tags = choreTags }
    , { effect = Effect.GainMxp { activity = activity, multiplier = 1 }, tags = choreTags }
    ]
        ++ (case maybeResource of
                Nothing ->
                    []

                Just { resource, amount, probability } ->
                    [ { effect =
                            Effect.VariableSuccess
                                { successProbability = probability
                                , successEffects =
                                    [ { effect =
                                            Effect.GainResource
                                                { base = amount
                                                , doublingChance = 0
                                                , resource = resource
                                                }
                                      , tags = choreTags
                                      }
                                    ]
                                , failureEffects = []
                                }
                      , tags = choreTags
                      }
                    ]
           )


getChoresMastery : Activity -> Mastery
getChoresMastery chore =
    [ ( 25
      , GameMod
            (Mod.coinBuff 0.1
                |> Mod.withTags [ Effect.ActivityTag chore ]
            )
      )
    , ( 50
      , GameMod
            (Mod.activityXpBuff chore 0.25
                |> Mod.withTags [ Effect.ActivityTag chore ]
            )
      )
    , ( 75
      , IntervalMod
            { kind = chore
            , percentChange = Percent.float 0.1
            , label = IntervalModLabel (Percent.float 0.1)
            }
      )
    , ( 100
      , GameMod
            (Mod.skillXpBuff Chores 0.05
                |> Mod.withTags [ Effect.SkillTag Chores ]
            )
      )
    ]


cleanStablesStats : Stats
cleanStablesStats =
    { skill = Chores
    , title = "Clean Stables"
    , image = ActivityLandscape "/chores/stable.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 3
    , effects =
        choreEffects
            { activity = CleanStables
            , xp = Xp.int 10
            , coin = Coin.int 1
            , maybeResource = Nothing
            }
    , mastery = Just (getChoresMastery CleanStables)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


cleanBigBubbaStats : Stats
cleanBigBubbaStats =
    { skill = Chores
    , title = "Clean Big Bubba's Stall"
    , image = ActivityLandscape "/chores/bubba4.png"
    , unlockRequirements = Just ( Chores, 10 )
    , duration = Duration.seconds 6
    , effects =
        choreEffects
            { activity = CleanBigBubba
            , xp = Xp.int 25
            , coin = Coin.int 3
            , maybeResource = Just { resource = Manure, amount = 1, probability = 0.75 }
            }
    , mastery =
        let
            choresMastery : Mastery
            choresMastery =
                getChoresMastery CleanBigBubba

            bigBubbaMastery : Mastery
            bigBubbaMastery =
                List.Extra.setAt 3
                    ( 100
                    , GameMod
                        { tags = [ Effect.ActivityTag CleanBigBubba ]
                        , label = Mod.MoreManure
                        , transformer = Mod.resourceBaseTransformer 1
                        , source = Mod.AdminCrimes
                        , repetitions = 1
                        }
                    )
                    choresMastery
        in
        Just bigBubbaMastery
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


sweepChimneyStats : Stats
sweepChimneyStats =
    { skill = Chores
    , title = "Sweep Chimneys"
    , image = ActivityLandscape "/chores/chimney.png"
    , unlockRequirements = Just ( Chores, 25 )
    , duration = Duration.seconds 8
    , effects =
        choreEffects
            { activity = SweepChimneys
            , xp = Xp.int 37
            , coin = Coin.int 6
            , maybeResource = Nothing
            }
    , mastery = Just (getChoresMastery SweepChimneys)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


waterGreenhousePlantsStats : Stats
waterGreenhousePlantsStats =
    { skill = Chores
    , title = "Water Greenhouse Plants"
    , image = ActivityLandscape "/chores/greenhouse_3.png"
    , unlockRequirements = Just ( Chores, 35 )
    , duration = Duration.seconds 2
    , effects =
        choreEffects
            { activity = WaterGreenhousePlants
            , xp = Xp.int 12
            , coin = Coin.int 2
            , maybeResource = Just { resource = GreenhouseDirt, amount = 1, probability = 0.6 }
            }
    , mastery = Just (getChoresMastery WaterGreenhousePlants)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


washAndIronRobesStats : Stats
washAndIronRobesStats =
    { skill = Chores
    , title = "Wash and Iron Robes"
    , image = ActivityLandscape "/chores/washRobes.png"
    , unlockRequirements = Just ( Chores, 45 )
    , duration = Duration.seconds 8
    , effects =
        choreEffects
            { activity = WashAndIronRobes
            , xp = Xp.int 50
            , coin = Coin.int 9
            , maybeResource = Just { resource = WashWater, amount = 1, probability = 0.1 }
            }
    , mastery = Just (getChoresMastery WashAndIronRobes)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


organizePotionIngredientsStats : Stats
organizePotionIngredientsStats =
    { skill = Chores
    , title = "Organize Potion Ingredients"
    , image = ActivityLandscape "/chores/potionIngredients_2.png"
    , unlockRequirements = Just ( Chores, 55 )
    , duration = Duration.seconds 20
    , effects =
        choreEffects
            { activity = OrganizePotionIngredients
            , xp = Xp.int 165
            , coin = Coin.int 12
            , maybeResource = Nothing
            }
    , mastery = Just (getChoresMastery OrganizePotionIngredients)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


repairInstrumentsStats : Stats
repairInstrumentsStats =
    { skill = Chores
    , title = "Repair Instruments"
    , image = ActivityLandscape "/chores/repairInstruments.png"
    , unlockRequirements = Just ( Chores, 65 )
    , duration = Duration.seconds 12
    , effects =
        choreEffects
            { activity = RepairInstruments
            , xp = Xp.int 75
            , coin = Coin.int 20
            , maybeResource = Just { resource = Scrap, amount = 1, probability = 0.25 }
            }
    , mastery = Just (getChoresMastery RepairInstruments)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


flushDrainDemonsStats : Stats
flushDrainDemonsStats =
    { skill = Chores
    , title = "Flush the Drain Demons"
    , image = ActivityLandscape "/chores/drainDemons.png"
    , unlockRequirements = Just ( Chores, 75 )
    , duration = Duration.seconds 10
    , effects =
        choreEffects
            { activity = FlushDrainDemons
            , xp = Xp.int 90
            , coin = Coin.int 14
            , maybeResource = Just { resource = Ectoplasm, amount = 1, probability = 0.1 }
            }
    , mastery = Just (getChoresMastery FlushDrainDemons)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


organizeSpellBooksStats : Stats
organizeSpellBooksStats =
    { skill = Chores
    , title = "Organize Spell Books"
    , image = ActivityLandscape "/chores/spellBooks.png"
    , unlockRequirements = Just ( Chores, 90 )
    , duration = Duration.seconds 20
    , effects =
        choreEffects
            { activity = OrganizeSpellBooks
            , xp = Xp.int 210
            , coin = Coin.int 30
            , maybeResource = Just { resource = Parchment, amount = 1, probability = 0.05 }
            }
    , mastery = Just (getChoresMastery OrganizeSpellBooks)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }



-- Hexes


defaultSpellMastery : Mastery
defaultSpellMastery =
    [ ( 25, SpellAvailable )
    , ( 50, SecondaryEnabled )
    , ( 75, ImbueEnabled )
    , ( 100, GameMod (Mod.powerBuff 1) )
    ]


hex1Stats : Stats
hex1Stats =
    let
        spell : Spell
        spell =
            Hex1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Nothing
    , duration = Duration.seconds 3.5
    , effects =
        [ Effect.gainXp (Xp.int 12) Hexes
        , Effect.gainMxp StudyHex1
        , Effect.gainResource -1 Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Hex1
    }


jinx1Stats : Stats
jinx1Stats =
    let
        spell : Spell
        spell =
            Jinx1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 10 )
    , duration = Duration.seconds 4.5
    , effects =
        [ Effect.gainXp (Xp.int 18) Hexes
        , Effect.gainMxp StudyJinx1
        , Effect.gainResource -1 GreenhouseDirt
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Jinx1
    }


curse1Stats : Stats
curse1Stats =
    let
        spell : Spell
        spell =
            Curse1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 25 )
    , duration = Duration.seconds 5
    , effects =
        [ Effect.gainXp (Xp.int 24) Hexes
        , Effect.gainMxp StudyCurse1
        , Effect.gainResource -1 WashWater
        , Effect.gainResource -1 Soot
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Curse1
    }


hex2Stats : Stats
hex2Stats =
    let
        spell : Spell
        spell =
            Hex2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 35 )
    , duration = Duration.seconds 9
    , effects =
        [ Effect.gainXp (Xp.int 54) Hexes
        , Effect.gainMxp StudyHex2
        , Effect.gainResource -4 Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Hex2
    }


jinx2Stats : Stats
jinx2Stats =
    let
        spell : Spell
        spell =
            Jinx2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 45 )
    , duration = Duration.seconds 10.5
    , effects =
        [ Effect.gainXp (Xp.int 65) Hexes
        , Effect.gainMxp StudyJinx2
        , Effect.gainResource -5 GreenhouseDirt
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Jinx2
    }


curse2Stats : Stats
curse2Stats =
    let
        spell : Spell
        spell =
            Curse2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 55 )
    , duration = Duration.seconds 12
    , effects =
        [ Effect.gainXp (Xp.int 99) Hexes
        , Effect.gainMxp StudyCurse2
        , Effect.gainResource -2 WashWater
        , Effect.gainResource -1 Scrap
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Curse2
    }


hex3Stats : Stats
hex3Stats =
    let
        spell : Spell
        spell =
            Hex3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 65 )
    , duration = Duration.seconds 15
    , effects =
        [ Effect.gainXp (Xp.int 94) Hexes
        , Effect.gainMxp StudyHex3
        , Effect.gainResource -10 Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Hex3
    }


jinx3Stats : Stats
jinx3Stats =
    let
        spell : Spell
        spell =
            Jinx3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 75 )
    , duration = Duration.seconds 16
    , effects =
        [ Effect.gainXp (Xp.int 144) Hexes
        , Effect.gainMxp StudyJinx3
        , Effect.gainResource -6 GreenhouseDirt
        , Effect.gainResource -1 Ectoplasm
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Jinx3
    }


curse3Stats : Stats
curse3Stats =
    let
        spell : Spell
        spell =
            Curse3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 90 )
    , duration = Duration.seconds 19
    , effects =
        [ Effect.gainXp (Xp.int 200) Hexes
        , Effect.gainMxp StudyCurse3
        , Effect.gainResource -2 WashWater
        , Effect.gainResource -2 Soot
        , Effect.gainResource -2 Scrap
        , Effect.gainResource -2 Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Curse3
    }



-- Adventuring


exploreLocation1Stats : Stats
exploreLocation1Stats =
    { skill = Combat
    , title = "Explore"
    , image = ActivityLandscape "/chores/bubba4.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 4
    , effects = []
    , mastery = Nothing
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


exploreLocation2Stats : Stats
exploreLocation2Stats =
    { skill = Combat
    , title = "Explore"
    , image = ActivityLandscape "/chores/bubba4.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 4
    , effects = []
    , mastery = Nothing
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


monsterEffects : { activity : Activity, rewards : List Effect.TaggedEffect, power : Int } -> List Effect.TaggedEffect
monsterEffects { activity, rewards, power } =
    [ Effect.resolveCombat (Combat.create { monsterPower = power, playerPower = 1 }) rewards
        |> Effect.withTags [ Effect.ActivityTag activity, Effect.SkillTag Combat ]
    ]


fightMonster1Stats : Stats
fightMonster1Stats =
    { skill = Combat
    , title = "Furball"
    , image = ActivityIcon (Icon.letter "F")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster1
            , rewards =
                [ Effect.gainCoin (Coin.int 1)
                    |> Effect.withTags [ Effect.ActivityTag FightMonster1 ]
                ]
            , power = 1
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster2Stats : Stats
fightMonster2Stats =
    { skill = Combat
    , title = "Ectoplo"
    , image = ActivityIcon (Icon.letter "E")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster2
            , rewards =
                [ Effect.gainResource 1 Ectoplasm
                    |> Effect.withTags [ Effect.ActivityTag FightMonster2, Effect.SkillTag Combat ]
                ]
            , power = 8
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster3Stats : Stats
fightMonster3Stats =
    { skill = Combat
    , title = "Dreadkin"
    , image = ActivityIcon (Icon.letter "D")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster3
            , rewards =
                [ Effect.gainCoin (Coin.int 5)
                    |> Effect.withTags [ Effect.ActivityTag FightMonster3, Effect.SkillTag Combat ]
                ]
            , power = 22
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster4Stats : Stats
fightMonster4Stats =
    { skill = Combat
    , title = "Creeping Vine"
    , image = ActivityIcon (Icon.letter "C")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster4
            , rewards =
                [ Effect.gainResource 1 GreenhouseDirt
                    |> Effect.withTags [ Effect.ActivityTag FightMonster4, Effect.SkillTag Combat ]
                ]
            , power = 45
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster5Stats : Stats
fightMonster5Stats =
    { skill = Combat
    , title = "Banshee"
    , image = ActivityIcon (Icon.letter "B")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster5
            , rewards =
                [ Effect.gainCoin (Coin.int 15)
                    |> Effect.withTags [ Effect.ActivityTag FightMonster5, Effect.SkillTag Combat ]
                ]
            , power = 75
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster6Stats : Stats
fightMonster6Stats =
    { skill = Combat
    , title = "Alucard"
    , image = ActivityIcon (Icon.letter "A")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster6
            , rewards =
                [ Effect.gainResource 2 Scrap
                    |> Effect.withTags [ Effect.ActivityTag FightMonster6, Effect.SkillTag Combat ]
                , Effect.gainResource 2 Soot
                    |> Effect.withTags [ Effect.ActivityTag FightMonster6, Effect.SkillTag Combat ]
                , Effect.gainCoin (Coin.int 20)
                    |> Effect.withTags [ Effect.ActivityTag FightMonster6, Effect.SkillTag Combat ]
                ]
            , power = 110
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }
