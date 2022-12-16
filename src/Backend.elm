module Backend exposing (app)

import Dict
import IdleGame.Game
import Lamdera exposing (ClientId, SessionId)
import Task
import Time
import Types exposing (..)


init : ( BackendModel, Cmd BackendMsg )
init =
    ( { sessionGameMap = Dict.empty }, Cmd.none )


update : BackendMsg -> BackendModel -> ( BackendModel, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )

        HandleConnectWithTime sessionId clientId now ->
            let
                gameState : GameState
                gameState =
                    Dict.get sessionId model.sessionGameMap
                        |> Maybe.withDefault { currentTime = now, lastTick = now, game = IdleGame.Game.create }
            in
            ( model, Lamdera.sendToFrontend clientId (UpdateGameState gameState) )

        HandleConnect sessionId clientId ->
            ( model, Task.perform (HandleConnectWithTime sessionId clientId) Time.now )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> BackendModel -> ( BackendModel, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        Save clientGameState ->
            ( { model
                | sessionGameMap =
                    model.sessionGameMap
                        |> Dict.insert sessionId clientGameState
              }
            , Cmd.none
            )


subscriptions : BackendModel -> Sub BackendMsg
subscriptions _ =
    Sub.batch
        [ Lamdera.onConnect HandleConnect
        ]


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }
