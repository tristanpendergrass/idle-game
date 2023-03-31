module IdleGame.Adventuring exposing (..)

import Duration exposing (Duration)
import IdleGame.Timer as Timer exposing (Timer)
import List.Extra


type Move
    = Punch
    | Firebolt
    | Barrier
      -- Monster moves
    | Claw


type alias MoveStats =
    { title : String }


getMoveStats : Move -> MoveStats
getMoveStats move =
    case move of
        Punch ->
            { title = "Punch" }

        Firebolt ->
            { title = "Firebolt" }

        Barrier ->
            { title = "Barrier" }

        Claw ->
            { title = "Claw" }


getPlayerMove : Int -> State -> Move
getPlayerMove index { playerMoves } =
    List.Extra.getAt index playerMoves
        |> Maybe.withDefault Punch


getMonsterMove : Int -> State -> Move
getMonsterMove index _ =
    Claw


type alias State =
    { playerMoves : List Move
    , monsterMoves : List Move
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


setPlayerMove : Int -> Move -> State -> State
setPlayerMove index move state =
    { state
        | playerMoves = List.Extra.setAt index move state.playerMoves
    }


numMoves : Int
numMoves =
    3


increment : State -> State
increment state =
    { state | nextMoveIndex = modBy numMoves (state.nextMoveIndex + 1) }
