module IdleGame.Views.Adventuring exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Adventuring as Adventuring
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Maybe.Extra
import Percent exposing (Percent)
import Types exposing (..)


type Loyalty
    = Friend
    | Foe


renderAvatar : Loyalty -> Icon -> Html FrontendMsg
renderAvatar loyalty icon =
    div
        [ class "avatar rounded-full w-20 h-20 items-center justify-center"
        , case loyalty of
            Friend ->
                class "bg-primary text-primary-content"

            Foe ->
                class "bg-error text-error-content"
        ]
        [ icon
            |> Icon.withSize Icon.Large
            |> Icon.toHtml
        ]


renderHealthBar : Int -> Loyalty -> Html FrontendMsg
renderHealthBar health loyalty =
    div [ class "t-column" ]
        [ progress
            [ class "progress w-3/5"
            , case loyalty of
                Friend ->
                    class "progress-primary"

                Foe ->
                    class "progress-error"
            , attribute "value" (String.fromInt health)
            , attribute "max" "100"
            ]
            []
        , span [] [ text <| "HP: " ++ String.fromInt health ++ "/100" ]
        ]


moveHeightClass : Attribute FrontendMsg
moveHeightClass =
    class "h-12"


renderPlayerMove : Adventuring.PlayerMove -> Html FrontendMsg
renderPlayerMove move =
    div [ class "flex gap-2 items-center", moveHeightClass ]
        [ span [] [ text <| (Adventuring.getPlayerMoveStats move).title ]
        , case move of
            Adventuring.Punch ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Adventuring.punchDamage ]
                    , span [ class "text-error" ]
                        [ Icon.damage
                            |> Icon.toHtml
                        ]
                    ]

            Adventuring.Firebolt ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Adventuring.fireboltDamage ]
                    , span [ class "text-error" ]
                        [ Icon.damage
                            |> Icon.toHtml
                        ]
                    ]

            Adventuring.Barrier ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Adventuring.barrierBlock ]
                    , span [ class "text-info" ]
                        [ Icon.shield
                            |> Icon.toHtml
                        ]
                    ]
        ]


renderMonsterMove : Adventuring.MonsterMove -> Html FrontendMsg
renderMonsterMove move =
    div [ class "flex gap-2 items-center", moveHeightClass ]
        [ span [] [ text <| (Adventuring.getMonsterMoveStats move).title ]
        , case move of
            Adventuring.Claw ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Adventuring.clawDamage ]
                    , span [ class "text-error" ]
                        [ Icon.damage
                            |> Icon.toHtml
                        ]
                    ]
        ]


renderPlayerMoveRow :
    { index : Int
    , move : Adventuring.PlayerMove
    , isActive : Bool
    }
    -> Html FrontendMsg
renderPlayerMoveRow { index, move, isActive } =
    div
        [ class "flex gap-1 items-center"
        , moveHeightClass
        , classList [ ( "border border-accent", isActive ) ]
        ]
        [ div [ class "dropdown" ]
            [ label [ tabindex 0, class "btn btn-circle btn-sm m-1" ]
                [ Icon.switch
                    |> Icon.withSize Icon.Small
                    |> Icon.toHtml
                ]
            , ul [ tabindex 0, class "dropdown-content menu p-2 shadow bg-base-200 rounded-box w-52" ]
                [ li [ onClick <| SetPlayerMove index Adventuring.Punch ] [ span [] [ text "Punch" ] ]
                , li [ onClick <| SetPlayerMove index Adventuring.Firebolt ] [ span [] [ text "Firebolt" ] ]
                , li [ onClick <| SetPlayerMove index Adventuring.Barrier ] [ span [] [ text "Barrier" ] ]
                ]
            ]
        , renderPlayerMove move
        ]


renderMonsterMoveRow : Adventuring.MonsterMove -> Html FrontendMsg
renderMonsterMoveRow move =
    renderMonsterMove move


titleHeightClass : Attribute FrontendMsg
titleHeightClass =
    class "h-10"


