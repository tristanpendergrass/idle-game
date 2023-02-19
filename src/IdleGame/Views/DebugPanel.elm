module IdleGame.Views.DebugPanel exposing (..)

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


render : FrontendModel -> Html FrontendMsg
render model =
    div
        [ class "fixed bottom-0 w-screen h-48 bg-accent text-accent-content border-t border-accent-content relative"
        , classList [ ( "hidden", not model.showDebugPanel ) ]
        , Utils.zIndexes.debugPanel
        , id panelId
        ]
        [ div [ class "absolute top-0 right-0" ]
            [ button
                [ onClick CloseDebugPanel
                , class "btn btn-ghost btn-icon"
                ]
                [ Icon.close
                    |> Icon.toHtml
                ]
            ]
        ]
