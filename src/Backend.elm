module Backend exposing (app)

import Config
import Dict
import IdleGame.Game as Game exposing (..)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import Lamdera exposing (ClientId, SessionId)
import Random
import Task
import Time exposing (Posix)
import Time.Extra
import Types exposing (..)


init : ( BackendModel, Cmd BackendMsg )
init =
    ( { sessionGameMap = Dict.empty, seed = Random.initialSeed 0 }, Cmd.none )


setSeed : Random.Seed -> BackendModel -> BackendModel
setSeed newSeed model =
    { model | seed = newSeed }


setSnapshot : SessionId -> Snapshot Game -> BackendModel -> BackendModel
setSnapshot sessionId snapshot model =
    { model | sessionGameMap = Dict.insert sessionId snapshot model.sessionGameMap }


update : BackendMsg -> BackendModel -> ( BackendModel, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackend ->
            ( model, Cmd.none )

        HandleConnectWithTime sessionId clientId now ->
            let
                ( seedForGame, newSeed ) =
                    Random.step Random.independentSeed model.seed

                createGame : Random.Seed -> Game
                createGame =
                    if Config.flags.isDev then
                        Game.createDev

                    else
                        Game.createProd

                snapshot : Snapshot Game
                snapshot =
                    Dict.get sessionId model.sessionGameMap
                        |> Maybe.withDefault
                            (Snapshot.fromTuple ( now, createGame seedForGame ))
            in
            ( model
                |> setSeed newSeed
                |> setSnapshot sessionId snapshot
            , Lamdera.sendToFrontend clientId (InitializeGame snapshot)
            )

        HandleConnect sessionId clientId ->
            ( model, Task.perform (HandleConnectWithTime sessionId clientId) Time.now )


updateSessionGameMap : (SessionGameMap -> SessionGameMap) -> BackendModel -> BackendModel
updateSessionGameMap fn model =
    { model
        | sessionGameMap = fn model.sessionGameMap
    }


updateFromFrontend : SessionId -> ClientId -> ToBackend -> BackendModel -> ( BackendModel, Cmd BackendMsg )
updateFromFrontend sessionId _ msg model =
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
    Lamdera.onConnect HandleConnect


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }
