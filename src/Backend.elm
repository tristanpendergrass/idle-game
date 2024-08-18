module Backend exposing (app)

import AssocList as Dict exposing (Dict)
import AssocSet as Set
import BiDict.Assoc as BiDict exposing (BiDict)
import Config
import Duration
import Id exposing (Id, UserId)
import IdleGame.Game as Game exposing (..)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import Lamdera exposing (ClientId, SessionId)
import List.Extra
import List.Nonempty exposing (Nonempty)
import Random
import Task
import Time exposing (Posix)
import Time.Extra
import Types exposing (..)


init : ( BackendModel, Cmd BackendMsg )
init =
    ( { time = Time.millisToPosix 0
      , secretCounter = 0
      , userGames = Dict.empty
      , seed = Random.initialSeed 0
      , sessions = BiDict.empty
      , connections = Dict.empty
      , users = Dict.empty
      }
    , Time.now |> Task.perform BackendGotTime
    )


setSeed : Random.Seed -> BackendModel -> BackendModel
setSeed newSeed model =
    { model | seed = newSeed }


setSnapshot : SessionId -> Snapshot Game -> BackendModel -> BackendModel
setSnapshot sessionId snapshot model =
    let
        maybeUserId : Maybe (Id UserId)
        maybeUserId =
            BiDict.get sessionId model.sessions
    in
    case maybeUserId of
        Just userId ->
            { model
                | userGames = Dict.insert userId snapshot model.userGames
            }

        Nothing ->
            model


updateConnections : SessionId -> ClientId -> BackendModel -> BackendModel
updateConnections sessionId clientId model =
    { model
        | connections =
            Dict.update sessionId
                (Maybe.map (List.Nonempty.cons clientId)
                    >> Maybe.withDefault (List.Nonempty.fromElement clientId)
                    >> Just
                )
                model.connections
    }


updateUsers : (Dict (Id UserId) BackendUser -> Dict (Id UserId) BackendUser) -> BackendModel -> BackendModel
updateUsers fn model =
    { model | users = fn model.users }


update : BackendMsg -> BackendModel -> ( BackendModel, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackend ->
            ( model, Cmd.none )

        BackendGotTime time ->
            ( { model | time = time }
            , Cmd.none
            )

        HandleConnectWithTime sessionId clientId now ->
            let
                ( userId, model2 ) =
                    getOrCreateUser now sessionId model

                ( snapshot, model3 ) =
                    getOrCreateGame now userId model2

                model4 : BackendModel
                model4 =
                    model3
                        |> updateConnections sessionId clientId
            in
            ( model4
            , Cmd.batch
                [ Lamdera.sendToFrontend clientId (InitializeGame snapshot)
                , Lamdera.broadcast (GiveServerInfo (getServerInfo model4))
                ]
            )

        HandleConnect sessionId clientId ->
            ( model
            , Task.perform (HandleConnectWithTime sessionId clientId) Time.now
            )

        HandleDisconnect sessionId clientId ->
            let
                model2 : BackendModel
                model2 =
                    { model
                        | connections =
                            Dict.update sessionId
                                (Maybe.andThen (List.Nonempty.toList >> List.Extra.remove clientId >> List.Nonempty.fromList))
                                model.connections
                    }
            in
            ( model2
            , Lamdera.broadcast (GiveServerInfo (getServerInfo model2))
            )


getServerInfo : BackendModel -> ServerInfo
getServerInfo model =
    { users = model.users
    , sessions = model.sessions
    , connections = model.connections
    }


getOrCreateGame : Time.Posix -> Id UserId -> BackendModel -> ( Snapshot Game, BackendModel )
getOrCreateGame time userId model =
    case Dict.get userId model.userGames of
        Just snapshot ->
            ( snapshot, model )

        Nothing ->
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
                    Snapshot.fromTuple ( time, createGame seedForGame )

                model2 =
                    model
                        |> setSeed newSeed
                        |> updateUserGames (Dict.insert userId snapshot)
            in
            ( snapshot, model2 )


addSession : SessionId -> Id UserId -> BackendModel -> BackendModel
addSession sessionId userId model =
    { model | sessions = BiDict.insert sessionId userId model.sessions }


getOrCreateUser : Time.Posix -> SessionId -> BackendModel -> ( Id UserId, BackendModel )
getOrCreateUser time sessionId model =
    case BiDict.get sessionId model.sessions of
        Just userId ->
            ( userId, model )

        Nothing ->
            let
                ( model2, userId ) =
                    Id.getUniqueShortId (\id_ model_ -> Dict.member id_ model_.users |> not) model

                newUser : BackendUser
                newUser =
                    UnauthenticatedBackendUser { lastConnectionTime = time }

                model3 =
                    { model2 | users = Dict.insert userId newUser model2.users }
                        |> addSession sessionId userId
            in
            ( userId
            , model3
            )


updateUserGames : (Dict (Id UserId) (Snapshot Game) -> Dict (Id UserId) (Snapshot Game)) -> BackendModel -> BackendModel
updateUserGames fn model =
    { model
        | userGames = fn model.userGames
    }


getUser : Id UserId -> BackendModel -> Maybe BackendUser
getUser userId model =
    Dict.get userId model.users


getUserFromSessionId : SessionId -> BackendModel -> Maybe ( Id UserId, BackendUser )
getUserFromSessionId sessionId model =
    BiDict.get sessionId model.sessions
        |> Maybe.andThen (\userId -> getUser userId model |> Maybe.map (Tuple.pair userId))


checkLogin : SessionId -> BackendModel -> Maybe { userId : Id UserId, user : Authenticated }
checkLogin sessionId model =
    case getUserFromSessionId sessionId model of
        Just ( userId, AuthenticatedBackendUser authenticatedUser ) ->
            Just { userId = userId, user = authenticatedUser }

        _ ->
            Nothing


updateFromFrontend : SessionId -> ClientId -> ToBackend -> BackendModel -> ( BackendModel, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        CheckLoginRequest ->
            ( model, checkLogin sessionId model |> CheckLoginResponse |> Lamdera.sendToFrontend clientId )

        Save clientGameState ->
            let
                ( userId, model2 ) =
                    getOrCreateUser model.time sessionId model
            in
            ( model2
                |> updateUserGames (Dict.insert userId clientGameState)
            , Cmd.none
            )


subscriptions : BackendModel -> Sub BackendMsg
subscriptions _ =
    Sub.batch
        [ Time.every (Duration.inMilliseconds (Duration.seconds 15)) BackendGotTime
        , Lamdera.onConnect HandleConnect
        , Lamdera.onDisconnect HandleDisconnect
        ]


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }
