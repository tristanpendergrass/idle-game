module IdleGame.Views.Utils exposing (..)

import FormatNumber
import FormatNumber.Locales
import Html exposing (..)
import Html.Attributes exposing (..)
import IdleGame.Xp as Xp exposing (Xp)
import Percent exposing (Percent)


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
    { combatDivider = class "z-0"
    , drawerContent = class "z-0"
    , cardBody = class "z-0"
    , activityProgressBar = class "z-10"
    , navbar = class "z-20"
    , toast = class "z-20"
    , detailViewMobile = class "z-30" -- needs to be above toast so they don't obscure the full screen detail view
    , bottomRightMenu = class "z-30"
    , drawerSide = class "z-40"
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

    else
        let
            wholeHours =
                millis // hour
        in
        if wholeHours > 0 then
            let
                displayUnit =
                    if wholeHours > 1 then
                        "hours"

                    else
                        "hour"
            in
            (intToString wholeHours ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // hour) * hour))

        else
            let
                wholeMinutes =
                    millis // minute
            in
            if wholeMinutes > 0 then
                let
                    displayUnit =
                        if wholeMinutes > 1 then
                            "minutes"

                        else
                            "minute"
                in
                (intToString wholeMinutes ++ " " ++ displayUnit) :: getDurationStringParts (millis - ((millis // minute) * minute))

            else
                let
                    wholeSeconds =
                        millis // second
                in
                if wholeSeconds > 0 then
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


xpSection : Xp -> Html msg
xpSection xp =
    let
        skillLevel : String
        skillLevel =
            Xp.level Xp.defaultSchedule xp
                |> intToString

        skillPercent : Percent
        skillPercent =
            Xp.levelPercent Xp.defaultSchedule xp
    in
    div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-orange-900" ]
        [ div [ class "t-column" ]
            [ div [ class "w-full flex items-center justify-between" ]
                [ div [ class "text-2xs font-bold" ] [ text "Skill level" ]
                , div [ class "text-2xs" ]
                    [ xp
                        |> Xp.toInt
                        |> intToString
                        |> text
                    ]
                ]
            , div [ class "w-full flex items-center gap-2" ]
                [ div [ class "text-lg font-bold p-1 bg-primary text-primary-content rounded text-center w-10" ]
                    [ text skillLevel ]
                , div [ class "flex-1 bg-base-300 rounded-full h-1.5" ]
                    [ div [ class "bg-primary h-2 rounded-full", attribute "style" ("width:" ++ String.fromFloat (Percent.toFloat skillPercent) ++ "%") ] []
                    ]
                ]
            ]
        ]


skills =
    { wrapper = class "t-column gap-4 p-6 pb-16 max-w-[1920px] min-w-[375px]"
    , grid = class "w-full grid grid-cols-2 md:grid-cols-3 2xl:grid-cols-4 gap-2 2xl:gap-4"
    , xpSection = xpSection
    }


type
    ScreenWidth
    -- Represents the width of a screen in which the game is displayed
    = ScreenXs -- Screen width < 640px
    | ScreenSm
    | ScreenMd
    | ScreenLg
    | ScreenXl
    | Screen2xl -- Screen width >= 1536px


withScreenWidth : (ScreenWidth -> Html msg) -> Html msg
withScreenWidth view =
    -- Use Tailwind breakpoints to determine the screen width
    div []
        [ div [ class "block sm:hidden" ] [ view ScreenXs ]
        , div [ class "hidden sm:block md:hidden" ] [ view ScreenSm ]
        , div [ class "hidden md:block lg:hidden" ] [ view ScreenMd ]
        , div [ class "hidden lg:block xl:hidden" ] [ view ScreenLg ]
        , div [ class "hidden xl:block 2xl:hidden" ] [ view ScreenXl ]
        , div [ class "hidden 2xl:block" ] [ view Screen2xl ]
        ]


{-| Returns true if the screen is large enough to display the game in full screen mode, with right rail and left drawer displayed.
-}
screenSupportsRighRail : ScreenWidth -> Bool
screenSupportsRighRail screenWidth =
    case screenWidth of
        ScreenXs ->
            False

        ScreenSm ->
            False

        ScreenMd ->
            False

        ScreenLg ->
            False

        ScreenXl ->
            True

        Screen2xl ->
            True
