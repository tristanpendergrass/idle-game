module Route exposing (Route(..), Token(..), decode, encode, encodeWithToken)

import Id exposing (Id, LoginToken)
import Url exposing (Url)
import Url.Builder
import Url.Parser exposing ((</>), (<?>))
import Url.Parser.Query


type Route
    = RootRoute
    | ServerInfoRoute


decode : Url -> Maybe ( Route, Token )
decode url =
    Url.Parser.oneOf
        [ Url.Parser.top |> Url.Parser.map RootRoute
        , Url.Parser.s "server-info" |> Url.Parser.map ServerInfoRoute
        ]
        <?> decodeToken
        |> Url.Parser.map Tuple.pair
        |> (\a -> Url.Parser.parse a url)


decodeToken : Url.Parser.Query.Parser Token
decodeToken =
    Url.Parser.Query.map
        (\maybeLoginToken ->
            case maybeLoginToken of
                Just token ->
                    LoginToken token

                Nothing ->
                    NoToken
        )
        (Url.Parser.Query.string loginTokenName |> Url.Parser.Query.map (Maybe.andThen Id.cryptoHashFromString))


loginTokenName : String
loginTokenName =
    "login-token"


type Token
    = NoToken
    | LoginToken (Id LoginToken)


encode : Route -> String
encode route =
    encodeWithToken route NoToken


encodeWithToken : Route -> Token -> String
encodeWithToken route token =
    Url.Builder.absolute
        (case route of
            RootRoute ->
                []

            ServerInfoRoute ->
                [ "server-info" ]
        )
        (case token of
            LoginToken loginToken ->
                [ Url.Builder.string loginTokenName (Id.cryptoHashToString loginToken) ]

            NoToken ->
                []
        )
