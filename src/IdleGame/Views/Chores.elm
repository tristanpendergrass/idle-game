module IdleGame.Views.Chores exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Chore as Chore
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game, getChoreListItems)
import IdleGame.GameTypes exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon as Icon
import IdleGame.Views.Placeholder
import IdleGame.Views.Utils
import IdleGame.XpFormulas
import List.Extra
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        skillLevel =
            game.choresXp
                |> IdleGame.XpFormulas.skillLevel
                |> IdleGame.Views.Utils.intToString

        skillPercent =
            IdleGame.XpFormulas.skillLevelPercent game.choresXp * 100

        masteryPercent =
            IdleGame.XpFormulas.masteryPoolPercent game.choresMxp
                |> Basics.min 100

        masteryPercentLabel =
            IdleGame.Views.Utils.intToString (floor masteryPercent)
    in
    div [ class "t-column gap-4 p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-orange-900" ]
            [ div [ class "t-column" ]
                [ div [ class "w-full flex items-center justify-between" ]
                    [ div [ class "text-2xs font-bold" ] [ text "Skill level" ]
                    , div [ class "text-2xs" ] [ text <| IdleGame.Views.Utils.intToString (floor game.choresXp) ]
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
                    , div [ class "text-2xs flex gap-1" ] [ span [] [ text <| IdleGame.Views.Utils.intToString (floor game.choresMxp) ++ " / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text <| "(" ++ masteryPercentLabel ++ "%)" ] ]
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
            (List.map (renderChoreListItem game) (IdleGame.Game.getChoreListItems game))
        ]


type alias ChoreEffectsView =
    { gold : Int, skillXp : Float, mxp : Float, resource : Resource.Kind, probability : Float }


getChoreEfffectsView : Game -> List Effect -> Maybe ChoreEffectsView
getChoreEfffectsView game effects =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    let
        gold =
            List.Extra.findMap getChoreGold effects

        xp =
            List.Extra.findMap getChoreXp effects

        mxp =
            List.Extra.findMap (getChoreMxp game) effects

        resource =
            List.Extra.findMap getChoreResource effects

        probability =
            List.Extra.findMap getChoreProbability effects
    in
    Maybe.map5 ChoreEffectsView gold xp mxp resource probability


getChoreXp : Effect -> Maybe Float
getChoreXp effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        GainXp { base, multiplier } ChoresSkill ->
            Just (base * multiplier)

        _ ->
            Nothing


getChoreMxp : Game -> Effect -> Maybe Float
getChoreMxp game effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        GainChoreMxp { multiplier } kind ->
            let
                choreStats =
                    Chore.getStats kind

                { mxp } =
                    choreStats.getter game.choresData

                currentMasteryLevel =
                    IdleGame.XpFormulas.skillLevel mxp

                grantedMxp =
                    toFloat currentMasteryLevel
                        * (choreStats.outcome.duration / 1000)
                        * multiplier
            in
            Just grantedMxp

        _ ->
            Nothing


getChoreGold : Effect -> Maybe Int
getChoreGold effect =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    case getType effect of
        GainGold { base } ->
            Just base

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


getModdedDuration : Game -> ChoreKind -> Float
getModdedDuration game choreKind =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    let
        stats =
            Chore.getStats choreKind

        mods =
            IdleGame.Game.getAllIntervalMods game
                |> List.filter (\{ kind } -> kind == choreKind)

        choreDuration =
            stats.outcome.duration
                |> IdleGame.Game.applyIntervalMods mods
    in
    choreDuration


renderChoreListItem : Game -> IdleGame.Game.ChoresListItem -> Html FrontendMsg
renderChoreListItem game item =
    case item of
        IdleGame.Game.ChoreItem kind ->
            let
                stats =
                    Chore.getStats kind

                moddedEvent : ModdedEvent
                moddedEvent =
                    IdleGame.Game.getEvent stats
                        |> IdleGame.Event.applyModsToEvent (IdleGame.Game.getAllMods game)

                effects =
                    case moddedEvent of
                        IdleGame.Event.ModdedEvent eventData ->
                            eventData.effects

                maybeTimer =
                    case game.activeChore of
                        Just ( activeType, timer ) ->
                            if kind == activeType then
                                Just timer

                            else
                                Nothing

                        Nothing ->
                            Nothing

                moddedDuration : Float
                moddedDuration =
                    getModdedDuration game kind
            in
            case getChoreEfffectsView game effects of
                Nothing ->
                    div [] []

                Just { gold, skillXp, mxp, resource, probability } ->
                    renderChore
                        { title = stats.title
                        , handleClick = ToggleActiveChore kind
                        , maybeTimer = maybeTimer
                        , duration = moddedDuration
                        , imgSrc = stats.imgSrc
                        , gold = gold
                        , extraResourceProbability = probability
                        , extraResource = resource
                        , skillXp = skillXp
                        , mxp = mxp
                        , mxpCurrentValue = (stats.getter game.choresData).mxp
                        }

        IdleGame.Game.LockedChore level ->
            renderLockedChore level


choreHeight : String
choreHeight =
    "h-[425px] xl:h-[405px]"


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)


type alias ChoreItemView =
    { title : String
    , handleClick : FrontendMsg
    , maybeTimer : Maybe Timer
    , duration : Float
    , imgSrc : String
    , gold : Int
    , extraResourceProbability : Float
    , extraResource : Resource.Kind
    , skillXp : Float
    , mxp : Float
    , mxpCurrentValue : Float
    }


renderChore : ChoreItemView -> Html FrontendMsg
renderChore { title, handleClick, maybeTimer, duration, imgSrc, gold, extraResource, extraResourceProbability, skillXp, mxp, mxpCurrentValue } =
    let
        renderDuration : Html msg
        renderDuration =
            div [ class "text-2xs" ] [ text <| IdleGame.Views.Utils.floatToString (duration / 1000) ++ " seconds" ]

        renderGold =
            div [ class "flex items-center gap-1" ]
                [ div [ class "flex items-center gap-1" ]
                    [ span [] [ text (IdleGame.Views.Utils.intToString gold) ]
                    , Icon.gold
                        |> Icon.toHtml
                    ]
                ]

        renderResource : Resource.Kind -> Html FrontendMsg
        renderResource resource =
            (Resource.getStats resource).icon
                |> Icon.toHtml

        renderSuccessCondition child =
            div [ class "flex items-center gap-2" ]
                [ div [ class "border border-info text-info px-2 rounded-full" ] [ text (IdleGame.Views.Utils.intToString (probabilityToInt extraResourceProbability) ++ "%") ]
                , div [] [ text ":" ]
                , child
                ]

        renderXp =
            div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
                [ IdleGame.Views.Utils.skillXpBadge
                , span [ class "font-bold col-span-4" ] [ text (IdleGame.Views.Utils.intToString (floor skillXp)) ]
                , IdleGame.Views.Utils.masteryXpBadge
                , span [ class "font-bold col-span-4" ] [ text (IdleGame.Views.Utils.intToString (floor mxp)) ]
                ]
    in
    div
        [ class "card border-t-2 border-orange-900 card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none"
        , class choreHeight
        , onClick handleClick
        ]
        -- Chore image
        [ figure []
            [ img [ src imgSrc, class "w-full h-24 object-cover" ] [] ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column gap-2 h-full z-9", IdleGame.Views.Utils.zIndexes.cardBody ]
                -- Chore title
                [ h2 [ class "text-sm  md:text-lg text-center" ] [ text title ]
                , renderDuration
                , renderGold
                , renderSuccessCondition (renderResource extraResource)
                , div [ class "divider" ] []

                -- Chore XP rewards
                , renderXp
                , div [ class "w-full flex items-center gap-2" ]
                    [ div [ class "text-2xs font-bold py-[0.35rem] w-6 leading-none bg-secondary text-secondary-content rounded text-center" ] [ text <| IdleGame.Views.Utils.intToString (IdleGame.XpFormulas.skillLevel mxp) ]
                    , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                        [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" ("width:" ++ String.fromFloat (IdleGame.XpFormulas.skillLevelPercent mxpCurrentValue * 100) ++ "%") ] []
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
                        , IdleGame.Views.Utils.zIndexes.activityProgressBar
                        , attribute "style" ("width:" ++ String.fromFloat percentComplete ++ "%")
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
            [ div [ class "t-column h-full gap-4", IdleGame.Views.Utils.zIndexes.cardBody ]
                -- Chore title
                [ FeatherIcons.lock
                    |> FeatherIcons.withSize 24
                    |> FeatherIcons.toHtml []
                , div [ class "text-lg font-semibold" ] [ text <| "Level " ++ IdleGame.Views.Utils.intToString level ]
                ]
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [ class "absolute bottom-[2rem] right-[2rem]", IdleGame.Views.Utils.zIndexes.bottomRightMenu ]
        [ button [ class "btn btn-secondary uppercase", onClick OpenMasteryUnlocksModal ] [ text "m" ]
        ]
