module IdleGame.Views.Content exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event3 exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer
import IdleGame.Views.Bag
import IdleGame.Views.Chores
import IdleGame.Views.Icon
import IdleGame.Views.UnderConstruction
import IdleGame.ZIndexes exposing (zIndexes)
import Types exposing (..)


getActivityProgress : IdleGame.Game.ActivityStatus -> Maybe Float
getActivityProgress activityStatus =
    activityStatus
        |> Maybe.map IdleGame.Timer.percentComplete


renderContent : Game -> Tab -> Html FrontendMsg
renderContent game activeTab =
    let
        { title, icon } =
            Tab.getConfig activeTab
    in
    div [ class "drawer-content t-column", attribute "style" "scroll-behavior:smooth; scroll-padding-top: 5rem" ]
        [ div [ class "sticky top-0 flex h-16 w-full justify-center bg-opacity-90 backdrop-blur transition-all duration-100 bg-base-100 text-base-content shadow-sm", zIndexes.drawerContent ]
            -- TOP NAV
            [ nav [ class "navbar w-full bg-primary text-primary-content" ]
                -- Menu to open sidebar
                [ div [ class "flex gap-2 lg:gap-4" ]
                    [ span [ class "tooltip tooltip-bottom before:text-xs before:content-[attr(data-tip)]", attribute "data-tip" "Menu" ]
                        [ label [ for "drawer", class "btn btn-square btn-sm  drawer-button lg:hidden" ]
                            [ FeatherIcons.menu
                                |> FeatherIcons.withSize 20
                                |> FeatherIcons.toHtml []
                            ]
                        ]

                    -- Left side stuff
                    , div [ class "flex items-center gap-2" ]
                        [ icon
                            |> IdleGame.Views.Icon.toFeatherIcon
                            |> FeatherIcons.withSize 24
                            |> FeatherIcons.toHtml []
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

            _ ->
                IdleGame.Views.UnderConstruction.render
        ]
