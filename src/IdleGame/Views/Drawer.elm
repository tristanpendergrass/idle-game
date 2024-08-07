module IdleGame.Views.Drawer exposing (..)

import Config
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import Types exposing (..)


renderDrawer : Bool -> Tab -> Html FrontendMsg
renderDrawer isDrawerOpen activeTab =
    let
        underConstructionIcon =
            Icon.underConstruction
                |> Icon.withSize Icon.Small
                |> Icon.toHtml

        renderTab : { tab : Tab, underConstruction : Bool } -> Html FrontendMsg
        renderTab { tab, underConstruction } =
            let
                config =
                    Tab.getConfig tab
            in
            span
                [ class "flex gap-4 items-center"
                , classList [ ( "active", activeTab == tab ) ]
                ]
                [ span [ class "flex-none" ]
                    [ config.icon
                        |> Icon.withRounded True
                        |> Icon.toHtml
                    ]
                , span [ class "flex-1" ] [ text config.title ]
                , span [ class "flex-none", classList [ ( "hidden", not underConstruction ) ] ]
                    [ underConstructionIcon ]
                ]

        zIndexAttributes =
            if isDrawerOpen then
                [ Utils.zIndexes.drawerSide ]

            else
                []
    in
    div ([ class "drawer-side", attribute "style" "scroll-behavior: smooth; scroll-padding-top:5rem" ] ++ zIndexAttributes)
        [ label [ for "drawer", class "drawer-overlay" ] []
        , aside [ class "bg-base-200 w-80 h-full" ]
            -- title row
            [ div [ class "bg-base-200 sticky top-0 z-10 w-full bg-opacity-90 py-3 px-2 backdrop-blur flex" ]
                [ div [ class "flex-1 flex items-center justify-between gap-2 px-4" ]
                    [ div [ class "flex-0 px-2 flex flex-col items-center" ]
                        [ div [ class "font-title text-primary inline-flex text-lg transition-all duration-200 md:text-3xl flex gap-1 items-center rounded-t-xl overflow-hidden p-1 border border-primary border-b-4" ]
                            [ div [ class "text-primary text-sm font-bold t-column gap-0 leading-xs text-primary" ] [ span [] [ text "Med" ], span [] [ text "School" ] ]
                            , span [ class "uppercase text-base-content text-base-300 bg-primary leading-none px-1" ] [ text "idle" ]
                            ]
                        , div [ class "w-full border border-primary flex justify-center" ] [ div [ class "text-xs" ] [ text "The ", strong [ class "text-secondary" ] [ text "Preclinical" ], text " Years" ] ]
                        ]
                    , a [ href "/", class "link link-hover font-mono text-xs text-opacity-50 " ]
                        [ div [ class "tooltip tooltip-bottom", attribute "data-tip" "Patch notes" ]
                            [ text ("v" ++ Config.version) ]
                        ]
                    ]

                -- Close drawer button
                , label [ for "drawer", class "btn btn-square btn-ghost drawer-button lg:hidden" ]
                    [ Icon.close
                        |> Icon.toHtml
                    ]
                ]
            , div [ class "h-4" ] []
            , ul [ class "menu flex flex-col p-0 px-4" ]
                [ li [ onClick (HandleTabClick Tab.Home) ] [ renderTab { tab = Tab.Home, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.Backpack) ] [ renderTab { tab = Tab.Backpack, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.Shop) ] [ renderTab { tab = Tab.Shop, underConstruction = False } ]
                ]
            , ul [ class "menu flex flex-col p-0 px-4" ]
                (List.concat
                    [ [ li [] []
                      , li [ class "menu-title" ] [ text "Study" ]
                      ]
                    , List.filter ((/=) Labs) allSkills
                        |> List.map
                            (\skill ->
                                li [ onClick (HandleTabClick (Tab.SkillTab skill)) ]
                                    [ renderTab { tab = Tab.SkillTab skill, underConstruction = False } ]
                            )
                    ]
                )
            , ul [ class "menu flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ text "Campus" ]
                , li [ onClick (HandleTabClick (Tab.SkillTab Labs)) ]
                    [ renderTab { tab = Tab.SkillTab Labs, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.TestingCenter) ] [ renderTab { tab = Tab.TestingCenter, underConstruction = False } ]
                ]
            ]
        ]
