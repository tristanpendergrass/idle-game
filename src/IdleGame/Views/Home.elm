module IdleGame.Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.AcademicTest as AcademicTest
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Game as Game
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.Views.Activity as ActivityView
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon
import IdleGame.Views.Utils as Utils
import Random
import Result.Extra
import Types exposing (..)


render : InGameFrontend -> Game -> ActivityRecord (List Effect) -> Html FrontendMsg
render model game cachedActivityEffects =
    let
        subjectHeader : Skill -> Html FrontendMsg
        subjectHeader skill =
            let
                stats : SkillStats
                stats =
                    getSkillStats skill
            in
            li [ class "flex items-center gap-2" ]
                [ stats.icon
                    |> Icon.toHtml
                , text stats.title
                ]

        activityCard : Html FrontendMsg
        activityCard =
            let
                activity : Activity
                activity =
                    BackAndSpine

                effects : List Effect
                effects =
                    getByActivity activity cachedActivityEffects
            in
            div [ class "max-w-lg not-prose" ]
                [ ActivityView.renderActivityCard ( activity, effects ) game
                    |> Utils.withScreenWidth
                ]
    in
    div [ class "p-6 pt-10 pb-16 w-full max-w-[1920px] min-w-[375px] prose prose-sm md:prose-base grid grid-cols-1 md:grid-cols-2 gap-4" ]
        [ article []
            [ h1 [] [ text "Welcome Letter" ]
            , p [] [ text "It is our ", strong [] [ text "great honor" ], text " to welcome you to ", strong [ class "underline" ] [ text "Idyllic School of Medicine" ], text " as a ", strong [] [ text "first-year medical student." ] ]
            , p [] [ text "We trust you know the road to becoming a full-fledged doctor is a long one, but assure you that here at Idyllic the road is straight. ", strong [] [ text "Carefully consider" ], text " how you spend your time, ", strong [] [ text "put in the hours" ], text ", and we're sure you'll see great success." ]
            , p [] [ text "Now...hit the books, sport!" ]
            ]
        , article []
            [ h1 [] [ text "Student Handbook" ]
            , p [] [ text "In Med School Idle: the Preclinical Years, you are a medical student at Idyllic School of Medicine. Your ultimate goal is to pass the ", strong [] [ text "USMLE Step 1" ], text " exam in the ", strong [] [ text "Testing Center" ], text ", but to do that you'll need to acquire enough ", strong [] [ text "Knowledge" ], text " from studying the following subjects:" ]
            , ul [ class "list-disc" ]
                [ subjectHeader Anatomy
                , subjectHeader Biochemistry
                , subjectHeader Physiology
                , subjectHeader Pharmacology
                , subjectHeader Microbiology
                , subjectHeader Pathology
                , subjectHeader MedicalEthics
                ]
            , p [] [ text "To get started, navigate to a subject tab using the menu and click on a topic to study it. Below is a working example:" ]
            , p [ class "flex items-center gap-2" ]
                [ div [ class "animate-ping" ]
                    [ Icon.arrowDown
                        |> Icon.withSize Icon.Large
                        |> Icon.toHtml
                    ]
                , span [] [ text "Click" ]
                ]
            , activityCard
            ]
        , article []
            [ h1 [] [ text "Dedication" ]
            , p [] [ text "Made this game for a particular med student. I hope all can enjoy though." ]
            ]
        ]
