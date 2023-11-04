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
        setActiveTab : Tab -> FrontendMsg
        setActiveTab tab =
            case mode of
                Skilling ->
                    SetActiveSkillTab tab

                Adventuring ->
                    SetActiveAdventuringTab tab

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
                , onClick <| setActiveTab Tab.ForbiddenKnowledge
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

                label : Html msg
                label =
                    case newMode of
                        Skilling ->
                            span [] [ text "Studying" ]

                        Adventuring ->
                            span [ class "text-2xs" ] [ text "Adventuring" ]
            in
            button [ class "btn btn-secondary btn-sm flex items-center gap-2", onClick (SwitchMode newMode) ]
                [ Icon.go
                    |> Icon.withSize Icon.Medium
                    |> Icon.toHtml
                , label
                ]

        skillTabs : List (Html FrontendMsg)
        skillTabs =
            [ ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [ onClick (SetActiveSkillTab Tab.Bag) ] [ renderTab { tab = Tab.Bag, underConstruction = False } ]
                , li [ onClick (SetActiveSkillTab Tab.Shop) ] [ renderTab { tab = Tab.Shop, underConstruction = False } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ onClick (SetActiveSkillTab Tab.Chores) ] [ renderTab { tab = Tab.Chores, underConstruction = False } ]
                , li [ onClick (SetActiveSkillTab Tab.Explore) ] [ renderTab { tab = Tab.Explore, underConstruction = True } ]
                , li [ onClick (SetActiveSkillTab Tab.Mischief) ] [ renderTab { tab = Tab.Mischief, underConstruction = True } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Classes" ] ]
                , li [ onClick (SetActiveSkillTab Tab.Hexes) ] [ renderTab { tab = Tab.Hexes, underConstruction = False } ]
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
                [ li [ onClick (SetActiveAdventuringTab Tab.Location1) ] [ renderTab { tab = Tab.Location1, underConstruction = False } ]
                , li [ onClick (SetActiveAdventuringTab Tab.Location2) ] [ renderTab { tab = Tab.Location2, underConstruction = False } ]
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
                , div [ class "hidden lg:block" ]
                    [ switchModeButton ]
                ]
             , div [ class "pl-4 w-full flex justify-center items-center lg:hidden" ]
                [ switchModeButton
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
