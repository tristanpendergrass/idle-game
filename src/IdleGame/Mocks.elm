module IdleGame.Mocks exposing (..)

import Duration exposing (Duration)
import IdleGame.Kinds exposing (..)
import IdleGame.Xp as Xp
import Time
import Types exposing (..)


timePassesModal : Modal
timePassesModal =
    let
        duration : Duration
        duration =
            Duration.seconds 10

        time : Time.Posix
        time =
            Time.millisToPosix (1000 * 60 * 10)

        data : TimePassesData
        data =
            { xpGains =
                [ { originalXp = Xp.int 0, currentXp = Xp.int 100, skill = Anatomy }
                ]
            , coinGains = Nothing
            , resourcesDiff = resourceRecord 0
            }
    in
    TimePassesModal duration time data
