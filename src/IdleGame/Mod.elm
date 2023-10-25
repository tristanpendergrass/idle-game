module IdleGame.Mod exposing (..)

import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.Skill as Skill
import Percent exposing (Percent)


type ModSource
    = AdminCrimes
    | ShopItem


type alias Mod =
    { tags : List Effect.Tag
    , label : Label
    , transformer : Transformer
    , repetitions : Int
    , source : ModSource
    }


type alias Transformer =
    Int -> Effect.TaggedEffect -> TransformerResult


type TransformerResult
    = NoChange
    | ChangeEffect Effect.TaggedEffect
    | ChangeAndAddEffects Effect.TaggedEffect (List Effect.TaggedEffect)


type alias SimpleTransformer =
    Effect -> Effect


scopeTransformerToTags : List Effect.Tag -> Transformer -> Transformer
scopeTransformerToTags tags transformer multiplier effect =
    if Effect.hasTags tags effect then
        transformer multiplier effect

    else
        NoChange


includeVariableEffects : Mod -> Mod
includeVariableEffects mod =
    -- Transforms the mod to apply to not just an effect but all the subeffects of that effect, e.g. the successEffects contained in a VariableSuccess
    let
        transformer =
            mod.transformer

        newTransformer : Int -> Effect.TaggedEffect -> TransformerResult
        newTransformer multiplier taggedEffect =
            case taggedEffect.effect of
                Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
                    let
                        ( successEffectsDidChange, newSuccessEffects ) =
                            let
                                newEffects : List Effect.TaggedEffect
                                newEffects =
                                    successEffects
                                        |> List.concatMap
                                            (\successEffect ->
                                                let
                                                    ( moddedSuccessEffect, additionalSuccessEffects ) =
                                                        applyModsToEffect [ { mod | transformer = newTransformer } ] successEffect
                                                in
                                                moddedSuccessEffect :: additionalSuccessEffects
                                            )
                            in
                            ( successEffects /= newEffects, newEffects )

                        ( failureEffectsDidChange, newFailureEffects ) =
                            let
                                newEffects : List Effect.TaggedEffect
                                newEffects =
                                    failureEffects
                                        |> List.concatMap
                                            (\failureEffect ->
                                                let
                                                    ( moddedFailureEffect, additionalFailureEffects ) =
                                                        applyModsToEffect [ { mod | transformer = newTransformer } ] failureEffect
                                                in
                                                moddedFailureEffect :: additionalFailureEffects
                                            )
                            in
                            ( failureEffects /= newEffects, newEffects )

                        effectDidChange : Bool
                        effectDidChange =
                            successEffectsDidChange || failureEffectsDidChange
                    in
                    if effectDidChange then
                        taggedEffect
                            |> Effect.setEffect
                                (Effect.VariableSuccess
                                    { successProbability = successProbability
                                    , successEffects = newSuccessEffects
                                    , failureEffects = newFailureEffects
                                    }
                                )
                            |> ChangeEffect

                    else
                        NoChange

                Effect.ResolveCombat { combat, successEffects, failureEffects } ->
                    let
                        ( successEffectsDidChange, newSuccessEffects ) =
                            let
                                newEffects : List Effect.TaggedEffect
                                newEffects =
                                    successEffects
                                        |> List.concatMap
                                            (\successEffect ->
                                                let
                                                    ( moddedSuccessEffect, additionalSuccessEffects ) =
                                                        applyModsToEffect [ { mod | transformer = newTransformer } ] successEffect
                                                in
                                                moddedSuccessEffect :: additionalSuccessEffects
                                            )
                            in
                            ( successEffects /= newEffects, newEffects )

                        ( failureEffectsDidChange, newFailureEffects ) =
                            let
                                newEffects : List Effect.TaggedEffect
                                newEffects =
                                    successEffects
                                        |> List.concatMap
                                            (\failureEffect ->
                                                let
                                                    ( moddedFailureEffect, additionalFailureEffects ) =
                                                        applyModsToEffect [ { mod | transformer = newTransformer } ] failureEffect
                                                in
                                                moddedFailureEffect :: additionalFailureEffects
                                            )
                            in
                            ( failureEffects /= newEffects, newEffects )

                        effectDidChange : Bool
                        effectDidChange =
                            successEffectsDidChange || failureEffectsDidChange
                    in
                    if effectDidChange then
                        taggedEffect
                            |> Effect.setEffect
                                (Effect.ResolveCombat
                                    { combat = combat
                                    , successEffects = newSuccessEffects
                                    , failureEffects = newFailureEffects
                                    }
                                )
                            |> ChangeEffect

                    else
                        NoChange

                _ ->
                    transformer multiplier taggedEffect
    in
    { mod | transformer = newTransformer }


