module IdleGame.Combat exposing (..)

import CombatTypes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import List
import List.Extra
import Random
import Types exposing (..)


init : Model
init =
    { state = { leftState = { health = 100, block = 0 }, rightState = { health = 100, block = 0 }, moveIndex = 0 } }


update : Msg -> Model -> Model
update msg model =
    case msg of
        StartNewCombat ->
            { model | state = { leftState = { health = 100, block = 0 }, rightState = { health = 100, block = 0 }, moveIndex = 0 } }

        NextStep ->
            let
                state : CombatState
                state =
                    model.state
            in
            { model | state = { state | moveIndex = state.moveIndex + 1 } }


view : Model -> Html FrontendMsg
view model =
    div [] [ text "Combat" ]


emptyMove : Move
emptyMove _ _ =
    Random.constant []


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
