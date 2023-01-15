module IdleGame.Views.Drawer exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Views.Icon as Icon
import Types exposing (..)


renderDrawer : Game -> Tab -> Html FrontendMsg
renderDrawer game activeTab =
    div [ class "drawer-side", attribute "style" "scroll-behavior:smooth; scroll-padding-top:5rem" ]
        [ label [ for "drawer", class "drawer-overlay" ] []
        , aside [ class "bg-base-200 w-80" ]
            -- title row
            ([ div [ class "bg-base-200 sticky top-0 w-full bg-opacity-90 py-3 px-2 backdrop-blur flex" ]
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
             ]
                ++ [ li [ class "menu menu-compact flex flex-col p-0 px-4" ]
                        [ li []
                            [ span
                                [ class "flex gap-4"
                                , classList [ ( "active", activeTab == BagTab ) ]
                                , onClick <| SetActiveTab BagTab
                                ]
                                [ span [ class "flex-none" ]
                                    [ Icon.Bag
                                        |> Icon.toFeatherIcon
                                        |> FeatherIcons.withSize 24
                                        |> FeatherIcons.toHtml []
                                    ]
                                , span [ class "flex-1" ] [ text "Bag" ]
                                ]
                            ]
                        , li []
                            [ span
                                [ class "flex gap-4"
                                , classList [ ( "active", activeTab == ChoresTab ) ]
                                , onClick <| SetActiveTab ChoresTab
                                ]
                                [ span [ class "flex-none" ]
                                    [ Icon.Chores
                                        |> Icon.toFeatherIcon
                                        |> FeatherIcons.withSize 24
                                        |> FeatherIcons.toHtml []
                                    ]
                                , span [ class "flex-1" ] [ text "Chores" ]
                                ]
                            ]
                        ]
                   ]
            )
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
