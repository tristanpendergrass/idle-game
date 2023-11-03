module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Kinds.Spells as Spells exposing (Spell)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)


allActivitiesBySkill : Skill.Kind -> List Activity
allActivitiesBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getStats kind).skill == skill
            )


allChores : List Activity
allChores =
    allActivitiesBySkill Skill.Chores


allHexes : List Activity
allHexes =
    allActivitiesBySkill Skill.Hexes


allAdventuring : List Activity
allAdventuring =
    allActivitiesBySkill Skill.Adventuring


getActivities : Skill.Kind -> List Activity
getActivities skill =
    case skill of
        Skill.Chores ->
            allChores

        Skill.Hexes ->
            allHexes

        Skill.Adventuring ->
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
    , Hex1
    , Jinx1
    , Curse1
    , Hex2
    , Jinx2
    , Curse2
    , Hex3
    , Jinx3
    , Curse3
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

        Hex1 ->
            record.hex1

        Jinx1 ->
            record.jinx1

        Curse1 ->
            record.curse1

        Hex2 ->
            record.hex2

        Jinx2 ->
            record.jinx2

        Curse2 ->
            record.curse2

        Hex3 ->
            record.hex3

        Jinx3 ->
            record.jinx3

        Curse3 ->
            record.curse3

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

        Hex1 ->
            { record | hex1 = value }

        Jinx1 ->
            { record | jinx1 = value }

        Curse1 ->
            { record | curse1 = value }

        Hex2 ->
            { record | hex2 = value }

        Jinx2 ->
            { record | jinx2 = value }

        Curse2 ->
            { record | curse2 = value }

        Hex3 ->
            { record | hex3 = value }

        Jinx3 ->
            { record | jinx3 = value }

        Curse3 ->
            { record | curse3 = value }

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
    { skill : Skill.Kind
    , title : String
    , image : ActivityImage
    , unlockRequirements : Maybe ( Skill.Kind, Int )
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
    , maybeResource : Maybe { resource : Resource.Kind, amount : Int, probability : Float }
    }
    -> List Effect.TaggedEffect
choreEffects { activity, xp, coin, maybeResource } =
    let
        choreTags : List Effect.Tag
        choreTags =
            [ Effect.ActivityTag activity, Effect.SkillTag Skill.Chores ]
    in
    [ { effect = Effect.GainXp { base = xp, multiplier = 1, skill = Skill.Chores }, tags = choreTags }
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
            (Mod.skillXpBuff Skill.Chores 0.05
                |> Mod.withTags [ Effect.SkillTag Skill.Chores ]
            )
      )
    ]


