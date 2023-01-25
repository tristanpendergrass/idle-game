module IdleGame.Views.TimePasses exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (TimePassesData)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.ModalWrapper
import Maybe.Extra
import Time exposing (Posix)
import Types exposing (..)


resourceIcon : FeatherIcons.Icon
resourceIcon =
    FeatherIcons.stopCircle
        |> FeatherIcons.withSize 16
        |> FeatherIcons.withStrokeWidth 4


getDurationString : Int -> String
getDurationString millis =
    let
        parts =
            getDurationStringParts millis
    in
    case parts of
        [] ->
            "0 seconds"

        _ ->
            String.join ", " parts


second : Int
second =
    1000


minute : Int
minute =
    60 * second


hour : Int
hour =
    60 * minute


day : Int
day =
    24 * hour


getDurationStringParts : Int -> List String
getDurationStringParts millis =
    let
        wholeDays =
            millis // day

        wholeHours =
            millis // hour

        wholeMinutes =
            millis // minute

        wholeSeconds =
            millis // second
    in
    if wholeDays > 0 then
        let
            displayUnit =
                if wholeDays > 1 then
                    "days"

                else
                    "day"
        in
        (String.fromInt wholeDays ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // day) * day))

    else if wholeHours > 0 then
        let
            displayUnit =
                if wholeHours > 1 then
                    "hours"

                else
                    "hour"
        in
        (String.fromInt wholeHours ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // hour) * hour))

    else if wholeMinutes > 0 then
        let
            displayUnit =
                if wholeMinutes > 1 then
                    "minutes"

                else
                    "minute"
        in
        (String.fromInt wholeMinutes ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // minute) * minute))

    else if wholeSeconds > 0 then
        let
            displayUnit =
                if wholeSeconds > 1 then
                    "seconds"

                else
                    "second"
        in
        [ String.fromInt wholeSeconds ++ " " ++ displayUnit ]

    else
        []


render : Posix -> TimePassesData -> Html FrontendMsg
render timePassed { xpGains, goldGains, resourceGains, resourceLosses } =
    div [ class "t-column gap-4" ]
        [ h2 [ class "text-3xl font-bold" ] [ text "Time passes..." ]
        , span [ class "text-sm italic" ] [ text <| "(" ++ getDurationString (Time.posixToMillis timePassed) ++ ")" ]
        , div [ classList [ ( "hidden", List.isEmpty resourceLosses ) ] ]
            [ h3 [ class "text-xl font-bold" ] [ text "You used" ]
            , ul [ class "t-column font-semibold" ]
                (resourceLosses
                    |> List.map
                        (\{ title, amount } ->
                            li [ class "flex items-center gap-2" ]
                                [ span [ class "text-error" ] [ text <| String.fromInt amount ]
                                , span [] [ text title ]
                                ]
                        )
                )
            ]
        , div [ classList [ ( "hidden", List.isEmpty resourceGains && List.isEmpty xpGains && Maybe.Extra.isNothing goldGains ) ] ]
            [ h3 [ class "text-xl font-bold text-center" ] [ text "You gained" ]
            , case goldGains of
                Nothing ->
                    div [] []

                Just amount ->
                    div [ class "flex items-center gap-2" ]
                        [ span [ class "text-success" ] [ text <| String.fromInt amount ]
                        , span [] [ text "Gold" ]
                        ]
            , ul [ class "t-column font-semibold" ]
                (List.concat
                    [ xpGains
                        |> List.map
                            (\{ title, amount } ->
                                li [ class "flex items-center gap-2" ]
                                    [ span [ class "text-success" ] [ text <| String.fromInt amount ]
                                    , span [] [ text title ]
                                    ]
                            )
                    , resourceGains
                        |> List.map
                            (\{ title, amount } ->
                                li [ class "flex items-center gap-2" ]
                                    [ span [ class "text-success" ] [ text <| String.fromInt amount ]
                                    , span [] [ text title ]
                                    ]
                            )
                    ]
                )
            ]
        , IdleGame.Views.ModalWrapper.renderCloseButton
        ]
