module IdleGame.Views.DebugPanel exposing (..)

import Duration exposing (Duration)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils as Utils
import Types exposing (..)


panelId : String
panelId =
    "debug-panel"


renderOpenButton : Html FrontendMsg
renderOpenButton =
    button
        [ onClick OpenDebugPanel
        , class "btn btn-square btn-accent"
        ]
        [ Icon.debug
            |> Icon.toHtml
        ]


render : LoadedFrontend -> Html FrontendMsg
render model =
    let
        closeButton =
            button [ onClick CloseDebugPanel, class "btn btn-ghost btn-icon" ]
                [ Icon.close
                    |> Icon.toHtml
                ]
    in
    div
        [ class "fixed flex gap-4 top-0 w-full h-48 bg-accent text-accent-content border-t border-accent-content p-2"
        , classList [ ( "hidden", not model.showDebugPanel ) ]
        , Utils.zIndexes.debugPanel
        , id panelId
        ]
        [ button [ onClick (AddTime (Duration.minutes 30)), class "btn" ] [ text "Add 30 min" ]
        , button [ onClick (AddTime (Duration.hours 8)), class "btn" ] [ text "Add 8 hrs" ]
        , button [ onClick (AddTime (Duration.days 3)), class "btn" ] [ text "Add 3 days" ]
        , button [ onClick (AddTime (Duration.days 30)), class "btn" ] [ text "Add 30 days" ]
        , button [ onClick (AddTime (Duration.days 365)), class "btn" ] [ text "Add 1 year" ]
        , div [ class "absolute top-0 right-0" ] [ closeButton ]
        ]
