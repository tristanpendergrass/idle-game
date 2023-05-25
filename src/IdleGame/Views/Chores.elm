module IdleGame.Views.Chores exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Chore as Chore
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event exposing (..)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Multiplicable as Multiplicable exposing (Multiplicable)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Effect
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import IdleGame.XpFormulas
import List.Extra
import Percent exposing (Percent)
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        skillLevel =
            Xp.level Xp.defaultSchedule game.choresXp
                |> Utils.intToString

        skillPercent =
            Xp.levelPercent Xp.defaultSchedule game.choresXp
                |> (*) 100

        masteryPercent =
            Xp.levelPercent Xp.defaultSchedule game.choresMxp
                |> Basics.min 100

        masteryPercentLabel =
            Utils.intToString (floor masteryPercent)
    in
    div [ class "t-column gap-4 p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-orange-900" ]
            [ div [ class "t-column" ]
                [ div [ class "w-full flex items-center justify-between" ]
                    [ div [ class "text-2xs font-bold" ] [ text "Skill level" ]
                    , div [ class "text-2xs" ]
                        [ game.choresXp
                            |> Xp.toString
                            |> text
                        ]
                    ]
                , div [ class "w-full flex items-center gap-2" ]
                    [ div [ class "text-lg font-bold p-1 bg-primary text-primary-content rounded text-center w-10" ]
                        [ text skillLevel ]
                    , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                        [ div [ class "bg-primary h-2 rounded-full", attribute "style" ("width:" ++ String.fromFloat skillPercent ++ "%") ] []
                        ]
                    ]
                , div [ class "w-full flex items-center justify-between" ]
                    [ div [ class "text-2xs font-bold" ] [ text "Mastery Pool" ]
                    , div [ class "text-2xs flex gap-1" ] [ span [] [ text <| Counter.toString game.choresMxp ++ " / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text <| "(" ++ masteryPercentLabel ++ "%)" ] ]
                    ]
                , div [ class "w-full flex items-center gap-2" ]
                    [ div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                        [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" ("width:" ++ String.fromFloat masteryPercent ++ "%") ] []
                        ]
                    ]
                , div [ class "w-full flex justify-end" ]
                    [ button [ class "btn btn-xs btn-secondary", onClick OpenMasteryCheckpointsModal ] [ text "View Checkpoints" ] ]
                ]
            ]

        -- Chore grid
        , div [ class "w-full grid grid-cols-2 md:grid-cols-3 2xl:grid-cols-4 gap-4" ]
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

        xp =
            List.Extra.findMap getChoreXp effects

        mxp =
            List.Extra.findMap (getChoreMxp game) effects

        resource =
            List.Extra.findMap getChoreResource effects

        probability =
            List.Extra.findMap getChoreProbability effects
    in
    Maybe.map5 ChoreEffectsView coin xp mxp resource probability


getChoreXp : Effect -> Maybe Counter
getChoreXp effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        GainXp quantity ChoresSkill ->
            Just (Multiplicable.toCounter quantity)

        _ ->
            Nothing


getChoreMxp : Game -> Effect -> Maybe Counter
getChoreMxp game effect =
    -- -- Important! Keep the application here in sync with Views.Chores.elm
    -- let
    --     mxp =
    --         Multiplicable.toCounter quantity
    --     masteryPoolXp =
    --         Multiplicable.toCounter quantity
    --             |> Counter.multiplyBy 0.5
    -- in
    -- game
    --     |> addMxp kind mxp
    --     |> addMasteryPoolXp masteryPoolXp
    --     |> (\newGame -> Random.constant ( newGame, [] ))
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        GainChoreMxp quantity kind ->
            let
                mxp =
                    Multiplicable.toCounter quantity

                masteryPoolXp =
                    Multiplicable.toCounter quantity
                        |> Counter.multiplyBy 0.5
            in
            Just mxp

        _ ->
            Nothing


getChoreCoin : Effect -> Maybe Counter
getChoreCoin effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        GainCoin quantity ->
            Just (Multiplicable.toCounter quantity)

        _ ->
            Nothing


getChoreResource : Effect -> Maybe Resource.Kind
getChoreResource effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        VariableSuccess { successEffects } ->
            successEffects
                |> List.Extra.findMap
                    (\innerEffect ->
                        case getType innerEffect of
                            GainResource _ kind ->
                                Just kind

                            _ ->
                                Nothing
                    )

        _ ->
            Nothing


getChoreProbability : Effect -> Maybe Float
getChoreProbability effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        VariableSuccess { successProbability } ->
            Just successProbability

        _ ->
            Nothing


renderChoreListItem : Game -> Game.ChoresListItem -> Html FrontendMsg
renderChoreListItem game item =
    case item of
        Game.ChoreItem kind ->
            let
                event : Event
                event =
                    Game.completeChoreEvent game kind

                mods : List Mod
                mods =
                    Game.getAllMods game

                moddedEvent : ModdedEvent
                moddedEvent =
                    IdleGame.Event.applyMods mods event

                effects =
                    IdleGame.Event.getEffectsModded moddedEvent
            in
            case getChoreEffectsView game effects of
                Nothing ->
                    div [] []

                Just { coin, skillXp, mxp, resource, probability } ->
                    let
                        stats =
                            Chore.getStats kind

                        moddedDuration : Duration
                        moddedDuration =
                            Game.getModdedDuration game kind

                        maybeTimer =
                            case game.activity of
                                Just (ActivityChore activeType timer) ->
                                    if kind == activeType then
                                        Just timer

                                    else
                                        Nothing

                                Nothing ->
                                    Nothing
                    in
                    renderChore
                        { kind = kind
                        , title = stats.title
                        , handleClick = ToggleActiveChore kind
                        , maybeTimer = maybeTimer
                        , duration = moddedDuration
                        , imgSrc = stats.imgSrc
                        , coin = coin
                        , extraResourceProbability = probability
                        , extraResource = resource
                        , skillXp = skillXp
                        , mxp = mxp
                        , mxpCurrentValue = (stats.getter game.choresData).mxp
                        }

        Game.LockedChore level ->
            renderLockedChore level


choreHeight : String
choreHeight =
    "h-[425px] xl:h-[405px]"


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)


type alias ChoreItemView =
    { kind : ChoreKind
    , title : String
    , handleClick : FrontendMsg
    , maybeTimer : Maybe Timer
    , duration : Duration
    , imgSrc : String
    , coin : Counter
    , extraResourceProbability : Float
    , extraResource : Resource.Kind
    , skillXp : Counter
    , mxp : Counter
    , mxpCurrentValue : Counter
    }



-- Chore title


choreImage : ChoreKind -> Html FrontendMsg
choreImage kind =
    img
        [ src <| (Chore.getStats kind).imgSrc
        , class "h-full w-full object-cover"
        ]
        []


choreTitle : ChoreKind -> Html FrontendMsg
choreTitle kind =
    h2 [ class "text-sm  md:text-lg text-center flex items-center gap-2" ]
        [ span [] [ text (Chore.getStats kind).title ]
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


renderChore : ChoreItemView -> Html FrontendMsg
renderChore { kind, title, handleClick, maybeTimer, duration, imgSrc, coin, extraResource, extraResourceProbability, skillXp, mxp, mxpCurrentValue } =
    let
        renderResource : Resource.Kind -> Html FrontendMsg
        renderResource resource =
            (Resource.getStats resource).icon
                |> Icon.toHtml

        renderSuccessCondition child =
            div [ class "flex items-center gap-2" ]
                [ div [ class "border border-info text-info px-2 rounded-full" ] [ text (Utils.intToString (probabilityToInt extraResourceProbability) ++ "%") ]
                , div [] [ text ":" ]
                , child
                ]

        renderXp =
            div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
                [ Utils.skillXpBadge
                , span [ class "font-bold col-span-4" ] [ text (Counter.toString skillXp) ]
                , Utils.masteryXpBadge
                , span [ class "font-bold col-span-4" ] [ text (Counter.toString mxp) ]
                ]

        masteryLevel =
            mxpCurrentValue
                |> Counter.getValue
                |> IdleGame.XpFormulas.skillLevel
                |> Utils.intToString

        masteryPercent =
            mxpCurrentValue
                |> Counter.getValue
                |> IdleGame.XpFormulas.skillLevelPercent
                |> (*) 100
    in
    div
        [ class "card card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none"
        , class choreHeight
        , onClick handleClick
        ]
        -- Chore image
        -- [ figure []
        --     [ img [ src imgSrc, class "w-full h-24 object-cover" ] [] ]
        [ div [ class "h-24 relative" ]
            [ choreImage kind ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column gap-2 h-full", Utils.zIndexes.cardBody ]
                -- Chore title
                [ choreTitle kind
                , choreDuration duration
                , choreCoin coin
                , renderSuccessCondition (renderResource extraResource)
                , div [ class "divider" ] []

                -- Chore XP rewards
                , renderXp
                , div [ class "w-full flex items-center gap-2" ]
                    [ div [ class "text-2xs font-bold py-[0.35rem] w-6 leading-none bg-secondary text-secondary-content rounded text-center" ] [ text <| masteryLevel ]
                    , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                        [ div
                            [ class "bg-secondary h-1.5 rounded-full"
                            , attribute "style" ("width:" ++ String.fromFloat masteryPercent ++ "%")
                            ]
                            []
                        ]
                    ]
                ]

            -- Chore progress bar
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
