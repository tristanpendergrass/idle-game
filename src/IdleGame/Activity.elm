module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils exposing (cardImage)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)


allActivitiesBySkill : Skill -> List Activity
allActivitiesBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getStats kind).belongsTo == BelongsToSkill skill
            )


activityForMonster : Monster -> Activity
activityForMonster monster =
    case monster of
        Prefect ->
            FightPrefect

        BookWyrm ->
            FightBookWyrm

        WhisperingWind ->
            FightWhisperingWind


allChores : List Activity
allChores =
    allActivitiesBySkill Chores


allHexes : List Activity
allHexes =
    allActivitiesBySkill Hexes


allWeathermancing : List Activity
allWeathermancing =
    allActivitiesBySkill Weathermancing


getActivities : Skill -> List Activity
getActivities skill =
    case skill of
        Chores ->
            allChores

        Hexes ->
            allHexes

        Weathermancing ->
            allWeathermancing


getBySpell : Spell -> Maybe Activity
getBySpell spell =
    List.Extra.find (\activity -> (getStats activity).teachesSpell == Just spell) allActivities


type MasteryReward
    = SpellAvailable -- Spell can now be used
    | SecondaryEnabled -- Spell can be used as secondary
    | ImbueEnabled -- Spell can be embued with elements
    | IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Mod -- Apply mod to game


type alias Mastery =
    List ( Int, MasteryReward )


type BelongsTo
    = BelongsToSkill Skill
    | BelongsToLocation Location


belongsToLabel : BelongsTo -> String
belongsToLabel belongsTo =
    case belongsTo of
        BelongsToSkill skill ->
            Skill.getLabel skill

        BelongsToLocation location ->
            Location.getLabel location


type alias Stats =
    { belongsTo : BelongsTo
    , title : String
    , image : CardImage
    , unlockRequirements : Maybe ( Skill, Int )
    , duration : Duration
    , effects : List Effect.TaggedEffect
    , mastery : Maybe Mastery
    , teachesSpell : Maybe Spell -- Does this activity represent training a specific spell
    , showDuration : Bool
    }


getStats : Activity -> Stats
getStats kind =
    getByActivity kind allStats


allStats : ActivityRecord Stats
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
    , studyHex1 = studyHex1Stats
    , studyJinx1 = studyJinx1Stats
    , studyCurse1 = studyCurse1Stats
    , studyHex2 = studyHex2Stats
    , studyJinx2 = studyJinx2Stats
    , studyCurse2 = studyCurse2Stats
    , studyHex3 = studyHex3Stats
    , studyJinx3 = studyJinx3Stats
    , studyCurse3 = studyCurse3Stats
    , studyWind = studyWindStats
    , studyWater = studyWaterStats
    , studySun = studySunStats
    , exploreSchoolGrounds = exploreSchoolGroundsStats
    , exploreSecretGarden = exploreSecretGardenStats
    , fightPrefect = fightPrefectStats
    , fightBookWyrm = fightBookWyrmStats
    , fightWhisperingWind = fightWhisperingWind
    }



-- Chores


choreEffects :
    { activity : Activity
    , xp : Xp
    , coin : Coin
    , maybeResource : Maybe { resource : Resource, amount : Int, probability : Percent }
    }
    -> List Effect.TaggedEffect
choreEffects { activity, xp, coin, maybeResource } =
    let
        choreTags : List Effect.Tag
        choreTags =
            [ Effect.ActivityTag activity, Effect.SkillTag Chores ]
    in
    [ { effect = Effect.GainXp { base = xp, percentIncrease = Percent.zero, skill = Chores }, tags = choreTags }
    , { effect = Effect.GainCoin { base = coin, percentIncrease = Percent.zero }, tags = choreTags }
    , { effect = Effect.GainMxp { activity = activity, percentIncrease = Percent.zero }, tags = choreTags }
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
                                                , doublingChance = Percent.zero
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
            (Mod.coinBuff (Percent.float 0.1)
                |> Mod.withTags [ Effect.ActivityTag chore ]
            )
      )
    , ( 50
      , GameMod
            (Mod.activityXpBuff chore (Percent.float 0.25)
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
            (Mod.skillXpBuff Chores (Percent.float 0.05)
                |> Mod.withTags [ Effect.SkillTag Chores ]
            )
      )
    ]


cleanStablesStats : Stats
cleanStablesStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Clean Stables"
    , image = CardLandscape "/chores/stable.png"
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
    , teachesSpell = Nothing
    , showDuration = True
    }


