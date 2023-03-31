module IdleGame.Adventuring exposing (..)

import Duration exposing (Duration)
import IdleGame.Timer as Timer exposing (Timer)
import List.Extra


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


punchDamage : Int
punchDamage =
    6


fireboltDamage : Int
fireboltDamage =
    9


clawDamage : Int
clawDamage =
    8


barrierBlock : Int
barrierBlock =
    12


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
    , playerHealth : Int
    , monsterHealth : Int
    , nextMoveIndex : Int
    }


createState : State
createState =
    { playerMoves = List.repeat numMoves Punch
    , monsterMoves = List.repeat numMoves Claw
    , playerHealth = 100
    , monsterHealth = 100
    , nextMoveIndex = 0
    }


setPlayerMove : Int -> PlayerMove -> State -> State
setPlayerMove index move state =
    { state
        | playerMoves = List.Extra.setAt index move state.playerMoves
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


applyMonsterMove : State -> State
applyMonsterMove state =
    let
        monsterMove =
            List.Extra.getAt state.nextMoveIndex state.monsterMoves
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


increment : State -> State
increment state =
    state
        |> applyPlayerMove
        |> applyMonsterMove
        |> incrementMoveIndex
