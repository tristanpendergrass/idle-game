module IdleGame.Views.TestingCenter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Game as Game
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.TestExtras as Test
import IdleGame.Views.Effect as EffectView
import Random
import Result.Extra
import Types exposing (..)


renderTestingCenterTabButton : { activeTab : TestCategory, label : String, tab : TestCategory } -> Html FrontendMsg
renderTestingCenterTabButton { activeTab, label, tab } =
    div
        [ attribute "role" "tab"
        , class "tab"
        , classList [ ( "tab-active", activeTab == tab ) ]
        , onClick (HandleTestingCenterTabClick tab)
        ]
        [ text label ]


renderTest : Game -> List Mod -> Test -> Html FrontendMsg
renderTest game mods test =
    let
        stats : TestStats
        stats =
            getTestStats test

        renderCost : Effect -> Html FrontendMsg
        renderCost cost =
            EffectView.render { effect = cost, game = game, mods = mods, renderType = EffectView.Card }

        canAfford : Bool
        canAfford =
            Game.applyEffects mods (Test.getAllEffects test) 1 game
                |> (\g -> Random.step g game.seed)
                |> Tuple.first
                |> Result.Extra.isOk
    in
    div [ class "card shadow w-80 bg-base-200 card-compact lg:card-normal" ]
        [ div [ class "card-body" ]
            (List.concat
                [ [ h2 [ class "card-title flex items-center justify-between" ]
                        [ text stats.title
                        , button [ class "btn btn-sm btn-primary", disabled (not canAfford), onClick (HandleTestCompletionClick test) ] [ text "Complete" ]
                        ]
                  ]
                , List.map renderCost (Test.getCostEffects test)
                , [ div [] [ text "Rewards" ] ]
                , List.map renderCost (Test.getRewardEffects test)
                ]
            )
        ]


render : FrontendModel -> Game -> Html FrontendMsg
render model game =
    let
        allMods : List Mod
        allMods =
            Game.getAllMods game

        showTest : Test -> Bool
        showTest test =
            ((getTestStats test).category == model.activeTestCategory) && not (getByTest test game.testCompletions)

        tests : List Test
        tests =
            List.filter showTest allTests
    in
    div [ class "t-column items-start p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ attribute "role" "tablist", class "tabs tabs-lifted" ]
            [ renderTestingCenterTabButton
                { activeTab = model.activeTestCategory
                , label = "Quizzes"
                , tab = Quiz
                }
            , renderTestingCenterTabButton
                { activeTab = model.activeTestCategory
                , label = "Shelf Exams"
                , tab = ShelfExam
                }
            , renderTestingCenterTabButton
                { activeTab = model.activeTestCategory
                , label = "USMLE Step 1"
                , tab = UsmleStep1
                }
            ]
        , div [ class "w-full grid" ]
            (List.map (renderTest game allMods) tests)
        , div [ class "w-full", classList [ ( "hidden", not (List.isEmpty tests) ) ] ]
            [ text "Completed all" ]
        ]
