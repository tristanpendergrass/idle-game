module IdleGame.Combat exposing (..)

import List
import List.Extra
import Random


type Player
    = LeftPlayer
    | RightPlayer


type alias Move =
    CombatParams -> CombatState -> Random.Generator (List ( Mutation, Player ))


emptyMove : Move
emptyMove _ _ =
    Random.constant []


type Mutation
    = Damage Int
    | Block Int


type alias CombatParams =
    { leftMaxHealth : Int
    , rightMaxHealth : Int
    }


type alias PlayerState =
    { health : Int
    , block : Int
    }


type alias CombatState =
    { leftState : PlayerState
    , rightState : PlayerState
    , moveIndex : Int
    }


type CombatResult
    = Continue
    | LeftWins
    | RightWins
    | Draw


result : CombatParams -> CombatState -> CombatResult
result _ state =
    if state.leftState.health <= 0 && state.rightState.health <= 0 then
        Draw

    else if state.leftState.health <= 0 then
        RightWins

    else if state.rightState.health <= 0 then
        LeftWins

    else
        Continue


step : List Move -> List Move -> CombatParams -> CombatState -> Random.Generator CombatState
step leftMoves rightMoves params state =
    let
        leftMove : Move
        leftMove =
            List.Extra.getAt state.moveIndex leftMoves
                |> Maybe.withDefault emptyMove

        rightMove : Move
        rightMove =
            List.Extra.getAt state.moveIndex rightMoves
                |> Maybe.withDefault emptyMove

        applyMutations : List ( Mutation, Player ) -> List ( Mutation, Player ) -> CombatState
        applyMutations leftMutations rightMutations =
            List.concat [ leftMutations, rightMutations ]
                -- TODO: sort mutations e.g. gain block should happen before damage
                |> List.foldl applyMutation state
    in
    Random.map2
        applyMutations
        (leftMove params state)
        (rightMove params state)


applyMutation : ( Mutation, Player ) -> CombatState -> CombatState
applyMutation ( mutation, player ) state =
    let
        applyDamage : Int -> PlayerState -> PlayerState
        applyDamage amount playerState =
            { playerState | health = playerState.health - Basics.min 0 (amount - playerState.block), block = Basics.min 0 (playerState.block - amount) }

        applyBlock : Int -> PlayerState -> PlayerState
        applyBlock amount playerState =
            { playerState | block = playerState.block + amount }
    in
    case ( mutation, player ) of
        ( Damage amount, LeftPlayer ) ->
            { state | leftState = applyDamage amount state.leftState }

        ( Damage amount, RightPlayer ) ->
            { state | rightState = applyDamage amount state.rightState }

        ( Block amount, LeftPlayer ) ->
            { state | leftState = applyBlock amount state.leftState }

        ( Block amount, RightPlayer ) ->
            { state | rightState = applyBlock amount state.rightState }
