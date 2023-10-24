module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities as Activities exposing (Activity)
import IdleGame.Kinds.Spells as Spells exposing (Spell)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)



-- type Activity
--     = -- Chores
--       CleanStables
--     | CleanBigBubba
--     | SweepChimneys
--     | WaterGreenhousePlants
--     | WashAndIronRobes
--     | OrganizePotionIngredients
--     | RepairInstruments
--     | FlushDrainDemons
--     | OrganizeSpellBooks
--       -- Hexes
--     | Hex1
--     | Hex2
--       -- Adventuring
--     | FightMonster1
--     | FightMonster2


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
    [ Activities.CleanStables
    , Activities.CleanBigBubba
    , Activities.SweepChimneys
    , Activities.WaterGreenhousePlants
    , Activities.WashAndIronRobes
    , Activities.OrganizePotionIngredients
    , Activities.RepairInstruments
    , Activities.FlushDrainDemons
    , Activities.OrganizeSpellBooks
    , Activities.Hex1
    , Activities.Hex2
    , Activities.FightMonster1
    , Activities.FightMonster2
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
    , hex2 : a
    , fightMonster1 : a
    , fightMonster2 : a
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
    , hex2 = d
    , fightMonster1 = d
    , fightMonster2 = d
    }


getByKind : Activity -> Record a -> a
getByKind kind record =
    case kind of
        Activities.CleanStables ->
            record.cleanStables

        Activities.CleanBigBubba ->
            record.cleanBigBubba

        Activities.SweepChimneys ->
            record.sweepChimneys

        Activities.WaterGreenhousePlants ->
            record.waterGreenhousePlants

        Activities.WashAndIronRobes ->
            record.washAndIronRobes

        Activities.OrganizePotionIngredients ->
            record.organizePotionIngredients

        Activities.RepairInstruments ->
            record.repairInstruments

        Activities.FlushDrainDemons ->
            record.flushDrainDemons

        Activities.OrganizeSpellBooks ->
            record.organizeSpellBooks

        Activities.Hex1 ->
            record.hex1

        Activities.Hex2 ->
            record.hex2

        Activities.FightMonster1 ->
            record.fightMonster1

        Activities.FightMonster2 ->
            record.fightMonster2


setByKind : Activity -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        Activities.CleanStables ->
            { record | cleanStables = value }

        Activities.CleanBigBubba ->
            { record | cleanBigBubba = value }

        Activities.SweepChimneys ->
            { record | sweepChimneys = value }

        Activities.WaterGreenhousePlants ->
            { record | waterGreenhousePlants = value }

        Activities.WashAndIronRobes ->
            { record | washAndIronRobes = value }

        Activities.OrganizePotionIngredients ->
            { record | organizePotionIngredients = value }

        Activities.RepairInstruments ->
            { record | repairInstruments = value }

        Activities.FlushDrainDemons ->
            { record | flushDrainDemons = value }

        Activities.OrganizeSpellBooks ->
            { record | organizeSpellBooks = value }

        Activities.Hex1 ->
            { record | hex1 = value }

        Activities.Hex2 ->
            { record | hex2 = value }

        Activities.FightMonster1 ->
            { record | fightMonster1 = value }

        Activities.FightMonster2 ->
            { record | fightMonster2 = value }


updateByKind : Activity -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record


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
            [ Effect.ActivityTag activity ]
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
    , hex2 = hex2Stats
    , fightMonster1 = fightMonster1Stats
    , fightMonster2 = fightMonster2Stats
    }


