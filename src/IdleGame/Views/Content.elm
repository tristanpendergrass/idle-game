module IdleGame.Views.Content exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Event3 exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.GameTypes
import IdleGame.Timer
import IdleGame.Views.Bag
import IdleGame.Views.Chores
import IdleGame.Views.Icon
import IdleGame.Views.Placeholder
import IdleGame.XpFormulas
import List.Extra
import Time exposing (Posix)
import Types exposing (..)


getActivityProgress : IdleGame.Game.ActivityStatus -> Maybe Float
getActivityProgress activityStatus =
    activityStatus
        |> Maybe.map IdleGame.Timer.percentComplete


renderContent : Game -> Tab -> Html FrontendMsg
renderContent game activeTab =
    let
        topNavTitle =
            case activeTab of
                BagTab ->
                    "Bag"

                ChoresTab ->
                    "Chores"

        topNavIcon =
            case activeTab of
                BagTab ->
                    IdleGame.Views.Icon.bag

                ChoresTab ->
                    IdleGame.Views.Icon.chores

        topNavBgColor =
            case activeTab of
                BagTab ->
                    "bg-blue-900"

                ChoresTab ->
                    "bg-orange-900"
    in
    div [ class "drawer-content t-column", attribute "style" "scroll-behavior:smooth; scroll-padding-top: 5rem" ]
        [ div [ class "sticky top-0 z-30 flex h-16 w-full justify-center bg-opacity-90 backdrop-blur transition-all duration-100 bg-base-100 text-base-content shadow-sm" ]
            -- TOP NAV
            [ nav [ class "navbar w-full", class topNavBgColor ]
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
                        [ topNavIcon
                            |> IdleGame.Views.Icon.toFeatherIcon
                            |> FeatherIcons.withSize 24
                            |> FeatherIcons.toHtml []
                        , span [] [ text topNavTitle ]
                        ]

                    -- Right side stuff
                    , div [ class "flex-1" ] []
                    ]
                ]
            ]

        -- Chore XP and MXP
        , case activeTab of
            BagTab ->
                IdleGame.Views.Bag.render game

            ChoresTab ->
                IdleGame.Views.Chores.render game
        , div [ class "absolute bottom-[2rem] right-[2rem]" ]
            [ button [ class "btn btn-secondary uppercase", onClick OpenMasteryUnlocksModal ] [ text "m" ]
            ]
        ]
