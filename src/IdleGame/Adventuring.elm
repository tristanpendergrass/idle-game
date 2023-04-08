module IdleGame.Adventuring exposing (..)

import Duration exposing (Duration)
import IdleGame.Combat as Combat
import IdleGame.Timer as Timer exposing (Timer)
import List.Extra
import Quantity exposing (Quantity)
import Random exposing (Generator)


moveDuration : Duration
moveDuration =
    Duration.seconds 3


type Adventuring
    = InCombat Timer Combat.State
    | Idle IdleState


type alias IdleState =
    { playerMoves : List Combat.PlayerMove
    , monster : Combat.MonsterKind
    }


create : Adventuring
create =
    Idle { playerMoves = Combat.defaultPlayerMoves, monster = Combat.defaultMonster }


startFight : Adventuring -> Adventuring
startFight adventuring =
    case adventuring of
        InCombat _ _ ->
            adventuring

        Idle { playerMoves, monster } ->
            InCombat Timer.create (Combat.createState { monster = monster, playerMoves = playerMoves })


stopFight : Adventuring -> Adventuring
stopFight adventuring =
    case adventuring of
        InCombat _ { monster, playerMoves } ->
            Idle { playerMoves = playerMoves, monster = monster }

        Idle _ ->
            adventuring


{-| Sets adventuring state to Idle with the given monster selected
If we ever need a method that sets the monster and keeps in combat we can create it.
-}
setMonster : Combat.MonsterKind -> Adventuring -> Adventuring
setMonster newMonster adventuring =
    case adventuring of
        Idle idleState ->
            Idle { idleState | monster = newMonster }

        InCombat _ { playerMoves } ->
            Idle { monster = newMonster, playerMoves = playerMoves }


setPlayerMove : Int -> Combat.PlayerMove -> Adventuring -> Adventuring
setPlayerMove index move adventuring =
    case adventuring of
        InCombat _ combatState ->
            Idle
                { playerMoves = List.Extra.setAt index move combatState.playerMoves
                , monster = combatState.monster
                }

        Idle idleState ->
            Idle
                { idleState
                    | playerMoves = List.Extra.setAt index move idleState.playerMoves
                }


{-| Resets an InCombat state to the way it would have been at the start of the fight. Idle remains Idle.
-}
reset : Adventuring -> Adventuring
reset adventuring =
    case adventuring of
        InCombat _ combatState ->
            InCombat Timer.create (Combat.resetHealth combatState)

        Idle idleState ->
            Idle idleState


type UpdateResult
    = PlayerWon Duration Adventuring -- in this scenario we yield flow back to the caller of update with the remaining duration. Update might need to be called again with remaining
    | MonsterWon Duration Adventuring
    | Continue Adventuring


update : Duration -> Adventuring -> Generator UpdateResult
update delta adventuring =
    case adventuring of
        Idle _ ->
            Continue adventuring
                |> Random.constant

        InCombat timer combatState ->
            let
                ( newTimer, timeRemaining ) =
                    Timer.incrementUntilComplete moveDuration delta timer
            in
            if timeRemaining == Quantity.zero then
                -- Timer hasn't completed. Just increment it
                Continue (InCombat newTimer combatState)
                    |> Random.constant

            else
                -- Timer completed at least once
                Combat.increment combatState
                    |> Random.andThen
                        (\updatedCombatState ->
                            if Combat.monsterDead updatedCombatState then
                                -- Player won
                                InCombat newTimer updatedCombatState
                                    |> reset
                                    |> PlayerWon timeRemaining
                                    |> Random.constant

                            else if Combat.playerDead updatedCombatState then
                                InCombat newTimer updatedCombatState
                                    |> reset
                                    |> MonsterWon timeRemaining
                                    |> Random.constant

                            else
                                InCombat newTimer updatedCombatState
                                    |> Continue
                                    |> Random.constant
                        )


type alias PlayerMoveInfo =
    { index : Int
    , move : Combat.PlayerMove
    , isActive : Bool
    }


getPlayerMoveInfo : Int -> Adventuring -> PlayerMoveInfo
getPlayerMoveInfo index adventuring =
    case adventuring of
        Idle { playerMoves } ->
            { index = index
            , move = playerMoves |> List.Extra.getAt index |> Maybe.withDefault Combat.Punch
            , isActive = False
            }

        InCombat _ combatState ->
            { index = index
            , move = Combat.getPlayerMove index combatState
            , isActive = combatState.nextMoveIndex == index
            }


getPlayerHealth : Adventuring -> Int
getPlayerHealth adventuring =
    case adventuring of
        Idle _ ->
            Combat.playerMaxHealth

        InCombat _ combatState ->
            combatState.playerHealth


getMonster : Adventuring -> Combat.MonsterKind
getMonster adventuring =
    case adventuring of
        Idle { monster } ->
            monster

        InCombat _ { monster } ->
            monster


getMonsterHealth : Adventuring -> Int
getMonsterHealth adventuring =
    case adventuring of
        Idle _ ->
            Combat.monsterMaxHealth

        InCombat _ { monsterHealth } ->
            monsterHealth


getMonsterMoves : Adventuring -> List Combat.MonsterMove
getMonsterMoves adventuring =
    case adventuring of
        Idle { monster } ->
            (Combat.getMonsterStats monster).moves

        InCombat _ { monsterMoves } ->
            monsterMoves
