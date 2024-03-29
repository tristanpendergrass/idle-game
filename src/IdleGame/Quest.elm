module IdleGame.Quest exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Monster as Monster
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)



-- Stats


type Criteria
    = CanApplyEffect Effect


type alias Stats =
    { title : String
    , criteria : List Criteria
    , reward : List Effect
    , image : CardImage
    }


getStats : Quest -> Stats
getStats kind =
    getByQuest kind allStats


allStats : QuestRecord Stats
allStats =
    { mendCrackedBell =
        { title = "Mend Cracked Bell"
        , criteria = [ CanApplyEffect (Effect.spendResource 10 Scrap) ]
        , reward = [ Effect.gainResource 20 Scrap ]
        , image = CardLandscape "/aiart/mend_cracked_bell.webp"
        }
    , chopFirewood =
        { title = "Chop Firewood"
        , criteria = [ CanApplyEffect (Effect.spendResource 10 Scrap) ]
        , reward = [ Effect.gainResource 20 Scrap ]
        , image = CardLandscape "/aiart/chop_firewood.webp"
        }
    }


getCompletionEffects : Quest -> List Effect
getCompletionEffects quest =
    let
        questStats : Stats
        questStats =
            getStats quest

        criteriaEffects : List Effect
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
