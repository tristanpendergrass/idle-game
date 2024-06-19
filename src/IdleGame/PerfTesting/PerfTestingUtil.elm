module IdleGame.PerfTesting.PerfTestingUtil exposing (..)

import Duration exposing (Duration)
import Expect
import IdleGame.Game as Game
import IdleGame.Snapshot as Snapshot
import Test exposing (..)
import Types exposing (..)


createTick : Duration -> Snapshot.Tick Game
createTick duration =
    Snapshot.createTick duration
        (\d oldGame -> Game.tick d oldGame |> Tuple.first)


testTimePasses : { tick : Snapshot.Tick Game, duration : Duration } -> Test
testTimePasses { tick, duration } =
    test "fast fowrard time " <|
        \_ -> Expect.pass
