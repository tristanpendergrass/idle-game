module IdleGame.Views.DebugPanel exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import IdleGame.Views.Utils as Utils
import Types exposing (..)


render : FrontendModel -> Html FrontendMsg
render model =
    div
        [ class "fixed bottom-0 w-screen h-48 bg-accent text-accent-content border-t border-accent-content"
        , Utils.zIndexes.debugPanel
        ]
        []
