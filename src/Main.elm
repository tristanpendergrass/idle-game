port module Main exposing (..)

import Browser
import Browser.Events exposing (onVisibilityChange)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Tabs
import IdleGame.Types exposing (..)
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import Json.Decode as D
import Json.Decode.Pipeline exposing (..)
import Json.Encode as E
import Task
import Time


port sendToLocalStorage : E.Value -> Cmd msg


main : Program ( Int, D.Value ) Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : ( Int, D.Value ) -> ( Model, Cmd Msg )
init ( nowMillis, localStorageData ) =
    let
        now =
            Time.millisToPosix nowMillis
    in
    ( { tabs = IdleGame.Tabs.initialTabs -- TODO: most of the config for tabs should not live in the model but in a config function. only being enabled/disabled should be in model
      , isVisible = True
      , activeModal = Nothing
      , game =
            D.decodeValue (D.field "game" IdleGame.Game.gameDecoder) localStorageData
                |> Result.withDefault (IdleGame.Game.create now)
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

        ToggleActiveChore toggleId ->
            ( { model | game = IdleGame.Game.toggleActiveChore toggleId model.game }, Cmd.none )

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
                ( { model | activeModal = Just (TimePassesModal timePassesData), isVisible = True }, Cmd.none )

            else
                ( { model | isVisible = False }, Cmd.none )

        CloseModal ->
            ( { model | activeModal = Nothing }, Cmd.none )


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
            ++ (case model.activeModal of
                    Nothing ->
                        []

                    Just (TimePassesModal timePassesData) ->
                        [ IdleGame.Views.ModalWrapper.renderModal
                            [ IdleGame.Views.TimePasses.render model.game timePassesData
                            ]
                        ]

                    Just ChoreMasteryCheckpointsModal ->
                        []
               )
        )



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