useSimpleTransformer : SimpleTransformer -> Transformer
useSimpleTransformer =
    -- TODO: add unit test for recursive transformer only working 20x
    useSimpleTransformerHelp 0


useSimpleTransformerHelp : Int -> SimpleTransformer -> Transformer
useSimpleTransformerHelp depth transformFn repetitions taggedEffect =
    let
        newEffectType =
            transformFn (Effect.getEffect taggedEffect)

        newEffect =
            taggedEffect
                |> Effect.setEffect newEffectType
    in
    if repetitions > 1 && depth < 20 then
        useSimpleTransformerHelp (depth + 1) transformFn (repetitions - 1) newEffect

    else if repetitions == 0 then
        NoChange

    else
        ChangeEffect newEffect


applyModToEffect : Mod -> ( Effect.TaggedEffect, List Effect.TaggedEffect ) -> ( Effect.TaggedEffect, List Effect.TaggedEffect )
applyModToEffect mod ( effectAccum, furtherEffectsAccum ) =
    if Effect.hasTags mod.tags effectAccum then
        case mod.transformer mod.repetitions effectAccum of
            NoChange ->
                ( effectAccum, furtherEffectsAccum )

            ChangeEffect changedEffect ->
                ( changedEffect, furtherEffectsAccum )

            ChangeAndAddEffects changedEffect changedFurtherEffects ->
                ( changedEffect, furtherEffectsAccum ++ changedFurtherEffects )

    else
        ( effectAccum, furtherEffectsAccum )


applyModsToEffect : List Mod -> Effect.TaggedEffect -> ( Effect.TaggedEffect, List Effect.TaggedEffect )
applyModsToEffect =
    applyModsToEffectHelp 0


tupleToList : ( a, List a ) -> List a
tupleToList ( x, xs ) =
    x :: xs


applyModsToEffectHelp : Int -> List Mod -> Effect.TaggedEffect -> ( Effect.TaggedEffect, List Effect.TaggedEffect )
applyModsToEffectHelp depth mods effect =
    let
        ( newEffect, furtherEffects ) =
            List.foldl
                (\mod accum ->
                    if Effect.hasTags mod.tags effect then
                        applyModToEffect mod accum

                    else
                        accum
                )
                ( effect, [] )
                mods
    in
    ( newEffect
      -- TODO: unit test this 20 threshold?
      -- The depth < 20 is an arbitrary limit that shouldn't usually be reached. It should be rare for a "further effect" to trigger
      -- a mod that gives another further effect and have that repeat more than 20 times, if so the player just doesn't get the benefit -- :)
    , if depth < 20 then
        List.concatMap (applyModsToEffectHelp (depth + 1) mods >> tupleToList) furtherEffects

      else
        []
    )



-- applyMods : List Mod -> Event -> ModdedEvent
-- applyMods mods (Event eventData) =
--     ModdedEvent
--         { eventData
--           -- | effects = List.concatMap (applyTransformersToEffect 0 transformers) eventData.effects
--             | effects = List.concatMap (applyModsToEffect mods) eventData.effects
--         }
-- withMods : List Mod -> Event -> ModdedEvent
-- withMods mods event =
--     applyMods mods event


withHowManyTimesToApplyMod : Int -> Mod -> Mod
withHowManyTimesToApplyMod repetitions mod =
    { mod | repetitions = repetitions }


withSource : ModSource -> Mod -> Mod
withSource source mod =
    { mod | source = source }


withTags : List Effect.Tag -> Mod -> Mod
withTags tags mod =
    { mod | tags = mod.tags ++ tags }


xpTransformer : Float -> Transformer
xpTransformer buff repetitions effect =
    case Effect.getEffect effect of
        Effect.GainXp params ->
            let
                adjustedBuff : Float
                adjustedBuff =
                    buff * toFloat repetitions

                newParams : Effect.GainXpParams
                newParams =
                    { params | multiplier = params.multiplier * adjustedBuff }
            in
            effect
                |> Effect.setEffect (Effect.GainXp newParams)
                |> ChangeEffect

        _ ->
            NoChange


coinTransformer : Float -> Transformer
coinTransformer buff repetitions taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainCoin quantity ->
            let
                adjustedMultiplicable =
                    { quantity | multiplier = quantity.multiplier + (buff * toFloat repetitions) }
            in
            taggedEffect
                |> Effect.setEffect (Effect.GainCoin adjustedMultiplicable)
                |> ChangeEffect

        _ ->
            NoChange