cleanBigBubbaStats : Stats
cleanBigBubbaStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Clean Big Bubba's Stall"
    , image = CardLandscape "/chores/bubba4.png"
    , unlockRequirements = Just ( Chores, 10 )
    , duration = Duration.seconds 6
    , effects =
        choreEffects
            { activity = CleanBigBubba
            , xp = Xp.int 25
            , coin = Coin.int 3
            , maybeResource = Just { resource = Manure, amount = 1, probability = Percent.float 0.75 }
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
    , teachesSpell = Nothing
    , showDuration = True
    }


sweepChimneyStats : Stats
sweepChimneyStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Sweep Chimneys"
    , image = CardLandscape "/chores/chimney.png"
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
    , teachesSpell = Nothing
    , showDuration = True
    }


waterGreenhousePlantsStats : Stats
waterGreenhousePlantsStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Water Greenhouse Plants"
    , image = CardLandscape "/chores/greenhouse_3.png"
    , unlockRequirements = Just ( Chores, 35 )
    , duration = Duration.seconds 2
    , effects =
        choreEffects
            { activity = WaterGreenhousePlants
            , xp = Xp.int 12
            , coin = Coin.int 2
            , maybeResource = Just { resource = GreenhouseDirt, amount = 1, probability = Percent.float 0.6 }
            }
    , mastery = Just (getChoresMastery WaterGreenhousePlants)
    , teachesSpell = Nothing
    , showDuration = True
    }


washAndIronRobesStats : Stats
washAndIronRobesStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Wash and Iron Robes"
    , image = CardLandscape "/chores/washRobes.png"
    , unlockRequirements = Just ( Chores, 45 )
    , duration = Duration.seconds 8
    , effects =
        choreEffects
            { activity = WashAndIronRobes
            , xp = Xp.int 50
            , coin = Coin.int 9
            , maybeResource = Just { resource = WashWater, amount = 1, probability = Percent.float 0.1 }
            }
    , mastery = Just (getChoresMastery WashAndIronRobes)
    , teachesSpell = Nothing
    , showDuration = True
    }


organizePotionIngredientsStats : Stats
organizePotionIngredientsStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Organize Potion Ingredients"
    , image = CardLandscape "/chores/potionIngredients_2.png"
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
    , teachesSpell = Nothing
    , showDuration = True
    }


repairInstrumentsStats : Stats
repairInstrumentsStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Repair Instruments"
    , image = CardLandscape "/chores/repairInstruments.png"
    , unlockRequirements = Just ( Chores, 65 )
    , duration = Duration.seconds 12
    , effects =
        choreEffects
            { activity = RepairInstruments
            , xp = Xp.int 75
            , coin = Coin.int 20
            , maybeResource = Just { resource = Scrap, amount = 1, probability = Percent.float 0.25 }
            }
    , mastery = Just (getChoresMastery RepairInstruments)
    , teachesSpell = Nothing
    , showDuration = True
    }


flushDrainDemonsStats : Stats
flushDrainDemonsStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Flush the Drain Demons"
    , image = CardLandscape "/chores/drainDemons.png"
    , unlockRequirements = Just ( Chores, 75 )
    , duration = Duration.seconds 10
    , effects =
        choreEffects
            { activity = FlushDrainDemons
            , xp = Xp.int 90
            , coin = Coin.int 14
            , maybeResource = Just { resource = Ectoplasm, amount = 1, probability = Percent.float 0.1 }
            }
    , mastery = Just (getChoresMastery FlushDrainDemons)
    , teachesSpell = Nothing
    , showDuration = True
    }


organizeSpellBooksStats : Stats
organizeSpellBooksStats =
    { belongsTo = BelongsToSkill Chores
    , title = "Organize Spell Books"
    , image = CardLandscape "/chores/spellBooks.png"
    , unlockRequirements = Just ( Chores, 90 )
    , duration = Duration.seconds 20
    , effects =
        choreEffects
            { activity = OrganizeSpellBooks
            , xp = Xp.int 210
            , coin = Coin.int 30
            , maybeResource = Just { resource = Parchment, amount = 1, probability = Percent.float 0.05 }
            }
    , mastery = Just (getChoresMastery OrganizeSpellBooks)
    , teachesSpell = Nothing
    , showDuration = True
    }



-- Hexes


studyHexesMastery : Mastery
studyHexesMastery =
    [ ( 25, SpellAvailable )
    , ( 50, SecondaryEnabled )
    , ( 75, ImbueEnabled )
    , ( 100, GameMod (Mod.powerBuff 1) )
    ]


