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


render : FrontendModel -> Html FrontendMsg
render model =
    let
        closeButton =
            button [ onClick CloseDebugPanel, class "btn btn-ghost btn-icon" ]
                [ Icon.close
                    |> Icon.toHtml
                ]

        addTimeButton =
            button [ onClick (AddTime (Duration.hours 8)), class "btn" ] [ text "Add 8 hrs" ]

        toggleTimePassesCheckbox =
            label
                [ class "label cursor-pointer justify-start gap-2"
                ]
                [ input
                    [ type_ "checkbox"
                    , class "checkbox"
                    , checked model.showTimePasses
                    , onCheck ToggleTimePasses
                    ]
                    []
                , span [] [ text "Show Time Passes" ]
                ]
    in
    div
        [ class "fixed bottom-0 w-screen h-48 bg-accent text-accent-content border-t border-accent-content relative p-2"
        , classList [ ( "hidden", not model.showDebugPanel ) ]
        , Utils.zIndexes.debugPanel
        , id panelId
        ]
        [ addTimeButton
        , toggleTimePassesCheckbox
        , div [ class "absolute top-0 right-0" ] [ closeButton ]
        ]
