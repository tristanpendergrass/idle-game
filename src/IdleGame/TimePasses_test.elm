module IdleGame.TimePasses_test exposing (..)

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
import IdleGame.GameTypes exposing (..)
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
            Duration.addTo now (Duration.days 30)

        fastForwardResult : Snapshot Game
        fastForwardResult =
            Snapshot.tickUntil performantTick nextTime initialSnapshot
    in
    test "fast fowrard time " <|
        \_ -> Expect.pass
