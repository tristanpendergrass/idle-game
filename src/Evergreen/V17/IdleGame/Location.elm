module Evergreen.V17.IdleGame.Location exposing (..)

import Evergreen.V17.IdleGame.Kinds
import Evergreen.V17.IdleGame.Timer


type alias State =
    { foundMonsters : Evergreen.V17.IdleGame.Kinds.MonsterRecord Bool
    , foundResources : Evergreen.V17.IdleGame.Kinds.ResourceRecord Bool
    , foundQuests : Evergreen.V17.IdleGame.Kinds.QuestRecord Bool
    , discoveryTimer : Evergreen.V17.IdleGame.Timer.Timer
    }
