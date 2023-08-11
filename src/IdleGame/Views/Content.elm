module IdleGame.Views.Content exposing (..)

-- import IdleGame.Views.Adventuring2

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer
import IdleGame.Views.Activity
import IdleGame.Views.Adventuring
import IdleGame.Views.Bag
import IdleGame.Views.Chores
import IdleGame.Views.Hexes
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Shop
import IdleGame.Views.UnderConstruction
import IdleGame.Views.Utils
import Types exposing (..)


renderContent : Game -> Tab -> Html FrontendMsg
renderContent game activeTab =
    let
        { title, icon } =
            Tab.getConfig activeTab
    in
    div [ class "drawer-content t-column", attribute "style" "scroll-behavior:smooth; scroll-padding-top: 5rem", IdleGame.Views.Utils.zIndexes.drawerContent ]
        [ div [ class "sticky top-0 flex h-16 w-full justify-center bg-opacity-90 backdrop-blur transition-all duration-100 bg-base-100 text-base-content shadow-sm", IdleGame.Views.Utils.zIndexes.navbar ]
            -- TOP NAV
            [ nav [ class "navbar w-full bg-primary text-primary-content" ]
                -- Menu to open sidebar
                [ div [ class "flex gap-2 lg:gap-4" ]
                    [ span [ class "tooltip tooltip-bottom before:text-xs before:content-[attr(data-tip)]", attribute "data-tip" "Menu" ]
                        [ label [ for "drawer", class "btn btn-square btn-sm  drawer-button lg:hidden" ]
                            [ Icon.menu
                                |> Icon.toHtml
                            ]
                        ]

                    -- Left side stuff
                    , div [ class "flex items-center gap-2" ]
                        [ icon
                            |> Icon.toHtml
                        , span [] [ text title ]
                        ]

                    -- Right side stuff
                    , div [ class "flex-1" ] []
                    ]
                ]
            ]

        -- Chore XP and MXP
        , case activeTab of
            Tab.Bag ->
                IdleGame.Views.Bag.render game

            Tab.Chores ->
                IdleGame.Views.Chores.render game

            Tab.Hexes ->
                IdleGame.Views.Hexes.render game

            Tab.Shop ->
                IdleGame.Views.Shop.render game

            Tab.Adventuring ->
                IdleGame.Views.Adventuring.render game

            _ ->
                IdleGame.Views.UnderConstruction.render
        ]
