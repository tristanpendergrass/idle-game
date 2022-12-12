module IdleGame.Views.Content exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event exposing (Event, Mod)
import IdleGame.Game exposing (Game)
import IdleGame.Timer
import IdleGame.Views.Placeholder
import IdleGame.XpFormulas
import Round
import Time exposing (Posix)
import Types exposing (..)


getActivityProgress : IdleGame.Game.ActivityStatus -> Maybe Float
getActivityProgress activityStatus =
    activityStatus
        |> Maybe.map IdleGame.Timer.percentComplete


renderContent : Game -> Html FrontendMsg
renderContent game =
    let
        skillLevel =
            game.choresXp
                |> IdleGame.XpFormulas.skillLevel
                |> String.fromInt

        skillPercent =
            IdleGame.XpFormulas.skillLevelPercent game.choresXp * 100

        masteryPercent =
            game.choresMxp
                / 4500000
                * 100

        masteryPercentLabel =
            Round.round 2 masteryPercent
    in
    div [ class "drawer-content flex flex-col items-center", attribute "style" "scroll-behavior:smooth; scroll-padding-top: 5rem" ]
        [ div [ class "sticky top-0 z-30 flex h-16 w-full justify-center bg-opacity-90 backdrop-blur transition-all duration-100 bg-base-100 text-base-content shadow-sm" ]
            -- TOP NAV
            [ nav [ class "navbar w-full bg-orange-900 " ]
                -- Menu to open sidebar
                [ div [ class "flex gap-2 lg:gap-4" ]
                    [ span [ class "tooltip tooltip-bottom before:text-xs before:content-[attr(data-tip)]", attribute "data-tip" "Menu" ]
                        [ label [ for "drawer", class "btn btn-square btn-sm  drawer-button lg:hidden" ]
                            [ FeatherIcons.menu
                                |> FeatherIcons.withSize 20
                                |> FeatherIcons.toHtml []
                            ]
                        ]

                    -- Left side stuff
                    , div [ class "flex items-center gap-2" ]
                        [ FeatherIcons.tool
                            |> FeatherIcons.withSize 24
                            |> FeatherIcons.toHtml []
                        , span [] [ text "Chores" ]
                        ]

                    -- Right side stuff
                    , div [ class "flex-1" ] []
                    ]
                ]
            ]
        , div [ class "flex flex-col items-center gap-4 p-6 pb-16 w-full max-w-[1920px] min-w-[375px]" ]
            -- Skill card
            [ div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-orange-900" ]
                [ div [ class "w-full flex flex-col gap-2" ]
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
                        [ div [ class "text-2xs font-bold" ] [ text "Mastery" ]
                        , div [ class "text-2xs flex gap-1" ] [ span [] [ text <| String.fromInt (floor game.choresMxp) ++ " / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text <| "(" ++ masteryPercentLabel ++ "%)" ] ]
                        ]
                    , div [ class "w-full flex items-center gap-2" ]
                        [ div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                            [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" ("width:" ++ String.fromFloat masteryPercent ++ "%") ] []
                            ]
                        ]
                    , div [ class "w-full flex justify-end" ]
                        [ button [ class "btn btn-xs btn-secondary" ] [ text "View Checkpoints" ] ]
                    ]
                ]

            -- Chore grid
            , div [ class "w-full grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4" ]
                (List.map (renderChoreListItem game) (IdleGame.Game.getChoreListItems game))
            ]
        ]


renderChoreListItem : Game -> IdleGame.Game.ChoresListItem -> Html FrontendMsg
renderChoreListItem game item =
    case item of
        IdleGame.Game.ChoreItem type_ ->
            renderChore game (IdleGame.Game.getChore type_)

        IdleGame.Game.LockedChore level ->
            renderLockedChore level


choreHeight : String
choreHeight =
    "h-[324px]"


renderChore : Game -> IdleGame.Game.Chore -> Html FrontendMsg
renderChore game { type_, title, xp, rewardText } =
    let
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

        onHarvestXp =
            IdleGame.Event.gainChoresXp xp

        xpMods =
            List.filter (IdleGame.Event.modAppliesToEvent onHarvestXp) allMods

        modifiedHarvestXpEvent =
            IdleGame.Event.modifyEvent xpMods onHarvestXp

        displayXp =
            case modifiedHarvestXpEvent.type_ of
                IdleGame.Event.ChoresXp amount ->
                    amount

                _ ->
                    0.0

        mastery =
            IdleGame.Game.getMastery type_ game.choresData

        mxp =
            IdleGame.Game.getMxp type_ game.choresData

        onHarvestMxp =
            IdleGame.Event.gainChoresMxp mxp type_

        mxpMods =
            List.filter (IdleGame.Event.modAppliesToEvent onHarvestMxp) allMods

        modifiedHarvestMxpEvent =
            IdleGame.Event.modifyEvent mxpMods onHarvestMxp

        displayMxp =
            case modifiedHarvestMxpEvent.type_ of
                IdleGame.Event.ChoresMxp amount _ ->
                    amount

                _ ->
                    0.0
    in
    div
        [ class "card border-t-2 border-orange-900 card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop select-none"
        , class choreHeight
        , onClick handleClick
        ]
        -- Chore image
        [ figure []
            [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24" ] ]
        , div [ class "relative card-body" ]
            [ div [ class "w-full h-full z-20 flex flex-col items-center text-center gap-4" ]
                -- Chore title
                [ h2 [ class "card-title text-lg h-[3rem]" ] [ text title ]
                , div [ class "" ] [ text rewardText ]

                -- Chore XP rewards
                , div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
                    [ div [ class "badge badge-primary badge-xs col-span-8" ] [ text "Skill XP" ]
                    , span [ class "font-bold col-span-4" ] [ text <| String.fromInt (floor displayXp) ]
                    , div [ class "badge badge-secondary badge-xs col-span-8" ] [ text "Mastery XP" ]
                    , span [ class "font-bold col-span-4" ] [ text <| String.fromInt (floor displayMxp) ]
                    ]
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
            [ div [ class "w-full h-full z-20 flex flex-col items-center text-center gap-4" ]
                -- Chore title
                [ FeatherIcons.lock
                    |> FeatherIcons.withSize 24
                    |> FeatherIcons.toHtml []
                , div [ class "text-lg font-semibold" ] [ text <| "Level " ++ String.fromInt level ]
                ]
            ]
        ]
