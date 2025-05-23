module IdleGame.Combat exposing (..)

import CombatTypes exposing (..)
import List
import List.Extra
import Random


emptyMove : Move
emptyMove _ =
    Random.constant []


result : State -> CombatResult
result state =
    if state.leftState.health <= 0 && state.rightState.health <= 0 then
        Draw

    else if state.leftState.health <= 0 then
        RightWins

    else if state.rightState.health <= 0 then
        LeftWins

    else
        Continue


step : Config -> State -> Random.Generator State
step config state =
    let
        leftMove =
            List.Extra.getAt state.moveIndex config.leftMoves
                |> Maybe.withDefault emptyMove

        rightMove =
            List.Extra.getAt state.moveIndex config.rightMoves
                |> Maybe.withDefault emptyMove
    in
    state
        |> incrementIndex config
        |> stepMove leftMove rightMove config


incrementIndex : Config -> State -> State
incrementIndex config state =
    let
        lastMoveIndex : Int
        lastMoveIndex =
            Basics.max (List.length config.leftMoves) (List.length config.rightMoves)
                - 1
    in
    { state
        | moveIndex =
            if state.moveIndex >= lastMoveIndex then
                0

            else
                state.moveIndex + 1
    }


stepMove : Move -> Move -> Config -> State -> Random.Generator State
stepMove leftMove rightMove params state =
    -- Run generators for left and right moves to generate the List (Mutation, EntityRelative)
    -- Map the EntityRelative to EntityAbsolute according to whether it was a left or right move
    -- Sort the mutations accordingly-- Block before Damage
    -- Apply all mutation to state using foldl
    let
        leftMutations : Random.Generator (List ( Mutation, EntityAbsolute ))
        leftMutations =
            leftMove state
                |> Random.map (List.map (\( mutation, relative ) -> ( mutation, mapRelativeToAbsolute relative Left )))

        rightMutations : Random.Generator (List ( Mutation, EntityAbsolute ))
        rightMutations =
            rightMove state
                |> Random.map (List.map (\( mutation, relative ) -> ( mutation, mapRelativeToAbsolute relative Right )))

        allMutations : Random.Generator (List ( Mutation, EntityAbsolute ))
        allMutations =
            Random.map2 (++) leftMutations rightMutations
                |> Random.map (List.sortWith sortMutations)

        applyMutationToAbsolute : ( Mutation, EntityAbsolute ) -> State -> State
        applyMutationToAbsolute ( mutation, absolute ) s =
            case absolute of
                Left ->
                    { s | leftState = applyMutation mutation s.leftState }

                Right ->
                    { s | rightState = applyMutation mutation s.rightState }
    in
    allMutations
        |> Random.map (List.foldl applyMutationToAbsolute state)


sortMutations : ( Mutation, EntityAbsolute ) -> ( Mutation, EntityAbsolute ) -> Order
sortMutations ( leftMutation, _ ) ( rightMutation, _ ) =
    case ( leftMutation, rightMutation ) of
        ( Block _, Damage _ ) ->
            LT

        ( Damage _, Block _ ) ->
            GT

        _ ->
            EQ


mapRelativeToAbsolute : EntityRelative -> EntityAbsolute -> EntityAbsolute
mapRelativeToAbsolute relative self =
    case ( relative, self ) of
        ( Self, Left ) ->
            Left

        ( Opponent, Left ) ->
            Right

        ( Self, Right ) ->
            Right

        ( Opponent, Right ) ->
            Left


applyMutation : Mutation -> EntityState -> EntityState
applyMutation mutation state =
    case mutation of
        Damage amount ->
            let
                blockRemoved =
                    Basics.min amount state.block

                healthRemoved =
                    amount - blockRemoved
            in
            { state | health = state.health - healthRemoved, block = state.block - blockRemoved }

        Block amount ->
            { state | block = state.block + amount }


stepUntilEnd : Config -> State -> Random.Generator State
stepUntilEnd config state =
    let
        isOver : Bool
        isOver =
            result state /= Continue
    in
    if isOver then
        Random.constant state

    else
        Random.andThen (stepUntilEnd config) (step config state)
