module IdleGame.Views.Effect exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Multiplicable as Multiplicable exposing (Multiplicable)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import Types exposing (..)


render : List IdleGame.Event.Mod -> IdleGame.Event.Effect -> Html FrontendMsg
render mods effect =
    IdleGame.Event.applyModsToEffect mods effect
        |> List.head
        |> Maybe.map renderModdedEffect
        |> Maybe.withDefault (div [] [])



-- = VariableSuccess { successProbability : Float, successEffects : List Effect, failureEffects : List Effect }
-- | GainResource { base : Int, doublingChance : Float } Resource.Kind
-- | GainXp Multiplicable.Multiplicable Skill
-- | GainChoreMxp { multiplier : Float } ChoreKind
-- | GainCoin Multiplicable.Multiplicable


renderModdedEffect : IdleGame.Event.Effect -> Html FrontendMsg
renderModdedEffect effect =
    case IdleGame.Event.getType effect of
        IdleGame.Event.GainCoin multiplicable ->
            renderCoin multiplicable

        IdleGame.Event.GainResource { base, doublingChance } kind ->
            renderResource { base = base, doublingChance = doublingChance } kind

        IdleGame.Event.GainXp multiplicable skill ->
            renderXp multiplicable skill

        IdleGame.Event.GainChoreMxp multiplier skill ->
            renderMxp multiplier skill

        IdleGame.Event.VariableSuccess { successProbability, successEffects, failureEffects } ->
            case successEffects of
                [ e ] ->
                    case IdleGame.Event.getType e of
                        IdleGame.Event.GainResource _ kind ->
                            renderVariableResource successProbability kind

                        _ ->
                            div [] []

                _ ->
                    div [] []


renderCoin : Multiplicable -> Html msg
renderCoin coin =
    div [ class "flex items-center gap-1" ]
        [ div [ class "flex items-center gap-1" ]
            [ span []
                [ coin
                    |> Multiplicable.toCounter
                    |> Counter.toString
                    |> text
                ]
            , Icon.coin
                |> Icon.toHtml
            ]
        ]


renderResource : { base : Int, doublingChance : Float } -> Resource.Kind -> Html msg
renderResource { base, doublingChance } kind =
    (Resource.getStats kind).icon
        |> Icon.toHtml


renderXp : Multiplicable -> IdleGame.Event.Skill -> Html msg
renderXp xp skill =
    div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
        [ Utils.skillXpBadge
        , span [ class "font-bold col-span-4" ]
            [ xp
                |> Multiplicable.toCounter
                |> Counter.toString
                |> text
            ]
        ]


renderMxp : Multiplicable -> IdleGame.GameTypes.ChoreKind -> Html msg
renderMxp mxp skill =
    div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
        [ Utils.masteryXpBadge
        , span [ class "font-bold col-span-4" ]
            [ mxp
                |> Multiplicable.toCounter
                |> Counter.toString
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
