module IdleGame.Views.DetailView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Chore
import IdleGame.Game exposing (..)
import IdleGame.GameTypes exposing (..)
import IdleGame.Timer as Timer
import IdleGame.Views.Chores
import IdleGame.Views.Icon
import Percent exposing (Percent)
import Types exposing (..)


render : Game -> Maybe Preview -> Bool -> Html FrontendMsg
render game maybePreview detailViewExpanded =
    div [ class "bg-base-100" ]
        [ div [ class "hidden lg:block h-full" ]
            [ renderRightRail game
            ]
        , div [ class "lg:hidden" ]
            [ renderCollapsible
                game
                maybePreview
                detailViewExpanded
            ]
        ]


{-| renderRightRail is the version of DetailView shown when the screen is at its widest. It's a sidebar on the right side.
-}
renderRightRail : Game -> Html FrontendMsg
renderRightRail game =
    div [ class "w-[20rem] h-full border-l-8 border-base-200 overflow-y-auto overflow-x-hidden" ]
        [ IdleGame.Views.Chores.detailView game ]


type CollapsibleHeight
    = Expanded
    | Collapsed
    | StatusBar


{-| renderCollapsible is the version of DetailView shown when the screen is less than its widest.
It will display either a full screen detail view or be collapsed. In its collapsed state it may show a
status bar or not depending on the state of the game.
-}
renderCollapsible : Game -> Maybe Preview -> Bool -> Html FrontendMsg
renderCollapsible game maybePreview detailViewExpanded =
    let
        height : CollapsibleHeight
        height =
            case ( game.activity, maybePreview ) of
                ( Nothing, Nothing ) ->
                    Collapsed

                ( _, Just _ ) ->
                    Expanded

                -- Note that we're ignoring detailViewExpanded here. That's just for the real activity not the preview
                ( Just _, Nothing ) ->
                    if detailViewExpanded then
                        Expanded

                    else
                        StatusBar
    in
    div
        [ class "fixed left-0 w-screen h-screen bg-base-100"
        , class "transition-[top] duration-100 ease-in motion-reduce:transition-none"
        , case height of
            Expanded ->
                class "top-0"

            Collapsed ->
                class "top-full"

            StatusBar ->
                class "top-[calc(100vh-4rem)]"
        ]
        [ div
            [ class "w-full h-full"
            , classList [ ( "hidden", height /= Expanded ) ]
            ]
            [ IdleGame.Views.Chores.detailView game
            ]
        , div
            [ class "absolute top-0 left-0 ml-2 mt-2"
            , classList [ ( "hidden", height /= Expanded ) ]
            ]
            [ collapseButton ]
        , case game.activity of
            Nothing ->
                div [] []

            Just activity ->
                div
                    [ class "absolute top-0 left-0 w-full"
                    , classList [ ( "hidden", detailViewExpanded ) ]
                    ]
                    [ renderStatusBar game activity ]
        ]


collapseButton : Html FrontendMsg
collapseButton =
    button
        [ class "btn btn-icon btn-ghost btn-circle"
        , onClick CollapseDetailView
        ]
        [ IdleGame.Views.Icon.chevronDown
            |> IdleGame.Views.Icon.toHtml
        ]


renderStatusBar : Game -> Activity -> Html FrontendMsg
renderStatusBar game activity =
    let
        stats : IdleGame.Chore.Stats
        stats =
            case activity of
                ActivityChore kind _ ->
                    IdleGame.Chore.getStats kind

        percentComplete : Percent
        percentComplete =
            case activity of
                ActivityChore _ timer ->
                    Timer.percentComplete timer
    in
    div [ class "w-full h-[4rem] bg-base-300 text-accent-content flex items-center overflow-hidden p-2 gap-3 rounded-t relative", onClick ExpandDetailView ]
        [ div [ class "w-[3rem] h-full overflow-hidden bg-red rounded" ]
            [ img [ src stats.imgSrc, class "object-cover h-full w-full object-center" ] []
            ]
        , div [ class "grow overflow-hidden h-full flex flex-col items-start justify-center" ]
            [ div [ class "font-bold text-sm leading-tight" ] [ text stats.title ]
            , div [ class "text-xs text-base-content/70 leading-tight" ] [ text "Chores" ]
            ]
        , div [ class "absolute bottom-0 left-0 w-full h-[2px]" ]
            [ div
                [ class "absolute top-0 left-0 w-[50%] h-full bg-base-content/50"
                , style "width" (String.fromFloat (Percent.toPercentage percentComplete) ++ "%")
                ]
                []
            ]
        ]
