module IdleGame.TimePasses_test exposing (..)

import Duration
import Expect
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Snapshot as Snapshot
import Test exposing (..)
import Types exposing (..)


standardTick : Snapshot.Tick ( Game, List Toast )
standardTick =
    Snapshot.createTick (Duration.milliseconds 15)
        (\duration ( oldGame, oldToasts ) ->
            let
                ( newGame, newToasts ) =
                    Game.tick duration oldGame
            in
            ( newGame, oldToasts ++ newToasts )
        )


performantTick : Snapshot.Tick Game
performantTick =
    Snapshot.createTick (Duration.seconds 2)
        (\duration oldGame -> Game.tick duration oldGame |> Tuple.first)


performantPlusTick : Snapshot.Tick Game
performantPlusTick =
    Snapshot.createTick (Duration.seconds 2)
        (\duration oldGame -> Game.tick duration oldGame |> Tuple.first)


testTimePasses : Test
testTimePasses =
    test "fast fowrard time " <|
        \_ -> Expect.pass
