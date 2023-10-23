module IdleGame.Views.Effect exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Quantity exposing (Quantity)
import Types exposing (..)


type RenderType
    = ForCard
    | ForDetailView


render : { game : Game, mods : List Mod, effect : Effect.TaggedEffect, renderType : RenderType } -> Html FrontendMsg
render { game, mods, effect, renderType } =
    Mod.applyModsToEffect mods effect
        |> Tuple.first
        |> renderModdedEffect renderType game


renderModdedEffect : RenderType -> Game -> Effect.TaggedEffect -> Html FrontendMsg
renderModdedEffect renderType game effect =
    case Effect.getEffect effect of
        Effect.GainCoin coin ->
            renderCoin coin

        Effect.GainResource params ->
            renderResource params

        Effect.GainXp params ->
            renderXp params

        Effect.GainMxp params ->
            renderMxp game params

        Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
            case successEffects of
                [ e ] ->
                    case Effect.getEffect e of
                        Effect.GainResource { resource } ->
                            renderVariableResource successProbability resource

                        _ ->
                            div [] []

                _ ->
                    div [] []

        Effect.ResolveCombat { combat } ->
            renderCombat renderType combat


renderCoin : { base : Coin, multiplier : Float } -> Html msg
renderCoin { base, multiplier } =
    let
        coin : Coin
        coin =
            Quantity.multiplyBy multiplier base

        isNegative : Bool
        isNegative =
            Coin.toInt coin < 0
    in
    div [ class "flex items-center gap-1" ]
        [ span [ classList [ ( "text-error", isNegative ) ] ]
            [ coin
                |> Coin.toInt
                |> Utils.intToString
                |> text
            ]
        , Icon.coin
            |> Icon.toHtml
        ]


renderResource : Effect.GainResourceParams -> Html msg
renderResource { base, resource } =
    let
        isNegative : Bool
        isNegative =
            base < 0
    in
    div [ class "flex items-center gap-1" ]
        [ span [ classList [ ( "text-error", isNegative ) ] ]
            [ base
                |> Utils.intToString
                |> text
            ]
        , (Resource.getStats resource).icon
            |> Icon.toHtml
        ]


renderXp : Effect.GainXpParams -> Html msg
renderXp params =
    div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
        [ Utils.skillXpBadge
        , span [ class "font-bold col-span-4" ]
            [ Quantity.multiplyBy params.multiplier params.base
                |> Xp.toInt
                |> Utils.intToString
                |> text
            ]
        ]


renderMxp : Game -> Effect.GainMxpParams -> Html msg
renderMxp game params =
    let
        base : Xp
        base =
            Game.calculateActivityMxp params.activity game
    in
    div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
        [ Utils.masteryXpBadge
        , span [ class "font-bold col-span-4" ]
            [ Quantity.multiplyBy params.multiplier base
                |> Xp.toInt
                |> Utils.intToString
                |> text
            ]
        ]


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)


renderVariableResource : Float -> Resource.Kind -> Html msg
renderVariableResource probability kind =
    let
        probabilityStr : String
        probabilityStr =
            Utils.intToString (floor (probability * 100)) ++ "%"
    in
    div [ class "flex items-center gap-2" ]
        [ div [ class "border border-info text-info px-2 rounded-full" ] [ text probabilityStr ]
        , div [] [ text ":" ]
        , (Resource.getStats kind).icon
            |> Icon.toHtml
        ]


renderMonsterPower : Int -> Html msg
renderMonsterPower strength =
    div [ class "flex items-center gap-4" ]
        [ Icon.adventuring
            |> Icon.withSize Icon.Large
            |> Icon.toHtml
        , span [ class "text-5xl font-bold leading-none" ]
            [ text (Utils.intToString strength)
            ]
        ]


renderCombat : RenderType -> Combat -> Html msg
renderCombat renderType combat =
    let
        monsterPower : Int
        monsterPower =
            Combat.getMonsterPower combat

        playerPower : Int
        playerPower =
            Combat.getPlayerPower combat
    in
    div [ class "flex items-center gap-1 h-24 max-w-full overflow-hidden" ]
        (case renderType of
            ForDetailView ->
                [ renderMonsterPower monsterPower
                , div [ class "divider divider-horizontal h-full text-sm" ] [ text "Vs" ]
                , div [ class "t-column gap-0" ]
                    [ div [ class "text-2xl font-bold" ] [ text (Utils.intToString playerPower) ]
                    , div [ class "text-sm" ] [ text "Player Power" ]
                    ]
                ]

            ForCard ->
                [ renderMonsterPower monsterPower ]
        )
