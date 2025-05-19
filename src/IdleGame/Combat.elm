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
    { state =
        { leftState = { health = 100, block = 0 }
        , rightState = { health = 100, block = 0 }
        , moveIndex = 0
        , log = []
        }
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        StartNewCombat ->
            { model | state = { leftState = { health = 100, block = 0 }, rightState = { health = 100, block = 0 }, moveIndex = 0, log = [] } }

        NextStep ->
            let
                state : State
                state =
                    model.state
            in
            { model | state = { state | moveIndex = state.moveIndex + 1 } }


view : Model -> Html FrontendMsg
view model =
    ul [ class "list" ]
        [ li [ class "list-row flex items-center" ]
            [ h1 [ class "text-xl" ] [ text "Player" ]
            , div [] [ text <| "Health: " ++ String.fromInt model.state.leftState.health ]
            , div [] [ text <| "Block: " ++ String.fromInt model.state.leftState.block ]
            ]
        , li [ class "list-row flex items-center" ]
            [ h1 [ class "text-xl" ] [ text "Enemy" ]
            , div [] [ text <| "Health: " ++ String.fromInt model.state.rightState.health ]
            , div [] [ text <| "Block: " ++ String.fromInt model.state.rightState.block ]
            ]

        -- Display the moves
        ]


renderState : EntityState -> Html FrontendMsg
renderState state =
    ul []
        [ li []
            [ text "Health: "
            , text (String.fromInt state.health)
            ]
        , li []
            [ text "Block: "
            , text (String.fromInt state.block)
            ]
        ]


emptyMove : Move
emptyMove _ =
    Random.constant []


result : Params -> State -> CombatResult
result _ state =
    if state.leftState.health <= 0 && state.rightState.health <= 0 then
        Draw

    else if state.leftState.health <= 0 then
        RightWins

    else if state.rightState.health <= 0 then
        LeftWins

    else
        Continue


step : Params -> State -> Random.Generator State
step params state =
    let
        leftMove =
            List.Extra.getAt state.moveIndex params.leftMoves
                |> Maybe.withDefault emptyMove

        rightMove =
            List.Extra.getAt state.moveIndex params.rightMoves
                |> Maybe.withDefault emptyMove
    in
    stepMove leftMove rightMove params state


stepMove : Move -> Move -> Params -> State -> Random.Generator State
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
