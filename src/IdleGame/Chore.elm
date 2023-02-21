module IdleGame.Chore exposing (..)

import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource


allKinds : List ChoreKind
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
    { mxp : Counter }


type alias AllChoreStates =
    { cleanStables : State
    , cleanBigBubba : State
    , sweepChimneys : State
    , waterGreenhousePlants : State
    , washRobes : State
    , organizePotionIngredients : State
    , repairInstruments : State
    , flushDrainDemons : State
    , organizeSpellBooks : State
    }


type alias Stats =
    { title : String
    , imgSrc : String
    , getter : AllChoreStates -> State
    , setter : (State -> State) -> AllChoreStates -> AllChoreStates
    , outcome : ChoreOutcome
    }


type alias ChoreOutcome =
    { xp : Int
    , duration : Float
    , extraResourceProbability : Float
    , extraResource : Resource.Kind
    , coin : Int
    }


incrementChoreMxp : Counter -> ChoreKind -> AllChoreStates -> AllChoreStates
incrementChoreMxp amount kind choresData =
    let
        stats =
            getStats kind
    in
    stats.setter (\choreData -> { choreData | mxp = Counter.add choreData.mxp amount }) choresData


cleanStablesStats =
    { title = "Clean Stables"
    , imgSrc = "/chores/stable.png"
    , getter = .cleanStables
    , setter = \fn choresData -> { choresData | cleanStables = fn choresData.cleanStables }
    , outcome =
        { xp = 10
        , duration = 3000
        , extraResourceProbability = 0.25
        , extraResource = Resource.Manure
        , coin = 1
        }
    }


cleanBigBubbaStats =
    { title = "Clean Big Bubba's Stall"
    , imgSrc = "/chores/bubba4.png"
    , getter = .cleanBigBubba
    , setter = \fn choresData -> { choresData | cleanBigBubba = fn choresData.cleanBigBubba }
    , outcome =
        { xp = 25
        , duration = 6000
        , extraResourceProbability = 0.75
        , extraResource = Resource.Manure
        , coin = 3
        }
    }


sweepChimneysStats =
    { title = "Sweep Chimneys"
    , imgSrc = "/chores/chimney.png"
    , getter = .sweepChimneys
    , setter = \fn choresData -> { choresData | sweepChimneys = fn choresData.sweepChimneys }
    , outcome =
        { xp = 37
        , duration = 8000
        , extraResourceProbability = 0.5
        , extraResource = Resource.Soot
        , coin = 6
        }
    }


waterGreenhousePlantsStats =
    { title = "Water Greenhouse Plants"
    , imgSrc = "/chores/greenhouse_3.png"
    , getter = .waterGreenhousePlants
    , setter = \fn choresData -> { choresData | waterGreenhousePlants = fn choresData.waterGreenhousePlants }
    , outcome =
        { xp = 12
        , duration = 2000
        , extraResourceProbability = 0.6
        , extraResource = Resource.GreenhouseDirt
        , coin = 2
        }
    }


washAndIronRobesStats =
    { title = "Wash and Iron Robes"
    , imgSrc = "/chores/washRobes.png"
    , getter = .washRobes
    , setter = \fn choresData -> { choresData | washRobes = fn choresData.washRobes }
    , outcome =
        { xp = 50
        , duration = 8000
        , extraResourceProbability = 0.2
        , extraResource = Resource.WashWater
        , coin = 9
        }
    }


organizePotionIngredientsStats =
    { title = "Organize Potion Ingredients"
    , imgSrc = "/chores/potionIngredients_2.png"
    , getter = .organizePotionIngredients
    , setter = \fn choresData -> { choresData | organizePotionIngredients = fn choresData.organizePotionIngredients }
    , outcome =
        { xp = 165
        , duration = 20000
        , extraResourceProbability = 0.1
        , extraResource = Resource.EmptyBottle
        , coin = 12
        }
    }


repairInstrumentsStats =
    { title = "Repair Instruments"
    , imgSrc = "/chores/repairInstruments.png"
    , getter = .repairInstruments
    , setter = \fn choresData -> { choresData | repairInstruments = fn choresData.repairInstruments }
    , outcome =
        { xp = 75
        , duration = 12000
        , extraResourceProbability = 0.25
        , extraResource = Resource.Scrap
        , coin = 20
        }
    }


flushDrainDemonsStats =
    { title = "Flush the Drain Demons"
    , imgSrc = "/chores/drainDemons.png"
    , getter = .flushDrainDemons
    , setter = \fn choresData -> { choresData | flushDrainDemons = fn choresData.flushDrainDemons }
    , outcome =
        { xp = 90
        , duration = 10000
        , extraResourceProbability = 0.5
        , extraResource = Resource.Ectoplasm
        , coin = 14
        }
    }


organizeSpellBooksStats =
    { title = "Organize Spell Books"
    , imgSrc = "/chores/spellBooks.png"
    , getter = .organizeSpellBooks
    , setter = \fn choresData -> { choresData | organizeSpellBooks = fn choresData.organizeSpellBooks }
    , outcome =
        { xp = 210
        , duration = 20000
        , extraResourceProbability = 0.1
        , extraResource = Resource.Parchment
        , coin = 30
        }
    }


getStats : ChoreKind -> Stats
getStats kind =
    case kind of
        CleanStables ->
            cleanStablesStats

        CleanBigBubba ->
            cleanBigBubbaStats

        SweepChimneys ->
            sweepChimneysStats

        WaterGreenhousePlants ->
            waterGreenhousePlantsStats

        WashAndIronRobes ->
            washAndIronRobesStats

        OrganizePotionIngredients ->
            organizePotionIngredientsStats

        RepairInstruments ->
            repairInstrumentsStats

        FlushDrainDemons ->
            flushDrainDemonsStats

        OrganizeSpellBooks ->
            organizeSpellBooksStats
