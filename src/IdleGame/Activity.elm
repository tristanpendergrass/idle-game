module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils exposing (cardImage)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)


getBySkill : Skill -> List Activity
getBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getActivityStats kind).skill == skill
            )


allAnatomy : List Activity
allAnatomy =
    getBySkill Anatomy


type MasteryReward
    = IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Mod -- Apply mod to game


type alias Mastery =
    List ( Int, MasteryReward )


type alias EffectStats =
    { effects : List Effect
    , mastery : Maybe Mastery
    }


knowledgeResource : Skill -> Maybe Resource
knowledgeResource skill =
    case skill of
        Anatomy ->
            Just AnatomyK

        Biochemistry ->
            Just BiochemistryK

        Physiology ->
            Just PhysiologyK

        Pharmacology ->
            Just PharmacologyK

        Microbiology ->
            Just MicrobiologyK

        Pathology ->
            Just PathologyK

        MedicalEthics ->
            Just MedicalEthicsK

        _ ->
            Nothing


getEffectStats : Activity -> EffectStats
getEffectStats activity =
    let
        stats : ActivityStats
        stats =
            getActivityStats activity

        knowledgeEffects : List Effect
        knowledgeEffects =
            case ( knowledgeResource stats.skill, stats.knowledge ) of
                ( Just resource, Just amount ) ->
                    [ Effect.gainResource amount resource ]

                _ ->
                    []

        labEffects : List Effect
        labEffects =
            -- case activity of
            --     Lab1 ->
            --         []
            []
    in
    { effects = List.concat [ knowledgeEffects, labEffects ]
    , mastery = Nothing
    }


updateByKindActivity : Activity -> (a -> a) -> ActivityRecord a -> ActivityRecord a
updateByKindActivity activity fn record =
    setByActivity activity (fn (getByActivity activity record)) record


getAnatomyMastery : Activity -> Mastery
getAnatomyMastery activity =
    [ ( 25
      , GameMod
            (Mod.coinBuff (Percent.float 0.1)
                |> Mod.withTags [ Effect.ActivityTag activity ]
            )
      )
    , ( 50
      , GameMod
            (Mod.activityXpBuff activity (Percent.float 0.25)
                |> Mod.withTags [ Effect.ActivityTag activity ]
            )
      )
    , ( 75
      , IntervalMod
            { kind = activity
            , percentChange = Percent.float 0.1
            , label = IntervalModLabel (Percent.float 0.1)
            }
      )
    , ( 100
      , GameMod
            (Mod.skillXpBuff Anatomy (Percent.float 0.05)
                |> Mod.withTags [ Effect.SkillTag Anatomy ]
            )
      )
    ]
