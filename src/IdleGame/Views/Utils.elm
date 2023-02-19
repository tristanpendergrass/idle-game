module IdleGame.Views.Utils exposing (..)

import FormatNumber
import FormatNumber.Locales
import Html exposing (..)
import Html.Attributes exposing (..)


intToString : Int -> String
intToString num =
    let
        localeForInts : FormatNumber.Locales.Locale
        localeForInts =
            FormatNumber.Locales.usLocale
                |> (\usLocale ->
                        { usLocale | decimals = FormatNumber.Locales.Exact 0 }
                   )
    in
    FormatNumber.format localeForInts (toFloat num)


floatToString : Int -> Float -> String
floatToString decimals =
    let
        localeForFloats : FormatNumber.Locales.Locale
        localeForFloats =
            FormatNumber.Locales.usLocale
                |> (\usLocale ->
                        { usLocale | decimals = FormatNumber.Locales.Max decimals }
                   )
    in
    FormatNumber.format localeForFloats


skillXpBadge : Html msg
skillXpBadge =
    div [ class "badge badge-primary badge-xs col-span-8" ] [ text "Skill XP" ]


masteryXpBadge : Html msg
masteryXpBadge =
    div [ class "badge badge-secondary badge-xs col-span-8" ] [ text "Mastery XP" ]


zIndexes =
    -- Note that tailwind z-indexes only allow 0 through 50, in increments of 10. See https://tailwindcss.com/docs/z-index
    { drawerContent = class "z-0"
    , cardBody = class "z-0"
    , activityProgressBar = class "z-10"
    , navbar = class "z-20"
    , toast = class "z-20"
    , bottomRightMenu = class "z-30"
    , modalWrapper = class "z-40"
    , debugPanel = class "z-50"
    }


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
        (intToString wholeDays ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // day) * day))

    else if wholeHours > 0 then
        let
            displayUnit =
                if wholeHours > 1 then
                    "hours"

                else
                    "hour"
        in
        (intToString wholeHours ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // hour) * hour))

    else if wholeMinutes > 0 then
        let
            displayUnit =
                if wholeMinutes > 1 then
                    "minutes"

                else
                    "minute"
        in
        (intToString wholeMinutes ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // minute) * minute))

    else if wholeSeconds > 0 then
        let
            displayUnit =
                if wholeSeconds > 1 then
                    "seconds"

                else
                    "second"
        in
        [ intToString wholeSeconds ++ " " ++ displayUnit ]

    else
        []
