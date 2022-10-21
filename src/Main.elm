module Main exposing (..)

import Browser
import Browser.Events exposing (onVisibilityChange)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Chores exposing (..)
import IdleGame.Tabs
import IdleGame.Types exposing (..)
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.WelcomeBackModal
import List.Selection
import Task
import Time


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init () =
    ( { tabs = IdleGame.Tabs.initialTabs
      , showWelcomeBackModal = False
      , now = 0
      , skillXp = 444
      , masteryXp = 100000
      , chores =
            [ IdleGame.Chores.create 0
                { title = "Clean Stables", rewardText = "+5 gold", skillXpGranted = 5, masteryXpGranted = 15, masteryXp = 235 }
            , IdleGame.Chores.create 1
                { title = "Clean Big Bubba's Stall", rewardText = "+15 gold", skillXpGranted = 10, masteryXpGranted = 1, masteryXp = 0 }
            ]
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOp ->
            noOp

        WithTime getMsg ->
            ( model, Cmd.batch [ Task.perform getMsg Time.now ] )

        ToggleActiveChore toggleId now ->
            ( { model | chores = IdleGame.Chores.toggleActiveChore toggleId (Time.posixToMillis now) model.chores }, Cmd.none )

        HandleAnimationFrame nowPosix ->
            let
                now =
                    Time.posixToMillis nowPosix

                -- handle chores
                ( newChores, { skillXpGained, masteryXpGained } ) =
                    IdleGame.Chores.handleAnimationFrame now model.chores
            in
            ( { model | chores = newChores, skillXp = model.skillXp + skillXpGained, masteryXp = model.masteryXp + masteryXpGained, now = now }, Cmd.none )

        HandleVisibilityChange visibility ->
            if visibility == Browser.Events.Visible then
                ( { model | showWelcomeBackModal = True }, Cmd.none )

            else
                noOp

        CloseWelcomeBackModal ->
            ( { model | showWelcomeBackModal = False }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onVisibilityChange HandleVisibilityChange
        ]


view : Model -> Html Msg
view model =
    let
        css =
            -- There's an experimental technique to include styles in header instead of body https://dashboard.lamdera.app/docs/html-head
            -- We're not using it for now because it's experimental but might be useful if we want to eliminate the flicker from the css loading in
            [ node "link" [ rel "stylesheet", href "/tailwind.css" ] []
            ]
    in
    div []
        (css
            ++ [ div [ class "bg-base-100 drawer drawer-mobile" ]
                    [ input [ id "drawer", type_ "checkbox", class "drawer-toggle" ] []
                    , IdleGame.Views.Content.renderContent model
                    , IdleGame.Views.Drawer.renderDrawer model
                    ]
               ]
            ++ (if model.showWelcomeBackModal then
                    [ IdleGame.Views.WelcomeBackModal.render model
                    ]

                else
                    []
               )
        )
