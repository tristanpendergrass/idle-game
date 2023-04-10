module Evergreen.V10.IdleGame.Adventuring exposing (..)

import Evergreen.V10.IdleGame.Combat
import Evergreen.V10.IdleGame.Timer


type alias IdleState =
    { playerMoves : List Evergreen.V10.IdleGame.Combat.PlayerMove
    , monster : Evergreen.V10.IdleGame.Combat.MonsterKind
    }


type Adventuring
    = InCombat Evergreen.V10.IdleGame.Timer.Timer Evergreen.V10.IdleGame.Combat.State
    | Idle IdleState
