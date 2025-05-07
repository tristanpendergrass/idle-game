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
import IdleGame.Mod as Mod exposing (EffectMod)
import IdleGame.OneTime as OneTime
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)
import Quantity exposing (Quantity)
import Svg.Attributes exposing (lengthAdjust)
import Types exposing (..)


type RenderType
    = Card
    | DetailView


render : { game : Game, effect : Effect, renderType : RenderType } -> Html FrontendMsg
render { game, effect, renderType } =
    renderModdedEffect renderType game effect
        |> Maybe.withDefault (div [] [])


renderModdedEffect : RenderType -> Game -> Effect -> Maybe (Html msg)
renderModdedEffect renderType game effect =
    let
        maybeEffectContent : Maybe (Html msg)
        maybeEffectContent =
            case Effect.getEffectType effect of
                Effect.NoOp ->
                    Nothing

                Effect.OneOf firstEffect restEffects ->
                    let
                        effects : List Effect
                        effects =
                            firstEffect :: restEffects

                        renderedEffects : List (Html msg)
                        renderedEffects =
                            List.filterMap (renderModdedEffect renderType game) effects
                    in
                    if List.isEmpty renderedEffects then
                        Nothing

                    else
                        Just
                            (div [ IdleGame.Views.Utils.classes.column, class "gap-2" ]
                                (div [] [ text "one of" ]
                                    :: renderedEffects
                                )
                            )

                Effect.GainCoin coin ->
                    Just (renderCoin coin)

                Effect.GainResource params ->
                    Just (renderResource game params.resource params.base { showTitle = renderType == DetailView, showTooltip = renderType == Card })

                Effect.SpendResource params ->
                    Just (renderResource game params.resource (-1 * params.base) { showTitle = renderType == DetailView, showTooltip = renderType == Card })

                Effect.GainXp params ->
                    Just (renderXp params)

                Effect.GainMxp params ->
                    Just (renderMxp game params)

                Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
                    case successEffects of
                        [] ->
                            Nothing

                        effects ->
                            let
                                effectsToDisplay : List Effect
                                effectsToDisplay =
                                    List.filter (\e -> OneTime.isAvailable game.oneTimeStatuses e.oneTimeStatus) effects
                            in
                            case effectsToDisplay of
                                [] ->
                                    Nothing

                                nonEmptyEffects ->
                                    let
                                        renderedEffects : List (Html msg)
                                        renderedEffects =
                                            List.filterMap (renderModdedEffect renderType game) nonEmptyEffects
                                    in
                                    if List.isEmpty renderedEffects then
                                        Nothing

                                    else
                                        Just
                                            (div [ class "flex rounded overflow-hidden relative" ]
                                                [ div []
                                                    [ div [ class "h-full flex items-center bg-info text-info-content p-2 border-2 border-r-0 border-info" ]
                                                        [ text (IdleGame.Views.Utils.percentToString successProbability)
                                                        ]
                                                    ]
                                                , div [ class "p-2 border border-content border-dashed border-l-0 border-tr-rounded border-br-rounded" ]
                                                    [ div [ IdleGame.Views.Utils.classes.column, class "gap-2" ] renderedEffects
                                                    ]
                                                ]
                                            )
    in
    if OneTime.isAvailable game.oneTimeStatuses effect.oneTimeStatus then
        maybeEffectContent
            |> Maybe.map
                (\effectContent ->
                    div
                        [ IdleGame.Views.Utils.classes.column, class "gap-0" ]
                        [ effectContent
                        , div [ class "text-xs font-bold", classList [ ( "hidden", not (OneTime.isOneTime effect.oneTimeStatus) ) ] ] [ text "[Unique]" ]
                        ]
                )

    else
        Nothing


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
                |> IdleGame.Views.Utils.intToString
                |> text
            ]
        , Icon.coin
            |> Icon.toHtml
        ]


renderResource : Game -> Resource -> Int -> { showTitle : Bool, showTooltip : Bool } -> Html msg
renderResource game resource base { showTitle, showTooltip } =
    let
        owned : Int
        owned =
            getByResource resource game.resources

        isNegativeAmount : Bool
        isNegativeAmount =
            base < 0

        stats : ResourceStats
        stats =
            getResourceStats resource

        iconLg : Html msg
        iconLg =
            stats.icon
                |> Icon.withSize Icon.Large
                |> Icon.toHtml

        iconSm : Html msg
        iconSm =
            stats.icon
                |> Icon.withSize Icon.Medium
                |> Icon.toHtml

        iconWrapper : List (Attribute msg)
        iconWrapper =
            List.concat
                [ [ class "flex items-center" ]
                , if showTooltip then
                    [ class "tooltip", attribute "data-tip" stats.title ]

                  else
                    []
                ]
    in
    div [ class "flex items-center gap-1" ]
        [ div [ classList [ ( "text-error", isNegativeAmount ) ] ] [ text (IdleGame.Views.Utils.intToString base) ]
        , div (iconWrapper ++ [ class "md:hidden" ]) [ iconSm ]
        , div (iconWrapper ++ [ class "hidden md:inline-block" ]) [ iconLg ]
        , div [ classList [ ( "hidden", not showTitle ) ] ] [ text stats.title ]
        , div [ classList [ ( "hidden", not isNegativeAmount || owned >= abs base ) ] ]
            [ text <| "(Owned: " ++ IdleGame.Views.Utils.intToString owned ++ ")" ]
        ]


renderXp : Effect.GainXpParams -> Html msg
renderXp params =
    div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
        [ IdleGame.Views.Utils.skillXpBadge params.skill
        , span [ class "font-bold col-span-4" ]
            [ Quantity.multiplyBy (Percent.toMultiplier params.percentIncrease) params.base
                |> Xp.toInt
                |> IdleGame.Views.Utils.intToString
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
        [ IdleGame.Views.Utils.masteryXpBadge
        , span [ class "font-bold col-span-4" ]
            [ Quantity.multiplyBy (Percent.toMultiplier params.percentIncrease) base
                |> Xp.toInt
                |> IdleGame.Views.Utils.intToString
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
            IdleGame.Views.Utils.intToString (floor (Percent.toPercentage cappedProbability)) ++ "%"
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
            [ text (IdleGame.Views.Utils.intToString strength)
            ]
        ]
