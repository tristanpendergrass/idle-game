module IdleGame.Combat exposing (..)

import Duration exposing (Duration)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon as Icon exposing (Icon)
import List.Extra
import Random exposing (Generator)


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


getPlayerMove : Int -> State -> PlayerMove
getPlayerMove index { playerMoves } =
    List.Extra.getAt index playerMoves
        |> Maybe.withDefault Punch


getMonsterMove : Int -> State -> MonsterMove
getMonsterMove index _ =
    Claw


type alias State =
    { playerMoves : List PlayerMove
    , monsterMoves : List MonsterMove
    , monster : MonsterKind
    , playerHealth : Int
    , monsterHealth : Int
    , nextMoveIndex : Int
    }


createState : { monster : MonsterKind, playerMoves : List PlayerMove } -> State
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


incrementMoveIndex : State -> State
incrementMoveIndex state =
    { state | nextMoveIndex = modBy numMoves (state.nextMoveIndex + 1) }


updatePlayerHealth : Int -> State -> State
updatePlayerHealth amount state =
    { state | playerHealth = state.playerHealth + amount }


updateMonsterHealth : Int -> State -> State
updateMonsterHealth amount state =
    { state | monsterHealth = state.monsterHealth + amount }


applyPlayerMove : State -> State
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


getMonsterMoves : State -> List MonsterMove
getMonsterMoves { monster } =
    (getMonsterStats monster).moves


applyMonsterMove : State -> State
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


increment : State -> Generator State
increment state =
    state
        |> applyPlayerMove
        |> applyMonsterMove
        |> incrementMoveIndex
        |> Random.constant


monsterDead : State -> Bool
monsterDead state =
    state.monsterHealth <= 0


playerDead : State -> Bool
playerDead state =
    state.playerHealth <= 0


resetHealth : State -> State
resetHealth state =
    { state
        | playerHealth = playerMaxHealth
        , monsterHealth = monsterMaxHealth
    }
