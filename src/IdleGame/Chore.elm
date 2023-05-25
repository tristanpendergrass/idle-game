module IdleGame.Chore exposing (..)

import Duration exposing (Duration)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Xp as Xp exposing (Xp)
import Quantity exposing (Quantity)


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
    { mxp : Xp }


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
    { xp : Xp
    , duration : Duration
    , extraResourceProbability : Float
    , extraResource : Resource.Kind
    , coin : Int
    }


incrementChoreMxp : Xp -> ChoreKind -> AllChoreStates -> AllChoreStates
incrementChoreMxp amount kind choresData =
    let
        stats =
            getStats kind
    in
    stats.setter (\choreData -> { choreData | mxp = Quantity.plus choreData.mxp amount }) choresData


cleanStablesStats : Stats
cleanStablesStats =
    { title = "Clean Stables"
    , imgSrc = "/chores/stable.png"
    , getter = .cleanStables
    , setter = \fn choresData -> { choresData | cleanStables = fn choresData.cleanStables }
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
    , getter = .cleanBigBubba
    , setter = \fn choresData -> { choresData | cleanBigBubba = fn choresData.cleanBigBubba }
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
    , getter = .sweepChimneys
    , setter = \fn choresData -> { choresData | sweepChimneys = fn choresData.sweepChimneys }
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
    , getter = .waterGreenhousePlants
    , setter = \fn choresData -> { choresData | waterGreenhousePlants = fn choresData.waterGreenhousePlants }
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
    , getter = .washRobes
    , setter = \fn choresData -> { choresData | washRobes = fn choresData.washRobes }
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
    , getter = .organizePotionIngredients
    , setter = \fn choresData -> { choresData | organizePotionIngredients = fn choresData.organizePotionIngredients }
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
    , getter = .repairInstruments
    , setter = \fn choresData -> { choresData | repairInstruments = fn choresData.repairInstruments }
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
    , getter = .flushDrainDemons
    , setter = \fn choresData -> { choresData | flushDrainDemons = fn choresData.flushDrainDemons }
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
    , getter = .organizeSpellBooks
    , setter = \fn choresData -> { choresData | organizeSpellBooks = fn choresData.organizeSpellBooks }
    , outcome =
        { xp = Xp.fromInt 210
        , duration = Duration.seconds 20
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
