module Evergreen.V2.IdleGame.GameTypes exposing (..)

import Evergreen.V2.IdleGame.Coin
import Evergreen.V2.IdleGame.Kinds


type Toast
    = GainedCoin Evergreen.V2.IdleGame.Coin.Coin
    | GainedResource Int Evergreen.V2.IdleGame.Kinds.Resource
    | NegativeAmountErr
    | TestAlreadyCompleted
    | TestNotUnlocked