cleanStablesStats : Stats
cleanStablesStats =
    { skill = Skill.Chores
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
    { skill = Skill.Chores
    , title = "Clean Big Bubba's Stall"
    , image = ActivityLandscape "/chores/bubba4.png"
    , unlockRequirements = Just ( Skill.Chores, 10 )
    , duration = Duration.seconds 6
    , effects =
        choreEffects
            { activity = CleanBigBubba
            , xp = Xp.int 25
            , coin = Coin.int 3
            , maybeResource = Just { resource = Resource.Manure, amount = 1, probability = 0.75 }
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
    { skill = Skill.Chores
    , title = "Sweep Chimneys"
    , image = ActivityLandscape "/chores/chimney.png"
    , unlockRequirements = Just ( Skill.Chores, 25 )
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
    { skill = Skill.Chores
    , title = "Water Greenhouse Plants"
    , image = ActivityLandscape "/chores/greenhouse_3.png"
    , unlockRequirements = Just ( Skill.Chores, 35 )
    , duration = Duration.seconds 2
    , effects =
        choreEffects
            { activity = WaterGreenhousePlants
            , xp = Xp.int 12
            , coin = Coin.int 2
            , maybeResource = Just { resource = Resource.GreenhouseDirt, amount = 1, probability = 0.6 }
            }
    , mastery = Just (getChoresMastery WaterGreenhousePlants)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


washAndIronRobesStats : Stats
washAndIronRobesStats =
    { skill = Skill.Chores
    , title = "Wash and Iron Robes"
    , image = ActivityLandscape "/chores/washRobes.png"
    , unlockRequirements = Just ( Skill.Chores, 45 )
    , duration = Duration.seconds 8
    , effects =
        choreEffects
            { activity = WashAndIronRobes
            , xp = Xp.int 50
            , coin = Coin.int 9
            , maybeResource = Just { resource = Resource.WashWater, amount = 1, probability = 0.1 }
            }
    , mastery = Just (getChoresMastery WashAndIronRobes)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


organizePotionIngredientsStats : Stats
organizePotionIngredientsStats =
    { skill = Skill.Chores
    , title = "Organize Potion Ingredients"
    , image = ActivityLandscape "/chores/potionIngredients_2.png"
    , unlockRequirements = Just ( Skill.Chores, 55 )
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
    { skill = Skill.Chores
    , title = "Repair Instruments"
    , image = ActivityLandscape "/chores/repairInstruments.png"
    , unlockRequirements = Just ( Skill.Chores, 65 )
    , duration = Duration.seconds 12
    , effects =
        choreEffects
            { activity = RepairInstruments
            , xp = Xp.int 75
            , coin = Coin.int 20
            , maybeResource = Just { resource = Resource.Scrap, amount = 1, probability = 0.25 }
            }
    , mastery = Just (getChoresMastery RepairInstruments)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


flushDrainDemonsStats : Stats
flushDrainDemonsStats =
    { skill = Skill.Chores
    , title = "Flush the Drain Demons"
    , image = ActivityLandscape "/chores/drainDemons.png"
    , unlockRequirements = Just ( Skill.Chores, 75 )
    , duration = Duration.seconds 10
    , effects =
        choreEffects
            { activity = FlushDrainDemons
            , xp = Xp.int 90
            , coin = Coin.int 14
            , maybeResource = Just { resource = Resource.Ectoplasm, amount = 1, probability = 0.1 }
            }
    , mastery = Just (getChoresMastery FlushDrainDemons)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }


organizeSpellBooksStats : Stats
organizeSpellBooksStats =
    { skill = Skill.Chores
    , title = "Organize Spell Books"
    , image = ActivityLandscape "/chores/spellBooks.png"
    , unlockRequirements = Just ( Skill.Chores, 90 )
    , duration = Duration.seconds 20
    , effects =
        choreEffects
            { activity = OrganizeSpellBooks
            , xp = Xp.int 210
            , coin = Coin.int 30
            , maybeResource = Just { resource = Resource.Parchment, amount = 1, probability = 0.05 }
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
            Spells.Hex1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Nothing
    , duration = Duration.seconds 3.5
    , effects =
        [ Effect.gainXp (Xp.int 12) Skill.Hexes
        , Effect.gainMxp Hex1
        , Effect.gainResource -1 Resource.Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Hex1
    }


jinx1Stats : Stats
jinx1Stats =
    let
        spell : Spell
        spell =
            Spells.Jinx1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 10 )
    , duration = Duration.seconds 4.5
    , effects =
        [ Effect.gainXp (Xp.int 18) Skill.Hexes
        , Effect.gainMxp Jinx1
        , Effect.gainResource -1 Resource.GreenhouseDirt
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Jinx1
    }


curse1Stats : Stats
curse1Stats =
    let
        spell : Spell
        spell =
            Spells.Curse1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 25 )
    , duration = Duration.seconds 5
    , effects =
        [ Effect.gainXp (Xp.int 24) Skill.Hexes
        , Effect.gainMxp Curse1
        , Effect.gainResource -1 Resource.WashWater
        , Effect.gainResource -1 Resource.Soot
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Curse1
    }


hex2Stats : Stats
hex2Stats =
    let
        spell : Spell
        spell =
            Spells.Hex2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 35 )
    , duration = Duration.seconds 9
    , effects =
        [ Effect.gainXp (Xp.int 54) Skill.Hexes
        , Effect.gainMxp Hex2
        , Effect.gainResource -4 Resource.Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Hex2
    }


jinx2Stats : Stats
jinx2Stats =
    let
        spell : Spell
        spell =
            Spells.Jinx2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 45 )
    , duration = Duration.seconds 10.5
    , effects =
        [ Effect.gainXp (Xp.int 65) Skill.Hexes
        , Effect.gainMxp Jinx2
        , Effect.gainResource -5 Resource.GreenhouseDirt
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Jinx2
    }


curse2Stats : Stats
curse2Stats =
    let
        spell : Spell
        spell =
            Spells.Curse2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 55 )
    , duration = Duration.seconds 12
    , effects =
        [ Effect.gainXp (Xp.int 99) Skill.Hexes
        , Effect.gainMxp Curse2
        , Effect.gainResource -2 Resource.WashWater
        , Effect.gainResource -1 Resource.Scrap
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Curse2
    }


hex3Stats : Stats
hex3Stats =
    let
        spell : Spell
        spell =
            Spells.Hex3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 65 )
    , duration = Duration.seconds 15
    , effects =
        [ Effect.gainXp (Xp.int 94) Skill.Hexes
        , Effect.gainMxp Hex3
        , Effect.gainResource -10 Resource.Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Hex3
    }


jinx3Stats : Stats
jinx3Stats =
    let
        spell : Spell
        spell =
            Spells.Jinx3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 75 )
    , duration = Duration.seconds 16
    , effects =
        [ Effect.gainXp (Xp.int 144) Skill.Hexes
        , Effect.gainMxp Jinx3
        , Effect.gainResource -6 Resource.GreenhouseDirt
        , Effect.gainResource -1 Resource.Ectoplasm
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Jinx3
    }


curse3Stats : Stats
curse3Stats =
    let
        spell : Spell
        spell =
            Spells.Curse3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { skill = Skill.Hexes
    , title = spellStats.title
    , image = ActivityIcon spellStats.icon
    , unlockRequirements = Just ( Skill.Hexes, 90 )
    , duration = Duration.seconds 19
    , effects =
        [ Effect.gainXp (Xp.int 200) Skill.Hexes
        , Effect.gainMxp Curse3
        , Effect.gainResource -2 Resource.WashWater
        , Effect.gainResource -2 Resource.Soot
        , Effect.gainResource -2 Resource.Scrap
        , Effect.gainResource -2 Resource.Manure
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Curse3
    }



-- Monsters


monsterEffects : { activity : Activity, rewards : List Effect.TaggedEffect, power : Int } -> List Effect.TaggedEffect
monsterEffects { activity, rewards, power } =
    [ Effect.resolveCombat (Combat.create { monsterPower = power, playerPower = 1 }) rewards
        |> Effect.withTags [ Effect.ActivityTag activity, Effect.SkillTag Skill.Adventuring ]
    ]


fightMonster1Stats : Stats
fightMonster1Stats =
    { skill = Skill.Adventuring
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
    { skill = Skill.Adventuring
    , title = "Ectoplo"
    , image = ActivityIcon (Icon.letter "E")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster2
            , rewards =
                [ Effect.gainResource 1 Resource.Ectoplasm
                    |> Effect.withTags [ Effect.ActivityTag FightMonster2, Effect.SkillTag Skill.Adventuring ]
                ]
            , power = 8
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster3Stats : Stats
fightMonster3Stats =
    { skill = Skill.Adventuring
    , title = "Dreadkin"
    , image = ActivityIcon (Icon.letter "D")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster3
            , rewards =
                [ Effect.gainCoin (Coin.int 5)
                    |> Effect.withTags [ Effect.ActivityTag FightMonster3, Effect.SkillTag Skill.Adventuring ]
                ]
            , power = 22
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster4Stats : Stats
fightMonster4Stats =
    { skill = Skill.Adventuring
    , title = "Creeping Vine"
    , image = ActivityIcon (Icon.letter "C")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster4
            , rewards =
                [ Effect.gainResource 1 Resource.GreenhouseDirt
                    |> Effect.withTags [ Effect.ActivityTag FightMonster4, Effect.SkillTag Skill.Adventuring ]
                ]
            , power = 45
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster5Stats : Stats
fightMonster5Stats =
    { skill = Skill.Adventuring
    , title = "Banshee"
    , image = ActivityIcon (Icon.letter "B")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster5
            , rewards =
                [ Effect.gainCoin (Coin.int 15)
                    |> Effect.withTags [ Effect.ActivityTag FightMonster5, Effect.SkillTag Skill.Adventuring ]
                ]
            , power = 75
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster6Stats : Stats
fightMonster6Stats =
    { skill = Skill.Adventuring
    , title = "Alucard"
    , image = ActivityIcon (Icon.letter "A")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightMonster6
            , rewards =
                [ Effect.gainResource 2 Resource.Scrap
                    |> Effect.withTags [ Effect.ActivityTag FightMonster6, Effect.SkillTag Skill.Adventuring ]
                , Effect.gainResource 2 Resource.Soot
                    |> Effect.withTags [ Effect.ActivityTag FightMonster6, Effect.SkillTag Skill.Adventuring ]
                , Effect.gainCoin (Coin.int 20)
                    |> Effect.withTags [ Effect.ActivityTag FightMonster6, Effect.SkillTag Skill.Adventuring ]
                ]
            , power = 110
            }
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }
