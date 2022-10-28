module IdleGame.Views.Content exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import IdleGame.Timer
import IdleGame.Types exposing (..)
import IdleGame.Views.Placeholder
import Round
import Time exposing (Posix)


skillLevelFromXp : Float -> Int
skillLevelFromXp xp =
    floor xp // 100 + 1


skillLevelPercentFromXp : Float -> Float
skillLevelPercentFromXp xp =
    xp
        |> floor
        |> remainderBy 100
        |> toFloat


masteryLevelFromXp : Float -> Int
masteryLevelFromXp xp =
    floor xp // 10 + 1


masteryLevelPercentFromXp : Float -> Float
masteryLevelPercentFromXp xp =
    xp
        |> floor
        |> remainderBy 10
        |> toFloat


getActivityProgress : Posix -> IdleGame.Game.ActivityStatus -> Maybe Float
getActivityProgress now activityStatus =
    activityStatus
        |> Maybe.map
            (\timer ->
                IdleGame.Timer.percentComplete now timer
            )


renderContent : Model -> Html Msg
renderContent model =
    let
        game =
            model.game

        skillLevel =
            game.woodcuttingXp
                |> skillLevelFromXp
                |> String.fromInt

        skillPercent =
            skillLevelPercentFromXp game.woodcuttingXp

        masteryPercent =
            game.woodcuttingMxp
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
                        , span [] [ text "Woodcutting" ]
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
                        , div [ class "text-2xs" ] [ text <| String.fromInt (floor game.woodcuttingXp) ]
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
                        , div [ class "text-2xs flex gap-1" ] [ span [] [ text <| String.fromInt (floor game.woodcuttingMxp) ++ " / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text <| "(" ++ masteryPercentLabel ++ "%)" ] ]
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

            -- Woodcutting grid
            , div [ class "w-full grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4" ]
                ([]
                    ++ List.map (renderWoodcutting model) game.trees
                    ++ [ renderLockedWoodcutting ]
                )
            ]
        ]


woodcuttingHeight : String
woodcuttingHeight =
    "h-[324px]"


renderWoodcutting : Model -> IdleGame.Game.Tree -> Html Msg
renderWoodcutting model (IdleGame.Game.Tree id treeData activityStatus) =
    let
        game =
            model.game

        handleClick =
            IdleGame.Types.ToggleActiveTree id
                |> IdleGame.Types.WithTime
    in
    div
        [ class "card border-t-2 border-orange-900 card-compact bg-base-100 shadow-xl cursor-pointer bubble-pop"
        , class woodcuttingHeight
        , onClick handleClick
        ]
        -- Woodcutting image
        [ figure []
            [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24" ] ]
        , div [ class "relative card-body" ]
            [ div [ class "w-full h-full z-20 flex flex-col items-center text-center gap-4" ]
                -- Woodcutting title
                [ h2 [ class "card-title text-lg h-[3rem]" ] [ text treeData.title ]
                , div [ class "" ] [ text treeData.rewardText ]

                -- Woodcutting XP rewards
                , div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
                    [ div [ class "badge badge-primary badge-xs col-span-8" ] [ text "Skill XP" ]
                    , span [ class "font-bold col-span-4" ] [ text <| String.fromInt (floor treeData.xpGranted) ]
                    , div [ class "badge badge-secondary badge-xs col-span-8" ] [ text "Mastery XP" ]
                    , span [ class "font-bold col-span-4" ] [ text <| String.fromInt (floor treeData.mxpGranted) ]
                    ]
                , div [ class "w-full flex items-center gap-2" ]
                    [ div [ class "text-2xs font-bold py-[0.35rem] w-6 leading-none bg-secondary text-secondary-content rounded text-center" ] [ text <| String.fromInt (masteryLevelFromXp treeData.mxp) ]
                    , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                        [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" ("width:" ++ String.fromFloat (masteryLevelPercentFromXp treeData.mxp) ++ "%") ] []
                        ]
                    ]
                ]

            -- Woodcutting progress bar
            , case getActivityProgress game.currentTime activityStatus of
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


renderLockedWoodcutting : Html Msg
renderLockedWoodcutting =
    div
        [ class "card card-compact bg-base-100 shadow-xl relative text-error cursor-pointer bubble-shake"
        , class woodcuttingHeight
        ]
        -- Woodcutting image
        [ figure []
            [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24 bg-error text-error-content" ] ]
        , div [ class "relative card-body" ]
            [ div [ class "w-full h-full z-20 flex flex-col items-center text-center gap-4" ]
                -- Woodcutting title
                [ FeatherIcons.lock
                    |> FeatherIcons.withSize 24
                    |> FeatherIcons.toHtml []
                , div [ class "text-lg font-semibold" ] [ text "Level 50" ]
                ]
            ]
        ]
