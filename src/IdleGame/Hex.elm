module IdleGame.Hex exposing (..)

import Duration exposing (Duration)
import IdleGame.Chore as Chore
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Xp as Xp exposing (Xp)
import Quantity exposing (Quantity)


type Kind
    = Hex1
    | Jinx1
    | Curse1
    | Hex2
    | Jinx2
    | Curse2
    | Hex3
    | Jinx3
    | Curse3


allKinds : List Kind
allKinds =
    [ Hex1
    , Jinx1
    , Curse1
    , Hex2
    , Jinx2
    , Curse2
    , Hex3
    , Jinx3
    , Curse3
    ]


type alias Record a =
    { hex1 : a
    , jinx1 : a
    , curse1 : a
    , hex2 : a
    , jinx2 : a
    , curse2 : a
    , hex3 : a
    , jinx3 : a
    , curse3 : a
    }


getByKind : Kind -> Record a -> a
getByKind kind data =
    case kind of
        Hex1 ->
            data.hex1

        Jinx1 ->
            data.jinx1

        Curse1 ->
            data.curse1

        Hex2 ->
            data.hex2

        Jinx2 ->
            data.jinx2

        Curse2 ->
            data.curse2

        Hex3 ->
            data.hex3

        Jinx3 ->
            data.jinx3

        Curse3 ->
            data.curse3


setByKind : Kind -> a -> Record a -> Record a
setByKind kind value data =
    case kind of
        Hex1 ->
            { data | hex1 = value }

        Jinx1 ->
            { data | jinx1 = value }

        Curse1 ->
            { data | curse1 = value }

        Hex2 ->
            { data | hex2 = value }

        Jinx2 ->
            { data | jinx2 = value }

        Curse2 ->
            { data | curse2 = value }

        Hex3 ->
            { data | hex3 = value }

        Jinx3 ->
            { data | jinx3 = value }

        Curse3 ->
            { data | curse3 = value }


updateByKind : Kind -> (a -> a) -> Record a -> Record a
updateByKind kind update data =
    setByKind kind (update (getByKind kind data)) data


type alias Outcome =
    { xp : Xp
    , duration : Duration
    , createdHex : Kind
    }


type alias Stats =
    { title : String
    , imgSrc : String
    , outcome : Outcome
    }


type alias AllStats =
    Record Stats


getStats : Kind -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { hex1 = hex1Stats
    , jinx1 = jinx1Stats
    , curse1 = curse1Stats
    , hex2 = hex2Stats
    , jinx2 = jinx2Stats
    , curse2 = curse2Stats
    , hex3 = hex3Stats
    , jinx3 = jinx3Stats
    , curse3 = curse3Stats
    }


hex1Stats : Stats
hex1Stats =
    { title = "Hex I"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Hex1
        }
    }


jinx1Stats : Stats
jinx1Stats =
    { title = "Jinx I"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Jinx1
        }
    }


curse1Stats : Stats
curse1Stats =
    { title = "Curse I"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Curse1
        }
    }


hex2Stats : Stats
hex2Stats =
    { title = "Hex II"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Hex2
        }
    }


jinx2Stats : Stats
jinx2Stats =
    { title = "Jinx II"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Jinx2
        }
    }


curse2Stats : Stats
curse2Stats =
    { title = "Curse II"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Curse2
        }
    }


hex3Stats : Stats
hex3Stats =
    { title = "Hex III"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Hex3
        }
    }


jinx3Stats : Stats
jinx3Stats =
    { title = "Jinx III"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Jinx3
        }
    }


curse3Stats : Stats
curse3Stats =
    { title = "Curse III"
    , imgSrc = "/chores/drainDemons.png"
    , outcome =
        { xp = Xp.fromInt 10
        , duration = Duration.seconds 3
        , createdHex = Curse3
        }
    }
