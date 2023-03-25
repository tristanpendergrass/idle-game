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

        renderForbiddenTab : Html FrontendMsg
        renderForbiddenTab =
            span
                [ class "flex gap-4 items-center"
                , onClick <| SetActiveTab Tab.ForbiddenKnowledge
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
    in
    div ([ class "drawer-side", attribute "style" "scroll-behavior: smooth; scroll-padding-top:5rem" ] ++ zIndexAttributes)
        [ label [ for "drawer", class "drawer-overlay" ] []
        , aside [ class "bg-base-200 w-80" ]
            -- title row
            [ div [ class "bg-base-200 sticky top-0 z-10 w-full bg-opacity-90 py-3 px-2 backdrop-blur flex" ]
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
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [ onClick (SetActiveTab Tab.Bag) ] [ renderTab { tab = Tab.Bag, underConstruction = False } ]
                , li [ onClick (SetActiveTab Tab.Shop) ] [ renderTab { tab = Tab.Shop, underConstruction = False } ]
                , li [ onClick (SetActiveTab Tab.Adventuring) ] [ renderTab { tab = Tab.Adventuring, underConstruction = False } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ onClick (SetActiveTab Tab.Chores) ] [ renderTab { tab = Tab.Chores, underConstruction = False } ]
                , li [ onClick (SetActiveTab Tab.Explore) ] [ renderTab { tab = Tab.Explore, underConstruction = True } ]
                , li [ onClick (SetActiveTab Tab.Mischief) ] [ renderTab { tab = Tab.Mischief, underConstruction = True } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Classes" ] ]
                , li [ class "disabled" ] [ renderTab { tab = Tab.Hexes, underConstruction = True } ]
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
        ]



-- renderCategory : Bool -> Maybe Tab -> Tabs.Category -> Html FrontendMsg
-- renderCategory withTopLine activeTab category =
--     let
--         maybeTopLine =
--             if withTopLine then
--                 [ li [] [] ]
--             else
--                 []
--         maybeTitle =
--             case category.title of
--                 Just title ->
--                     [ li [ class "menu-title" ]
--                         [ span []
--                             [ span [ classList [ ( "text-error text-opacity-40", category.forbidden ) ] ]
--                                 [ text title ]
--                             ]
--                         ]
--                     ]
--                 Nothing ->
--                     []
--     in
--     ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
--         (maybeTopLine ++ maybeTitle ++ List.map (\tab -> renderTab tab (Just tab.type_ == Maybe.map .type_ activeTab)) category.items)
-- renderTab : Tab -> Bool -> Html FrontendMsg
-- renderTab tab isActive =
--     li [ classList [ ( "disabled", tab.disabled ) ] ]
--         [ span [ class "flex gap-4", classList [ ( "active", isActive ) ] ]
--             [ span [ class "flex-none" ]
--                 [ tab.icon
--                     |> Icon.toFeatherIcon
--                     |> FeatherIcons.withSize 24
--                     |> FeatherIcons.toHtml []
--                 ]
--             , span [ class "flex-1" ] [ text tab.title ]
--             ]
--         ]
