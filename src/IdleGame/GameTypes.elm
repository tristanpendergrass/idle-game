module IdleGame.GameTypes exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import Percent exposing (Percent)


type Toast
    = GainedCoin Coin
    | GainedResource Int Resource
    | LostCombat
    | NegativeAmountErr
    | QuestAlreadyCompleteErr
    | DiscoveredMonster Monster
    | DiscoveredQuest Quest
    | DiscoveredResource Resource


type IntervalModLabel
    = IntervalModLabel Percent


type alias IntervalMod =
    { kind : Activity
    , percentChange : Percent -- e.g. 0.25 -> 25% faster
    , label : IntervalModLabel
    }
