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
