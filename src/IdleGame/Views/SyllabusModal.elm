module IdleGame.Views.SyllabusModal exposing (..)

import FeatherIcons exposing (activity)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Kinds exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Svg.Attributes exposing (d, in_)
import Types exposing (..)


render : Game -> Skill -> Html FrontendMsg
render game skill =
    let
        skillStats : SkillStats
        skillStats =
            getSkillStats skill

        activities : List Activity
        activities =
            Activity.getBySkill skill
    in
    div [ IdleGame.Views.Utils.classes.column, class "gap-6" ]
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
                                activityStats : ActivityStats
                                activityStats =
                                    getActivityStats activity

                                levelCell : Html FrontendMsg
                                levelCell =
                                    td [] [ text (String.fromInt activityStats.level) ]
                            in
                            tr []
                                [ levelCell
                                , td [] [ text activityStats.title ]
                                ]
                        )
                )
            ]
        ]
