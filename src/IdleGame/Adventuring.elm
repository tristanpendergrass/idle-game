module IdleGame.Adventuring exposing (..)

import Duration exposing (Duration)
import IdleGame.Timer as Timer exposing (Timer)
import List.Extra


type PlayerMove
    = Punch
    | Firebolt
    | Barrier


type alias PlayerMoveStats =
    { title : String }


getPlayerMoveStats : PlayerMove -> PlayerMoveStats
getPlayerMoveStats move =
    case move of
        Punch ->
            { title = "Punch" }

        Firebolt ->
            { title = "Firebolt" }

        Barrier ->
            { title = "Barrier" }


getPlayerMove : Int -> State -> PlayerMove
getPlayerMove index { playerMoves } =
    List.Extra.getAt index playerMoves
        |> Maybe.withDefault Punch


type alias State =
    { playerMoves : List PlayerMove
    , playerHealth : Int
    , monsterHealth : Int
    , combatTimer : Maybe ( Int, Timer )
    }


createState : State
createState =
    { playerMoves = [ Punch, Punch, Punch ]
    , playerHealth = 100
    , monsterHealth = 100
    , combatTimer = Nothing
    }


startFight : State -> State
startFight state =
    { state
        | combatTimer = Just ( 0, Timer.create )
    }


stopFight : State -> State
stopFight state =
    { state
        | combatTimer = Nothing
    }


setPlayerMove : Int -> PlayerMove -> State -> State
setPlayerMove index move state =
    { state
        | playerMoves = List.Extra.setAt index move state.playerMoves
    }


moveDuration : Duration
moveDuration =
    Duration.seconds 1.5


update : Duration -> State -> State
update delta state =
    case state.combatTimer of
        Just ( index, timer ) ->
            let
                ( newTimer, completions ) =
                    Timer.increment moveDuration delta timer

                newIndex =
                    modBy 3 (index + completions)
            in
            { state
                | combatTimer = Just ( newIndex, newTimer )
            }

        Nothing ->
            state
