module Backend exposing (app)

import Dict
import IdleGame.Game
import Lamdera exposing (ClientId, SessionId)
import Random
import Task
import Time
import Types exposing (..)


init : ( BackendModel, Cmd BackendMsg )
init =
    ( { sessionGameMap = Dict.empty, seed = Random.initialSeed 0 }, Cmd.none )


setSeed : Random.Seed -> BackendModel -> BackendModel
setSeed newSeed model =
    { model | seed = newSeed }


update : BackendMsg -> BackendModel -> ( BackendModel, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )

        HandleConnectWithTime sessionId clientId now ->
            let
                ( seedForGame, newSeed ) =
                    Random.step Random.independentSeed model.seed

                gameState : GameState
                gameState =
                    Dict.get sessionId model.sessionGameMap
                        |> Maybe.withDefault { currentTime = now, lastTick = now, game = IdleGame.Game.create seedForGame }
            in
            ( model
                |> setSeed newSeed
            , Lamdera.sendToFrontend clientId (InitializeGame gameState)
            )

        HandleConnect sessionId clientId ->
            ( model, Task.perform (HandleConnectWithTime sessionId clientId) Time.now )


updateSessionGameMap : (SessionGameMap -> SessionGameMap) -> BackendModel -> BackendModel
updateSessionGameMap fn model =
    { model
        | sessionGameMap = fn model.sessionGameMap
    }


updateFromFrontend : SessionId -> ClientId -> ToBackend -> BackendModel -> ( BackendModel, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        Save clientGameState ->
            ( model
                |> updateSessionGameMap (Dict.insert sessionId clientGameState)
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
