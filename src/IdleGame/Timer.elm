module IdleGame.Timer exposing
    ( Timer(..)
    , create
    , increment
    , incrementUntilComplete
    , percentComplete
    )

import Duration exposing (Duration)
import Percent exposing (Percent)
import Quantity exposing (Quantity)


type Timer
    = Timer
        { current : Percent
        }


create : Timer
create =
    Timer { current = Percent.zero }


percentComplete : Timer -> Percent
percentComplete (Timer { current }) =
    current


increment : Duration -> Duration -> Timer -> ( Timer, Int )
increment totalDuration delta (Timer { current }) =
    let
        additionalPercent =
            Quantity.ratio delta totalDuration
                |> Percent.float

        sum =
            Quantity.plus current additionalPercent

        completions =
            sum
                |> Percent.toFloat
                |> floor

        newCurrent =
            Percent.toFloat sum
                - toFloat (floor (Percent.toFloat sum))
                |> Percent.float
    in
    ( Timer { current = newCurrent }, completions )


{-| Increments timer by duration unless timer would go beyond 100% in which case it sets
the timer to 0 and returns the remaining time
-}
incrementUntilComplete : Duration -> Duration -> Timer -> ( Timer, Duration )
incrementUntilComplete totalDuration delta timer =
    let
        ( timer_, completions ) =
            increment totalDuration delta timer
    in
    if completions > 0 then
        let
            percentRemainder =
                percentComplete timer_

            remainder =
                Quantity.timesUnitless
                    (Quantity.float (Percent.toFloat percentRemainder))
                    totalDuration

            completionRemainder =
                Quantity.timesUnitless
                    (Quantity.float (toFloat (completions - 1)))
                    totalDuration

            totalRemainder =
                Quantity.plus remainder completionRemainder
        in
        ( create, totalRemainder )

    else
        ( timer_, Quantity.zero )
