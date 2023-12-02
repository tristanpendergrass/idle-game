module IdleGame.Quest exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Kinds2 exposing (..)
import IdleGame.Monster as Monster
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)


allQuests : List Quest
allQuests =
    [ MendCrackedBell, ChopFirewood ]



-- Record


type alias Record a =
    { mendCrackedBell : a
    , chopFirewood : a
    }


createRecord : a -> Record a
createRecord d =
    Record d d


getByKind : Quest -> Record a -> a
getByKind kind record =
    case kind of
        MendCrackedBell ->
            record.mendCrackedBell

        ChopFirewood ->
            record.chopFirewood


setByKind : Quest -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        MendCrackedBell ->
            { record | mendCrackedBell = value }

        ChopFirewood ->
            { record | chopFirewood = value }


updateByKind : Quest -> (a -> a) -> Record a -> Record a
updateByKind kind f record =
    setByKind kind (f (getByKind kind record)) record



-- Stats


type Criteria
    = CanApplyEffect Effect.TaggedEffect


type alias Stats =
    { title : String
    , criteria : List Criteria
    , reward : List Effect.TaggedEffect
    , image : CardImage
    }


getStats : Quest -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { mendCrackedBell =
        { title = "Mend Cracked Bell"
        , criteria = [ CanApplyEffect (Effect.gainResource -10 Scrap) ]
        , reward = [ Effect.gainResource 20 Scrap ]
        , image = CardLandscape "/aiart/mend_cracked_bell.webp"
        }
    , chopFirewood =
        { title = "Chop Firewood"
        , criteria = [ CanApplyEffect (Effect.gainResource -10 Scrap) ]
        , reward = [ Effect.gainResource 20 Scrap ]
        , image = CardLandscape "/aiart/chop_firewood.webp"
        }
    }


getCompletionEffects : Quest -> List Effect.TaggedEffect
getCompletionEffects quest =
    let
        questStats : Stats
        questStats =
            getStats quest

        criteriaEffects : List Effect.TaggedEffect
        criteriaEffects =
            questStats.criteria
                |> List.map
                    (\criteria ->
                        case criteria of
                            CanApplyEffect effect ->
                                effect
                    )
    in
    List.concat
        [ criteriaEffects
        , questStats.reward
        ]



-- State


type State
    = Incomplete
    | Complete



-- Utils


getLabel : Quest -> String
getLabel kind =
    (getStats kind).title
