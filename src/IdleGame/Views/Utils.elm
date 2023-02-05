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
    }
