module IdleGame.Views.SyllabusModal exposing (..)

import FeatherIcons exposing (activity)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Svg.Attributes exposing (d, in_)
import Types exposing (..)


withUnlockLevel : Activity -> Maybe Int
withUnlockLevel activity =
    let
        activityStats : Activity.Stats
        activityStats =
            Activity.getStats activity
    in
    case activityStats.unlockRequirements of
        Just ( _, level ) ->
            Just level

        Nothing ->
            Nothing


render : Game -> Skill -> Html FrontendMsg
render game skill =
    let
        skillStats : Skill.Stats
        skillStats =
            Skill.getStats skill

        activities : List Activity
        activities =
            Activity.getBySkill skill
    in
    div [ class "t-column gap-6" ]
        [ h3 [ class "font-bold text-lg" ] [ text ("Syllabus: " ++ skillStats.title) ]
        , table [ class "table table-sm w-80" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Unlock Level" ]
                    , th [] [ text "Activity" ]
                    ]
                ]
            , tbody []
                (activities
                    |> List.map
                        (\activity ->
                            let
                                activityStats : Activity.Stats
                                activityStats =
                                    Activity.getStats activity

                                unlockLevel : Maybe Int
                                unlockLevel =
                                    withUnlockLevel activity

                                levelCell : Html FrontendMsg
                                levelCell =
                                    case unlockLevel of
                                        Just level ->
                                            td [] [ text (String.fromInt level) ]

                                        Nothing ->
                                            td [] []
                            in
                            tr []
                                [ levelCell
                                , td [] [ text activityStats.title ]
                                ]
                        )
                )
            ]
        ]
