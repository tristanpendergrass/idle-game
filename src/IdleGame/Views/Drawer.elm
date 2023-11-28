module IdleGame.Views.Drawer exposing (..)

import Config
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import Types exposing (..)


renderDrawer : Bool -> Mode -> Tab -> Html FrontendMsg
renderDrawer isDrawerOpen mode activeTab =
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

        renderForbiddenTab : Html FrontendMsg
        renderForbiddenTab =
            span
                [ class "flex gap-4 items-center"
                , onClick <| HandleTabClick Tab.ForbiddenKnowledge mode
                ]
                [ span [ class "flex-none" ]
                    [ Icon.forbiddenKnowledge
                        |> Icon.toHtml
                    ]
                , span [ class "flex-1" ] [ text "Forbidden Knowledge" ]
                , span [ class "flex-none" ]
                    [ underConstructionIcon ]
                ]

        zIndexAttributes =
            if isDrawerOpen then
                [ Utils.zIndexes.drawerSide ]

            else
                []

        switchModeButton =
            let
                newMode : Mode
                newMode =
                    case mode of
                        Skilling ->
                            Adventuring

                        Adventuring ->
                            Skilling

                btnClass : Attribute FrontendMsg
                btnClass =
                    case mode of
                        Skilling ->
                            class "btn-warning"

                        Adventuring ->
                            class "btn-info"
            in
            button [ class "btn btn-sm btn-square flex items-center gap-2", btnClass, onClick (SwitchMode newMode) ]
                [ Icon.go
                    |> Icon.withSize Icon.Medium
                    |> Icon.toHtml
                ]

        modeHeader =
            case mode of
                Skilling ->
                    h2 [ class "text-info font-bold text-2xl" ] [ text "Studying" ]

                Adventuring ->
                    h2 [ class "text-warning font-bold text-2xl" ] [ text "Adventuring" ]

        skillTabs : List (Html FrontendMsg)
        skillTabs =
            [ ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [ onClick (HandleTabClick Tab.Bag Skilling) ] [ renderTab { tab = Tab.Bag, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.Shop Skilling) ] [ renderTab { tab = Tab.Shop, underConstruction = False } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , div [ class "py-2" ]
                    [ div [ class "flex items-center justify-between" ]
                        [ modeHeader
                        , switchModeButton
                        ]
                    ]
                , li [ onClick (HandleTabClick Tab.Chores Skilling) ] [ renderTab { tab = Tab.Chores, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.Explore Skilling) ] [ renderTab { tab = Tab.Explore, underConstruction = True } ]
                , li [ onClick (HandleTabClick Tab.Mischief Skilling) ] [ renderTab { tab = Tab.Mischief, underConstruction = True } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Classes" ] ]
                , li [ onClick (HandleTabClick Tab.Hexes Skilling) ] [ renderTab { tab = Tab.Hexes, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.Weathermancing Skilling) ] [ renderTab { tab = Tab.Weathermancing, underConstruction = False } ]
                , li [ class "disabled" ] [ renderTab { tab = Tab.Wards, underConstruction = True } ]
                , li [ class "disabled" ] [ renderTab { tab = Tab.Enchantment, underConstruction = True } ]
                , li [ class "disabled" ] [ renderTab { tab = Tab.Botany, underConstruction = True } ]
                , li [ class "disabled" ] [ renderTab { tab = Tab.Potionmaking, underConstruction = True } ]
                , li [ class "disabled" ] [ renderTab { tab = Tab.Conjuration, underConstruction = True } ]
                , li [ class "disabled" ] [ renderTab { tab = Tab.Transmogrification, underConstruction = True } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Dark Arts" ] ]
                , li [ class "disabled" ] [ renderForbiddenTab ]
                , li [ class "disabled" ] [ renderForbiddenTab ]
                , li [ class "disabled" ] [ renderForbiddenTab ]
                ]
            ]

        adventuringTabs : List (Html FrontendMsg)
        adventuringTabs =
            [ ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [ onClick (HandleTabClick Tab.Bag Adventuring) ] [ renderTab { tab = Tab.Bag, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.Shop Adventuring) ] [ renderTab { tab = Tab.Shop, underConstruction = False } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , div [ class "py-2" ]
                    [ div [ class "flex items-center justify-between" ]
                        [ modeHeader
                        , switchModeButton
                        ]
                    ]
                , li [ onClick (HandleTabClick Tab.SchoolGrounds Adventuring) ] [ renderTab { tab = Tab.SchoolGrounds, underConstruction = False } ]
                , li [ onClick (HandleTabClick Tab.SecretGarden Adventuring) ] [ renderTab { tab = Tab.SecretGarden, underConstruction = False } ]
                ]
            ]
    in
    div ([ class "drawer-side", attribute "style" "scroll-behavior: smooth; scroll-padding-top:5rem" ] ++ zIndexAttributes)
        [ label [ for "drawer", class "drawer-overlay" ] []
        , aside [ class "bg-base-200 w-80" ]
            -- title row
            ([ div [ class "bg-base-200 sticky top-0 z-10 w-full bg-opacity-90 py-3 px-2 backdrop-blur flex" ]
                [ div [ class "flex-1 flex items-center gap-2" ]
                    [ div [ class "flex-0 px-2" ]
                        [ div [ class "font-title text-primary inline-flex text-lg transition-all duration-200 md:text-3xl" ]
                            [ span [ class "lowercase text-primary" ] [ text "elm" ]
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
             ]
                ++ (case mode of
                        Skilling ->
                            skillTabs

                        Adventuring ->
                            adventuringTabs
                   )
            )
        ]
