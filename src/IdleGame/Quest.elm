module IdleGame.Quest exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Monster as Monster
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)


allQuests : List Quest
allQuests =
    [ Quest1, Quest2 ]



-- Record


type alias Record a =
    { quest1 : a
    , quest2 : a
    }


createRecord : a -> Record a
createRecord d =
    Record d d


getByKind : Quest -> Record a -> a
getByKind kind record =
    case kind of
        Quest1 ->
            record.quest1

        Quest2 ->
            record.quest2


setByKind : Quest -> a -> Record a -> Record a
setByKind kind value record =
    case kind of
        Quest1 ->
            { record | quest1 = value }

        Quest2 ->
            { record | quest2 = value }


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
    , icon : Icon
    }


getStats : Quest -> Stats
getStats kind =
    getByKind kind allStats


allStats : Record Stats
allStats =
    { quest1 =
        { title = "Quest 1"
        , criteria = [ CanApplyEffect (Effect.gainResource -10 Manure) ]
        , reward = [ Effect.gainResource 20 Manure ]
        , icon = Icon.fromString "Q1"
        }
    , quest2 =
        { title = "Quest 2"
        , criteria = [ CanApplyEffect (Effect.gainResource -20 EmptyBottle) ]
        , reward = [ Effect.gainResource 25 EmptyBottle ]
        , icon = Icon.fromString "Q2"
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