studyWeathermancingMastery : Mastery
studyWeathermancingMastery =
    [ ( 25, SpellAvailable )
    , ( 50, SecondaryEnabled )
    , ( 75, ImbueEnabled )
    , ( 100, GameMod (Mod.skillXpBuff Chores (Percent.float 0.05)) )
    ]


studyHex1Stats : Stats
studyHex1Stats =
    let
        spell : Spell
        spell =
            Hex1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Nothing
    , duration = Duration.seconds 3.5
    , effects =
        [ Effect.gainXp (Xp.int 12) Hexes
        , Effect.gainMxp StudyHex1
        , Effect.gainResource -1 Manure
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Hex1
    , showDuration = True
    }


studyJinx1Stats : Stats
studyJinx1Stats =
    let
        spell : Spell
        spell =
            Jinx1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 10 )
    , duration = Duration.seconds 4.5
    , effects =
        [ Effect.gainXp (Xp.int 18) Hexes
        , Effect.gainMxp StudyJinx1
        , Effect.gainResource -1 GreenhouseDirt
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Jinx1
    , showDuration = True
    }


studyCurse1Stats : Stats
studyCurse1Stats =
    let
        spell : Spell
        spell =
            Curse1

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 25 )
    , duration = Duration.seconds 5
    , effects =
        [ Effect.gainXp (Xp.int 24) Hexes
        , Effect.gainMxp StudyCurse1
        , Effect.gainResource -1 WashWater
        , Effect.gainResource -1 Soot
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Curse1
    , showDuration = True
    }


studyHex2Stats : Stats
studyHex2Stats =
    let
        spell : Spell
        spell =
            Hex2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 35 )
    , duration = Duration.seconds 9
    , effects =
        [ Effect.gainXp (Xp.int 54) Hexes
        , Effect.gainMxp StudyHex2
        , Effect.gainResource -4 Manure
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Hex2
    , showDuration = True
    }


studyJinx2Stats : Stats
studyJinx2Stats =
    let
        spell : Spell
        spell =
            Jinx2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 45 )
    , duration = Duration.seconds 10.5
    , effects =
        [ Effect.gainXp (Xp.int 65) Hexes
        , Effect.gainMxp StudyJinx2
        , Effect.gainResource -5 GreenhouseDirt
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Jinx2
    , showDuration = True
    }


studyCurse2Stats : Stats
studyCurse2Stats =
    let
        spell : Spell
        spell =
            Curse2

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 55 )
    , duration = Duration.seconds 12
    , effects =
        [ Effect.gainXp (Xp.int 99) Hexes
        , Effect.gainMxp StudyCurse2
        , Effect.gainResource -2 WashWater
        , Effect.gainResource -1 Scrap
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Curse2
    , showDuration = True
    }


studyHex3Stats : Stats
studyHex3Stats =
    let
        spell : Spell
        spell =
            Hex3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 65 )
    , duration = Duration.seconds 15
    , effects =
        [ Effect.gainXp (Xp.int 94) Hexes
        , Effect.gainMxp StudyHex3
        , Effect.gainResource -10 Manure
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Hex3
    , showDuration = True
    }


studyJinx3Stats : Stats
studyJinx3Stats =
    let
        spell : Spell
        spell =
            Jinx3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
    , unlockRequirements = Just ( Hexes, 75 )
    , duration = Duration.seconds 16
    , effects =
        [ Effect.gainXp (Xp.int 144) Hexes
        , Effect.gainMxp StudyJinx3
        , Effect.gainResource -6 GreenhouseDirt
        , Effect.gainResource -1 Ectoplasm
        ]
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Jinx3
    , showDuration = True
    }


studyCurse3Stats : Stats
studyCurse3Stats =
    let
        spell : Spell
        spell =
            Curse3

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Hexes
    , title = spellStats.title
    , image = CardIcon spellStats.icon
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
    , mastery = Just studyHexesMastery
    , teachesSpell = Just Curse3
    , showDuration = True
    }


studyWindStats : Stats
studyWindStats =
    let
        spell : Spell
        spell =
            Wind

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Weathermancing
    , title = spellStats.title
    , image = CardLandscape "/weathermancing/wind.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 4
    , effects =
        [ Effect.gainXp (Xp.int 10) Weathermancing
        , Effect.gainMxp StudyWind
        ]
    , mastery = Just studyWeathermancingMastery
    , teachesSpell = Just Wind
    , showDuration = True
    }


