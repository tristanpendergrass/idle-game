module ServerInfo exposing (..)

import AssocList as Dict exposing (Dict)
import AssocSet as Set exposing (Set)
import BiDict.Assoc as BiDict exposing (BiDict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Id exposing (Id, UserId)
import Lamdera exposing (ClientId, SessionId)
import List.Nonempty as Nonempty
import Types exposing (..)


username : BackendUser -> String
username user =
    case user of
        UnauthenticatedBackendUser info ->
            "Unauthenticated user"

        AuthenticatedBackendUser info ->
            "Authenticated user"


renderSession : ServerInfo -> SessionId -> Html msg
renderSession serverInfo sessionId =
    let
        connectionCount : Int
        connectionCount =
            case Dict.get sessionId serverInfo.connections of
                Just connections ->
                    Nonempty.length connections

                Nothing ->
                    0
    in
    p [] [ text ("Session (" ++ String.fromInt connectionCount ++ " connections)") ]


renderUser : ServerInfo -> ( Id UserId, BackendUser ) -> Html msg
renderUser serverInfo ( userId, user ) =
    div []
        [ text (username user)
        , ul [] (List.map (\sessionId -> li [] [ renderSession serverInfo sessionId ]) (Set.toList (BiDict.getReverse userId serverInfo.sessions)))
        ]


render : Maybe ServerInfo -> Html msg
render maybeServerInfo =
    div [ class "t-column prose prose-sm md:prose-base" ]
        [ a [ href "/" ] [ text "Home" ]
        , case maybeServerInfo of
            Nothing ->
                div [] [ text "Loading..." ]

            Just serverInfo ->
                div []
                    [ h2 [] [ text "Users" ]
                    , ul []
                        (List.map
                            (\user ->
                                li [] [ renderUser serverInfo user ]
                            )
                            (Dict.toList serverInfo.users)
                        )
                    ]
        ]
