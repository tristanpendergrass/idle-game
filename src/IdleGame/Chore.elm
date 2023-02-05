module IdleGame.Chore exposing (..)

import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource


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
    { kind : Kind
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
    , gold : Int
    }


incrementChoreMxp : Float -> Kind -> AllChoreStates -> AllChoreStates
incrementChoreMxp amount kind choresData =
    let
        stats =
            getStats kind
    in
    stats.setter (\choreData -> { choreData | mxp = choreData.mxp + amount }) choresData


getStats : Kind -> Stats
getStats kind =
    case kind of
        CleanStables ->
            { kind = CleanStables
            , title = "Clean Stables"
            , imgSrc = "/stable.png"
            , getter = .cleanStables
            , setter = \fn choresData -> { choresData | cleanStables = fn choresData.cleanStables }
            , outcome =
                { xp = 10
                , duration = 3000
                , extraResourceProbability = 0.25
                , extraResource = Resource.Manure
                , gold = 1
                }
            }

        CleanBigBubba ->
            { kind = CleanBigBubba
            , title = "Clean Big Bubba's Stall"
            , imgSrc = "/bubba2.png"
            , getter = .cleanBigBubba
            , setter = \fn choresData -> { choresData | cleanBigBubba = fn choresData.cleanBigBubba }
            , outcome =
                { xp = 15
                , duration = 4000
                , extraResourceProbability = 0.75
                , extraResource = Resource.Manure
                , gold = 5
                }
            }

        SweepChimneys ->
            { kind = SweepChimneys
            , title = "Sweep Chimneys"
            , imgSrc = "/sweepChimneys.png"
            , getter = .sweepChimneys
            , setter = \fn choresData -> { choresData | sweepChimneys = fn choresData.sweepChimneys }
            , outcome =
                { xp = 22
                , duration = 5000
                , extraResourceProbability = 0.5
                , extraResource = Resource.Soot
                , gold = 10
                }
            }

        WaterGreenhousePlants ->
            { kind = WaterGreenhousePlants
            , title = "Water Greenhouse Plants"
            , imgSrc = "/waterGreenhousePlants.png"
            , getter = .waterGreenhousePlants
            , setter = \fn choresData -> { choresData | waterGreenhousePlants = fn choresData.waterGreenhousePlants }
            , outcome =
                { xp = 30
                , duration = 6000
                , extraResourceProbability = 0.6
                , extraResource = Resource.GreenhouseDirt
                , gold = 20
                }
            }

        WashAndIronRobes ->
            { kind = WashAndIronRobes
            , title = "Wash and Iron Robes"
            , imgSrc = "/washAndIronRobes.png"
            , getter = .washRobes
            , setter = \fn choresData -> { choresData | washRobes = fn choresData.washRobes }
            , outcome =
                { xp = 40
                , duration = 8000
                , extraResourceProbability = 0.2
                , extraResource = Resource.WashWater
                , gold = 35
                }
            }

        OrganizePotionIngredients ->
            { kind = OrganizePotionIngredients
            , title = "Organize Potion Ingredients"
            , imgSrc = "/organizePotionIngredients.png"
            , getter = .organizePotionIngredients
            , setter = \fn choresData -> { choresData | organizePotionIngredients = fn choresData.organizePotionIngredients }
            , outcome =
                { xp = 60
                , duration = 10000
                , extraResourceProbability = 0.1
                , extraResource = Resource.EmptyBottle
                , gold = 50
                }
            }

        RepairInstruments ->
            { kind = RepairInstruments
            , title = "Repair Instruments"
            , imgSrc = "/repairInstruments.png"
            , getter = .repairInstruments
            , setter = \fn choresData -> { choresData | repairInstruments = fn choresData.repairInstruments }
            , outcome =
                { xp = 80
                , duration = 12000
                , extraResourceProbability = 0.25
                , extraResource = Resource.Scrap
                , gold = 75
                }
            }

        FlushDrainDemons ->
            { kind = FlushDrainDemons
            , title = "Flush the Drain Demons"
            , imgSrc = "/flushDrainDemons.png"
            , getter = .flushDrainDemons
            , setter = \fn choresData -> { choresData | flushDrainDemons = fn choresData.flushDrainDemons }
            , outcome =
                { xp = 100
                , duration = 20000
                , extraResourceProbability = 0.5
                , extraResource = Resource.Ectoplasm
                , gold = 175
                }
            }

        OrganizeSpellBooks ->
            { kind = OrganizeSpellBooks
            , title = "Organize Spell Books"
            , imgSrc = "/organizeSpellBooks.png"
            , getter = .organizeSpellBooks
            , setter = \fn choresData -> { choresData | organizeSpellBooks = fn choresData.organizeSpellBooks }
            , outcome =
                { xp = 180
                , duration = 15000
                , extraResourceProbability = 0.1
                , extraResource = Resource.Parchment
                , gold = 190
                }
            }
