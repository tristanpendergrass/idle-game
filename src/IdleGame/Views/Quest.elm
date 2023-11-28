module IdleGame.Views.Quest exposing (..)

import Duration exposing (Duration)
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Activity as Activity
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Game as Game exposing (Game)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Location as Location
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Monster as Monster
import IdleGame.Quest as Quest
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Spell as Spell
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Placeholder
import IdleGame.Views.Spell as SpellView
import IdleGame.Views.Utils as Utils
import IdleGame.Xp as Xp exposing (Xp)
import Json.Decode as D
import Maybe.Extra
import Percent exposing (Percent)
import Types exposing (..)


completeButton : Quest -> Bool -> Html FrontendMsg
completeButton quest canComplete =
    button
        [ class "btn btn-sm btn-primary"
        , onClick (HandleQuestComplete quest)
        , disabled (not canComplete)
        ]
        [ text "Complete" ]


renderQuest : Game -> Quest -> Html FrontendMsg
renderQuest game quest =
    let
        state : Quest.State
        state =
            Quest.getByKind quest game.quests

        canComplete : Bool
        canComplete =
            case Game.attemptCompleteQuest quest game of
                Err _ ->
                    False

                Ok _ ->
                    True
    in
    div [ Utils.card.container ]
        [ div [ Utils.card.imageContainer ]
            [ Utils.cardImage (Quest.getStats quest).image ]
        , div [ Utils.card.body ]
            (List.concat
                [ [ h2 [ Utils.card.title ] [ text (Quest.getLabel quest) ] ]
                , case state of
                    Quest.Incomplete ->
                        List.concat
                            [ List.map (renderQuestCriteria game) (Quest.getStats quest).criteria
                            , [ div [ class "divider divider-vertical t-divider-tight" ] [] ]
                            , [ div [ class "italic text-sm" ] [ text "Rewards" ] ]
                            , List.map (renderQuestReward game) (Quest.getStats quest).reward
                            ]

                    Quest.Complete ->
                        [ div [ class "text-sm text-success" ] [ text "Completed" ] ]
                , [ div [ classList [ ( "hidden", state == Quest.Complete ) ] ]
                        [ completeButton quest canComplete ]
                  ]
                ]
            )
        ]


renderQuestCriteria : Game -> Quest.Criteria -> Html FrontendMsg
renderQuestCriteria game criteria =
    case criteria of
        Quest.CanApplyEffect taggedEffect ->
            let
                mods : List Mod
                mods =
                    Game.getAllMods game

                ( moddedEffect, _ ) =
                    Mod.applyModsToEffect mods taggedEffect
            in
            div [ class "t-column" ]
                [ div [ class "italic text-sm" ] [ text "Donate resources" ]
                , EffectView.renderModdedEffect EffectView.Card game moddedEffect
                ]


renderQuestReward : Game -> Effect.TaggedEffect -> Html FrontendMsg
renderQuestReward game reward =
    let
        mods : List Mod
        mods =
            Game.getAllMods game

        ( moddedEffect, _ ) =
            Mod.applyModsToEffect mods reward
    in
    EffectView.renderModdedEffect EffectView.Card game moddedEffect
