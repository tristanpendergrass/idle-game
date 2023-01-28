module IdleGame.Views.Drawer exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Views.Icon as Icon exposing (Icon)
import Types exposing (..)


renderDrawer : Game -> Tab -> Html FrontendMsg
renderDrawer game activeTab =
    let
        renderTab : { tab : Tab, onClick : FrontendMsg, icon : Icon, label : String } -> Html FrontendMsg
        renderTab props =
            span
                [ class "flex gap-4"
                , classList [ ( "active", activeTab == props.tab ) ]
                , onClick props.onClick
                ]
                [ span [ class "flex-none" ]
                    [ props.icon
                        |> Icon.toFeatherIcon
                        |> FeatherIcons.withSize 24
                        |> FeatherIcons.toHtml []
                    ]
                , span [ class "flex-1" ] [ text props.label ]
                ]

        renderForbiddenTab : Html FrontendMsg
        renderForbiddenTab =
            span
                [ class "flex gap-4"
                , onClick <| SetActiveTab ForbiddenKnowledgeTab
                ]
                [ span [ class "flex-none" ]
                    [ Icon.ForbiddenKnowledge
                        |> Icon.toFeatherIcon
                        |> FeatherIcons.withSize 24
                        |> FeatherIcons.toHtml []
                    ]
                , span [ class "flex-1" ] [ text "Forbidden Knowledge" ]
                ]
    in
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
                [ li [] [ renderTab { tab = BagTab, onClick = SetActiveTab BagTab, icon = Icon.Bag, label = "Bag" } ]
                , li [] [ renderTab { tab = ShopTab, onClick = SetActiveTab ShopTab, icon = Icon.Shop, label = "Shop" } ]
                , li [] [ renderTab { tab = ChoresTab, onClick = SetActiveTab ChoresTab, icon = Icon.Chores, label = "Chores" } ]
                , li [] [ renderTab { tab = ExploreTab, onClick = SetActiveTab ExploreTab, icon = Icon.Explore, label = "Explore" } ]
                , li [] [ renderTab { tab = MischiefTab, onClick = SetActiveTab MischiefTab, icon = Icon.Mischief, label = "Mischief" } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Classes" ] ]
                , li [] [ renderTab { tab = BotanyTab, onClick = SetActiveTab BotanyTab, icon = Icon.Botany, label = "Botany" } ]
                , li [] [ renderTab { tab = PotionmakingTab, onClick = SetActiveTab PotionmakingTab, icon = Icon.Potionmaking, label = "Potionmaking" } ]
                , li [] [ renderTab { tab = ConjurationTab, onClick = SetActiveTab ConjurationTab, icon = Icon.Conjuration, label = "Conjuration" } ]
                , li [] [ renderTab { tab = TransmogrificationTab, onClick = SetActiveTab TransmogrificationTab, icon = Icon.Transmogrification, label = "Transmogrification" } ]
                , li [] [ renderTab { tab = HexesTab, onClick = SetActiveTab HexesTab, icon = Icon.Hexes, label = "Hexes" } ]
                , li [] [ renderTab { tab = WardsTab, onClick = SetActiveTab WardsTab, icon = Icon.Wards, label = "Wards" } ]
                ]
            , ul [ class "menu menu-compact flex flex-col p-0 px-4" ]
                [ li [] []
                , li [ class "menu-title" ] [ span [] [ text "Dark Arts" ] ]
                , li [] [ renderForbiddenTab ]
                , li [] [ renderForbiddenTab ]
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
