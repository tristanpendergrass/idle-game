module IdleGame.Views.TimePasses exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game
import IdleGame.Types exposing (..)
import Json.Decode


resourceIcon : FeatherIcons.Icon
resourceIcon =
    FeatherIcons.stopCircle
        |> FeatherIcons.withSize 16
        |> FeatherIcons.withStrokeWidth 4


getDurationString : Int -> String
getDurationString millis =
    let
        parts =
            getDurationStringHelp millis
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


getDurationStringHelp : Int -> List String
getDurationStringHelp millis =
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
        (String.fromInt wholeDays ++ " " ++ displayUnit) :: getDurationStringHelp (millis - ((millis // day) * day))

    else if wholeHours > 0 then
        let
            displayUnit =
                if wholeHours > 1 then
                    "hours"

                else
                    "hour"
        in
        (String.fromInt wholeHours ++ " " ++ displayUnit) :: getDurationStringHelp (millis - ((millis // hour) * hour))

    else if wholeMinutes > 0 then
        let
            displayUnit =
                if wholeMinutes > 1 then
                    "minutes"

                else
                    "minute"
        in
        (String.fromInt wholeMinutes ++ " " ++ displayUnit) :: getDurationStringHelp (millis - ((millis // minute) * minute))

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


render : IdleGame.Game.TimePassesData -> Html Msg
render { timePassed, gains } =
    div [ class "fixed top-0 left-0 w-full h-full bg-black bg-opacity-40 z-10 flex justify-center items-center cursor-pointer", onClick CloseTimePassesModal ]
        [ div
            [ class "bg-base-100 rounded-xl w-[512px] max-w-[90%] max-h-[90%] cursor-auto overflow-x-hidden overflow-y-auto shadow-xl p-8 animate-pop-in"
            , class "flex flex-col justify-center items-center gap-4"
            , custom "click" (Json.Decode.succeed { message = NoOp, stopPropagation = True, preventDefault = False })
            ]
            [ h2 [ class "text-3xl font-bold" ] [ text "Time passes..." ]
            , span [ class "text-sm italic" ] [ text <| "(" ++ getDurationString timePassed ++ ")" ]
            , h3 [ class "text-xl font-bold" ] [ text "You used" ]
            , ul [ class "font-semibold flex flex-col items-center" ]
                [ li [ class "flex items-center gap-2" ]
                    [ span [ class "text-error" ] [ text "1" ]
                    , resourceIcon
                        |> FeatherIcons.withClass "inline-block text-orange-500"
                        |> FeatherIcons.toHtml []
                    , span [] [ text "Copper Ore" ]
                    ]
                , li [ class "flex items-center gap-2" ]
                    [ span [ class "text-error" ] [ text "2" ]
                    , resourceIcon
                        |> FeatherIcons.withClass "inline-block text-gray-500"
                        |> FeatherIcons.toHtml []
                    , span [] [ text "Tin Ore" ]
                    ]
                ]
            , h3 [ class "text-xl font-bold" ] [ text "You gained" ]
            , ul [ class "font-semibold flex flex-col items-center" ]
                [ li [ class "flex items-center gap-2" ]
                    [ span [ class "text-success" ] [ text "643" ]
                    , span [] [ text "Woodchopping XP" ]
                    ]
                , li [ class "flex items-center gap-2" ]
                    [ span [ class "text-success" ] [ text "38" ]
                    , span [] [ text "Wood" ]
                    ]
                ]
            , button [ class "btn btn-primary", onClick CloseTimePassesModal ]
                [ text "Done" ]
            ]
        ]
