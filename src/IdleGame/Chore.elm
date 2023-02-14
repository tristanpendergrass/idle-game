module IdleGame.Chore exposing (..)

import IdleGame.Coin as Coin
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
    { mxp : Float }


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
    -- TODO: the type_ should not be here, otherwise it's possible in the model to store a chore of the wrong type under a key
    { kind : ChoreKind
    , title : String
    , imgSrc : String
    , getter : AllChoreStates -> State
    , setter : (State -> State) -> AllChoreStates -> AllChoreStates
    , outcome : ChoreOutcome
    }


type alias ChoreOutcome =
    { xp : Float
    , duration : Float
    , extraResourceProbability : Float
    , extraResource : Resource.Kind
    , coin : Coin.Counter
    }


incrementChoreMxp : Float -> ChoreKind -> AllChoreStates -> AllChoreStates
incrementChoreMxp amount kind choresData =
    let
        stats =
            getStats kind
    in
    stats.setter (\choreData -> { choreData | mxp = choreData.mxp + amount }) choresData


cleanStablesStats =
    { kind = CleanStables
    , title = "Clean Stables"
    , imgSrc = "/chores/stable.png"
    , getter = .cleanStables
    , setter = \fn choresData -> { choresData | cleanStables = fn choresData.cleanStables }
    , outcome =
        { xp = 10
        , duration = 3000
        , extraResourceProbability = 0.25
        , extraResource = Resource.Manure
        , coin = Coin.create 1
        }
    }


cleanBigBubbaStats =
    { kind = CleanBigBubba
    , title = "Clean Big Bubba's Stall"
    , imgSrc = "/chores/bubba4.png"
    , getter = .cleanBigBubba
    , setter = \fn choresData -> { choresData | cleanBigBubba = fn choresData.cleanBigBubba }
    , outcome =
        { xp = 25
        , duration = 6000
        , extraResourceProbability = 0.75
        , extraResource = Resource.Manure
        , coin = Coin.create 3
        }
    }


sweepChimneysStats =
    { kind = SweepChimneys
    , title = "Sweep Chimneys"
    , imgSrc = "/chores/chimney.png"
    , getter = .sweepChimneys
    , setter = \fn choresData -> { choresData | sweepChimneys = fn choresData.sweepChimneys }
    , outcome =
        { xp = 37
        , duration = 8000
        , extraResourceProbability = 0.5
        , extraResource = Resource.Soot
        , coin = Coin.create 6
        }
    }


waterGreenhousePlantsStats =
    { kind = WaterGreenhousePlants
    , title = "Water Greenhouse Plants"
    , imgSrc = "/chores/greenhouse_3.png"
    , getter = .waterGreenhousePlants
    , setter = \fn choresData -> { choresData | waterGreenhousePlants = fn choresData.waterGreenhousePlants }
    , outcome =
        { xp = 12
        , duration = 2000
        , extraResourceProbability = 0.6
        , extraResource = Resource.GreenhouseDirt
        , coin = Coin.create 2
        }
    }


washAndIronRobesStats =
    { kind = WashAndIronRobes
    , title = "Wash and Iron Robes"
    , imgSrc = "/chores/washRobes.png"
    , getter = .washRobes
    , setter = \fn choresData -> { choresData | washRobes = fn choresData.washRobes }
    , outcome =
        { xp = 50
        , duration = 8000
        , extraResourceProbability = 0.2
        , extraResource = Resource.WashWater
        , coin = Coin.create 9
        }
    }


organizePotionIngredientsStats =
    { kind = OrganizePotionIngredients
    , title = "Organize Potion Ingredients"
    , imgSrc = "/chores/potionIngredients_2.png"
    , getter = .organizePotionIngredients
    , setter = \fn choresData -> { choresData | organizePotionIngredients = fn choresData.organizePotionIngredients }
    , outcome =
        { xp = 165
        , duration = 20000
        , extraResourceProbability = 0.1
        , extraResource = Resource.EmptyBottle
        , coin = Coin.create 12
        }
    }


repairInstrumentsStats =
    { kind = RepairInstruments
    , title = "Repair Instruments"
    , imgSrc = "/chores/repairInstruments.png"
    , getter = .repairInstruments
    , setter = \fn choresData -> { choresData | repairInstruments = fn choresData.repairInstruments }
    , outcome =
        { xp = 75
        , duration = 12000
        , extraResourceProbability = 0.25
        , extraResource = Resource.Scrap
        , coin = Coin.create 20
        }
    }


flushDrainDemonsStats =
    { kind = FlushDrainDemons
    , title = "Flush the Drain Demons"
    , imgSrc = "/chores/drainDemons.png"
    , getter = .flushDrainDemons
    , setter = \fn choresData -> { choresData | flushDrainDemons = fn choresData.flushDrainDemons }
    , outcome =
        { xp = 90
        , duration = 10000
        , extraResourceProbability = 0.5
        , extraResource = Resource.Ectoplasm
        , coin = Coin.create 14
        }
    }


organizeSpellBooksStats =
    { kind = OrganizeSpellBooks
    , title = "Organize Spell Books"
    , imgSrc = "/chores/spellBooks.png"
    , getter = .organizeSpellBooks
    , setter = \fn choresData -> { choresData | organizeSpellBooks = fn choresData.organizeSpellBooks }
    , outcome =
        { xp = 210
        , duration = 20000
        , extraResourceProbability = 0.1
        , extraResource = Resource.Parchment
        , coin = Coin.create 30
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
