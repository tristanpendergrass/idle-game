module IdleGame.Views.Utils exposing (..)

import FormatNumber
import FormatNumber.Locales


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
