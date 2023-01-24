module IdleGame.Views.Chores exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event3 exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes
import IdleGame.Resource as Resource exposing (Resource)
import IdleGame.Timer
import IdleGame.Views.Placeholder
import IdleGame.XpFormulas
import List.Extra
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    let
        skillLevel =
            game.choresXp
                |> IdleGame.XpFormulas.skillLevel
                |> String.fromInt

        skillPercent =
            IdleGame.XpFormulas.skillLevelPercent game.choresXp * 100

        masteryPercent =
            IdleGame.XpFormulas.masteryPoolPercent game.choresMxp
                |> Basics.min 100

        masteryPercentLabel =
            String.fromInt (floor masteryPercent)
    in
    div [ class "t-column gap-4 p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-orange-900" ]
            [ div [ class "t-column" ]
                [ div [ class "w-full flex items-center justify-between" ]
                    [ div [ class "text-2xs font-bold" ] [ text "Skill level" ]
                    , div [ class "text-2xs" ] [ text <| String.fromInt (floor game.choresXp) ]
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
                    , div [ class "text-2xs flex gap-1" ] [ span [] [ text <| String.fromInt (floor game.choresMxp) ++ " / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text <| "(" ++ masteryPercentLabel ++ "%)" ] ]
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


renderChoreListItem : Game -> IdleGame.Game.ChoresListItem -> Html FrontendMsg
renderChoreListItem game item =
    case item of
        IdleGame.Game.ChoreItem type_ ->
            renderChore game (IdleGame.Game.getChore type_)

        IdleGame.Game.LockedChore level ->
            renderLockedChore level


getChoresSkillXp : Effect -> Maybe Float
getChoresSkillXp effect =
    case getType effect of
        GainXp { base, multiplier } ChoresSkill ->
            Just (base * multiplier)

        _ ->
            Nothing


getChoreMxp : IdleGame.GameTypes.ChoreType -> IdleGame.Game.ChoresData -> Effect -> Maybe Float
getChoreMxp choreType choresData effect =
    case getType effect of
        GainChoreMxp { multiplier } t ->
            if t == choreType then
                let
                    base =
                        IdleGame.Game.getMxp choreType choresData
                in
                Just (base * multiplier)

            else
                Nothing

        _ ->
            Nothing


choreHeight : String
choreHeight =
    "h-[390px]"


renderChoreXpReward : Game -> IdleGame.GameTypes.ChoreType -> ModdedEvent -> Html FrontendMsg
renderChoreXpReward game choreType (ModdedEvent eventData) =
    let
        skillXpLabel =
            case List.Extra.findMap getChoresSkillXp eventData.effects of
                Just skillXp ->
                    String.fromInt (floor skillXp)

                Nothing ->
                    "N/A"

        mxpLabel =
            case List.Extra.findMap (getChoreMxp choreType game.choresData) eventData.effects of
                Just skillXp ->
                    String.fromInt (floor skillXp)

                Nothing ->
                    "N/A"
    in
    div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
        [ div [ class "badge badge-primary badge-xs col-span-8" ] [ text "Skill XP" ]
        , span [ class "font-bold col-span-4" ] [ text skillXpLabel ]
        , div [ class "badge badge-secondary badge-xs col-span-8" ] [ text "Mastery XP" ]
        , span [ class "font-bold col-span-4" ] [ text mxpLabel ]
        ]


probabilityToInt : Float -> Int
probabilityToInt x =
    floor (x * 100)


renderChore : Game -> IdleGame.Game.Chore -> Html FrontendMsg
renderChore game chore =
    let
        { type_, title, outcome } =
            chore

        handleClick =
            ToggleActiveChore type_

        maybeTimer =
            case game.activeChore of
                Just ( activeType, timer ) ->
                    if type_ == activeType then
                        Just timer

                    else
                        Nothing

                Nothing ->
                    Nothing

        allMods =
            IdleGame.Game.getAllMods game

        moddedEvent : ModdedEvent
        moddedEvent =
            IdleGame.Game.getEvent chore
                |> IdleGame.Event3.applyModsToEvent allMods

        mastery =
            IdleGame.Game.getMastery type_ game.choresData

        renderGold amount =
            div [ class "flex items-center gap-1" ]
                [ div [ class "flex items-center gap-1" ]
                    [ span [] [ text ("+" ++ String.fromInt amount) ]
                    , span [ class "font-semibold" ] [ text "Gold" ]
                    ]
                ]

        renderResource amount resource =
            div [ class "flex items-center gap-1" ]
                [ span [] [ text ("+" ++ String.fromInt amount) ]
                , span [ class "font-semibold" ] [ text resource ]
                ]

        renderSuccessCondition probability child =
            div [ class "flex items-center gap-1" ]
                [ div [ class "border border-info text-info px-2 rounded-full" ] [ text (String.fromInt probability ++ "%") ]
                , div [] [ text ":" ]
                , child
                ]
    in
    div
        [ class "card border-t-2 border-orange-900 card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none"
        , class choreHeight
        , onClick handleClick
        ]
        -- Chore image
        [ figure []
            [ img [ src chore.imgSrc, class "w-full h-24 object-cover" ] [] ]

        -- [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24" ] ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column h-full z-20" ]
                -- Chore title
                [ h2 [ class "card-title text-lg text-center h-[3rem]" ] [ text title ]
                , renderGold chore.outcome.gold
                , renderSuccessCondition (probabilityToInt chore.outcome.extraResourceProbability) (renderResource 1 (Resource.toString outcome.extraResource))
                , div [ class "divider" ] []

                -- Chore XP rewards
                , renderChoreXpReward game chore.type_ moddedEvent
                , div [ class "w-full flex items-center gap-2" ]
                    [ div [ class "text-2xs font-bold py-[0.35rem] w-6 leading-none bg-secondary text-secondary-content rounded text-center" ] [ text <| String.fromInt (IdleGame.XpFormulas.skillLevel mastery) ]
                    , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                        [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" ("width:" ++ String.fromFloat (IdleGame.XpFormulas.skillLevelPercent mastery * 100) ++ "%") ] []
                        ]
                    ]
                ]

            -- Chore progress bar
            , case Maybe.map IdleGame.Timer.percentComplete maybeTimer of
                Nothing ->
                    div [] []

                Just percentComplete ->
                    div
                        [ class "absolute z-10 h-full bg-base-content opacity-20 top-0 left-0 "
                        , attribute "style" ("width:" ++ String.fromFloat percentComplete ++ "%")
                        ]
                        []
            ]
        ]


renderLockedChore : Int -> Html FrontendMsg
renderLockedChore level =
    div
        [ class "card card-compact bg-base-100 shadow-xl relative text-error cursor-pointer bubble-shake"
        , class choreHeight
        ]
        -- Chore image
        [ figure []
            [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24 bg-error text-error-content" ] ]
        , div [ class "relative card-body" ]
            [ div [ class "t-column h-full z-20 gap-4" ]
                -- Chore title
                [ FeatherIcons.lock
                    |> FeatherIcons.withSize 24
                    |> FeatherIcons.toHtml []
                , div [ class "text-lg font-semibold" ] [ text <| "Level " ++ String.fromInt level ]
                ]
            ]
        ]


renderBottomRight : Html FrontendMsg
renderBottomRight =
    div [ class "absolute bottom-[2rem] right-[2rem]" ]
        [ button [ class "btn btn-secondary uppercase", onClick OpenMasteryUnlocksModal ] [ text "m" ]
        ]
