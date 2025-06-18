module IdleGame.Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Views.Icon as Icon
import Types exposing (..)


render : InGameFrontend -> Game -> ActivityRecord (List Effect) -> Html FrontendMsg
render model game cachedActivityEffects =
    let
        skillHeader : Skill -> Html FrontendMsg
        skillHeader skill =
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
    in
    div [ class "p-6 pt-10 pb-16 w-full max-w-[1920px] min-w-[375px] prose prose-sm md:prose-base grid grid-cols-1 md:grid-cols-2 gap-4" ]
        []
