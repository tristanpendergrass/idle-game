module IdleGame.Views.Adventuring2 exposing (..)

import Duration exposing (Duration)
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


renderCharmstone : Html FrontendMsg
renderCharmstone =
    div
        [ class "card border-t-2 border-red-900 card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none h-[425px] xl:h-[405px]"
        ]
        [ figure [ class "h-24" ]
            [ renderAvatar Foe Icon.charmstone
            ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column gap-2 h-full", Utils.zIndexes.cardBody ]
                [ h2 [ class "text-sm md:text-lg text-center" ] [ text "Charmstone" ]
                , div [ class "text-2xs" ] [ text <| Utils.floatToString 1 5 ++ " seconds" ]
                ]
            ]
        ]


renderCombatDivider : Html FrontendMsg
renderCombatDivider =
    div [ class "absolute w-full h-full flex justify-center", Utils.zIndexes.combatDivider ]
        [ div [ class "divider divider-horizontal h-full" ] [ text "vs" ]
        ]


titleHeightClass : Attribute FrontendMsg
titleHeightClass =
    class "h-10"


renderPlayerCol : Game -> Html FrontendMsg
renderPlayerCol game =
    div [ class "t-column gap-3" ]
        [ div [ class "flex items-center gap-1 font-semibold text-sm", titleHeightClass ] [ span [] [ text "Player" ] ]
        , renderAvatar Friend Icon.adventuring
        ]


renderMonsterCol : Game -> Html FrontendMsg
renderMonsterCol game =
    div [ class "t-column gap-3" ]
        [ div [ class "flex items-center gap-1 font-semibold text-sm", titleHeightClass ] [ span [] [ text "Charmstone" ] ]
        , renderAvatar Foe Icon.charmstone
        ]


render : Game -> Html FrontendMsg
render game =
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-red-900" ]
            [ div [ class "grid grid-cols-2 gap-2 lg:gap-4 w-full h-full relative" ]
                [ renderPlayerCol game
                , renderMonsterCol game
                , renderCombatDivider

                -- , renderFightButton
                ]
            ]
        , div [ class "w-full grid grid-cols-2 md:grid-cols-3 2xl:grid-cols-4 gap-4" ]
            [ renderCharmstone ]
        ]
