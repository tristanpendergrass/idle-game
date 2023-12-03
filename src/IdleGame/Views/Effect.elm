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
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location exposing (findableResources, foundResources)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Quantity exposing (Quantity)
import Types exposing (..)


type RenderType
    = Card
    | DetailView


render : { game : Game, mods : List Mod, effect : Effect.TaggedEffect, renderType : RenderType } -> Html FrontendMsg
render { game, mods, effect, renderType } =
    Mod.applyModsToEffect mods effect
        |> Tuple.first
        |> renderModdedEffect renderType game


renderModdedEffect : RenderType -> Game -> Effect.TaggedEffect -> Html msg
renderModdedEffect renderType game effect =
    case Effect.getEffect effect of
        Effect.GainCoin coin ->
            renderCoin coin

        Effect.GainResource params ->
            renderResource game params

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

        Effect.ResolveCombat { combat, successEffects } ->
            renderCombat
                { renderType = renderType
                , combat = combat
                , successEffects = successEffects
                , game = game
                }

        Effect.Explore { location } ->
            renderExplore game location


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


renderExplore : Game -> Location -> Html msg
renderExplore game location =
    let
        locationState : Location.State
        locationState =
            getByKindLocation location game.locations

        foundResources : List Resource
        foundResources =
            Location.foundResources location locationState

        foundResourcesCount : Int
        foundResourcesCount =
            List.length foundResources
    in
    div [ class "t-column" ]
        [ div [ class "italic text-sm" ] [ text "Gather" ]
        , div [ class "grid max-w-full" ]
            (List.map
                (\resource -> (Resource.getStats resource).icon |> Icon.toHtml)
                foundResources
            )
        ]


renderResource : Game -> Effect.GainResourceParams -> Html msg
renderResource game { base, resource } =
    let
        owned : Int
        owned =
            getByKindResource resource game.resources

        isNegativeAmount : Bool
        isNegativeAmount =
            base < 0

        icon : Html msg
        icon =
            (Resource.getStats resource).icon
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


renderVariableResource : Float -> Resource -> Html msg
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


renderCombat :
    { renderType : RenderType
    , successEffects : List Effect.TaggedEffect
    , combat : Combat
    , game : Game
    }
    -> Html msg
renderCombat { renderType, successEffects, combat, game } =
    let
        monsterPower : Int
        monsterPower =
            Combat.getMonsterPower combat

        playerPower : Int
        playerPower =
            Combat.getPlayerPower combat
    in
    case renderType of
        DetailView ->
            let
                ( predictionText, predictionColorClass ) =
                    parsePrediction (Combat.getVictoryPrediction combat)
            in
            div [ class "t-column max-w-full" ]
                [ div [ class "flex items-center gap-1 max-w-full overflow-hidden text-sm" ]
                    [ span [] [ text "Victory:" ]
                    , span [ predictionColorClass ] [ text predictionText ]
                    ]
                , div [ class "flex items-center gap-1 h-24 max-w-full overflow-hidden" ]
                    [ renderMonsterPower monsterPower
                    , div [ class "divider divider-horizontal h-full text-sm" ] [ text "Vs" ]
                    , div [ class "t-column gap-0" ]
                        [ div [ class "text-2xl font-bold" ] [ text (Utils.intToString playerPower) ]
                        , div [ class "text-sm" ] [ text "Player Power" ]
                        ]
                    ]
                , div [ class "flex items-center gap-4 max-w-full overflow-hidden" ]
                    (List.map (renderModdedEffect renderType game) successEffects)
                ]

        Card ->
            div [ class "t-column max-w-full" ]
                [ div [ class "flex items-center gap-1 h-24 max-w-full overflow-hidden" ]
                    [ renderMonsterPower monsterPower ]
                , div [ class "flex items-center gap-4 max-w-full overflow-hidden" ]
                    (List.map (renderModdedEffect renderType game) successEffects)
                ]


parsePrediction : Combat.Prediction -> ( String, Attribute msg )
parsePrediction prediction =
    case prediction of
        Combat.VeryLow ->
            ( "Doubtful", class "text-error" )

        Combat.Low ->
            ( "Plausible", class "text-warning" )

        Combat.AboutEven ->
            ( "Even", class "" )

        Combat.Good ->
            ( "Hopeful", class "text-success" )

        Combat.VeryGood ->
            ( "Likely", class "text-success" )
