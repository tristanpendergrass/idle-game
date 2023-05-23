module IdleGame.Views.Adventuring exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Adventuring as Adventuring exposing (Adventuring)
import IdleGame.Combat as Combat
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event exposing (..)
import IdleGame.Game as Game exposing (Game)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import List.Extra
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


renderPlayerMove : Combat.PlayerMove -> Html FrontendMsg
renderPlayerMove move =
    div [ class "flex gap-2 items-center", moveHeightClass ]
        [ span [] [ text <| (Combat.getPlayerMoveStats move).title ]
        , case move of
            Combat.Punch ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Combat.punchDamage ]
                    , span [ class "text-error" ]
                        [ Icon.damage
                            |> Icon.toHtml
                        ]
                    ]

            Combat.Firebolt ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Combat.fireboltDamage ]
                    , span [ class "text-error" ]
                        [ Icon.damage
                            |> Icon.toHtml
                        ]
                    ]

            Combat.Barrier ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Combat.barrierBlock ]
                    , span [ class "text-info" ]
                        [ Icon.shield
                            |> Icon.toHtml
                        ]
                    ]
        ]


renderMonsterMove : Combat.MonsterMove -> Html FrontendMsg
renderMonsterMove move =
    div [ class "flex gap-2 items-center", moveHeightClass ]
        [ span [] [ text <| (Combat.getMonsterMoveStats move).title ]
        , case move of
            Combat.Claw ->
                span [ class "flex items-center gap-1" ]
                    [ span [ class "font-bold" ] [ text <| String.fromInt Combat.clawDamage ]
                    , span [ class "text-error" ]
                        [ Icon.damage
                            |> Icon.toHtml
                        ]
                    ]
        ]


renderPlayerMoveRow : Adventuring.PlayerMoveInfo -> Html FrontendMsg
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
                [ li [ onClick <| HandlePlayerMoveSelect index Combat.Punch ] [ span [] [ text "Punch" ] ]
                , li [ onClick <| HandlePlayerMoveSelect index Combat.Firebolt ] [ span [] [ text "Firebolt" ] ]
                , li [ onClick <| HandlePlayerMoveSelect index Combat.Barrier ] [ span [] [ text "Barrier" ] ]
                ]
            ]
        , renderPlayerMove move
        ]


renderMonsterMoveRow : Combat.MonsterMove -> Html FrontendMsg
renderMonsterMoveRow move =
    renderMonsterMove move


titleHeightClass : Attribute FrontendMsg
titleHeightClass =
    class "h-10"


renderPlayerCol : Adventuring -> Html FrontendMsg
renderPlayerCol adventuring =
    let
        moveInfo : Int -> Adventuring.PlayerMoveInfo
        moveInfo i =
            Adventuring.getPlayerMoveInfo i adventuring

        health : Int
        health =
            Adventuring.getPlayerHealth adventuring
    in
    div [ class "t-column gap-3" ]
        [ div [ class "flex items-center gap-1 uppercase font-semibold", titleHeightClass ] [ span [] [ text "Player" ] ]
        , renderAvatar Friend Icon.adventuring
        , renderHealthBar health Friend
        , renderPlayerMoveRow (moveInfo 0)
        , renderPlayerMoveRow (moveInfo 1)
        , renderPlayerMoveRow (moveInfo 2)
        ]


renderMonsterTitle : Combat.MonsterKind -> Html FrontendMsg
renderMonsterTitle monster =
    div [ class "dropdown dropdown-end", titleHeightClass ]
        [ label [ class "btn btn-sm m-1 flex items-center gap-1", tabindex 0 ]
            [ span [] [ text (Combat.getMonsterStats monster).title ]
            , Icon.dropdown
                |> Icon.withSize Icon.Small
                |> Icon.toHtml
            ]
        , ul [ class "dropdown-content menu p-2 shadow bg-base-200 rounded-box w-52", tabindex 0 ]
            (Combat.allMonsterKinds
                |> List.map
                    (\kind ->
                        li [] [ button [ onClick (HandleMonsterSelect kind) ] [ text <| (Combat.getMonsterStats kind).title ] ]
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


renderMonsterCol : Adventuring -> Html FrontendMsg
renderMonsterCol adventuring =
    let
        monsterKind : Combat.MonsterKind
        monsterKind =
            Adventuring.getMonster adventuring

        monsterStats : Combat.MonsterStats
        monsterStats =
            Combat.getMonsterStats monsterKind

        health : Int
        health =
            Adventuring.getMonsterHealth adventuring

        moves : List Combat.MonsterMove
        moves =
            Adventuring.getMonsterMoves adventuring

        moveForIndex : Int -> Combat.MonsterMove
        moveForIndex index =
            List.Extra.getAt index moves
                |> Maybe.withDefault Combat.Claw
    in
    div [ class "t-column gap-3" ]
        [ renderMonsterTitle monsterKind
        , div [ class "relative" ]
            [ renderAvatar Foe monsterStats.avatar
            , div [ class "absolute bottom-0 right-[-45px]" ]
                [ renderMonsterReward (Counter.create monsterStats.reward) ]
            ]
        , renderHealthBar health Foe
        , renderMonsterMoveRow (moveForIndex 0)
        , renderMonsterMoveRow (moveForIndex 1)
        , renderMonsterMoveRow (moveForIndex 2)
        ]


renderCombatDivider : Html FrontendMsg
renderCombatDivider =
    div [ class "absolute w-full h-full flex justify-center", Utils.zIndexes.combatDivider ]
        [ div [ class "divider divider-horizontal h-full" ] [ text "vs" ]
        ]


fightButtonId : String
fightButtonId =
    -- This should always be present on the page as a place to put focus to close the dropdowns after selection
    "fight-button"


render : Game -> Html FrontendMsg
render game =
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "t-column w-full md:w-3/4 lg:w-1/2 h-20" ]
            (case game.adventuring of
                Adventuring.Idle _ ->
                    [ button [ class "btn btn-primary", onClick StartFight, id fightButtonId ] [ text "Fight!" ]
                    ]

                Adventuring.InCombat timer _ ->
                    let
                        percentComplete : Percent
                        percentComplete =
                            Timer.percentComplete timer
                    in
                    [ button [ class "btn btn-circle", onClick StopFight, id fightButtonId ] [ Icon.close |> Icon.toHtml ]
                    , progress
                        [ class "progress h-[2px]"
                        , Html.Attributes.max "100"
                        , Html.Attributes.value (String.fromFloat (Percent.toPercentage percentComplete))
                        ]
                        []
                    ]
            )
        , div [ class "grid grid-cols-2 gap-2 lg:gap-4 w-full h-full relative" ]
            [ renderPlayerCol game.adventuring
            , renderMonsterCol game.adventuring
            , renderCombatDivider
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
