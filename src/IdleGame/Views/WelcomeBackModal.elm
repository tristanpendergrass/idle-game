module IdleGame.Views.WelcomeBackModal exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Types exposing (..)
import Json.Decode


oreIcon : FeatherIcons.Icon
oreIcon =
    FeatherIcons.stopCircle
        |> FeatherIcons.withSize 16
        |> FeatherIcons.withStrokeWidth 4


render : Model -> Html Msg
render model =
    div [ class "fixed top-0 left-0 w-full h-full bg-black bg-opacity-40 z-10 flex justify-center items-center cursor-pointer", onClick CloseWelcomeBackModal ]
        [ div
            [ class "bg-base-100 rounded-xl w-[512px] max-w-[90%] max-h-[90%] cursor-auto overflow-x-hidden overflow-y-auto shadow-xl p-8 animate-pop-in"
            , class "flex flex-col justify-center items-center gap-4"
            , custom "click" (Json.Decode.succeed { message = NoOp, stopPropagation = True, preventDefault = False })
            ]
            [ h2 [ class "text-3xl font-bold" ] [ text "Time passes..." ]
            , span [ class "text-sm italic" ] [ text "(10 minutes 43 seconds)" ]
            , h3 [ class "text-xl font-bold" ] [ text "You used" ]
            , ul [ class "font-semibold flex flex-col items-center" ]
                [ li [ class "flex items-center gap-2" ]
                    [ span [ class "text-error" ] [ text "1" ]
                    , oreIcon
                        |> FeatherIcons.withClass "inline-block text-orange-500"
                        |> FeatherIcons.toHtml []
                    , span [] [ text "Copper Ore" ]
                    ]
                , li [ class "flex items-center gap-2" ]
                    [ span [ class "text-error" ] [ text "2" ]
                    , oreIcon
                        |> FeatherIcons.withClass "inline-block text-gray-500"
                        |> FeatherIcons.toHtml []
                    , span [] [ text "Tin Ore" ]
                    ]
                ]
            , h3 [ class "text-xl font-bold" ] [ text "You gained" ]
            , ul [ class "font-semibold flex flex-col items-center" ]
                [ li [ class "flex items-center gap-2" ]
                    [ span [ class "text-success" ] [ text "643" ]
                    , span [] [ text "Woodchopping XP" ]
                    ]
                , li [ class "flex items-center gap-2" ]
                    [ span [ class "text-success" ] [ text "38" ]
                    , span [] [ text "Wood" ]
                    ]
                ]
            , button [ class "btn btn-primary", onClick CloseWelcomeBackModal ]
                [ text "Done" ]
            ]
        ]
