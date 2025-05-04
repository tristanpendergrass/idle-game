module Backend exposing (app)

import AssocList as Dict exposing (Dict)
import AssocSet as Set
import BiDict.Assoc as BiDict exposing (BiDict)
import Config
import Duration
import Email.Html
import Email.Html.Attributes
import EmailAddress exposing (EmailAddress)
import Env
import Html.Attributes exposing (download)
import Http
import Id exposing (GameId, Id, LoginToken, UserId)
import IdleGame.Game as Game exposing (..)
import IdleGame.Snapshot as Snapshot exposing (Snapshot)
import Lamdera exposing (ClientId, SessionId)
import List.Extra
import List.Nonempty exposing (Nonempty)
import Postmark
import Quantity
import Random
import Route exposing (Route(..))
import String.Nonempty exposing (NonemptyString(..))
import Task
import Time exposing (Posix)
import Time.Extra
import Types exposing (..)


init : ( BackendModel, Cmd BackendMsg )
init =
    ( { approximateTime = Time.millisToPosix 0
      , secretCounter = 0
      , userGames = Dict.empty
      , games = Dict.empty
      , seed = Random.initialSeed 0
      , sessions = BiDict.empty
      , connections = Dict.empty
      , users = Dict.empty
      , pendingLoginTokens = Dict.empty
      }
    , Task.perform BackendGotTime Time.now
    )


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


backendUserToFrontendUser : BackendUser -> FrontendUser
backendUserToFrontendUser backendUser =
    let
        loginStatus : LoginStatus
        loginStatus =
            case backendUser.authentication of
                NotAuthenticated unauthenticatedUser ->
                    NotLoggedIn unauthenticatedUser

                AuthenticationPending _ unauthenticatedUser ->
                    -- Instead of becoming LoginPending it's NotLoggedIn. Because LoginPending is local state on frontend, not something derived from BackendUser
                    NotLoggedIn unauthenticatedUser

                Authenticated authenticatedUser ->
                    LoggedIn authenticatedUser
    in
    { id = backendUser.id
    , loginStatus = loginStatus
    }


getGames : Id UserId -> BackendModel -> List ( Id GameId, Snapshot Game )
getGames userId model =
    Dict.get userId model.userGames
        |> Maybe.withDefault []
        |> List.filterMap
            (\gameId ->
                Dict.get gameId model.games
                    |> Maybe.map (\snapshot -> ( gameId, snapshot ))
            )


