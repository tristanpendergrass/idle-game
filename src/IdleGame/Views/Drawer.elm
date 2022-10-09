module IdleGame.Views.Drawer exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Types exposing (Model)


renderDrawer : Model -> Html msg
renderDrawer model =
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
                    [ span [ class "flex gap-4", classList [ ( "active", model.activeTab == IdleGame.Types.Inventory ) ] ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.box
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Bag" ]
                        ]
                    ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Extracurricular" ] ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.dollarSign
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Odd Jobs" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.eye
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Exploration" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.gitlab
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Dueling" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.target
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Mischief" ]
                        ]
                    ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Classes" ] ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.cloudDrizzle
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Botany" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.droplet
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Potionmaking" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.zap
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Hexes" ]
                        ]
                    ]
                , li []
                    [ span [ class "flex gap-4" ]
                        [ span [ class "flex-none" ]
                            [ FeatherIcons.zapOff
                                |> FeatherIcons.withSize 24
                                |> FeatherIcons.toHtml []
                            ]
                        , span [ class "flex-1" ] [ text "Wards" ]
                        ]
                    ]
                ]
            ]
        ]
