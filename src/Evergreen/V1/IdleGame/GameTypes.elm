module Evergreen.V1.IdleGame.GameTypes exposing (..)

import Evergreen.V1.IdleGame.Coin
import Evergreen.V1.IdleGame.Kinds


type Toast
    = GainedCoin Evergreen.V1.IdleGame.Coin.Coin
    | GainedResource Int Evergreen.V1.IdleGame.Kinds.Resource
    | NegativeAmountErr
    | TestAlreadyCompleted
    | TestNotUnlocked
