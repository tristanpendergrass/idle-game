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
import IdleGame.Views.TimePasses
import Task
import Time


main : Program Int Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : Int -> ( Model, Cmd Msg )
init nowMillis =
    let
        -- TODO: replace with actual current time
        now =
            Time.millisToPosix nowMillis
    in
    ( { tabs = IdleGame.Tabs.initialTabs
      , isVisible = True
      , timePassesData = Nothing
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

        WithTime msgWithTime ->
            ( model, Task.perform msgWithTime Time.now )

        ToggleActiveTree toggleId ->
            ( { model | game = IdleGame.Game.toggleActiveTree toggleId model.game }, Cmd.none )

        HandleAnimationFrame now ->
            if model.isVisible then
                ( { model | game = IdleGame.Game.updateGameToTime now model.game }, Cmd.none )

            else
                noOp

        HandleVisibilityChange visibility now ->
            if visibility == Browser.Events.Visible then
                let
                    newGame =
                        IdleGame.Game.updateGameToTime now model.game

                    timePassesData : IdleGame.Game.TimePassesData
                    timePassesData =
                        IdleGame.Game.getTimePassesData model.game newGame
                in
                ( { model | timePassesData = Just timePassesData, isVisible = True }, Cmd.none )

            else
                ( { model | isVisible = False }, Cmd.none )

        CloseTimePassesModal ->
            ( { model | timePassesData = Nothing }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onVisibilityChange (HandleVisibilityChange >> WithTime)
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
            ++ (case model.timePassesData of
                    Just timePassesData ->
                        [ IdleGame.Views.TimePasses.render timePassesData
                        ]

                    Nothing ->
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
