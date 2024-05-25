module IdleGame.Views.Drawer exposing (..)

import Config
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
                [ div [ class "flex-1 flex items-center gap-2" ]
                    [ div [ class "flex-0 px-2" ]
                        [ div [ class "font-title text-primary inline-flex text-lg transition-all duration-200 md:text-3xl" ]
                            [ span [ class "text-primary text-sm" ] [ text "medSchool" ]
                            , span [ class "uppercase text-base-content" ] [ text "idle" ]
                            ]
                        ]
                    , a [ href "/", class "link link-hover font-mono text-xs text-opacity-50 " ]
                        [ div [ class "tooltip tooltip-bottom", attribute "data-tip" "Patch notes" ]
                            [ text Config.version ]
                        ]
                    ]

                -- Close drawer button
                , label [ for "drawer", class "btn btn-square btn-ghost drawer-button lg:hidden" ]
                    [ Icon.close
                        |> Icon.toHtml
                    ]
                ]
            , div [ class "h-4" ] []
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [ onClick (HandleTabClick Tab.Backpack) ] [ renderTab { tab = Tab.Backpack, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.Shop) ] [ renderTab { tab = Tab.Shop, underConstruction = False } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ onClick (HandleTabClick Tab.Anatomy) ] [ renderTab { tab = Tab.Anatomy, underConstruction = False } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Other classes" ] ]
                , li [ onClick (HandleTabClick Tab.MedicalEthics) ] [ renderTab { tab = Tab.MedicalEthics, underConstruction = True } ]
                ]
            ]
        ]