studyWaterStats : Stats
studyWaterStats =
    let
        spell : Spell
        spell =
            Water

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Weathermancing
    , title = spellStats.title
    , image = CardLandscape "/weathermancing/water.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 4
    , effects =
        [ Effect.gainXp (Xp.int 10) Weathermancing
        , Effect.gainMxp StudyWater
        ]
    , mastery = Just studyWeathermancingMastery
    , teachesSpell = Just Water
    , showDuration = True
    }


studySunStats : Stats
studySunStats =
    let
        spell : Spell
        spell =
            Sun

        spellStats : Spell.Stats
        spellStats =
            Spell.getStats spell
    in
    { belongsTo = BelongsToSkill Weathermancing
    , title = spellStats.title
    , image = CardLandscape "/weathermancing/sun.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 4
    , effects =
        [ Effect.gainXp (Xp.int 10) Weathermancing
        , Effect.gainMxp StudySun
        ]
    , mastery = Just studyWeathermancingMastery
    , teachesSpell = Just Sun
    , showDuration = True
    }



-- Adventuring


exploreSchoolGroundsStats : Stats
exploreSchoolGroundsStats =
    { belongsTo = BelongsToLocation SchoolGrounds
    , title = "Explore: School Grounds"
    , image = CardLandscape "/aiart/school_grounds.webp"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 4
    , effects = [ Effect.explore SchoolGrounds ]
    , mastery = Nothing
    , teachesSpell = Nothing
    , showDuration = False
    }


exploreSecretGardenStats : Stats
exploreSecretGardenStats =
    { belongsTo = BelongsToLocation SecretGarden
    , title = "Explore: Secret Garden"
    , image = CardLandscape "/aiart/secret_garden.png"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 4
    , effects = [ Effect.explore SecretGarden ]
    , mastery = Nothing
    , teachesSpell = Nothing
    , showDuration = False
    }


monsterEffects : { activity : Activity, rewards : List Effect.TaggedEffect, power : Int } -> List Effect.TaggedEffect
monsterEffects { activity, rewards, power } =
    [ Effect.resolveCombat (Combat.create { monsterPower = power, playerPower = 1 }) rewards
        |> Effect.withTags [ Effect.ActivityTag activity ]
    ]


fightPrefectStats : Stats
fightPrefectStats =
    { belongsTo = BelongsToLocation SchoolGrounds
    , title = "Prefect"
    , image = CardLandscape "/aiart/prefect.webp"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightPrefect
            , rewards =
                [ Effect.gainCoin (Coin.int 1)
                    |> Effect.withTags [ Effect.ActivityTag FightPrefect ]
                ]
            , power = 1
            }
    , mastery = Nothing
    , teachesSpell = Nothing
    , showDuration = False
    }


fightBookWyrmStats : Stats
fightBookWyrmStats =
    { belongsTo = BelongsToLocation SchoolGrounds
    , title = "Book Wyrm"
    , image = CardLandscape "/aiart/book_wyrm.webp"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightBookWyrm
            , rewards =
                [ Effect.gainResource 1 Ectoplasm
                    |> Effect.withTags [ Effect.ActivityTag FightBookWyrm ]
                ]
            , power = 8
            }
    , mastery = Nothing
    , teachesSpell = Nothing
    , showDuration = False
    }


fightWhisperingWind : Stats
fightWhisperingWind =
    { belongsTo = BelongsToLocation SecretGarden
    , title = "Whispering Wind"
    , image = CardLandscape "/aiart/whispering_wind.webp"
    , unlockRequirements = Nothing
    , duration = Duration.seconds 8
    , effects =
        monsterEffects
            { activity = FightWhisperingWind
            , rewards =
                [ Effect.gainCoin (Coin.int 5)
                    |> Effect.withTags [ Effect.ActivityTag FightWhisperingWind ]
                ]
            , power = 22
            }
    , mastery = Nothing
    , teachesSpell = Nothing
    , showDuration = False
    }



-- Utils


isCombatActivity : Activity -> Bool
isCombatActivity activity =
    let
        effects : List Effect.TaggedEffect
        effects =
            (getStats activity).effects

        effectIsCombat : Effect.TaggedEffect -> Bool
        effectIsCombat effect =
            case effect.effect of
                Effect.ResolveCombat _ ->
                    True

                _ ->
                    False
    in
    List.any effectIsCombat effects


updateByKindActivity : Activity -> (a -> a) -> ActivityRecord a -> ActivityRecord a
updateByKindActivity activity fn record =
    setByActivity activity (fn (getByActivity activity record)) record
