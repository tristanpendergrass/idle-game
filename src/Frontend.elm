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
import IdleGame.Timer
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import Json.Decode as D
import Json.Decode.Pipeline exposing (..)
import Json.Encode as E
import Lamdera
import Task
import Time exposing (Posix)
import Time.Extra
import Types exposing (..)
import Url exposing (Url)


init : Url -> Nav.Key -> ( FrontendModel, Cmd FrontendMsg )
init url key =
    ( { key = key
      , tabs = IdleGame.Tabs.initialTabs -- TODO: most of the config for tabs should not live in the model but in a config function. only being enabled/disabled should be in model
      , isVisible = True
      , activeModal = Nothing
      , saveGameTimer = IdleGame.Timer.create 1000
      , gameState = Nothing
      }
    , Cmd.none
    )


setCurrentTime : Posix -> GameState -> GameState
setCurrentTime now gameState =
    { gameState | currentTime = now }


laterGameState : GameState -> GameState -> GameState
laterGameState left right =
    if Time.posixToMillis left.lastTick < Time.posixToMillis right.lastTick then
        right

    else
        left


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

        UpdateGameStateWithTime serverGameState now ->
            let
                latestGameState =
                    case model.gameState of
                        Nothing ->
                            serverGameState

                        Just localGameState ->
                            laterGameState localGameState serverGameState
            in
            ( { model
                | gameState =
                    Just
                        (latestGameState
                            |> setCurrentTime now
                        )
              }
            , Cmd.none
            )

        ToggleActiveChore toggleId ->
            case model.gameState of
                Nothing ->
                    noOp

                Just gameState ->
                    ( { model
                        | gameState = Just { gameState | game = IdleGame.Game.toggleActiveChore toggleId gameState.game }
                      }
                    , Cmd.none
                    )

        HandleAnimationFrame now ->
            case model.gameState of
                Nothing ->
                    ( { model | gameState = Just { currentTime = now, lastTick = now, game = IdleGame.Game.create } }, Cmd.none )

                Just gameState ->
                    if model.isVisible then
                        let
                            ( newTick, newGame ) =
                                updateGameToTime now ( gameState.lastTick, gameState.game )

                            newGameState =
                                { gameState | currentTime = now, lastTick = newTick, game = newGame }

                            delta =
                                Time.posixToMillis now - Time.posixToMillis gameState.currentTime

                            ( newSaveGameTimer, saveGameCompletions ) =
                                IdleGame.Timer.increment delta model.saveGameTimer

                            shouldSaveGame =
                                saveGameCompletions > 0

                            saveGameCmd =
                                Lamdera.sendToBackend (Save newGameState)
                        in
                        ( { model
                            | gameState = Just newGameState
                            , saveGameTimer = newSaveGameTimer
                          }
                        , if shouldSaveGame then
                            saveGameCmd

                          else
                            Cmd.none
                        )

                    else
                        ( { model | gameState = Just { gameState | currentTime = now } }, Cmd.none )

        HandleVisibilityChange visibility ->
            case model.gameState of
                Nothing ->
                    noOp

                Just { currentTime, lastTick, game } ->
                    if visibility == Browser.Events.Visible then
                        let
                            ( newTick, newGame ) =
                                updateGameToTime currentTime ( lastTick, game )

                            timePassesData : IdleGame.Game.TimePassesData
                            timePassesData =
                                IdleGame.Game.getTimePassesData game newGame

                            timePassed =
                                Time.posixToMillis newTick
                                    - Time.posixToMillis lastTick
                                    |> Time.millisToPosix
                        in
                        ( { model | activeModal = Just (TimePassesModal timePassed timePassesData), isVisible = True }, Cmd.none )

                    else
                        ( { model | isVisible = False }, Cmd.none )

        CloseModal ->
            ( { model | activeModal = Nothing }, Cmd.none )


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        UpdateGameState gameState ->
            ( model, Task.perform (UpdateGameStateWithTime gameState) Time.now )


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
        case model.gameState of
            Nothing ->
                css

            Just { game } ->
                css
                    ++ [ div [ class "bg-base-100 drawer drawer-mobile" ]
                            [ input [ id "drawer", type_ "checkbox", class "drawer-toggle" ] []
                            , IdleGame.Views.Content.renderContent game
                            , IdleGame.Views.Drawer.renderDrawer game model.tabs
                            ]
                       ]
                    ++ (case model.activeModal of
                            Nothing ->
                                []

                            Just (TimePassesModal timePassed timePassesData) ->
                                [ IdleGame.Views.ModalWrapper.renderModal
                                    [ IdleGame.Views.TimePasses.render timePassed timePassesData
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



-- Ticks


updateGameToTime : Posix -> ( Posix, Game ) -> ( Posix, Game )
updateGameToTime now ( oldTick, game ) =
    let
        nextTick =
            Time.Extra.add Time.Extra.Millisecond IdleGame.Timer.tickDuration Time.utc oldTick

        shouldTick =
            Time.posixToMillis now >= Time.posixToMillis nextTick
    in
    if shouldTick then
        -- Note: be careful with the next line causing stack overflows. It is written in a particular way to allow Tail-call elimination and should stay that way.
        -- Additional reading: https://jfmengels.net/tail-call-optimization/
        updateGameToTime now ( nextTick, IdleGame.Game.tick game )

    else
        ( oldTick, game )
