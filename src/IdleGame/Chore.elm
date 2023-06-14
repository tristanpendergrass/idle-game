module IdleGame.Chore exposing (..)

import Duration exposing (Duration)
import IdleGame.Resource as Resource
import IdleGame.Xp as Xp exposing (Xp)
import Quantity exposing (Quantity)


type Kind
    = CleanStables
    | CleanBigBubba
    | SweepChimneys
    | WaterGreenhousePlants
    | WashAndIronRobes
    | OrganizePotionIngredients
    | RepairInstruments
    | FlushDrainDemons
    | OrganizeSpellBooks


allKinds : List Kind
allKinds =
    [ CleanStables
    , CleanBigBubba
    , SweepChimneys
    , WaterGreenhousePlants
    , WashAndIronRobes
    , OrganizePotionIngredients
    , RepairInstruments
    , FlushDrainDemons
    , OrganizeSpellBooks
    ]


type alias State =
    { mxp : Xp }


type alias ChoreRecord a =
    { cleanStables : a
    , cleanBigBubba : a
    , sweepChimneys : a
    , waterGreenhousePlants : a
    , washRobes : a
    , organizePotionIngredients : a
    , repairInstruments : a
    , flushDrainDemons : a
    , organizeSpellBooks : a
    }


getByKind : Kind -> ChoreRecord a -> a
getByKind kind data =
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
            data.washRobes

        OrganizePotionIngredients ->
            data.organizePotionIngredients

        RepairInstruments ->
            data.repairInstruments

        FlushDrainDemons ->
            data.flushDrainDemons

        OrganizeSpellBooks ->
            data.organizeSpellBooks


setByKind : Kind -> a -> ChoreRecord a -> ChoreRecord a
setByKind kind value data =
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
            { data | washRobes = value }

        OrganizePotionIngredients ->
            { data | organizePotionIngredients = value }

        RepairInstruments ->
            { data | repairInstruments = value }

        FlushDrainDemons ->
            { data | flushDrainDemons = value }

        OrganizeSpellBooks ->
            { data | organizeSpellBooks = value }


updateByKind : Kind -> (a -> a) -> ChoreRecord a -> ChoreRecord a
updateByKind kind update data =
    setByKind kind (update (getByKind kind data)) data


type alias AllStates =
    ChoreRecord State


type alias AllStats =
    ChoreRecord Stats


type alias Stats =
    { title : String
    , imgSrc : String
    , outcome : ChoreOutcome
    }


type alias ChoreOutcome =
    { xp : Xp
    , duration : Duration
    , extraResourceProbability : Float
    , extraResource : Resource.Kind
    , coin : Int
    }


allStats : ChoreRecord Stats
allStats =
    { cleanStables = cleanStablesStats
    , cleanBigBubba = cleanBigBubbaStats
    , sweepChimneys = sweepChimneysStats
    , waterGreenhousePlants = waterGreenhousePlantsStats
    , washRobes = washAndIronRobesStats
    , organizePotionIngredients = organizePotionIngredientsStats
    , repairInstruments = repairInstrumentsStats
    , flushDrainDemons = flushDrainDemonsStats
    , organizeSpellBooks = organizeSpellBooksStats
    }


cleanStablesStats : Stats
cleanStablesStats =
    { title = "Clean Stables"
    , imgSrc = "/chores/stable.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , extraResourceProbability = 0.25
        , extraResource = Resource.Manure
        , coin = 1
        }
    }


cleanBigBubbaStats : Stats
cleanBigBubbaStats =
    { title = "Clean Big Bubba's Stall"
    , imgSrc = "/chores/bubba4.png"
    , outcome =
        { xp = Xp.fromInt 25
        , duration = Duration.seconds 6
        , extraResourceProbability = 0.75
        , extraResource = Resource.Manure
        , coin = 3
        }
    }


sweepChimneysStats : Stats
sweepChimneysStats =
    { title = "Sweep Chimneys"
    , imgSrc = "/chores/chimney.png"
    , outcome =
        { xp = Xp.fromInt 37
        , duration = Duration.seconds 8
        , extraResourceProbability = 0.5
        , extraResource = Resource.Soot
        , coin = 6
        }
    }


waterGreenhousePlantsStats : Stats
waterGreenhousePlantsStats =
    { title = "Water Greenhouse Plants"
    , imgSrc = "/chores/greenhouse_3.png"
    , outcome =
        { xp = Xp.fromInt 12
        , duration = Duration.seconds 2
        , extraResourceProbability = 0.6
        , extraResource = Resource.GreenhouseDirt
        , coin = 2
        }
    }


washAndIronRobesStats : Stats
washAndIronRobesStats =
    { title = "Wash and Iron Robes"
    , imgSrc = "/chores/washRobes.png"
    , outcome =
        { xp = Xp.fromInt 50
        , duration = Duration.seconds 8
        , extraResourceProbability = 0.2
        , extraResource = Resource.WashWater
        , coin = 9
        }
    }


organizePotionIngredientsStats : Stats
organizePotionIngredientsStats =
    { title = "Organize Potion Ingredients"
    , imgSrc = "/chores/potionIngredients_2.png"
    , outcome =
        { xp = Xp.fromInt 165
        , duration = Duration.seconds 20
        , extraResourceProbability = 0.1
        , extraResource = Resource.EmptyBottle
        , coin = 12
        }
    }


repairInstrumentsStats : Stats
repairInstrumentsStats =
    { title = "Repair Instruments"
    , imgSrc = "/chores/repairInstruments.png"
    , outcome =
        { xp = Xp.fromInt 75
        , duration = Duration.seconds 12
        , extraResourceProbability = 0.25
        , extraResource = Resource.Scrap
        , coin = 20
        }
    }


flushDrainDemonsStats : Stats
flushDrainDemonsStats =
    { title = "Flush the Drain Demons"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 90
        , duration = Duration.seconds 10
        , extraResourceProbability = 0.5
        , extraResource = Resource.Ectoplasm
        , coin = 14
        }
    }


organizeSpellBooksStats : Stats
organizeSpellBooksStats =
    { title = "Organize Spell Books"
    , imgSrc = "/chores/spellBooks.png"
    , outcome =
        { xp = Xp.fromInt 210
        , duration = Duration.seconds 20
        , extraResourceProbability = 0.1
        , extraResource = Resource.Parchment
        , coin = 30
        }
    }


getStats : Kind -> Stats
getStats kind =
    getByKind kind allStats
