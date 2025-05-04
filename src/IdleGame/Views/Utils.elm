module IdleGame.Views.Utils exposing (..)

import FormatNumber
import FormatNumber.Locales
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import Json.Encode
import Percent exposing (Percent)
import Types exposing (..)


intToString : Int -> String
intToString num =
    let
        usLocale : FormatNumber.Locales.Locale
        usLocale =
            FormatNumber.Locales.usLocale

        localeForInts : FormatNumber.Locales.Locale
        localeForInts =
            { usLocale | decimals = FormatNumber.Locales.Exact 0 }
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


skillXpBadge : Skill -> Html msg
skillXpBadge skill =
    div [ class "badge badge-primary badge-sm col-span-8 flex items-center gap-2" ]
        [ (getSkillStats skill).icon
            |> Icon.withSize Icon.Small
            |> Icon.toHtml
        , text "Skill XP"
        ]


masteryXpBadge : Html msg
masteryXpBadge =
    div [ class "badge badge-secondary badge-sm col-span-8" ] [ text "Mastery XP" ]


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


classTopNav : { skill : Skill, xp : Xp } -> Html FrontendMsg
classTopNav { skill, xp } =
    let
        skillLevel : Int
        skillLevel =
            Xp.level Xp.defaultSchedule xp

        skillPercent : Percent
        skillPercent =
            Xp.levelPercent Xp.defaultSchedule xp
    in
    div [ class "w-full bg-base-200 rounded-lg p-4 border-t-4 border-orange-900" ]
        [ div [ classes.column ]
            [ div [ class "w-full flex items-center justify-between" ]
                [ div [ class "text-2xs font-bold" ] [ text "Skill level" ]
                , div [ class "text-2xs" ]
                    [ xp
                        |> Xp.toInt
                        |> intToString
                        |> text
                    ]
                ]
            , progressBar { progressText = intToString skillLevel, percent = skillPercent, primaryOrSecondary = Primary, size = ProgressBarLarge }
            , button [ class "btn btn-neutral btn-outline", onClick (HandleSyllabusClick skill) ] [ text "Syllabus" ]
            ]
        ]


type PrimaryOrSecondary
    = Primary
    | Secondary


type ProgressBarSize
    = ProgressBarSmall
    | ProgressBarLarge


progressBar : { progressText : String, percent : Percent, primaryOrSecondary : PrimaryOrSecondary, size : ProgressBarSize } -> Html msg
progressBar { progressText, percent, primaryOrSecondary, size } =
    let
        ( backgroundClass, textColorClass ) =
            case primaryOrSecondary of
                Primary ->
                    ( class "bg-primary", class "text-primary-content" )

                Secondary ->
                    ( class "bg-secondary", class "text-secondary-content" )

        ( textSizeClass, levelBoxWidthClass ) =
            case size of
                ProgressBarSmall ->
                    ( class "text-xs p-1", class "min-w-[2rem]" )

                ProgressBarLarge ->
                    ( class "text-lg px-2 py-1", class "min-w-[2.5rem]" )
    in
    div [ class "w-full flex items-center gap-2" ]
        [ div [ class "font-bold rounded text-center box-content", backgroundClass, textColorClass, textSizeClass, levelBoxWidthClass ]
            [ text progressText ]
        , progress
            [ class "progress w-full"
            , case primaryOrSecondary of
                Primary ->
                    class "progress-primary"

                Secondary ->
                    class "progress-secondary"
            , Html.Attributes.max "100"
            , Html.Attributes.value (String.fromFloat (Percent.toPercentage percent))
            , attribute "aria-label" "progress towards next experience level"
            ]
            []
        ]


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


resourceAndQuantity : { resource : Resource, quantity : Int, iconSize : Icon.Size } -> Html msg
resourceAndQuantity params =
    div [ class "relative" ]
        [ renderResource { resource = params.resource, iconSize = params.iconSize }
        , div [ class "absolute left-1/2 transform -translate-x-1/2 -bottom-3" ]
            [ resourceQuantity { quantity = params.quantity }
            ]
        ]


renderResource : { resource : Resource, iconSize : Icon.Size } -> Html msg
renderResource params =
    let
        stats : ResourceStats
        stats =
            getResourceStats params.resource
    in
    div [ class "border-2 border-primary bg-primary/50 rounded relative" ]
        [ stats.icon
            |> Icon.withSize params.iconSize
            |> Icon.toHtml
        ]


resourceQuantity : { quantity : Int } -> Html msg
resourceQuantity { quantity } =
    span [ class "px-4 bg-base-100 text-base-content border border-1 border-base-content rounded-xl text-sm font-semibold max-w-full bg-neutral text-neutral-content" ]
        [ text (intToString quantity)
        ]


percentToString : Percent -> String
percentToString percent =
    floatToString 4 (Percent.toPercentage percent) ++ "%"


priceLabel : { price : Coin, isError : Bool } -> Html msg
priceLabel { price, isError } =
    div [ class "flex items-center gap-1 " ]
        [ Icon.coin
            |> Icon.toHtml
        , div
            [ class "font-bold"
            , classList [ ( "text-error", isError ) ]
            ]
            [ text (intToString (Coin.toInt price)) ]
        ]


classes =
    { card =
        { container = class "card card-compact bg-base-100 shadow-xl border-b border-l border-r"
        , containerClickable = class "cursor-pointer bubble-pop select-none"
        , activityTypeBadge = class "badge badge-neutral badge-xs"
        , imageContainer = class "min-h-[6rem] h-24 relative"
        , title = class "text-sm  md:text-lg text-center flex items-center gap-2"
        }
    , column = class "flex flex-col items-center w-full gap-2"
    }


cardImage : CardImage -> Html msg
cardImage image =
    case image of
        CardLandscape imgSrc ->
            img
                [ src imgSrc
                , class "h-full w-full object-cover"
                ]
                []

        CardIcon icon ->
            div
                [ class "h-full w-full flex items-center justify-center bg-accent" ]
                [ icon
                    |> Icon.withSize Icon.Large
                    |> Icon.toHtml
                ]


indeterminate : Bool -> Attribute msg
indeterminate isIndeterminate =
    property "indeterminate" (Json.Encode.bool isIndeterminate)
