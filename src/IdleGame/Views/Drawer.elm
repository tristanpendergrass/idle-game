module IdleGame.Views.Drawer exposing (..)

import Config
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Types exposing (..)


renderDrawer : Bool -> Tab -> Html FrontendMsg
renderDrawer isDrawerOpen activeTab =
    let
        underConstructionIcon =
            Icon.underConstruction
                |> Icon.withSize Icon.Small
                |> Icon.toHtml

        renderTab : { tab : Tab } -> Html FrontendMsg
        renderTab { tab } =
            let
                config =
                    Tab.getConfig tab
            in
            renderDrawerRow { isActive = activeTab == tab, icon = config.icon, title = config.title, underConstruction = False }

        renderDrawerRow : { isActive : Bool, icon : Icon, title : String, underConstruction : Bool } -> Html FrontendMsg
        renderDrawerRow { isActive, icon, title, underConstruction } =
            span
                [ class "flex gap-4 items-center"
                , classList [ ( "active", isActive ) ]
                ]
                [ span [ class "flex-none" ]
                    [ icon
                        |> Icon.withRounded True
                        |> Icon.toHtml
                    ]
                , span [ class "flex-1" ] [ text title ]
                , span [ class "flex-none", classList [ ( "hidden", not underConstruction ) ] ]
                    [ underConstructionIcon ]
                ]

        zIndexAttributes =
            if isDrawerOpen then
                [ IdleGame.Views.Utils.zIndexes.drawerSide ]

            else
                []
    in
    div ([ class "drawer-side", attribute "style" "scroll-behavior: smooth; scroll-padding-top:5rem" ] ++ zIndexAttributes)
        [ label [ for "drawer", class "drawer-overlay" ] []
        , aside [ class "bg-base-200 h-full" ]
            -- title row
            [ div [ class "bg-base-200/90 sticky top-0 z-10 w-full py-3 px-2 backdrop-blur flex" ]
                [ div [ class "flex-1 flex items-center justify-between gap-2 px-4" ]
                    [ div [ class "flex-0 px-2 flex flex-col items-center" ]
                        [ div [ class "font-title text-primary inline-flex text-lg transition-all duration-200 md:text-3xl flex gap-1 items-center rounded-t-xl overflow-hidden p-1 border border-primary border-b-4" ]
                            [ div [ class "text-primary text-sm font-bold", IdleGame.Views.Utils.classes.column, class "gap-0 leading-xs text-primary" ] [ span [] [ text "idle" ] ]
                            , span [ class "uppercase leading-none px-1" ] [ text "sage" ]
                            ]
                        , div [ class "w-full border border-primary flex justify-center" ] [ div [ class "text-xs" ] [ text "Prologue" ] ]
                        ]
                    , a [ href "/", class "link link-hover font-mono text-xs text-opacity-50 " ]
                        [ div [ class "tooltip tooltip-bottom", attribute "data-tip" "Patch notes" ]
                            [ text ("v" ++ Config.version) ]
                        ]
                    ]

                -- Close drawer button
                , label [ for "drawer", class "btn btn-square btn-ghost drawer-button lg:hidden" ]
                    [ Icon.close
                        |> Icon.toHtml
                    ]
                ]
            , div [ class "h-4" ] []
            , ul [ class "menu flex flex-col p-0 px-4" ]
                [ li [ onClick (HandleTabClick Tab.Home) ] [ renderTab { tab = Tab.Home } ]
                , li [ onClick (HandleTabClick Tab.Backpack) ] [ renderTab { tab = Tab.Backpack } ]
                , li [ onClick (HandleTabClick Tab.Shop) ] [ renderTab { tab = Tab.Shop } ]
                , li [ onClick HandleGoToMainMenuClick ] [ renderDrawerRow { isActive = False, icon = Icon.menu, title = "Main Menu", underConstruction = False } ]
                ]
            , ul [ class "menu flex flex-col p-0 px-4" ]
                (List.concat
                    [ [ li [] []
                      , li [ class "menu-title" ] [ text "Study" ]
                      ]
                    , List.map
                        (\skill ->
                            li [ onClick (HandleTabClick (Tab.SkillTab skill)) ]
                                [ renderTab { tab = Tab.SkillTab skill } ]
                        )
                        allSkills
                    ]
                )
            ]
        ]
