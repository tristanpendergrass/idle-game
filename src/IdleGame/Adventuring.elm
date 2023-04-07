module IdleGame.Adventuring exposing (..)

import Duration exposing (Duration)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon as Icon exposing (Icon)
import List.Extra


type
    MonsterKind
    -- Don't forget to update allMonsterKinds when updating this list!
    = Charmstone
    | Silkling
    | Stalker


allMonsterKinds : List MonsterKind
allMonsterKinds =
    [ Charmstone, Silkling, Stalker ]


type alias MonsterStats =
    { title : String
    , avatar : Icon
    , reward : Int
    , moves : List MonsterMove
    }


getMonsterStats : MonsterKind -> MonsterStats
getMonsterStats kind =
    case kind of
        Charmstone ->
            { title = "Charmstone"
            , avatar = Icon.charmstone
            , reward = 10
            , moves = List.repeat numMoves Claw
            }

        Silkling ->
            { title = "Silkling"
            , avatar = Icon.silkling
            , reward = 15
            , moves = List.repeat numMoves Claw
            }

        Stalker ->
            { title = "Stalker"
            , avatar = Icon.stalker
            , reward = 20
            , moves = List.repeat numMoves Claw
            }


type PlayerMove
    = Punch
    | Firebolt
    | Barrier


type MonsterMove
    = Claw


type alias MoveStats =
    { title : String }


getPlayerMoveStats : PlayerMove -> MoveStats
getPlayerMoveStats move =
    case move of
        Punch ->
            { title = "Punch" }

        Firebolt ->
            { title = "Firebolt" }

        Barrier ->
            { title = "Barrier" }


playerMaxHealth : Int
playerMaxHealth =
    100


monsterMaxHealth : Int
monsterMaxHealth =
    100


punchDamage : Int
punchDamage =
    6


fireboltDamage : Int
fireboltDamage =
    20


clawDamage : Int
clawDamage =
    8


barrierBlock : Int
barrierBlock =
    12


defaultPlayerMoves : List PlayerMove
defaultPlayerMoves =
    [ Punch, Punch, Punch ]


defaultMonster : MonsterKind
defaultMonster =
    Charmstone


getMonsterMoveStats : MonsterMove -> MoveStats
getMonsterMoveStats move =
    case move of
        Claw ->
            { title = "Claw" }


getPlayerMove : Int -> CombatState -> PlayerMove
getPlayerMove index { playerMoves } =
    List.Extra.getAt index playerMoves
        |> Maybe.withDefault Punch


getMonsterMove : Int -> CombatState -> MonsterMove
getMonsterMove index _ =
    Claw


type alias CombatState =
    { playerMoves : List PlayerMove
    , monsterMoves : List MonsterMove
    , monster : MonsterKind
    , playerHealth : Int
    , monsterHealth : Int
    , nextMoveIndex : Int
    }


createState : { monster : MonsterKind, playerMoves : List PlayerMove } -> CombatState
createState { monster, playerMoves } =
    { playerMoves = playerMoves
    , monsterMoves = (getMonsterStats monster).moves
    , monster = monster
    , playerHealth = playerMaxHealth
    , monsterHealth = monsterMaxHealth
    , nextMoveIndex = 0
    }


numMoves : Int
numMoves =
    3


incrementMoveIndex : CombatState -> CombatState
incrementMoveIndex state =
    { state | nextMoveIndex = modBy numMoves (state.nextMoveIndex + 1) }


updatePlayerHealth : Int -> CombatState -> CombatState
updatePlayerHealth amount state =
    { state | playerHealth = state.playerHealth + amount }


updateMonsterHealth : Int -> CombatState -> CombatState
updateMonsterHealth amount state =
    { state | monsterHealth = state.monsterHealth + amount }


applyPlayerMove : CombatState -> CombatState
applyPlayerMove state =
    let
        playerMove =
            List.Extra.getAt state.nextMoveIndex state.playerMoves
    in
    case playerMove of
        Nothing ->
            state

        Just move ->
            case move of
                Punch ->
                    updateMonsterHealth (-1 * punchDamage) state

                Firebolt ->
                    updateMonsterHealth (-1 * fireboltDamage) state

                Barrier ->
                    state


getMonsterMoves : CombatState -> List MonsterMove
getMonsterMoves { monster } =
    (getMonsterStats monster).moves


applyMonsterMove : CombatState -> CombatState
applyMonsterMove state =
    let
        monsterMove =
            List.Extra.getAt state.nextMoveIndex (getMonsterMoves state)
    in
    case monsterMove of
        Nothing ->
            state

        Just move ->
            case move of
                Claw ->
                    let
                        modifiedDamage =
                            case List.Extra.getAt state.nextMoveIndex state.playerMoves of
                                Just Barrier ->
                                    max 0 (clawDamage - barrierBlock)

                                _ ->
                                    clawDamage
                    in
                    updatePlayerHealth (-1 * modifiedDamage) state


increment : CombatState -> CombatState
increment state =
    state
        |> applyPlayerMove
        |> applyMonsterMove
        |> incrementMoveIndex


monsterDead : CombatState -> Bool
monsterDead state =
    state.monsterHealth <= 0


playerDead : CombatState -> Bool
playerDead state =
    state.playerHealth <= 0


resetHealth : CombatState -> CombatState
resetHealth state =
    { state
        | playerHealth = playerMaxHealth
        , monsterHealth = monsterMaxHealth
    }
