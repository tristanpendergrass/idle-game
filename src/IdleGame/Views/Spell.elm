module IdleGame.Views.Spell exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Spell as Spell
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Utils as Utils
import Types exposing (..)


renderSpellEffects : Spell -> Html FrontendMsg
renderSpellEffects spell =
    let
        stats : Spell.Stats
        stats =
            Spell.getStats spell
    in
    div [ class "t-column" ]
        (stats.mods
            |> List.map
                (\mod ->
                    div [ class "bg-info py-1 px-2 rounded text-info-content" ] [ text <| Utils.modToString mod ]
                )
        )
