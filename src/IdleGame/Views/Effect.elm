module IdleGame.Views.Effect exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.Game as Game
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.OneTime as OneTime
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Quantity exposing (Quantity)
import Svg.Attributes exposing (lengthAdjust)
import Types exposing (..)


type RenderType
    = Card
    | DetailView


render : { game : Game, mods : List Mod, effect : Effect, renderType : RenderType } -> Html FrontendMsg
render { game, mods, effect, renderType } =
    Mod.applyModsToEffect mods effect
        |> Tuple.first
        |> renderModdedEffect renderType game


renderModdedEffect : RenderType -> Game -> Effect -> Html msg
renderModdedEffect renderType game effect =
    let
        effectContent : Html msg
        effectContent =
            case Effect.getEffect effect of
                Effect.GainCoin coin ->
                    renderCoin coin

                Effect.GainResource params ->
                    renderResource game params.resource params.base

                Effect.SpendResource params ->
                    renderResource game params.resource (-1 * params.base)

                Effect.GainXp params ->
                    renderXp params

                Effect.GainMxp params ->
                    renderMxp game params

                Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
                    case successEffects of
                        [] ->
                            div [] []

                        effects ->
                            div [ class "flex rounded overflow-hidden relative" ]
                                [ div []
                                    [ div [ class "h-full flex items-center bg-info text-info-content p-2 border-2 border-r-0 border-info" ]
                                        [ text (Utils.percentToString successProbability)
                                        ]
                                    ]
                                , div [ class "p-2 border border-content border-dashed border-l-0 border-tr-rounded border-br-rounded" ]
                                    [ div [ class "t-column gap-2" ] (List.map (renderModdedEffect renderType game) effects)
                                    ]
                                ]
    in
    if OneTime.isAvailable game.oneTimeStatuses effect.oneTimeStatus then
        div
            [ class "t-column gap-0"
            ]
            [ effectContent
            , div [ class "text-xs font-bold", classList [ ( "hidden", not (OneTime.isOneTime effect.oneTimeStatus) ) ] ] [ text "Unique" ]
            ]

    else
        div [] []


renderCoin : { base : Coin, percentIncrease : Percent } -> Html msg
renderCoin { base, percentIncrease } =
    let
        coin : Coin
        coin =
            Quantity.multiplyBy (Percent.toMultiplier percentIncrease) base

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


renderResource : Game -> Resource -> Int -> Html msg
renderResource game resource base =
    let
        owned : Int
        owned =
            getByResource resource game.resources

        isNegativeAmount : Bool
        isNegativeAmount =
            base < 0

        icon : Html msg
        icon =
            (getResourceStats resource).icon
                |> Icon.withSize Icon.Large
                |> Icon.toHtml
    in
    div [ class "flex items-center gap-1" ]
        [ div [ classList [ ( "text-error", isNegativeAmount ) ] ] [ text (Utils.intToString base) ]
        , icon
        , div [ classList [ ( "hidden", not isNegativeAmount || owned >= abs base ) ] ]
            [ text <| "(Owned: " ++ Utils.intToString owned ++ ")" ]
        ]


renderXp : Effect.GainXpParams -> Html msg
renderXp params =
    div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
        [ Utils.skillXpBadge params.skill
        , span [ class "font-bold col-span-4" ]
            [ Quantity.multiplyBy (Percent.toMultiplier params.percentIncrease) params.base
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
            [ Quantity.multiplyBy (Percent.toMultiplier params.percentIncrease) base
                |> Xp.toInt
                |> Utils.intToString
                |> text
            ]
        ]


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)


renderVariableResource : Percent -> Resource -> Html msg
renderVariableResource probability kind =
    let
        cappedProbability : Percent
        cappedProbability =
            Percent.capAtHundred probability

        probabilityStr : String
        probabilityStr =
            Utils.intToString (floor (Percent.toPercentage cappedProbability)) ++ "%"
    in
    div [ class "flex items-center gap-2" ]
        [ div [ class "border border-info text-info px-2 rounded-full" ] [ text probabilityStr ]
        , div [] [ text ":" ]
        , (getResourceStats kind).icon
            |> Icon.toHtml
        ]


renderMonsterPower : Int -> Html msg
renderMonsterPower strength =
    div [ class "flex items-center gap-4" ]
        [ Icon.monsterPower
            |> Icon.withSize Icon.Large
            |> Icon.toHtml
        , span [ class "text-5xl font-bold leading-none" ]
            [ text (Utils.intToString strength)
            ]
        ]
