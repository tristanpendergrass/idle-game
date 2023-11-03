module Evergreen.V12.IdleGame.GameTypes exposing (..)

import Evergreen.V12.IdleGame.Coin
import Evergreen.V12.IdleGame.Resource


type Toast
    = GainedCoin Evergreen.V12.IdleGame.Coin.Coin
    | GainedResource Int Evergreen.V12.IdleGame.Resource
    | LostCombat
    | NegativeAmountErr
