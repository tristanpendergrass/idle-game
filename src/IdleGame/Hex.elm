module IdleGame.Hex exposing (..)

import Duration exposing (Duration)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Xp as Xp exposing (Xp)
import Quantity exposing (Quantity)


allKinds : List HexKind
allKinds =
    [ Hex1
    , Jinx1
    , Curse1
    , Hex2
    , Jinx2
    , Curse2
    , Hex3
    , Jinx3
    , Curse3
    ]


type alias State =
    { mxp : Xp }


type alias AllStates =
    { hex1 : State
    , jinx1 : State
    , curse2 : State
    , hex2 : State
    , jinx2 : State
    , curse1 : State
    , hex3 : State
    , jinx3 : State
    , curse3 : State
    }


type alias Stats =
    { title : String
    , imgSrc : String
    , getter : AllStates -> State
    , setter : (State -> State) -> AllStates -> AllStates
    , outcome : ChoreOutcome
    }


type alias ChoreOutcome =
    { xp : Xp
    , duration : Duration
    , extraResourceProbability : Float
    , extraResource : Resource.Kind
    , coin : Int
    }


incrementChoreMxp : Xp -> ChoreKind -> AllStates -> AllStates
incrementChoreMxp amount kind choresData =
    let
        stats =
            getStats kind
    in
    stats.setter (\choreData -> { choreData | mxp = Quantity.plus choreData.mxp amount }) choresData


hex1Stats : Stats
hex1Stats =
    { title = "Hex I"
    , imgSrc = "/chores/drainDemons.png"
    , getter = .hex1
    , setter = \fn data -> { data | hex1 = fn data.hex1 }
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , extraResourceProbability = 0.25
        , extraResource = Resource.Manure
        , coin = 1
        }
    }


getStats : ChoreKind -> Stats
getStats kind =
    -- case kind of
    --     CleanStables ->
    --         hex1Stats
    --     CleanBigBubba ->
    --         cleanBigBubbaStats
    --     SweepChimneys ->
    --         sweepChimneysStats
    --     WaterGreenhousePlants ->
    --         waterGreenhousePlantsStats
    --     WashAndIronRobes ->
    --         washAndIronRobesStats
    --     OrganizePotionIngredients ->
    --         organizePotionIngredientsStats
    --     RepairInstruments ->
    --         repairInstrumentsStats
    --     FlushDrainDemons ->
    --         flushDrainDemonsStats
    --     OrganizeSpellBooks ->
    --         organizeSpellBooksStats
    hex1Stats
