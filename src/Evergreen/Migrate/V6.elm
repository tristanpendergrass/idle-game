module Evergreen.Migrate.V6 exposing (..)

import Browser.Navigation
import Dict
import Evergreen.V1.IdleGame.Chore as OldChore
import Evergreen.V1.IdleGame.Coin as OldCoin
import Evergreen.V1.IdleGame.Game as OldGame
import Evergreen.V1.IdleGame.GameTypes as OldGameTypes
import Evergreen.V1.IdleGame.Resource as OldResource
import Evergreen.V1.IdleGame.ShopItems as OldShopItems
import Evergreen.V1.IdleGame.Snapshot as OldSnapshot
import Evergreen.V1.IdleGame.Tab as OldTab
import Evergreen.V1.IdleGame.Timer as OldTimer
import Evergreen.V1.Types as Old
import Evergreen.V6.IdleGame.Chore as NewChore
import Evergreen.V6.IdleGame.Counter as NewCounter
import Evergreen.V6.IdleGame.Game as NewGame
import Evergreen.V6.IdleGame.GameTypes as NewGameTypes
import Evergreen.V6.IdleGame.Resource as NewResource
import Evergreen.V6.IdleGame.ShopItems as NewShopItems
import Evergreen.V6.IdleGame.Snapshot as NewSnapshot
import Evergreen.V6.IdleGame.Tab as NewTab
import Evergreen.V6.IdleGame.Timer as NewTimer
import Evergreen.V6.Types as New
import IdleGame.Timer as Timer
import Lamdera.Migrations exposing (..)
import Time exposing (Posix)
import Toast


migrateTray : Toast.Tray OldGameTypes.Toast -> Toast.Tray NewGameTypes.Toast
migrateTray _ =
    Toast.tray


migrateActiveTab : OldTab.Tab -> NewTab.Tab
migrateActiveTab _ =
    NewTab.Chores


migrateTimer : OldTimer.Timer -> NewTimer.Timer
migrateTimer (OldTimer.Timer { current }) =
    NewTimer.Timer { current = current }


migrateChoreKind : OldGameTypes.ChoreKind -> NewGameTypes.ChoreKind
migrateChoreKind oldChoreKind =
    case oldChoreKind of
        OldGameTypes.CleanStables ->
            NewGameTypes.CleanStables

        OldGameTypes.CleanBigBubba ->
            NewGameTypes.CleanBigBubba

        OldGameTypes.SweepChimneys ->
            NewGameTypes.SweepChimneys

        OldGameTypes.WaterGreenhousePlants ->
            NewGameTypes.WaterGreenhousePlants

        OldGameTypes.WashAndIronRobes ->
            NewGameTypes.WashAndIronRobes

        OldGameTypes.OrganizePotionIngredients ->
            NewGameTypes.OrganizePotionIngredients

        OldGameTypes.RepairInstruments ->
            NewGameTypes.RepairInstruments

        OldGameTypes.FlushDrainDemons ->
            NewGameTypes.FlushDrainDemons

        OldGameTypes.OrganizeSpellBooks ->
            NewGameTypes.OrganizeSpellBooks


migrateChoresStates : OldChore.AllChoreStates -> NewChore.AllChoreStates
migrateChoresStates oldChoreStates =
    { cleanStables = { mxp = NewCounter.Counter oldChoreStates.cleanStables.mxp }
    , cleanBigBubba = { mxp = NewCounter.Counter oldChoreStates.cleanBigBubba.mxp }
    , sweepChimneys = { mxp = NewCounter.Counter oldChoreStates.sweepChimneys.mxp }
    , waterGreenhousePlants = { mxp = NewCounter.Counter oldChoreStates.waterGreenhousePlants.mxp }
    , washRobes = { mxp = NewCounter.Counter oldChoreStates.washRobes.mxp }
    , organizePotionIngredients = { mxp = NewCounter.Counter oldChoreStates.organizePotionIngredients.mxp }
    , repairInstruments = { mxp = NewCounter.Counter oldChoreStates.repairInstruments.mxp }
    , flushDrainDemons = { mxp = NewCounter.Counter oldChoreStates.flushDrainDemons.mxp }
    , organizeSpellBooks = { mxp = NewCounter.Counter oldChoreStates.organizeSpellBooks.mxp }
    }


migrateGame : OldGame.Game -> NewGame.Game
migrateGame oldGame =
    let
        choresXp : NewCounter.Counter
        choresXp =
            NewCounter.Counter oldGame.choresXp

        choresMxp : NewCounter.Counter
        choresMxp =
            NewCounter.Counter oldGame.choresMxp

        activeChore : Maybe ( NewGameTypes.ChoreKind, NewTimer.Timer )
        activeChore =
            oldGame.activeChore
                |> Maybe.map
                    (\( oldChoreKind, oldTimer ) ->
                        ( migrateChoreKind oldChoreKind, migrateTimer oldTimer )
                    )

        choresData : NewChore.AllChoreStates
        choresData =
            migrateChoresStates oldGame.choresData

        coin : NewCounter.Counter
        coin =
            case oldGame.coin of
                OldCoin.Counter amount ->
                    NewCounter.Counter amount

        resources : NewResource.Amounts
        resources =
            oldGame.resources

        shopItems : NewShopItems.ShopItems
        shopItems =
            case oldGame.shopItems of
                OldShopItems.ShopItems items ->
                    NewShopItems.ShopItems items
    in
    { seed = oldGame.seed
    , choresXp = choresXp
    , choresMxp = choresMxp
    , activeChore = activeChore
    , choresData = choresData
    , coin = coin
    , resources = resources
    , shopItems = shopItems
    }


