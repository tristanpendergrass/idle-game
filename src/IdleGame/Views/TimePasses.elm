module IdleGame.Views.TimePasses exposing (..)

import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Game exposing (TimePassesData)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.ModalWrapper
import IdleGame.Views.Utils
import IdleGame.XpFormulas as XpFormulas
import Time exposing (Posix)
import Types exposing (..)


resourceIcon : FeatherIcons.Icon
resourceIcon =
    FeatherIcons.stopCircle
        |> FeatherIcons.withSize 16
        |> FeatherIcons.withStrokeWidth 4


render : Posix -> TimePassesData -> Html FrontendMsg
render timePassed { xpGains, coinGains, resourcesDiff } =
    div [ class "t-column gap-4" ]
        [ h2 [ class "text-3xl font-bold" ] [ text "Time passes..." ]
        , span [ class "text-sm italic" ] [ text <| "(" ++ IdleGame.Views.Utils.getDurationString (Time.posixToMillis timePassed) ++ ")" ]
        , div []
            [ h3 [ class "text-xl font-bold text-center" ] [ text "You gained" ]
            , div [ class "divider" ] []
            , ul [ class "t-column font-semibold" ]
                (List.concat
                    [ case coinGains of
                        Nothing ->
                            []

                        Just amount ->
                            [ li [ class "flex items-center gap-2" ]
                                [ span [ class "text-success" ] [ text <| Counter.toString amount ]
                                , Icon.coin
                                    |> Icon.toHtml
                                , span [] [ text "coin" ]
                                ]
                            ]
                    , xpGains
                        |> List.map
                            (\{ title, originalXp, currentXp } ->
                                let
                                    difference : Counter
                                    difference =
                                        Counter.subtract currentXp originalXp

                                    originalLevel : Int
                                    originalLevel =
                                        originalXp
                                            |> Counter.getValue
                                            |> XpFormulas.skillLevel

                                    currentLevel : Int
                                    currentLevel =
                                        currentXp
                                            |> Counter.getValue
                                            |> XpFormulas.skillLevel
                                in
                                li [ class "flex items-center gap-2" ]
                                    [ span [ class "text-success" ] [ text <| Counter.toString difference ]
                                    , span [] [ text title ]
                                    , IdleGame.Views.Utils.skillXpBadge
                                    , if originalLevel /= currentLevel then
                                        span [] [ text <| "(Level " ++ IdleGame.Views.Utils.intToString originalLevel ++ " -> " ++ IdleGame.Views.Utils.intToString currentLevel ++ ")" ]

                                      else
                                        span [] []
                                    ]
                            )
                    , resourcesDiff
                        |> Resource.mapDiff
                            (\amount resource ->
                                li [ class "flex items-center gap-2", classList [ ( "hidden", amount == 0 ) ] ]
                                    [ span [ class "text-success" ] [ text <| IdleGame.Views.Utils.intToString amount ]
                                    , (Resource.getStats resource).icon
                                        |> Icon.toHtml
                                    , span [] [ text <| (Resource.getStats resource).title ]
                                    ]
                            )
                    ]
                )
            ]
        , IdleGame.Views.ModalWrapper.renderCloseButton
        ]
