module IdleGame.CombatWrapper exposing (..)

import CombatTypes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Combat
import IdleGame.Views.Utils as ViewsUtils
import List
import List.Extra
import Percent exposing (Percent)
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


initState : State
initState =
    { leftState = { health = 10, block = 0 }
    , rightState = { health = 10, block = 0 }
    , moveIndex = 0
    , log = []
    }


init : CombatModel
init =
    { state =
        initState
    , configUi =
        { leftMoves = [ swing 5, swing 5, swing 5 ]
        , rightMoves = [ swing 5, swing 5, swing 5 ]
        }
    , maybeSimulationResults = Nothing
    }


uiToConfig : CombatConfigUi -> Config
uiToConfig configUi =
    { leftMoves = List.map .move configUi.leftMoves
    , rightMoves = List.map .move configUi.rightMoves
    }


update : CombatMsg -> CombatModel -> ( CombatModel, Cmd FrontendMsg )
update msg model =
    case msg of
        StartNewCombat ->
            ( { model | state = initState }, Cmd.none )

        HandleNextStepClick ->
            let
                state : State
                state =
                    model.state

                config : Config
                config =
                    uiToConfig model.configUi

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

        HandleSimulateClick ->
            let
                emptySimulationResults : CombatSimulationResults
                emptySimulationResults =
                    { leftWins = 0
                    , rightWins = 0
                    , draw = 0
                    }

                updateSimulationResults : State -> CombatSimulationResults -> CombatSimulationResults
                updateSimulationResults state results =
                    case IdleGame.Combat.result state of
                        LeftWins ->
                            { results | leftWins = results.leftWins + 1 }

                        RightWins ->
                            { results | rightWins = results.rightWins + 1 }

                        Draw ->
                            { results | draw = results.draw + 1 }

                        Continue ->
                            results

                config : Config
                config =
                    uiToConfig model.configUi

                generator : Random.Generator CombatSimulationResults
                generator =
                    Random.list 10000 (IdleGame.Combat.stepUntilEnd config initState)
                        |> Random.map (List.foldl updateSimulationResults emptySimulationResults)
            in
            ( model, Random.generate (CombatMsg << HandleSimulateResult) generator )

        HandleSimulateResult combatSimulationResults ->
            ( { model | maybeSimulationResults = Just combatSimulationResults }, Cmd.none )


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
    ul [ class "list min-w-full items-center" ]
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
        , table [ class "table w-80" ]
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
        , div [ class "divider" ] []
        , div [] [ button [ class "btn", onClick (CombatMsg HandleSimulateClick) ] [ text "Simulate" ] ]
        , case model.maybeSimulationResults of
            Just results ->
                let
                    sum : Int
                    sum =
                        results.leftWins + results.rightWins + results.draw

                    drawPercent : Percent
                    drawPercent =
                        Percent.float (toFloat results.draw / toFloat sum)

                    leftWinPercent : Percent
                    leftWinPercent =
                        Percent.float (toFloat results.leftWins / toFloat sum)

                    rightWinPercent : Percent
                    rightWinPercent =
                        Percent.float (toFloat results.rightWins / toFloat sum)
                in
                -- <div class="stats shadow">
                --   <div class="stat">
                --     <div class="stat-title">Total Page Views</div>
                --     <div class="stat-value">89,400</div>
                --     <div class="stat-desc">21% more than last month</div>
                --   </div>
                -- </div>
                div [ class "stats shadow" ]
                    [ div [ class "stat" ]
                        [ div [ class "stat-title" ] [ text "Left Win" ]
                        , div [ class "stat-value" ] [ text (ViewsUtils.percentToString leftWinPercent) ]
                        ]
                    , div [ class "stat" ]
                        [ div [ class "stat-title" ] [ text "Right Win" ]
                        , div [ class "stat-value" ] [ text (ViewsUtils.percentToString rightWinPercent) ]
                        ]
                    , div [ class "stat" ]
                        [ div [ class "stat-title" ] [ text "Draw" ]
                        , div [ class "stat-value" ] [ text (ViewsUtils.percentToString drawPercent) ]
                        ]
                    ]

            Nothing ->
                text ""
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