cleanStablesStats : Stats
cleanStablesStats =
    { skill = Skill.Chores
    , title = "Clean Stables"
    , image = ActivityLandscape "/chores/stable.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 3
    , effects =
        choreEffects
            { activity = Activities.CleanStables
            , xp = Xp.int 10
            , coin = Coin.int 1
            , maybeResource = Nothing
            }
    , mastery = Just (getChoresMastery Activities.CleanStables)
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
            { activity = Activities.CleanBigBubba
            , xp = Xp.int 25
            , coin = Coin.int 3
            , maybeResource = Just { resource = Resource.Manure, amount = 1, probability = 0.75 }
            }
    , mastery =
        let
            choresMastery : Mastery
            choresMastery =
                getChoresMastery Activities.CleanBigBubba

            bigBubbaMastery : Mastery
            bigBubbaMastery =
                List.Extra.setAt 3
                    ( 100
                    , GameMod
                        { tags = [ Effect.ActivityTag Activities.CleanBigBubba ]
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
            { activity = Activities.SweepChimneys
            , xp = Xp.int 37
            , coin = Coin.int 6
            , maybeResource = Nothing
            }
    , mastery = Just (getChoresMastery Activities.SweepChimneys)
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
            { activity = Activities.WaterGreenhousePlants
            , xp = Xp.int 12
            , coin = Coin.int 2
            , maybeResource = Just { resource = Resource.GreenhouseDirt, amount = 1, probability = 0.6 }
            }
    , mastery = Just (getChoresMastery Activities.WaterGreenhousePlants)
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
            { activity = Activities.WashAndIronRobes
            , xp = Xp.int 50
            , coin = Coin.int 9
            , maybeResource = Just { resource = Resource.WashWater, amount = 1, probability = 0.1 }
            }
    , mastery = Just (getChoresMastery Activities.WashAndIronRobes)
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
            { activity = Activities.OrganizePotionIngredients
            , xp = Xp.int 165
            , coin = Coin.int 12
            , maybeResource = Nothing
            }
    , mastery = Just (getChoresMastery Activities.OrganizePotionIngredients)
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
            { activity = Activities.RepairInstruments
            , xp = Xp.int 75
            , coin = Coin.int 20
            , maybeResource = Just { resource = Resource.Scrap, amount = 1, probability = 0.25 }
            }
    , mastery = Just (getChoresMastery Activities.RepairInstruments)
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
            { activity = Activities.FlushDrainDemons
            , xp = Xp.int 90
            , coin = Coin.int 14
            , maybeResource = Just { resource = Resource.Ectoplasm, amount = 1, probability = 0.1 }
            }
    , mastery = Just (getChoresMastery Activities.FlushDrainDemons)
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
            { activity = Activities.OrganizeSpellBooks
            , xp = Xp.int 210
            , coin = Coin.int 30
            , maybeResource = Just { resource = Resource.Parchment, amount = 1, probability = 0.05 }
            }
    , mastery = Just (getChoresMastery Activities.OrganizeSpellBooks)
    , hasSpellSelector = False
    , teachesSpell = Nothing
    }



-- Hexes


hex1Stats : Stats
hex1Stats =
    { skill = Skill.Hexes
    , title = "Hex I"
    , image = ActivityIcon (Resource.getStats Resource.Hex1).icon
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , effects =
        [ Effect.gainXp (Xp.int 5) Skill.Hexes
        , Effect.gainMxp Activities.Hex1
        , Effect.gainResource -1 Resource.Parchment
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Hex1
    }


hex2Stats : Stats
hex2Stats =
    { skill = Skill.Hexes
    , title = "Hex II"
    , image = ActivityIcon (Resource.getStats Resource.Hex2).icon
    , unlockRequirements = Just ( Skill.Hexes, 10 )
    , duration = Duration.seconds 5
    , effects =
        [ Effect.gainXp (Xp.int 10) Skill.Hexes
        , Effect.gainMxp Activities.Hex2
        , Effect.gainResource -1 Resource.Parchment
        ]
    , mastery = Just defaultSpellMastery
    , hasSpellSelector = False
    , teachesSpell = Just Spells.Hex2
    }


getActivityMastery : Activity -> Mastery
getActivityMastery activity =
    [ ( 10
      , GameMod
            (Mod.activityXpBuff activity 0.25
                |> Mod.withTags [ Effect.ActivityTag activity ]
            )
      )
    , ( 35, GameMod (Mod.activityXpBuff activity 0.25) )
    , ( 65, GameMod (Mod.activityXpBuff activity 0.25) )
    , ( 95, GameMod (Mod.activityXpBuff activity 0.35) )
    ]


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
            , percentChange = Percent.fromFloat 0.1
            , label = IntervalModLabel (Percent.fromFloat 0.1)
            }
      )
    , ( 100
      , GameMod
            (Mod.skillXpBuff Skill.Chores 0.05
                |> Mod.withTags [ Effect.SkillTag Skill.Chores ]
            )
      )
    ]


defaultSpellMastery : Mastery
defaultSpellMastery =
    [ ( 25, SpellAvailable )
    , ( 50, SecondaryEnabled )
    , ( 75, ImbueEnabled )
    , ( 100, GameMod (Mod.powerBuff 1) )
    ]


fightMonster1Stats : Stats
fightMonster1Stats =
    { skill = Skill.Adventuring
    , title = "Fight Monster I"
    , image = ActivityIcon (Icon.letter "M1")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , effects =
        [ Effect.resolveCombat
            (Combat.create { monsterPower = 1, playerPower = 1 })
            [ Effect.gainCoin (Coin.int 1) ]
            |> Effect.withTags [ Effect.ActivityTag Activities.FightMonster1 ]
        ]
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


fightMonster2Stats : Stats
fightMonster2Stats =
    { skill = Skill.Adventuring
    , title = "Fight Monster II"
    , image = ActivityIcon (Icon.letter "M2")
    , unlockRequirements = Nothing
    , duration = Duration.seconds 5
    , effects =
        [ Effect.resolveCombat
            (Combat.create { monsterPower = 2, playerPower = 1 })
            [ Effect.gainCoin (Coin.int 2) ]
            |> Effect.withTags [ Effect.ActivityTag Activities.FightMonster2 ]
        ]
    , mastery = Nothing
    , hasSpellSelector = True
    , teachesSpell = Nothing
    }


getBySpell : Spell -> Maybe Activity
getBySpell spell =
    List.Extra.find (\activity -> (getStats activity).teachesSpell == Just spell) allActivities
