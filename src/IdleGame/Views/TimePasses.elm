module IdleGame.Views.TimePasses exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (TimePassesData)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.ModalWrapper
import IdleGame.Views.Utils
import IdleGame.XpFormulas as XpFormulas
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
        (IdleGame.Views.Utils.intToString wholeDays ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // day) * day))

    else if wholeHours > 0 then
        let
            displayUnit =
                if wholeHours > 1 then
                    "hours"

                else
                    "hour"
        in
        (IdleGame.Views.Utils.intToString wholeHours ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // hour) * hour))

    else if wholeMinutes > 0 then
        let
            displayUnit =
                if wholeMinutes > 1 then
                    "minutes"

                else
                    "minute"
        in
        (IdleGame.Views.Utils.intToString wholeMinutes ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // minute) * minute))

    else if wholeSeconds > 0 then
        let
            displayUnit =
                if wholeSeconds > 1 then
                    "seconds"

                else
                    "second"
        in
        [ IdleGame.Views.Utils.intToString wholeSeconds ++ " " ++ displayUnit ]

    else
        []


render : Posix -> TimePassesData -> Html FrontendMsg
render timePassed { xpGains, goldGains, resourcesDiff } =
    div [ class "t-column gap-4" ]
        [ h2 [ class "text-3xl font-bold" ] [ text "Time passes..." ]
        , span [ class "text-sm italic" ] [ text <| "(" ++ getDurationString (Time.posixToMillis timePassed) ++ ")" ]
        , div []
            [ h3 [ class "text-xl font-bold text-center" ] [ text "You gained" ]
            , div [ class "divider" ] []
            , ul [ class "t-column font-semibold" ]
                (List.concat
                    [ case goldGains of
                        Nothing ->
                            []

                        Just amount ->
                            [ li [ class "flex items-center gap-2" ]
                                [ span [ class "text-success" ] [ text <| IdleGame.Views.Utils.intToString amount ]
                                , Icon.gold
                                    |> Icon.toHtml
                                , span [] [ text "Gold" ]
                                ]
                            ]
                    , xpGains
                        |> List.map
                            (\{ title, originalXp, currentXp } ->
                                let
                                    displayAmount =
                                        (currentXp - originalXp)
                                            |> floor

                                    originalLevel =
                                        XpFormulas.skillLevel originalXp

                                    currentLevel =
                                        XpFormulas.skillLevel currentXp
                                in
                                li [ class "flex items-center gap-2" ]
                                    [ span [ class "text-success" ] [ text <| IdleGame.Views.Utils.intToString displayAmount ]
                                    , span [] [ text title ]
                                    , if originalLevel /= currentLevel then
                                        span [] [ text <| "(Level " ++ IdleGame.Views.Utils.intToString originalLevel ++ " -> " ++ IdleGame.Views.Utils.intToString currentLevel ++ ")" ]

                                      else
                                        span [] []
                                    ]
                            )
                    , resourcesDiff
                        |> Resource.mapDiff
                            (\amount resource ->
                                li [ class "flex items-center gap-2", classList [ ( "hidden", amount == 0 ) ] ]
                                    [ span [ class "text-success" ] [ text <| IdleGame.Views.Utils.intToString amount ]
                                    , (Resource.getStats resource).icon
                                        |> Icon.toHtml
                                    , span [] [ text <| (Resource.getStats resource).title ]
                                    ]
                            )
                    ]
                )
            ]
        , IdleGame.Views.ModalWrapper.renderCloseButton
        ]
