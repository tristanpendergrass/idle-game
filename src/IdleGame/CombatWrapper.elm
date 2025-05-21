module IdleGame.CombatWrapper exposing (..)

import CombatTypes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Combat
import List
import List.Extra
import Random
import Types exposing (..)


swing : Int -> MoveUi
swing amount =
    let
        move : Move
        move _ =
            Random.map (\dmg -> [ ( Damage dmg, Opponent ) ]) (Random.int 1 amount)
    in
    { name = "Swing " ++ String.fromInt amount
    , move = move
    }


block : Int -> MoveUi
block amount =
    let
        move : Move
        move _ =
            Random.constant [ ( Block amount, Self ) ]
    in
    { name = "Block " ++ String.fromInt amount
    , move = move
    }


newState : State
newState =
    { leftState = { health = 10, block = 0 }
    , rightState = { health = 10, block = 0 }
    , moveIndex = 0
    , log = []
    }


init : CombatModel
init =
    { state =
        newState
    , configUi =
        { leftMoves = [ swing 5, swing 5, swing 5 ]
        , rightMoves = [ swing 5, swing 5, swing 5 ]
        }
    }


update : CombatMsg -> CombatModel -> ( CombatModel, Cmd FrontendMsg )
update msg model =
    case msg of
        StartNewCombat ->
            ( { model | state = newState }, Cmd.none )

        HandleNextStepClick ->
            let
                state : State
                state =
                    model.state

                config : Config
                config =
                    { leftMoves = List.map .move model.configUi.leftMoves
                    , rightMoves = List.map .move model.configUi.rightMoves
                    }

                handleGeneratorResult : State -> FrontendMsg
                handleGeneratorResult result =
                    CombatMsg (HandleNextStepResult result)
            in
            ( model, Random.generate handleGeneratorResult (IdleGame.Combat.step config state) )

        HandleNextStepResult result ->
            ( { model | state = result }, Cmd.none )

        HandleSelectCombatMove entityAbsolute moveIndex moveUi ->
            let
                configUi : CombatConfigUi
                configUi =
                    model.configUi

                updatedConfigUi =
                    case entityAbsolute of
                        Left ->
                            { configUi | leftMoves = List.Extra.setAt moveIndex moveUi configUi.leftMoves }

                        Right ->
                            { configUi | rightMoves = List.Extra.setAt moveIndex moveUi configUi.rightMoves }
            in
            ( { model | configUi = updatedConfigUi }, Cmd.none )


view : CombatModel -> Html FrontendMsg
view model =
    case IdleGame.Combat.result model.state of
        Continue ->
            viewInProgress model

        LeftWins ->
            viewWinner model (Just Left)

        RightWins ->
            viewWinner model (Just Right)

        Draw ->
            viewWinner model Nothing


viewWinner : CombatModel -> Maybe EntityAbsolute -> Html FrontendMsg
viewWinner model maybeWinner =
    div []
        [ div []
            [ case maybeWinner of
                Just Left ->
                    text "Player Wins!"

                Just Right ->
                    text "Enemy Wins!"

                Nothing ->
                    text "Draw!"
            ]
        , button [ class "btn", onClick (CombatMsg StartNewCombat) ] [ text "New Combat" ]
        ]


viewInProgress : CombatModel -> Html FrontendMsg
viewInProgress model =
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
        , div [ class "divider" ] []

        -- Display the moves
        , table [ class "table" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Player Moves" ]
                    , th [] [ text "Enemy Moves" ]
                    ]
                ]
            , tbody []
                [ renderMoveRow model.configUi model.state 0
                , renderMoveRow model.configUi model.state 1
                , renderMoveRow model.configUi model.state 2
                ]
            ]
        , button [ class "btn", onClick (CombatMsg HandleNextStepClick) ] [ text "Step" ]
        ]


emptyUiMove : MoveUi
emptyUiMove =
    { name = "Empty"
    , move = IdleGame.Combat.emptyMove
    }


renderMoveRow : CombatConfigUi -> State -> Int -> Html FrontendMsg
renderMoveRow config state index =
    let
        isActive =
            index == state.moveIndex

        leftMove : MoveUi
        leftMove =
            List.Extra.getAt index config.leftMoves
                |> Maybe.withDefault emptyUiMove

        rightMove : MoveUi
        rightMove =
            List.Extra.getAt index config.rightMoves
                |> Maybe.withDefault emptyUiMove
    in
    tr [ classList [ ( "bg-base-200", isActive ) ] ]
        [ td []
            [ renderMove
                leftMove
                (\move -> CombatMsg (HandleSelectCombatMove Left index move))
            ]
        , td []
            [ renderMove
                rightMove
                (\move -> CombatMsg (HandleSelectCombatMove Right index move))
            ]
        ]


renderMove : MoveUi -> (MoveUi -> FrontendMsg) -> Html FrontendMsg
renderMove move onSelect =
    -- div [] [ text move.name ]
    details [ class "dropdown" ]
        [ summary [ class "btn" ] [ text move.name ]
        , ul [ class "dropdown-content bg-base-100 rounded-box z-[1]" ]
            [ li [ onClick (onSelect (swing 5)) ] [ text "Swing" ]
            , li [ onClick (onSelect (block 4)) ] [ text "Block" ]
            ]
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