update : BackendMsg -> BackendModel -> ( BackendModel, Cmd BackendMsg )
update msg model =
    let
        noOp : ( BackendModel, Cmd BackendMsg )
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOpBackend ->
            noOp

        BackendGotTime now ->
            ( { model | approximateTime = now }, Cmd.none )

        HandleConnect sessionId clientId ->
            -- onConnect : Look up user by session id, create one if none, send user + games over
            let
                ( backendUser, model2 ) =
                    case getUserFromSessionId sessionId model of
                        Just u ->
                            ( u, model )

                        Nothing ->
                            getOrCreateUser model.approximateTime sessionId model

                model3 : BackendModel
                model3 =
                    updateConnections sessionId clientId model2
            in
            ( model3
            , Cmd.batch
                [ Lamdera.sendToFrontend clientId (SetUserAndGames ( backendUserToFrontendUser backendUser, getGames backendUser.id model3 ))
                , Lamdera.broadcast (GiveServerInfo (getServerInfo model3))
                ]
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

        SentLoginEmail email result ->
            noOp


getServerInfo : BackendModel -> ServerInfo
getServerInfo model =
    { users = model.users
    , sessions = model.sessions
    , connections = model.connections
    }


addSession : SessionId -> Id UserId -> BackendModel -> BackendModel
addSession sessionId userId model =
    { model | sessions = BiDict.insert sessionId userId model.sessions }


getOrCreateUser : Time.Posix -> SessionId -> BackendModel -> ( BackendUser, BackendModel )
getOrCreateUser now sessionId model =
    case getUser sessionId model of
        Just user ->
            ( user, model )

        Nothing ->
            let
                ( model2, newUserId ) =
                    Id.getUniqueShortId (\id_ model_ -> Dict.member id_ model_.users |> not) now model

                newUser : BackendUser
                newUser =
                    { id = newUserId
                    , lastConnectionTime = now
                    , authentication = NotAuthenticated {}
                    }

                model3 =
                    { model2 | users = Dict.insert newUserId newUser model2.users }
                        |> addSession sessionId newUserId
            in
            ( newUser
            , model3
            )


getUser : SessionId -> BackendModel -> Maybe BackendUser
getUser sessionId model =
    BiDict.get sessionId model.sessions
        |> Maybe.andThen (\userId -> Dict.get userId model.users)


getUserFromSessionId : SessionId -> BackendModel -> Maybe BackendUser
getUserFromSessionId sessionId model =
    BiDict.get sessionId model.sessions
        |> Maybe.andThen (\userId -> Dict.get userId model.users)


sessionDoesControlGame : SessionId -> Id GameId -> BackendModel -> Bool
sessionDoesControlGame sessionId gameId model =
    -- Sessions are associated with users, and users with game ids. This function chains all together to see if a session is associated with a given game
    case getUserFromSessionId sessionId model of
        Just user ->
            case Dict.get user.id model.userGames of
                Just gameIds ->
                    List.any ((==) gameId) gameIds

                Nothing ->
                    False

        Nothing ->
            False


sendToFrontends : List ClientId -> ToFrontend -> Cmd BackendMsg
sendToFrontends clientIds toFrontend =
    List.map (\clientId -> Lamdera.sendToFrontend clientId toFrontend) clientIds |> Cmd.batch


findUserWithEmail : EmailAddress -> Dict (Id UserId) BackendUser -> Maybe ( Id UserId, BackendUser )
findUserWithEmail emailQuery users =
    Dict.toList users
        |> List.Extra.find
            (\( _, user ) ->
                case user.authentication of
                    Authenticated { emailAddress } ->
                        emailAddress == emailQuery

                    _ ->
                        False
            )


frontendUserFromBackendUser : BackendUser -> FrontendUser
frontendUserFromBackendUser backendUser =
    let
        loginStatus : LoginStatus
        loginStatus =
            case backendUser.authentication of
                NotAuthenticated unauthenticatedUser ->
                    NotLoggedIn unauthenticatedUser

                AuthenticationPending _ unauthenticatedUser ->
                    NotLoggedIn unauthenticatedUser

                Authenticated authenticatedUser ->
                    LoggedIn authenticatedUser
    in
    { id = backendUser.id
    , loginStatus = loginStatus
    }


{-| Note this function works with logging in existing user and creating new user
-}
loginWithToken :
    SessionId
    -> ClientId
    -> Maybe LoginTokenData
    -> BackendModel
    -> ( BackendModel, Cmd BackendMsg )
loginWithToken sessionId clientId maybeLoginTokenData model =
    let
        loginResponse : ( Id UserId, BackendUser, List ( Id GameId, Snapshot Game ) ) -> Cmd BackendMsg
        loginResponse ( userId, userEntry, games ) =
            case Dict.get sessionId model.connections of
                Just clientIds ->
                    sendToFrontends (List.Nonempty.toList clientIds) (SetUserAndGames ( frontendUserFromBackendUser userEntry, games ))

                Nothing ->
                    Cmd.none
    in
    case maybeLoginTokenData of
        Just { creationTime, emailAddress } ->
            if Duration.from creationTime model.approximateTime |> Quantity.lessThan Duration.hour then
                case findUserWithEmail emailAddress model.users of
                    Just ( userId, user ) ->
                        let
                            model2 : BackendModel
                            model2 =
                                addSession sessionId userId model
                        in
                        ( model2
                        , loginResponse ( userId, user, getGames userId model2 )
                        )

                    Nothing ->
                        let
                            ( model2, userId ) =
                                Id.getUniqueShortId (\id_ model_ -> Dict.member id_ model_.users |> not) model.approximateTime model

                            newUser : BackendUser
                            newUser =
                                { id = userId
                                , lastConnectionTime = model.approximateTime
                                , authentication = Authenticated { emailAddress = emailAddress }
                                }

                            model3 =
                                { model2 | users = Dict.insert userId newUser model2.users }
                                    |> addSession sessionId userId
                        in
                        ( model3
                        , loginResponse ( userId, newUser, getGames userId model3 )
                        )

            else
                -- The login token was correct but is too old so we don't allow the login
                ( model, Cmd.none )

        Nothing ->
            -- For some reason the user tried to use a login token we hadn't saved on backend
            ( model, Cmd.none )


getAndRemoveLoginToken :
    (Maybe LoginTokenData -> BackendModel -> ( BackendModel, cmds ))
    -> Id LoginToken
    -> BackendModel
    -> ( BackendModel, cmds )
getAndRemoveLoginToken updateFunc loginToken model =
    updateFunc
        (Dict.get loginToken model.pendingLoginTokens)
        { model | pendingLoginTokens = Dict.remove loginToken model.pendingLoginTokens }


noReplyEmailAddress : Maybe EmailAddress
noReplyEmailAddress =
    EmailAddress.fromString "idlegame@tristanpendergrass.com"


loginEmailSubject : NonemptyString
loginEmailSubject =
    NonemptyString 'I' "dle Game login link"


loginEmailLink : Route -> Id LoginToken -> String
loginEmailLink route loginToken =
    Env.domain ++ Route.encodeWithToken route (Route.LoginToken loginToken)


loginEmailContent : Route -> Id LoginToken -> Email.Html.Html
loginEmailContent route loginToken =
    let
        loginLink : String
        loginLink =
            loginEmailLink route loginToken
    in
    Email.Html.div
        [ Email.Html.Attributes.padding "8px" ]
        [ Email.Html.a
            [ Email.Html.Attributes.href loginLink ]
            [ Email.Html.text "Click here to log in." ]
        , Email.Html.text " If you didn't request this email then it's safe to ignore it."
        ]


sendLoginEmail :
    (Result Http.Error Postmark.PostmarkSendResponse -> BackendMsg)
    -> EmailAddress
    -> Route
    -> Id LoginToken
    -> Cmd BackendMsg
sendLoginEmail msg emailAddress route loginToken =
    case noReplyEmailAddress of
        Just sender ->
            { from = { name = "Idlegame", email = sender }
            , to = List.Nonempty.fromElement { name = "", email = emailAddress }
            , subject = loginEmailSubject
            , body = Postmark.BodyHtml (loginEmailContent route loginToken)
            , messageStream = "outbound"
            }
                |> Postmark.sendEmail msg Env.postmarkServerToken

        Nothing ->
            Cmd.none


updateFromFrontend : SessionId -> ClientId -> ToBackend -> BackendModel -> ( BackendModel, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    let
        noOp : ( BackendModel, Cmd BackendMsg )
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        RegisterEmailRequest route email ->
            let
                ( model2, loginToken ) =
                    Id.getUniqueId model
            in
            ( { model2
                | pendingLoginTokens =
                    Dict.insert
                        loginToken
                        { creationTime = model2.approximateTime, emailAddress = email }
                        model2.pendingLoginTokens
              }
            , sendLoginEmail (SentLoginEmail email) email route loginToken
            )

        LoginWithEmailRequest route email ->
            let
                ( model2, loginToken ) =
                    Id.getUniqueId model
            in
            ( { model2
                | pendingLoginTokens =
                    Dict.insert
                        loginToken
                        { creationTime = model2.approximateTime, emailAddress = email }
                        model2.pendingLoginTokens
              }
            , sendLoginEmail (SentLoginEmail email) email route loginToken
            )

        LoginWithTokenRequest loginToken ->
            getAndRemoveLoginToken (loginWithToken sessionId clientId) loginToken model

        LogoutRequest ->
            let
                model2 : BackendModel
                model2 =
                    { model | sessions = BiDict.remove sessionId model.sessions }

                ( backendUser, model3 ) =
                    getOrCreateUser model.approximateTime sessionId model2

                model4 : BackendModel
                model4 =
                    addSession sessionId backendUser.id model3
            in
            ( model4
            , Cmd.batch
                [ Lamdera.sendToFrontend clientId (SetUserAndGames ( backendUserToFrontendUser backendUser, getGames backendUser.id model4 ))
                , Lamdera.broadcast (GiveServerInfo (getServerInfo model4))
                ]
            )

        CreateGameRequest ->
            case getUser sessionId model of
                Nothing ->
                    noOp

                Just userEntry ->
                    let
                        ( seedForGame, newSeed ) =
                            Random.step Random.independentSeed model.seed

                        createGame : Random.Seed -> Game
                        createGame =
                            if Config.flags.isDev then
                                Game.createDev

                            else
                                Game.createProd

                        ( model2, gameId ) =
                            Id.getUniqueId model

                        game : Game
                        game =
                            createGame seedForGame

                        snapshot : Snapshot Game
                        snapshot =
                            Snapshot.fromTuple ( model.approximateTime, game )

                        newGames : List ( Id GameId, Snapshot Game )
                        newGames =
                            ( gameId, snapshot )
                                :: getGames userEntry.id model

                        model3 =
                            { model2
                                | seed = newSeed
                                , games = Dict.insert gameId snapshot model2.games
                                , userGames =
                                    Dict.insert userEntry.id (List.map Tuple.first newGames) model2.userGames
                            }

                        clientIds : List ClientId
                        clientIds =
                            case Dict.get sessionId model3.connections of
                                Just ids ->
                                    List.Nonempty.toList ids

                                Nothing ->
                                    []
                    in
                    ( model3, sendToFrontends clientIds (SetUserAndGames ( frontendUserFromBackendUser userEntry, newGames )) )

        SaveGame gameId game ->
            let
                sessionControlsGame : Bool
                sessionControlsGame =
                    sessionDoesControlGame sessionId gameId model
            in
            if sessionControlsGame then
                ( { model | games = Dict.insert gameId game model.games }, Cmd.none )

            else
                -- This shouldn't happen but one can't trust the frontend
                ( model, Cmd.none )


subscriptions : BackendModel -> Sub BackendMsg
subscriptions _ =
    Sub.batch
        [ Time.every (Duration.inMilliseconds (Duration.seconds 15)) BackendGotTime -- Lamdera asks us not to run this too often. 15 seconds seems good enough for "approximate time"
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
