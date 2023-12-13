module Evergreen.V17.IdleGame.GameTypes exposing (..)

import Evergreen.V17.IdleGame.Coin
import Evergreen.V17.IdleGame.Kinds


type Toast
    = GainedCoin Evergreen.V17.IdleGame.Coin.Coin
    | GainedResource Int Evergreen.V17.IdleGame.Kinds.Resource
    | LostCombat
    | NegativeAmountErr
    | QuestAlreadyCompleteErr
    | DiscoveredMonster Evergreen.V17.IdleGame.Kinds.Monster
    | DiscoveredQuest Evergreen.V17.IdleGame.Kinds.Quest
    | DiscoveredResource Evergreen.V17.IdleGame.Kinds.Resource
