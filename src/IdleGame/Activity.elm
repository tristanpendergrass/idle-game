module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.OneTime as OneTime
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


updateModCount : (Int -> Int) -> MasteryMod -> MasteryMod
updateModCount fn mod =
    case mod of
        IntervalMod intervalMod ->
            IntervalMod { intervalMod | count = fn intervalMod.count }

        GameMod gameMod ->
            GameMod { gameMod | count = fn gameMod.count }


perLevelModCount : { modInterval : Int, mxpLevel : Int } -> Int
perLevelModCount { modInterval, mxpLevel } =
    mxpLevel // modInterval


masteryModsAtLevel : Int -> Mastery -> List MasteryMod
masteryModsAtLevel level mastery =
    let
        perLevel : ( Int, MasteryMod ) -> Maybe MasteryMod
        perLevel ( modInterval, mod ) =
            case perLevelModCount { modInterval = modInterval, mxpLevel = level } of
                0 ->
                    Nothing

                n ->
                    Just (updateModCount (\count -> count * n) mod)

        atLevelMods : List MasteryMod
        atLevelMods =
            mastery.atLevel
                |> List.filterMap
                    (\( requiredLevel, mod ) ->
                        if level >= requiredLevel then
                            Just mod

                        else
                            Nothing
                    )
    in
    List.concat [ List.filterMap perLevel mastery.perLevel, atLevelMods ]


hasMasteryMods : Mastery -> Bool
hasMasteryMods mastery =
    not (List.isEmpty mastery.atLevel && List.isEmpty mastery.perLevel)


type alias Mastery =
    { perLevel : List ( Int, MasteryMod ) -- The Int is the number of levels you gain to get an instance of the mod
    , atLevel : List ( Int, MasteryMod )
    }


type MasteryMod
    = IntervalMod IntervalMod -- Activity interval decreased by this much
    | GameMod Mod -- Apply mod to game


type alias EffectStats =
    { effects : List Effect
    , mastery : Mastery
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

        tempEffects : List Effect
        tempEffects =
            case activity of
                MetabolicPathways ->
                    [ Effect.spendResource 1 AnatomyK
                        |> Effect.withReducedBy (Effect.ReducedByFlat AnatomyPK)
                    ]

                UpperLimb ->
                    [ Effect.gainResource 1 AnatomyPK
                    ]

                _ ->
                    []

        knowledgeEffects : List Effect
        knowledgeEffects =
            case ( knowledgeResource stats.skill, stats.knowledge ) of
                ( Just resource, Just amount ) ->
                    [ Effect.gainResource amount resource ]

                _ ->
                    []

        labEffects : List Effect
        labEffects =
            case activity of
                Lab1 ->
                    [ Effect.gainWithProbability (Percent.float 0.5)
                        [ Effect.gainCoin (Coin.int 5)
                        , Effect.gainWithProbability (Percent.float 0.01)
                            [ Effect.gainResource 1 AnatomyPK
                                |> Effect.withOneTime OneTime.Lab1
                            ]
                        ]
                    ]

                _ ->
                    []

        mastery : Mastery
        mastery =
            case activity of
                BackAndSpine ->
                    { perLevel = [ ( 1, GameMod (Mod.resourceBaseBuff 1) ) ]

                    -- { kind : Activity
                    -- , percentChange : Percent -- e.g. 0.25 -> 25% faster
                    -- , label : IntervalModLabel
                    -- , count : Int -- How many times to apply this mod
                    -- }
                    , atLevel =
                        [ ( 5
                          , IntervalMod
                                { kind = BackAndSpine
                                , percentChange = Percent.float 0.25
                                , label = IntervalModLabel (Percent.float 0.25)
                                , count = 1
                                }
                          )
                        ]
                    }

                _ ->
                    { perLevel = []
                    , atLevel = []
                    }
    in
    { effects = List.concat [ tempEffects, knowledgeEffects, labEffects ]
    , mastery = mastery
    }


updateByKindActivity : Activity -> (a -> a) -> ActivityRecord a -> ActivityRecord a
updateByKindActivity activity fn record =
    setByActivity activity (fn (getByActivity activity record)) record
