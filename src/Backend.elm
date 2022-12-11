module Backend exposing (app)

import Lamdera exposing (ClientId, SessionId)
import Types exposing (..)


init : ( BackendModel, Cmd BackendMsg )
init =
    ( { message = "Why hello there" }, Cmd.none )


update : BackendMsg -> BackendModel -> ( BackendModel, Cmd BackendMsg )
update msg model =
    ( model, Cmd.none )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> BackendModel -> ( BackendModel, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    ( model, Cmd.none )


subscriptions : BackendModel -> Sub BackendMsg
subscriptions model =
    Sub.none


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }
