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


renderHealthBar : Loyalty -> Html FrontendMsg
renderHealthBar loyalty =
    div [ class "t-column" ]
        [ progress
            [ class "progress w-3/5"
            , case loyalty of
                Friend ->
                    class "progress-primary"

                Foe ->
                    class "progress-error"
            , attribute "value" "50"
            , attribute "max" "100"
            ]
            []
        , span [] [ text "HP: 50/100" ]
        ]


moveHeightClass : Attribute FrontendMsg
moveHeightClass =
    class "h-12"


renderPlayerMove : Int -> Adventuring.PlayerMove -> Html FrontendMsg
renderPlayerMove index move =
    div [ class "flex gap-1 items-center", moveHeightClass ]
        [ div [ class "dropdown" ]
            [ label [ tabindex 0, class "btn btn-circle m-1" ]
                [ Icon.switch
                    |> Icon.toHtml
                ]
            , ul [ tabindex 0, class "dropdown-content menu p-2 shadow bg-base-200 rounded-box w-52" ]
                [ li [ onClick <| SetPlayerMove index Adventuring.Punch ] [ span [] [ text "Punch" ] ]
                , li [ onClick <| SetPlayerMove index Adventuring.Firebolt ] [ span [] [ text "Firebolt" ] ]
                , li [ onClick <| SetPlayerMove index Adventuring.Barrier ] [ span [] [ text "Barrier" ] ]
                ]
            ]
        , div [ class "flex gap-2 items-center", moveHeightClass ]
            [ span [] [ text <| (Adventuring.getPlayerMoveStats move).title ]
            , case move of
                Adventuring.Punch ->
                    span [ class "flex items-center gap-1" ]
                        [ span [ class "font-bold" ] [ text "4" ]
                        , span [ class "text-error" ]
                            [ Icon.damage
                                |> Icon.toHtml
                            ]
                        ]

                Adventuring.Firebolt ->
                    span [ class "flex items-center gap-1" ]
                        [ span [ class "font-bold" ] [ text "6" ]
                        , span [ class "text-error" ]
                            [ Icon.damage
                                |> Icon.toHtml
                            ]
                        ]

                Adventuring.Barrier ->
                    span [ class "flex items-center gap-1" ]
                        [ span [ class "font-bold" ] [ text "6" ]
                        , span [ class "text-info" ]
                            [ Icon.shield
                                |> Icon.toHtml
                            ]
                        ]
            ]
        ]


renderMonsterMove : Html FrontendMsg
renderMonsterMove =
    div [ class "flex gap-2 items-center", moveHeightClass ]
        [ span [] [ text "Claw:" ]
        , span [ class "flex items-center gap-1" ]
            [ span [ class "font-bold" ] [ text "4" ]
            , span [ class "text-error" ]
                [ Icon.damage
                    |> Icon.toHtml
                ]
            ]
        ]


renderPlayerCol : Game -> Html FrontendMsg
renderPlayerCol game =
    div [ class "t-column gap-3" ]
        [ span [] [ text "Player" ]
        , renderAvatar Friend Icon.adventuring
        , renderHealthBar Friend
        , renderPlayerMove 0 (Adventuring.getPlayerMove 0 game.adventuring)
        , renderPlayerMove 1 (Adventuring.getPlayerMove 1 game.adventuring)
        , renderPlayerMove 2 (Adventuring.getPlayerMove 2 game.adventuring)
        ]


renderMonsterCol : Game -> Html FrontendMsg
renderMonsterCol game =
    div [ class "t-column gap-3" ]
        [ span [] [ text "Lil Gargoyle" ]
        , renderAvatar Foe Icon.monster
        , renderHealthBar Foe
        , renderMonsterMove
        , renderMonsterMove
        , renderMonsterMove
        ]


render : Game -> Html FrontendMsg
render game =
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "t-column w-full h-20" ]
            (case game.adventuring.combatTimer of
                Nothing ->
                    [ button [ class "btn btn-primary", onClick StartFight ] [ text "Fight!" ]
                    ]

                Just ( _, timer ) ->
                    let
                        percentComplete : Float
                        percentComplete =
                            Timer.percentComplete timer
                    in
                    [ button [ class "btn btn-circle", onClick StopFight ] [ Icon.close |> Icon.toHtml ]
                    , progress
                        [ class "progress h-[2px]"
                        , Html.Attributes.max "100"
                        , Html.Attributes.value (String.fromFloat percentComplete)
                        ]
                        []
                    ]
            )
        , div [ class "grid grid-cols-2 gap-2 lg:gap-4 w-full h-full" ]
            [ renderPlayerCol game
            , renderMonsterCol game
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [] []
