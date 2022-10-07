module IdleGame.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Types exposing (Model, Msg)
import IdleGame.Views.Content
import IdleGame.Views.Drawer


init : Model
init =
    { activeTab = IdleGame.Types.Inventory
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html msg
view model =
    div [ class "bg-base-100 drawer drawer-mobile" ]
        [ input [ id "drawer", type_ "checkbox", class "drawer-toggle" ] []
        , IdleGame.Views.Content.renderContent model
        , IdleGame.Views.Drawer.renderDrawer model
        ]
