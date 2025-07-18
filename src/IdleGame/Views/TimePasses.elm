module IdleGame.Views.TimePasses exposing (..)

import Config
import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Game as Game
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.ModalWrapper
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)
import Maybe.Extra
import Quantity exposing (Quantity)
import Time exposing (Posix)
import Types exposing (..)


resourceIcon : FeatherIcons.Icon
resourceIcon =
    FeatherIcons.stopCircle
        |> FeatherIcons.withSize 16
        |> FeatherIcons.withStrokeWidth 4


renderCombatsWon : Int -> Html FrontendMsg
renderCombatsWon num =
    li [ class "flex items-center gap-1" ]
        [ span [ class "text-success" ] [ text <| IdleGame.Views.Utils.intToString num ]
        , span [] [ text "combats won" ]
        ]


renderCombatsLost : Int -> Html FrontendMsg
renderCombatsLost num =
    li [ class "flex items-center gap-1" ]
        [ span [ class "text-error" ] [ text <| IdleGame.Views.Utils.intToString num ]
        , span [] [ text "combats lost" ]
        ]


hasGains : TimePassesData -> Bool
hasGains { xpGains, coinGains, resourcesDiff } =
    not <|
        (List.isEmpty xpGains
            && Resource.isEmptyDiff resourcesDiff
            && Maybe.Extra.isNothing coinGains
        )


render : Duration -> Posix -> TimePassesData -> Html FrontendMsg
render timeToFastForward timePassed timePassesData =
    let
        { xpGains, coinGains, resourcesDiff } =
            timePassesData

        -- timeStr =
        --     Utils.intToString (floor (Duration.inMilliseconds timeToFastForward))
    in
    div [ IdleGame.Views.Utils.classes.column, class "gap-4" ]
        [ h2 [ class "text-3xl font-bold" ] [ text "Time passes..." ]
        , span [ class "text-sm italic" ] [ text <| "(" ++ IdleGame.Views.Utils.getDurationString (Time.posixToMillis timePassed) ++ ")" ]

        -- , span [ classList [ ( "hidden", not Config.flags.showTimePasses ) ] ] [ text timeStr ]
        , div [ classList [ ( "hidden", not (hasGains timePassesData) ) ] ]
            [ h3 [ class "text-xl font-bold text-center" ] [ text "You gained" ]
            , div [ class "divider" ] []
            , ul [ IdleGame.Views.Utils.classes.column, class "font-semibold" ]
                (List.concat
                    [ case coinGains of
                        Nothing ->
                            []

                        Just amount ->
                            [ li [ class "flex items-center gap-2" ]
                                [ span [ class "text-success" ]
                                    [ amount
                                        |> Coin.toInt
                                        |> IdleGame.Views.Utils.intToString
                                        |> text
                                    ]
                                , Icon.coin
                                    |> Icon.toHtml
                                , span [] [ text "coin" ]
                                ]
                            ]
                    , xpGains
                        |> List.map
                            (\{ skill, originalXp, currentXp } ->
                                let
                                    difference : Xp
                                    difference =
                                        Quantity.minus originalXp currentXp

                                    originalLevel : Int
                                    originalLevel =
                                        originalXp
                                            |> Xp.level Xp.defaultSchedule

                                    currentLevel : Int
                                    currentLevel =
                                        currentXp
                                            |> Xp.level Xp.defaultSchedule
                                in
                                li [ class "flex items-center gap-2" ]
                                    [ span [ class "text-success" ]
                                        [ difference
                                            |> Xp.toInt
                                            |> IdleGame.Views.Utils.intToString
                                            |> text
                                        ]

                                    -- , span [] [ text title ]
                                    , IdleGame.Views.Utils.skillXpBadge skill
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
                                    [ span
                                        [ class
                                            (if amount >= 0 then
                                                "text-success"

                                             else
                                                "text-error"
                                            )
                                        ]
                                        [ text <| IdleGame.Views.Utils.intToString amount ]
                                    , (getResourceStats resource).icon
                                        |> Icon.toHtml
                                    , span [] [ text <| (getResourceStats resource).title ]
                                    ]
                            )
                    ]
                )
            ]
        , IdleGame.Views.ModalWrapper.renderCloseButton
        ]
