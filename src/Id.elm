module Id exposing
    ( DeleteUserToken(..)
    , GameId(..)
    , Id(..)
    , LoginToken(..)
    , SessionIdFirst4Chars(..)
    , UserId(..)
    , cryptoHashFromString
    , cryptoHashToString
    , getUniqueId
    , getUniqueShortId
    , sessionIdFirst4CharsToString
    )

import Env
import Sha256
import Time


type UserId
    = UserId Never


type GameId
    = GameId Never


type SessionIdFirst4Chars
    = SessionIdFirst4Chars String


sessionIdFirst4CharsToString : SessionIdFirst4Chars -> String
sessionIdFirst4CharsToString (SessionIdFirst4Chars a) =
    a


type Id a
    = Id String


type LoginToken
    = LoginToken Never


type DeleteUserToken
    = DeleteUserToken Never


getUniqueId : { a | secretCounter : Int, approximateTime : Time.Posix } -> ( { a | secretCounter : Int, approximateTime : Time.Posix }, Id b )
getUniqueId model =
    ( { model | secretCounter = model.secretCounter + 1 }
    , Env.secretKey
        ++ ":"
        ++ String.fromInt model.secretCounter
        ++ ":"
        ++ String.fromInt (Time.posixToMillis model.approximateTime)
        |> Sha256.sha256
        |> Id
    )


getUniqueShortId :
    (Id b -> { a | secretCounter : Int } -> Bool)
    -> Time.Posix
    -> { a | secretCounter : Int }
    -> ( { a | secretCounter : Int }, Id b )
getUniqueShortId isUnique now model =
    let
        id =
            Env.secretKey
                ++ ":"
                ++ String.fromInt model.secretCounter
                ++ ":"
                ++ String.fromInt (Time.posixToMillis now)
                |> Sha256.sha224
                |> String.left 6
                |> Id

        newModel =
            { model | secretCounter = model.secretCounter + 1 }
    in
    if isUnique id newModel then
        ( newModel, id )

    else
        getUniqueShortId isUnique now newModel


cryptoHashToString : Id a -> String
cryptoHashToString (Id hash) =
    hash


cryptoHashFromString : String -> Maybe (Id a)
cryptoHashFromString text =
    if text == "" then
        Nothing

    else if
        String.all
            (\char ->
                let
                    code =
                        Char.toCode char
                in
                -- Only digits and lower case letters are allowed
                (0x30 <= code && code <= 0x39) || (0x61 <= code && code <= 0x66)
            )
            text
    then
        Just (Id text)

    else
        Nothing
