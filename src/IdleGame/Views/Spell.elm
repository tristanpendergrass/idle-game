module IdleGame.Views.Spell exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Spell as Spell
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon as Icon
import IdleGame.Views.Utils as Utils
import Types exposing (..)


renderSpellEffects : Spell -> Html FrontendMsg
renderSpellEffects spell =
    let
        stats : Spell.Stats
        stats =
            Spell.getStats spell
    in
    div []
        [ div [ class "t-column bg-info px-3 py-2 rounded text-info-content min-w-[125px]" ]
            [ div [ class "flex items-center gap-2" ]
                [ Icon.weathermancing
                    |> Icon.withSize Icon.Small
                    |> Icon.toHtml
                , div [ class "text-2xs" ] [ text "Spell effect" ]
                ]
            , div [ class "t-column font-bold" ]
                (stats.mods
                    |> List.map
                        (\mod ->
                            div [] [ text <| Utils.modToString mod ]
                        )
                )
            ]
        ]
