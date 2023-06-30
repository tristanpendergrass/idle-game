module IdleGame.Views.Chores exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Chore as Chore
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event as Event exposing (Effect, Event)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Multiplicable as Multiplicable exposing (Multiplicable)
import IdleGame.Resource as Resource
import IdleGame.Skill exposing (Kind(..))
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)
import Quantity
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    div [ Utils.skills.wrapper ]
        [ Utils.xpSection game.xp.chores
        , div [ Utils.skills.grid ]
            (List.map (renderChoreListItem game) (Game.getChoreListItems game))
        ]


type alias ChoreEffectsView =
    { coin : Counter, skillXp : Xp, mxp : Xp, resource : Resource.Kind, probability : Float }


getChoreEffectsView : Game -> List Effect -> Maybe ChoreEffectsView
getChoreEffectsView game effects =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    let
        coin =
            List.Extra.findMap getChoreCoin effects

        xp : Maybe Xp
        xp =
            List.Extra.findMap getChoreXp effects

        mxp : Maybe Xp
        mxp =
            List.Extra.findMap (getChoreMxp game) effects

        resource =
            List.Extra.findMap getChoreResource effects

        probability =
            List.Extra.findMap getChoreProbability effects
    in
    Maybe.map5 ChoreEffectsView coin xp mxp resource probability


getChoreXp : Effect -> Maybe Xp
getChoreXp effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case Event.getType effect of
        Event.GainXp amount Chores ->
            Just (Quantity.multiplyBy amount.multiplier amount.base)

        _ ->
            Nothing


getChoreMxp : Game -> Effect -> Maybe Xp
getChoreMxp game effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case Event.getType effect of
        Event.GainMxp amount kind ->
            let
                base : Xp
                base =
                    Game.calculateActivityMxp kind game

                mxp : Xp
                mxp =
                    Quantity.multiplyBy amount.multiplier base
            in
            Just mxp

        _ ->
            Nothing


getChoreCoin : Effect -> Maybe Counter
getChoreCoin effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case Event.getType effect of
        Event.GainCoin quantity ->
            Just (Multiplicable.toCounter quantity)

        _ ->
            Nothing


getChoreResource : Effect -> Maybe Resource.Kind
getChoreResource effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case Event.getType effect of
        Event.VariableSuccess { successEffects } ->
            successEffects
                |> List.Extra.findMap
                    (\innerEffect ->
                        case Event.getType innerEffect of
                            Event.GainResource _ kind ->
                                Just kind

                            _ ->
                                Nothing
                    )

        _ ->
            Nothing


getChoreProbability : Effect -> Maybe Float
getChoreProbability effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case Event.getType effect of
        Event.VariableSuccess { successProbability } ->
            Just successProbability

        _ ->
            Nothing


renderChoreListItem : Game -> Game.ActivityListItem -> Html FrontendMsg
renderChoreListItem game item =
    case item of
        Game.ActivityListItem activity ->
            renderActivity activity game

        Game.LockedActivity level ->
            renderLockedChore level


choreHeight : String
choreHeight =
    "h-[425px] xl:h-[405px]"


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)



-- Chore title


activityImage : Activity -> Html FrontendMsg
activityImage kind =
    img
        [ src <| (Activity.getStats kind).imgSrc
        , class "h-full w-full object-cover"
        ]
        []


choreTitle : Activity -> Html FrontendMsg
choreTitle kind =
    h2 [ class "text-sm  md:text-lg text-center flex items-center gap-2" ]
        [ span [] [ text (Activity.getStats kind).title ]
        ]


choreDuration : Duration -> Html msg
choreDuration duration =
    div [ class "text-2xs" ] [ text <| Utils.floatToString 1 (Duration.inSeconds duration) ++ " seconds" ]


choreCoin : Counter -> Html msg
choreCoin coin =
    div [ class "flex items-center gap-1" ]
        [ div [ class "flex items-center gap-1" ]
            [ span [] [ text (Counter.toString coin) ]
            , Icon.coin
                |> Icon.toHtml
            ]
        ]


renderActivity : Activity -> Game -> Html FrontendMsg
renderActivity activity game =
    -- Similar to renderContent
    let
        maybeTimer : Maybe Timer
        maybeTimer =
            game.activity
                |> Maybe.andThen
                    (\( activeType, timer ) ->
                        if activity == activeType then
                            Just timer

                        else
                            Nothing
                    )

        stats : Activity.Stats
        stats =
            Activity.getStats activity

        event : Event
        event =
            stats.event

        mods : List Event.Mod
        mods =
            Game.getAllMods game

        effects : List Event.Effect
        effects =
            Event.getEffects event

        orderedEffects : List Event.Effect
        orderedEffects =
            List.sortWith Event.orderEffects effects

        duration : Duration
        duration =
            Game.getModdedDuration game activity
    in
    div
        [ class "card card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none"
        , onClick (HandleActivityClick activity)

        -- div
        --     [ class "t-column w-full h-full overflow-y-auto p-3 relative gap-4 bg-base-300"
        ]
        [ -- preview image
          div [ class "h-24 relative" ]
            [ activityImage activity ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column gap-2 h-full", Utils.zIndexes.cardBody ]
                -- Chore title
                ([ choreTitle activity
                 , choreDuration duration
                 ]
                    ++ List.map (EffectView.render game mods) orderedEffects
                )
            ]

        -- Progress bar
        , case Maybe.map Timer.percentComplete maybeTimer of
            Nothing ->
                div [] []

            Just percentComplete ->
                div
                    [ class "absolute h-full bg-base-content opacity-20 top-0 left-0"
                    , Utils.zIndexes.activityProgressBar
                    , attribute "style" ("width:" ++ String.fromFloat (Percent.toPercentage percentComplete) ++ "%")
                    ]
                    []
        ]


renderLockedChore : Int -> Html FrontendMsg
renderLockedChore level =
    div
        [ class "card card-compact bg-base-100 shadow-xl relative text-error cursor-pointer"

        -- Bring this back when we figure out how to solve the problem where the shake happens on every page render?
        -- , class "bubble-shake"
        , class choreHeight
        ]
        -- Chore image
        [ figure []
            [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24 bg-error text-error-content" ] ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column h-full gap-4", Utils.zIndexes.cardBody ]
                -- Chore title
                [ FeatherIcons.lock
                    |> FeatherIcons.withSize 24
                    |> FeatherIcons.toHtml []
                , div [ class "text-lg font-semibold" ] [ text <| "Level " ++ Utils.intToString level ]
                ]
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    button [ class "btn btn-square btn-secondary uppercase", onClick OpenMasteryUnlocksModal ] [ text "m" ]