mxpTransformer : Float -> Transformer
mxpTransformer buff repetitions taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainMxp params ->
            let
                adjustedBuff : Float
                adjustedBuff =
                    buff * toFloat repetitions

                newParams : Effect.GainMxpParams
                newParams =
                    { params | multiplier = params.multiplier * adjustedBuff }
            in
            taggedEffect
                |> Effect.setEffect (Effect.GainMxp newParams)
                |> ChangeEffect

        _ ->
            NoChange


resourceDoublingTransformer : Float -> Transformer
resourceDoublingTransformer buff repetitions taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainResource { base, doublingChance, resource } ->
            taggedEffect
                |> Effect.setEffect
                    (Effect.GainResource
                        { base = base
                        , doublingChance = doublingChance + (buff * toFloat repetitions)
                        , resource = resource
                        }
                    )
                |> ChangeEffect

        _ ->
            NoChange


resourceBaseTransformer : Int -> Transformer
resourceBaseTransformer buff repetitions taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainResource { base, doublingChance, resource } ->
            taggedEffect
                |> Effect.setEffect
                    (Effect.GainResource
                        { base = base + (buff * repetitions)
                        , doublingChance = doublingChance
                        , resource = resource
                        }
                    )
                |> ChangeEffect

        _ ->
            NoChange


increaseSuccessTransformer : Float -> Transformer
increaseSuccessTransformer buff repetitions taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.VariableSuccess params ->
            let
                newSuccessProbability =
                    (params.successProbability + buff * toFloat repetitions)
                        |> min 1.0

                newEffect =
                    Effect.VariableSuccess { params | successProbability = newSuccessProbability }
            in
            ChangeEffect (Effect.setEffect newEffect taggedEffect)

        _ ->
            NoChange


powerTransformer : Int -> Transformer
powerTransformer buff repetitions taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.ResolveCombat { combat, successEffects, failureEffects } ->
            let
                newCombat : Combat
                newCombat =
                    Combat.addPlayerPower (buff * repetitions) combat

                newEffect : Effect
                newEffect =
                    Effect.ResolveCombat { combat = newCombat, successEffects = successEffects, failureEffects = failureEffects }
            in
            taggedEffect
                |> Effect.setEffect newEffect
                |> ChangeEffect

        _ ->
            NoChange


activityXpBuff : Activity -> Float -> Mod
activityXpBuff activity amount =
    { tags = [ Effect.XpTag, Effect.ActivityTag activity ]
    , label = XpActivityLabel amount
    , transformer = xpTransformer amount
    , source = AdminCrimes
    , repetitions = 1
    }


skillXpBuff : Skill.Kind -> Float -> Mod
skillXpBuff skill amount =
    { tags = [ Effect.XpTag, Effect.SkillTag skill ]
    , label = XpSkillLabel amount skill
    , transformer = xpTransformer amount
    , source = AdminCrimes
    , repetitions = 1
    }


choresXpBuff : Float -> Mod
choresXpBuff buff =
    { tags = [ Effect.SkillTag Skill.Chores, Effect.XpTag ]
    , label = XpActivityLabel buff
    , transformer = xpTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


coinBuff : Float -> Mod
coinBuff buff =
    { tags = []
    , label = CoinLabel buff
    , transformer = coinTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


mxpBuff : Float -> Mod
mxpBuff buff =
    { tags = [ Effect.MxpTag ]
    , label = MxpModLabel buff
    , transformer = mxpTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


resourceBuff : Float -> Mod
resourceBuff buff =
    { tags = []
    , label = ResourceDoublingLabel buff
    , transformer = resourceDoublingTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


resourceBaseBuff : Int -> Mod
resourceBaseBuff buff =
    { tags = []
    , label = ResourceBaseLabel buff
    , transformer = resourceBaseTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


successBuff : Float -> Mod
successBuff buff =
    { tags = []
    , label = SuccessLabel buff
    , transformer = increaseSuccessTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


powerBuff : Int -> Mod
powerBuff buff =
    { tags = []
    , label = PowerLabel buff
    , transformer = powerTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


type Label
    = XpActivityLabel Float
    | XpSkillLabel Float Skill.Kind
    | MxpModLabel Float
    | ResourceDoublingLabel Float
    | ResourceBaseLabel Int
    | MoreManure
    | SuccessLabel Float
    | CoinLabel Float
    | PowerLabel Int
