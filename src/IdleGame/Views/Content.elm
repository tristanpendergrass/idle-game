module IdleGame.Views.Content exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Types exposing (Model)
import IdleGame.Views.Placeholder


renderContent : Model -> Html msg
renderContent { idleGame } =
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
                        , div [ class "text-2xs" ] [ text "40 / 83 XP" ]
                        ]
                    , div [ class "w-full flex items-center gap-2" ]
                        [ div [ class "text-lg font-bold p-1 bg-primary text-primary-content rounded text-center w-10" ] [ text "1" ]
                        , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                            [ div [ class "bg-primary h-2 rounded-full", attribute "style" "width:45%" ] []
                            ]
                        ]
                    , div [ class "w-full flex items-center justify-between" ]
                        [ div [ class "text-2xs font-bold" ] [ text "Mastery" ]
                        , div [ class "text-2xs flex gap-1" ] [ span [] [ text "450,000 / 4,500,000" ], span [ class "font-bold text-secondary" ] [ text "(10%)" ] ]
                        ]
                    , div [ class "w-full flex items-center gap-2" ]
                        [ div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                            [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" "width:10%" ] []
                            ]
                        ]
                    , div [ class "w-full flex justify-end" ]
                        [ button [ class "btn btn-xs btn-secondary" ] [ text "View Checkpoints" ] ]
                    ]
                ]

            -- Chore grid
            , div [ class "w-full grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4" ]
                [ div [ class "card border-t-2 border-orange-900 card-compact bg-base-100 shadow-xl cursor-pointer clickable" ]
                    -- Chore image
                    [ figure []
                        [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24" ] ]
                    , div [ class "relative card-body" ]
                        [ div [ class "w-full h-full z-20 flex flex-col items-center text-center gap-4" ]
                            -- Chore title
                            [ h2 [ class "card-title text-lg h-[3rem]" ] [ text "Clean Stables" ]
                            , div [ class "" ] [ text "+5 gold" ]

                            -- Chore XP rewards
                            , div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
                                [ div [ class "badge badge-primary badge-xs col-span-8" ] [ text "Skill XP" ]
                                , span [ class "font-bold col-span-4" ] [ text "5" ]
                                , div [ class "badge badge-secondary badge-xs col-span-8" ] [ text "Mastery XP" ]
                                , span [ class "font-bold col-span-4" ] [ text "3" ]
                                ]
                            , div [ class "w-full flex items-center gap-2" ]
                                [ div [ class "text-2xs font-bold py-[0.35rem] w-6 leading-none bg-secondary text-secondary-content rounded text-center" ] [ text "5" ]
                                , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                                    [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" "width:45%" ] []
                                    ]
                                ]
                            ]

                        -- Chore progress bar
                        , div [ class "absolute z-10 h-full bg-base-content opacity-20 top-0 left-0 animate-progress-bar" ] []
                        ]
                    ]
                , div [ class "card card-compact border-t-2 border-orange-900 bg-base-100 shadow-xl cursor-pointer clickable" ]
                    -- Chore image
                    [ figure []
                        [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24" ] ]
                    , div [ class "relative card-body" ]
                        [ div [ class "w-full h-full z-20 flex flex-col items-center text-center gap-4" ]
                            -- Chore title
                            [ h2 [ class "card-title text-lg h-[3rem]" ] [ text "Clean Big Bubba's Stall" ]
                            , div [ class "" ] [ text "+15 gold" ]

                            -- Chore XP rewards
                            , div [ class "grid grid-cols-12 justify-items-center items-center gap-1" ]
                                [ div [ class "badge badge-primary badge-xs col-span-8" ] [ text "Skill XP" ]
                                , span [ class "font-bold col-span-4" ] [ text "10" ]
                                , div [ class "badge badge-secondary badge-xs col-span-8" ] [ text "Mastery XP" ]
                                , span [ class "font-bold col-span-4" ] [ text "1" ]
                                ]
                            , div [ class "w-full flex items-center gap-2" ]
                                [ div [ class "text-2xs font-bold py-[0.35rem] w-6 leading-none bg-secondary text-secondary-content rounded text-center" ] [ text "1" ]
                                , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                                    [ div [ class "bg-secondary h-1.5 rounded-full", attribute "style" "width:1%" ] []
                                    ]
                                ]
                            ]

                        -- Chore progress bar
                        , div [ class "absolute z-10 h-full bg-base-content opacity-20 top-0 left-0" ] []
                        ]
                    ]
                , div [ class "card card-compact bg-base-100 shadow-xl relative text-error cursor-not-allowed" ]
                    -- Chore image
                    [ figure []
                        [ IdleGame.Views.Placeholder.placeholder [ class "w-full h-24 bg-error text-error-content" ] ]
                    , div [ class "relative card-body" ]
                        [ div [ class "w-full h-full z-20 flex flex-col items-center text-center gap-4" ]
                            -- Chore title
                            [ FeatherIcons.lock
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            , div [ class "text-lg font-semibold" ] [ text "Level 50" ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
