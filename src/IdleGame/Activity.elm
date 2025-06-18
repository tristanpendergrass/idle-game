module IdleGame.Activity exposing (..)

import Duration exposing (Duration)
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod
import IdleGame.OneTime as OneTime
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils exposing (cardImage)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Percent exposing (Percent)
import Types exposing (..)


getBySkill : Skill -> List Activity
getBySkill skill =
    allActivities
        |> List.filter
            (\kind ->
                (getActivityStats kind).skill == skill
            )


updateModCount : (Int -> Int) -> Mod -> Mod
updateModCount fn mod =
    case mod of
        IntervalMod intervalMod ->
            IntervalMod { intervalMod | count = fn intervalMod.count }

        EffectMod gameMod ->
            EffectMod { gameMod | count = fn gameMod.count }


perLevelModCount : { modInterval : Int, mxpLevel : Int } -> Int
perLevelModCount { modInterval, mxpLevel } =
    mxpLevel // modInterval


masteryModsAtLevel : Int -> Mastery -> List Mod
masteryModsAtLevel playerLevel mastery =
    let
        perLevelMods : List Mod
        perLevelMods =
            mastery.perLevel
                |> List.filterMap
                    (\{ interval, mod } ->
                        let
                            n : Int
                            n =
                                perLevelModCount { modInterval = interval, mxpLevel = playerLevel }
                        in
                        if n > 0 then
                            Just (updateModCount (\count -> count * n) mod)

                        else
                            Nothing
                    )

        atLevelMods : List Mod
        atLevelMods =
            mastery.atLevel
                |> List.filterMap
                    (\{ level, mod } ->
                        if playerLevel >= level then
                            Just mod

                        else
                            Nothing
                    )
    in
    perLevelMods ++ atLevelMods


hasMasteryMods : Mastery -> Bool
hasMasteryMods mastery =
    not (List.isEmpty mastery.atLevel && List.isEmpty mastery.perLevel)


getActivityEffects : Activity -> List Effect
getActivityEffects activity =
    getByActivity activity activityEffects


getActivityMasteries : Activity -> Mastery
getActivityMasteries activity =
    getByActivity activity activityMasteries


activityEffects : ActivityRecord (List Effect)
activityEffects =
    createRecordByFn getActivityEffectsHelper


activityMasteries : ActivityRecord Mastery
activityMasteries =
    createRecordByFn getActivityMasteriesHelper


getActivityEffectsHelper : Activity -> List Effect
getActivityEffectsHelper activity =
    let
        stats : ActivityStats
        stats =
            getActivityStats activity

        tagsForThisActivity : List Tag
        tagsForThisActivity =
            [ ActivityTag activity, SkillTag stats.skill ]

        costs : List Effect
        costs =
            []

        gainMxpEffects : List Effect
        gainMxpEffects =
            [ Effect.gainMxp activity
                |> Effect.withTags tagsForThisActivity
            ]

        gainXpEffects : List Effect
        gainXpEffects =
            [ Effect.gainXp (Xp.int 5) stats.skill
                |> Effect.withTags tagsForThisActivity
            ]

        gainResourceEffects : List Effect
        gainResourceEffects =
            List.map (\( count, resource ) -> Effect.gainResource count resource) stats.resourceGains
    in
    List.concat
        [ costs
        , gainMxpEffects
        , gainXpEffects
        , gainResourceEffects
        ]


getActivityMasteriesHelper : Activity -> Mastery
getActivityMasteriesHelper activity =
    case (getActivityStats activity).skill of
        HerbGathering ->
            { perLevel = []
            , atLevel =
                [ { level = 25
                  , mod =
                        EffectMod
                            (Mod.resourceDoublingBuff (Percent.float 0.1)
                                |> Mod.withLabel "+10% resource doubling for this herb"
                                |> Mod.withTags [ ActivityTag activity ]
                            )
                  }
                , { level = 50
                  , mod =
                        EffectMod
                            (Mod.resourceDoublingBuff (Percent.float 0.1)
                                |> Mod.withLabel "+10% resource doubling for this herb"
                                |> Mod.withTags [ ActivityTag activity ]
                            )
                  }
                , { level = 75
                  , mod =
                        EffectMod
                            (Mod.resourceDoublingBuff (Percent.float 0.1)
                                |> Mod.withLabel "+10% resource doubling for this herb"
                                |> Mod.withTags [ ActivityTag activity ]
                            )
                  }
                , { level = 99
                  , mod =
                        EffectMod
                            (Mod.resourceBaseBuff 1
                                |> Mod.withLabel "+1 herb gathered"
                                |> Mod.withTags [ ActivityTag activity ]
                            )
                  }
                ]
            }

        WildMagic ->
            { perLevel = [], atLevel = [] }



{- All the commented out cases can be removed since we only have
   HerbGathering and WildMagic skills now
-}


updateByKindActivity : Activity -> (a -> a) -> ActivityRecord a -> ActivityRecord a
updateByKindActivity activity fn record =
    setByActivity activity (fn (getByActivity activity record)) record


createRecordByFn : (Activity -> a) -> ActivityRecord a
createRecordByFn fn =
    let
        emptyRecord : ActivityRecord a
        emptyRecord =
            -- Note: it doesn't matter what activity we put here, it will be overwritten
            activityRecord (fn GatherSage)
    in
    List.foldl
        (\activity record ->
            setByActivity activity (fn activity) record
        )
        emptyRecord
        allActivities
