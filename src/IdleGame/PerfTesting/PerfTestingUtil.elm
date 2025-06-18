module IdleGame.PerfTesting.PerfTestingUtil exposing (..)

import Duration exposing (Duration)
import Expect exposing (..)
import FeatherIcons exposing (fastForward)
import Fuzz exposing (Fuzzer)
import Html.Attributes exposing (download)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter
import IdleGame.Effect as Effect
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.Game as Game
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Event exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Quantity
import Random
import Test exposing (..)
import Test.Distribution
import Test.Random
import Time
import Types exposing (..)


createTick : Duration -> Snapshot.Tick Game
createTick duration =
    Snapshot.createTick duration
        (\d oldGame -> (Game.tick d oldGame).game)


testTimePasses : { tick : Snapshot.Tick Game, duration : Duration } -> Test
testTimePasses { tick, duration } =
    let
        initialGame : Game
        initialGame =
            Game.createProd (Random.initialSeed 0)

        now : Time.Posix
        now =
            Time.millisToPosix 0

        initialSnapshot : Snapshot Game
        initialSnapshot =
            Snapshot.fromTuple ( now, initialGame )

        nextTime : Time.Posix
        nextTime =
            Duration.addTo now duration

        fastForwardResult : Snapshot Game
        fastForwardResult =
            Snapshot.tickUntil tick nextTime initialSnapshot
    in
    test "fast fowrard time " <|
        \_ -> Expect.pass
