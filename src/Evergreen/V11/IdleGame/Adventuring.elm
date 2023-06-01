module Evergreen.V11.IdleGame.Adventuring exposing (..)

import Evergreen.V11.IdleGame.Combat
import Evergreen.V11.IdleGame.Timer


type alias IdleState =
    { playerMoves : List Evergreen.V11.IdleGame.Combat.PlayerMove
    , monster : Evergreen.V11.IdleGame.Combat.MonsterKind
    }


type Adventuring
    = InCombat Evergreen.V11.IdleGame.Timer.Timer Evergreen.V11.IdleGame.Combat.State
    | Idle IdleState
