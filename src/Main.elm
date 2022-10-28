module Main exposing (..)

import Browser
import Browser.Events exposing (onVisibilityChange)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import IdleGame.Tabs
import IdleGame.Types exposing (..)
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.WelcomeBackModal
import Task
import Time


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init () =
    let
        -- TODO: replace with actual current time
        now =
            Time.millisToPosix 0
    in
    ( { tabs = IdleGame.Tabs.initialTabs
      , showWelcomeBackModal = False
      , game = IdleGame.Game.create now
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

        ToggleActiveTree toggleId now ->
            noOp

        -- ( { model | woodcutting = IdleGame.Woodcutting.toggleActiveWoodcutting toggleId (Time.posixToMillis now) model.woodcutting }, Cmd.none )
        HandleAnimationFrame nowPosix ->
            noOp

        -- let
        --     now =
        --         Time.posixToMillis nowPosix
        --     -- handle woodcutting
        --     ( newWoodcutting, { skillXpGained, masteryXpGained } ) =
        --         IdleGame.Woodcutting.handleAnimationFrame now model.woodcutting
        -- in
        -- ( { model | woodcutting = newWoodcutting, skillXp = model.skillXp + skillXpGained, masteryXp = model.masteryXp + masteryXpGained, now = now }, Cmd.none )
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



-- toggleActiveWoodcutting : Id -> Int -> List Woodcutting -> List Woodcutting
-- toggleActiveWoodcutting toggleId now woodcuttings =
--     woodcuttings
--         |> List.map
--             (\(Woodcutting id woodcuttingData activityStatus) ->
--                 if id == toggleId then
--                     let
--                         newActivityStatus =
--                             case activityStatus of
--                                 Nothing ->
--                                     Just (IdleGame.Timer.create now 2500)
--                                 Just _ ->
--                                     Nothing
--                     in
--                     Woodcutting id woodcuttingData newActivityStatus
--                 else
--                     Woodcutting id woodcuttingData Nothing
--             )
-- Diff stuff


type Gain
    = XpGain
    | ResourceGain


type Loss
    = ResourceLoss


type alias GameObjectDiff =
    { gains : List Gain
    , losses : List Loss
    }