renderPlayerCol : Game -> Html FrontendMsg
renderPlayerCol game =
    let
        isActive : Int -> Bool
        isActive i =
            Maybe.Extra.isJust game.adventuringTimer && game.adventuringState.nextMoveIndex == i
    in
    div [ class "t-column gap-3" ]
        [ div [ class "flex items-center gap-1 uppercase font-semibold", titleHeightClass ] [ span [] [ text "Player" ] ]
        , renderAvatar Friend Icon.adventuring
        , renderHealthBar game.adventuringState.playerHealth Friend
        , renderPlayerMoveRow { index = 0, move = Adventuring.getPlayerMove 0 game.adventuringState, isActive = isActive 0 }
        , renderPlayerMoveRow { index = 1, move = Adventuring.getPlayerMove 1 game.adventuringState, isActive = isActive 1 }
        , renderPlayerMoveRow { index = 2, move = Adventuring.getPlayerMove 2 game.adventuringState, isActive = isActive 2 }
        ]


renderMonsterTitle : Adventuring.MonsterKind -> Html FrontendMsg
renderMonsterTitle monster =
    div [ class "dropdown dropdown-end", titleHeightClass ]
        [ label [ class "btn btn-sm m-1 flex items-center gap-1", tabindex 0 ]
            [ span [] [ text (Adventuring.getMonsterStats monster).title ]
            , Icon.dropdown
                |> Icon.withSize Icon.Small
                |> Icon.toHtml
            ]
        , ul [ class "dropdown-content menu p-2 shadow bg-base-200 rounded-box w-52", tabindex 0 ]
            (Adventuring.allMonsterKinds
                |> List.map
                    (\kind ->
                        li [] [ button [ onClick (SetMonster kind) ] [ text <| (Adventuring.getMonsterStats kind).title ] ]
                    )
            )
        ]


renderMonsterReward : Counter -> Html FrontendMsg
renderMonsterReward coin =
    div [ class "flex items-center gap-1" ]
        [ div [ class "flex items-center gap-1" ]
            [ span [] [ text (Counter.toString coin) ]
            , Icon.coin
                |> Icon.toHtml
            ]
        ]


renderMonsterCol : Game -> Html FrontendMsg
renderMonsterCol game =
    let
        monsterStats =
            Adventuring.getMonsterStats game.adventuringState.monster
    in
    div [ class "t-column gap-3" ]
        [ renderMonsterTitle game.adventuringState.monster
        , div [ class "relative" ]
            [ renderAvatar Foe monsterStats.avatar
            , div [ class "absolute bottom-0 right-[-45px]" ]
                [ renderMonsterReward (Counter.create monsterStats.reward) ]
            ]
        , renderHealthBar game.adventuringState.monsterHealth Foe
        , renderMonsterMoveRow (Adventuring.getMonsterMove 0 game.adventuringState)
        , renderMonsterMoveRow (Adventuring.getMonsterMove 1 game.adventuringState)
        , renderMonsterMoveRow (Adventuring.getMonsterMove 2 game.adventuringState)
        ]


renderCombatDivider : Html FrontendMsg
renderCombatDivider =
    div [ class "absolute z-0 w-full h-full flex justify-center" ]
        [ div [ class "divider divider-horizontal h-full" ] [ text "vs" ]
        ]


render : Game -> Html FrontendMsg
render game =
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "t-column w-full md:w-3/4 lg:w-1/2 h-20" ]
            (case game.adventuringTimer of
                Nothing ->
                    [ button [ class "btn btn-primary", onClick StartFight ] [ text "Fight!" ]
                    ]

                Just timer ->
                    let
                        percentComplete : Percent
                        percentComplete =
                            Timer.percentComplete timer
                    in
                    [ button [ class "btn btn-circle", onClick StopFight ] [ Icon.close |> Icon.toHtml ]
                    , progress
                        [ class "progress h-[2px]"
                        , Html.Attributes.max "100"
                        , Html.Attributes.value (String.fromFloat (Percent.toNumber percentComplete))
                        ]
                        []
                    ]
            )
        , div [ class "grid grid-cols-2 gap-2 lg:gap-4 w-full h-full relative" ]
            [ renderPlayerCol game
            , renderMonsterCol game
            , renderCombatDivider
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
