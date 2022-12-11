module IdleGame.Views.TimePasses exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import IdleGame.Views.Icon as Icon
import IdleGame.Views.ModalWrapper
import Json.Decode
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


render : IdleGame.Game.Game -> IdleGame.Game.TimePassesData -> Html FrontendMsg
render game { timePassed, xpGains, itemGains, itemLosses } =
    div [ class "flex flex-col justify-center items-center gap-4" ]
        [ h2 [ class "text-3xl font-bold" ] [ text "Time passes..." ]
        , span [ class "text-sm italic" ] [ text <| "(" ++ getDurationString timePassed ++ ")" ]
        , div [ classList [ ( "hidden", List.isEmpty itemLosses ) ] ]
            [ h3 [ class "text-xl font-bold" ] [ text "You used" ]
            , ul [ class "font-semibold flex flex-col items-center" ]
                (itemLosses
                    |> List.map
                        (\{ title, amount, icon } ->
                            li [ class "flex items-center gap-2" ]
                                [ span [ class "text-error" ] [ text <| String.fromInt amount ]
                                , icon
                                    |> Icon.toFeatherIcon
                                    |> FeatherIcons.withClass "inline-block"
                                    |> FeatherIcons.toHtml []
                                , span [] [ text title ]
                                ]
                        )
                )
            ]
        , div [ classList [ ( "hidden", List.isEmpty itemGains && List.isEmpty xpGains ) ] ]
            [ h3 [ class "text-xl font-bold text-center" ] [ text "You gained" ]
            , ul [ class "font-semibold flex flex-col items-center" ]
                (List.concat
                    [ xpGains
                        |> List.map
                            (\{ title, amount } ->
                                li [ class "flex items-center gap-2" ]
                                    [ span [ class "text-success" ] [ text <| String.fromInt amount ]
                                    , span [] [ text title ]
                                    ]
                            )
                    , itemGains
                        |> List.map
                            (\{ title, amount, icon } ->
                                li [ class "flex items-center gap-2" ]
                                    [ span [ class "text-success" ] [ text <| String.fromInt amount ]
                                    , icon
                                        |> Icon.toFeatherIcon
                                        |> FeatherIcons.withClass "inline-block"
                                        |> FeatherIcons.toHtml []
                                    , span [] [ text title ]
                                    ]
                            )
                    ]
                )
            ]
        , IdleGame.Views.ModalWrapper.renderCloseButton
        ]