migrateGameSnapshot : OldSnapshot.Snapshot OldGame.Game -> NewSnapshot.Snapshot NewGame.Game
migrateGameSnapshot (OldSnapshot.Snapshot ( time, oldGame )) =
    NewSnapshot.Snapshot ( time, migrateGame oldGame )


migratePreviousIntervalTimer : Old.PreviousIntervalTimer -> New.PreviousIntervalTimer
migratePreviousIntervalTimer oldPreviousIntervalTimer =
    case oldPreviousIntervalTimer of
        Old.NotStarted ->
            New.NotStarted

        Old.HaveStart start ->
            New.HaveStart start

        Old.HaveStartAndEnd start end ->
            New.HaveStartAndEnd start end


migrateGameState : Old.FrontendGameState -> New.FrontendGameState
migrateGameState gameState =
    case gameState of
        Old.Initializing ->
            New.Initializing

        Old.Playing snapshot ->
            New.Playing (migrateGameSnapshot snapshot)

        Old.FastForward { original, current, previousIntervalTimer } ->
            New.FastForward
                { original = migrateGameSnapshot original
                , current = migrateGameSnapshot current
                , previousIntervalTimer = migratePreviousIntervalTimer previousIntervalTimer
                }


frontendModel : Old.FrontendModel -> ModelMigration New.FrontendModel New.FrontendMsg
frontendModel old =
    let
        key : Browser.Navigation.Key
        key =
            old.key

        showDebugPanel : Bool
        showDebugPanel =
            False

        tray : Toast.Tray NewGameTypes.Toast
        tray =
            migrateTray old.tray

        isDrawerOpen : Bool
        isDrawerOpen =
            old.isDrawerOpen

        activeTab : NewTab.Tab
        activeTab =
            migrateActiveTab old.activeTab

        isVisible : Bool
        isVisible =
            old.isVisible

        activeModal : Maybe New.Modal
        activeModal =
            Nothing

        saveGameTimer : NewTimer.Timer
        saveGameTimer =
            migrateTimer old.saveGameTimer

        gameState : New.FrontendGameState
        gameState =
            migrateGameState old.gameState

        showTimePasses : Bool
        showTimePasses =
            False

        newModel : New.FrontendModel
        newModel =
            { key = key
            , showDebugPanel = showDebugPanel
            , tray = tray
            , isDrawerOpen = isDrawerOpen
            , activeTab = activeTab
            , isVisible = isVisible
            , activeModal = activeModal
            , saveGameTimer = saveGameTimer
            , gameState = gameState
            , showTimePasses = showTimePasses
            }
    in
    ModelMigrated
        ( newModel
        , Cmd.none
        )


backendModel : Old.BackendModel -> ModelMigration New.BackendModel New.BackendMsg
backendModel old =
    let
        sessionGameMap : New.SessionGameMap
        sessionGameMap =
            old.sessionGameMap
                |> Dict.map (\_ snapshot -> migrateGameSnapshot snapshot)

        newModel : New.BackendModel
        newModel =
            { sessionGameMap = sessionGameMap
            , seed = old.seed
            }
    in
    ModelMigrated ( newModel, Cmd.none )


frontendMsg : Old.FrontendMsg -> MsgMigration New.FrontendMsg New.FrontendMsg
frontendMsg _ =
    MsgMigrated ( New.NoOp, Cmd.none )


toBackend : Old.ToBackend -> MsgMigration New.ToBackend New.BackendMsg
toBackend old =
    case old of
        Old.NoOpToBackend ->
            Debug.todo ""

        Old.Save oldSnapshot ->
            MsgMigrated ( New.Save (migrateGameSnapshot oldSnapshot), Cmd.none )


backendMsg : Old.BackendMsg -> MsgMigration New.BackendMsg New.BackendMsg
backendMsg old =
    case old of
        Old.NoOpBackendMsg ->
            Debug.todo ""

        Old.HandleConnect sessionId clientId ->
            MsgMigrated ( New.HandleConnect sessionId clientId, Cmd.none )

        Old.HandleConnectWithTime sessionId clientId time ->
            MsgMigrated ( New.HandleConnectWithTime sessionId clientId time, Cmd.none )


toFrontend : Old.ToFrontend -> MsgMigration New.ToFrontend New.FrontendMsg
toFrontend old =
    case old of
        Old.NoOpToFrontend ->
            Debug.todo ""

        Old.InitializeGame oldSnapshot ->
            MsgMigrated ( New.InitializeGame (migrateGameSnapshot oldSnapshot), Cmd.none )
