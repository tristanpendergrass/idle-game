module IdleGame.Views.Content exposing (..)

-- import IdleGame.Views.Adventuring2

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Effect exposing (Effect)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer
import IdleGame.Views.Activity
import IdleGame.Views.Bag
import IdleGame.Views.Home
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Shop
import IdleGame.Views.SubjectViews
import IdleGame.Views.UnderConstruction
import IdleGame.Views.Utils
import Types exposing (..)


renderContent : InGameFrontend -> Game -> ActivityRecord (List Effect) -> Tab -> Html FrontendMsg
renderContent model game cachedActivityEffects activeTab =
    let
        { title, icon } =
            Tab.getConfig activeTab
    in
    div [ class "drawer-content", IdleGame.Views.Utils.classes.column, class "overflow-y-auto", attribute "style" "scroll-behavior:smooth; scroll-padding-top: 5rem", IdleGame.Views.Utils.zIndexes.drawerContent ]
        [ div [ class "sticky top-0 flex h-16 w-full justify-center backdrop-blur transition-all duration-100 bg-base-100/90 text-base-content shadow-sm", IdleGame.Views.Utils.zIndexes.navbar ]
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
                            |> Icon.withSize Icon.Large
                            |> Icon.toHtml
                        , span [] [ text title ]
                        ]

                    -- Right side stuff
                    , div [ class "flex-1" ] []
                    ]
                ]
            ]
        , case activeTab of
            Tab.Home ->
                IdleGame.Views.Home.render model game cachedActivityEffects

            Tab.Shop ->
                IdleGame.Views.UnderConstruction.render

            Tab.Backpack ->
                IdleGame.Views.Bag.render game

            Tab.SkillTab subject ->
                IdleGame.Views.SubjectViews.renderSubject subject game cachedActivityEffects
        ]
