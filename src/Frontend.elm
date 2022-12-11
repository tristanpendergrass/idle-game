module Frontend exposing (app)

-- import IdleGame.Types exposing (..)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Tabs
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import Json.Decode as D
import Json.Decode.Pipeline exposing (..)
import Json.Encode as E
import Lamdera
import Task
import Time
import Types exposing (..)
import Url exposing (Url)


init : Url -> Nav.Key -> ( FrontendModel, Cmd FrontendMsg )
init url key =
    let
        now =
            -- TODO: set this correctly
            Time.millisToPosix 0
    in
    ( { key = key
      , currentTime = now
      , tabs = IdleGame.Tabs.initialTabs -- TODO: most of the config for tabs should not live in the model but in a config function. only being enabled/disabled should be in model
      , isVisible = True
      , activeModal = Nothing
      , game = IdleGame.Game.create now
      }
    , Cmd.none
    )


update : FrontendMsg -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOp ->
            noOp

        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            noOp

        ToggleActiveChore toggleId ->
            ( { model | game = IdleGame.Game.toggleActiveChore toggleId model.game }, Cmd.none )

        HandleAnimationFrame now ->
            if model.isVisible then
                ( { model | game = IdleGame.Game.updateGameToTime now model.game, currentTime = now }, Cmd.none )

            else
                noOp

        HandleVisibilityChange visibility ->
            if visibility == Browser.Events.Visible then
                let
                    newGame =
                        IdleGame.Game.updateGameToTime model.currentTime model.game

                    timePassesData : IdleGame.Game.TimePassesData
                    timePassesData =
                        IdleGame.Game.getTimePassesData model.game newGame
                in
                ( { model | activeModal = Just (TimePassesModal timePassesData), isVisible = True }, Cmd.none )

            else
                ( { model | isVisible = False }, Cmd.none )

        CloseModal ->
            ( { model | activeModal = Nothing }, Cmd.none )


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    ( model, Cmd.none )


subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions model =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onVisibilityChange HandleVisibilityChange
        ]


view : FrontendModel -> Document FrontendMsg
view model =
    let
        css =
            -- There's an experimental technique to include styles in header instead of body https://dashboard.lamdera.app/docs/html-head
            -- We're not using it for now because it's experimental but might be useful if we want to eliminate the flicker from the css loading in
            [ node "link" [ rel "stylesheet", href "/output.css" ] []
            ]
    in
    { title = "Idle Game"
    , body =
        css
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
    }


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = view
        }
