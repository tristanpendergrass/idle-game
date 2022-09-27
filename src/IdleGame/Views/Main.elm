module IdleGame.Views.Main exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


renderMain : Html msg
renderMain =
    div [ class "bg-base-100 drawer drawer-mobile" ]
        [ input [ id "drawer", type_ "checkbox", class "drawer-toggle" ] []
        , renderContent
        , renderDrawer
        ]


renderDrawer : Html msg
renderDrawer =
    div [ class "drawer-side", attribute "style" "scroll-behavior:smooth; scroll-padding-top:5rem" ]
        [ label [ for "drawer", class "drawer-overlay" ] []
        , aside [ class "bg-base-200 w-80" ]
            -- title row
            [ div [ class "bg-base-200 sticky top-0 w-full bg-opacity-90 py-3 px-2 backdrop-blur flex" ]
                [ div [ class "flex-1 flex items-center gap-2" ]
                    [ div [ class "flex-0 px-2" ]
                        [ div [ class "font-title text-primary inline-flex text-lg transition-all duration-200 md:text-3xl" ]
                            [ span [ class "lowercase text-primary" ] [ text "elm" ]
                            , span [ class "uppercase text-base-content" ] [ text "idle" ]
                            ]
                        ]
                    , a [ href "/", class "link link-hover font-mono text-xs text-opacity-50 " ]
                        [ div [ class "tooltip tooltip-bottom", attribute "data-tip" "Patch notes" ]
                            [ text "0.0.1" ]
                        ]
                    ]

                -- Close drawer button
                , label [ for "drawer", class "btn btn-square btn-ghost drawer-button lg:hidden" ]
                    [ FeatherIcons.x
                        |> FeatherIcons.withSize 20
                        |> FeatherIcons.toHtml []
                    ]
                ]
            , div [ class "h-4" ] []
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.box
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Inventory" ]
                        ]
                    ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.lifeBuoy
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Mining" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.paperclip
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Smithing" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.sunrise
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Meditation" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.gitlab
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Combat" ]
                        ]
                    ]
                ]
            ]
        ]


renderContent : Html msg
renderContent =
    div [ class "drawer-content", attribute "style" "scroll-behavior:smooth; scroll-padding-top: 5rem" ]
        [ div [ class "sticky top-0 z-30 flex h-16 w-full justify-center bg-opacity-90 backdrop-blur transition-all duration-100 bg-base-100 text-base-content" ]
            [ nav [ class "navbar w-full" ]
                -- Menu to open sidebar
                [ div [ class "flex md:gap-1 lg-gap-2" ]
                    [ span [ class "tooltip tooltip-bottom before:text-xs before:content-[attr(data-tip)]", attribute "data-tip" "Menu" ]
                        [ label [ for "drawer", class "btn btn-square btn-ghost drawer-button lg:hidden" ]
                            [ FeatherIcons.menu
                                |> FeatherIcons.withSize 20
                                |> FeatherIcons.toHtml []
                            ]
                        ]

                    -- Left side stuff
                    , div [ class "flex items-center gap-2" ]
                        []

                    -- Right side stuff
                    , div [ class "flex-1" ] []
                    ]
                ]
            ]
        ]
