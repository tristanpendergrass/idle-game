module IdleGame.Mod exposing (..)

import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import Percent exposing (Percent)
import Quantity


type ModSource
    = AdminCrimes
    | ShopItem


type alias Mod =
    { tags : List Effect.Tag
    , label : Label
    , transformer : Transformer
    , count : Int -- How many times to apply this mod
    , source : ModSource
    }


type alias Transformer =
    Int -> Effect -> TransformerResult


type TransformerResult
    = NoChange
    | ChangeEffect Effect
    | ChangeAndAddEffects Effect (List Effect)


type alias SimpleTransformer =
    EffectType -> EffectType


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

        newTransformer : Int -> Effect -> TransformerResult
        newTransformer multiplier taggedEffect =
            case taggedEffect.effect of
                Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
                    let
                        ( successEffectsDidChange, newSuccessEffects ) =
                            let
                                newEffects : List Effect
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
                                newEffects : List Effect
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

                _ ->
                    transformer multiplier taggedEffect
    in
    { mod | transformer = newTransformer }


useSimpleTransformer : SimpleTransformer -> Transformer
useSimpleTransformer =
    -- TODO: add unit test for recursive transformer only working 20x
    useSimpleTransformerHelp 0


useSimpleTransformerHelp : Int -> SimpleTransformer -> Transformer
useSimpleTransformerHelp depth transformFn count taggedEffect =
    let
        newEffectType =
            transformFn (Effect.getEffect taggedEffect)

        newEffect =
            taggedEffect
                |> Effect.setEffect newEffectType
    in
    if count > 1 && depth < 20 then
        useSimpleTransformerHelp (depth + 1) transformFn (count - 1) newEffect

    else if count == 0 then
        NoChange

    else
        ChangeEffect newEffect


applyModToEffect : Mod -> ( Effect, List Effect ) -> ( Effect, List Effect )
applyModToEffect mod ( effectAccum, furtherEffectsAccum ) =
    if Effect.hasTags mod.tags effectAccum then
        case mod.transformer mod.count effectAccum of
            NoChange ->
                ( effectAccum, furtherEffectsAccum )

            ChangeEffect changedEffect ->
                ( changedEffect, furtherEffectsAccum )

            ChangeAndAddEffects changedEffect changedFurtherEffects ->
                ( changedEffect, furtherEffectsAccum ++ changedFurtherEffects )

    else
        ( effectAccum, furtherEffectsAccum )


applyModsToEffect : List Mod -> Effect -> ( Effect, List Effect )
applyModsToEffect =
    applyModsToEffectHelp 0


tupleToList : ( a, List a ) -> List a
tupleToList ( x, xs ) =
    x :: xs


applyModsToEffectHelp : Int -> List Mod -> Effect -> ( Effect, List Effect )
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
withHowManyTimesToApplyMod count mod =
    { mod | count = count }


withSource : ModSource -> Mod -> Mod
withSource source mod =
    { mod | source = source }


withTags : List Effect.Tag -> Mod -> Mod
withTags tags mod =
    { mod | tags = mod.tags ++ tags }


withLabel : Label -> Mod -> Mod
withLabel label mod =
    { mod | label = label }


xpTransformer : Percent -> Transformer
xpTransformer buff count effect =
    case Effect.getEffect effect of
        Effect.GainXp params ->
            let
                adjustedBuff : Percent
                adjustedBuff =
                    Quantity.multiplyBy (toFloat count) buff

                newParams : Effect.GainXpParams
                newParams =
                    { params | percentIncrease = Quantity.plus params.percentIncrease adjustedBuff }
            in
            effect
                |> Effect.setEffect (Effect.GainXp newParams)
                |> ChangeEffect

        _ ->
            NoChange


coinTransformer : Percent -> Transformer
coinTransformer buff count taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainCoin quantity ->
            let
                adjustedMultiplicable : Effect.GainCoinParams
                adjustedMultiplicable =
                    { quantity | percentIncrease = Quantity.plus quantity.percentIncrease (Quantity.multiplyBy (toFloat count) buff) }
            in
            taggedEffect
                |> Effect.setEffect (Effect.GainCoin adjustedMultiplicable)
                |> ChangeEffect

        _ ->
            NoChange


mxpTransformer : Percent -> Transformer
mxpTransformer buff count taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainMxp params ->
            let
                adjustedBuff : Percent
                adjustedBuff =
                    Quantity.multiplyBy (toFloat count) buff

                newParams : Effect.GainMxpParams
                newParams =
                    { params | percentIncrease = Quantity.plus params.percentIncrease adjustedBuff }
            in
            taggedEffect
                |> Effect.setEffect (Effect.GainMxp newParams)
                |> ChangeEffect

        _ ->
            NoChange


resourceDoublingTransformer : Percent -> Transformer
resourceDoublingTransformer buff count taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainResource { base, doublingChance, resource } ->
            taggedEffect
                |> Effect.setEffect
                    (Effect.GainResource
                        { base = base
                        , doublingChance = Quantity.plus doublingChance (Quantity.multiplyBy (toFloat count) buff)
                        , resource = resource
                        }
                    )
                |> ChangeEffect

        _ ->
            NoChange


resourceBaseTransformer : Int -> Transformer
resourceBaseTransformer buff count taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainResource { base, doublingChance, resource } ->
            taggedEffect
                |> Effect.setEffect
                    (Effect.GainResource
                        { base = base + (buff * count)
                        , doublingChance = doublingChance
                        , resource = resource
                        }
                    )
                |> ChangeEffect

        _ ->
            NoChange


resourcePreservationTransformer : Percent -> Transformer
resourcePreservationTransformer buff count taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.SpendResource params ->
            let
                adjustedBuff : Percent
                adjustedBuff =
                    Quantity.multiplyBy (toFloat count) buff

                buffedChance : Percent
                buffedChance =
                    Quantity.plus params.preservationChance adjustedBuff
            in
            taggedEffect
                |> Effect.setEffect
                    (Effect.SpendResource
                        { params
                            | preservationChance = buffedChance
                        }
                    )
                |> ChangeEffect

        _ ->
            NoChange


increaseSuccessTransformer : Percent -> Transformer
increaseSuccessTransformer buff count taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.VariableSuccess params ->
            let
                newSuccessProbability =
                    Quantity.plus params.successProbability (Quantity.multiplyBy (toFloat count) buff)
                        |> Quantity.min (Percent.float 1.0)

                newEffect =
                    Effect.VariableSuccess { params | successProbability = newSuccessProbability }
            in
            ChangeEffect (Effect.setEffect newEffect taggedEffect)

        _ ->
            NoChange


addEffectsTransformer : List Effect -> Transformer
addEffectsTransformer effects count taggedEffect =
    ChangeAndAddEffects taggedEffect (List.concat (List.repeat count effects))


activityXpBuff : Activity -> Percent -> Mod
activityXpBuff activity amount =
    { tags = [ Effect.XpTag, Effect.ActivityTag activity ]
    , label = XpActivityLabel amount
    , transformer = xpTransformer amount
    , source = AdminCrimes
    , count = 1
    }


xpBuff : Percent -> Mod
xpBuff amount =
    { tags = [ Effect.XpTag ]
    , label = XpActivityLabel amount
    , transformer = xpTransformer amount
    , source = AdminCrimes
    , count = 1
    }


skillXpBuff : Skill -> Percent -> Mod
skillXpBuff skill amount =
    xpBuff amount
        |> withTags [ Effect.SkillTag skill ]
        |> withLabel (XpSkillLabel amount skill)


anatomyXpBuff : Percent -> Mod
anatomyXpBuff buff =
    { tags = [ Effect.SkillTag Anatomy, Effect.XpTag ]
    , label = XpActivityLabel buff
    , transformer = xpTransformer buff
    , source = AdminCrimes
    , count = 1
    }


coinBuff : Percent -> Mod
coinBuff buff =
    { tags = []
    , label = CoinLabel buff
    , transformer = coinTransformer buff
    , source = AdminCrimes
    , count = 1
    }


mxpBuff : Percent -> Mod
mxpBuff buff =
    { tags = [ Effect.MxpTag ]
    , label = MxpModLabel buff
    , transformer = mxpTransformer buff
    , source = AdminCrimes
    , count = 1
    }


resourceBuff : Percent -> Mod
resourceBuff buff =
    { tags = []
    , label = ResourceDoublingLabel buff
    , transformer = resourceDoublingTransformer buff
    , source = AdminCrimes
    , count = 1
    }


resourceBaseBuff : Int -> Mod
resourceBaseBuff buff =
    { tags = []
    , label = ResourceBaseLabel buff
    , transformer = resourceBaseTransformer buff
    , source = AdminCrimes
    , count = 1
    }


resourcePreservationBuff : Percent -> Mod
resourcePreservationBuff buff =
    { tags = []
    , label = ResourcePreservationLabel buff
    , transformer = resourcePreservationTransformer buff
    , source = AdminCrimes
    , count = 1
    }


successBuff : Percent -> Mod
successBuff buff =
    { tags = []
    , label = SuccessLabel buff
    , transformer = increaseSuccessTransformer buff
    , source = AdminCrimes
    , count = 1
    }


addEffects : List Effect -> Mod
addEffects effects =
    { tags = []
    , label = NullLabel
    , transformer = addEffectsTransformer effects
    , source = AdminCrimes
    , count = 1
    }


type Label
    = NullLabel -- for mods that don't make sense to label
    | XpActivityLabel Percent
    | XpSkillLabel Percent Skill
    | MxpModLabel Percent
    | ResourceDoublingLabel Percent
    | ResourcePreservationLabel Percent
    | ResourceBaseLabel Int
    | MoreManure
    | SuccessLabel Percent
    | CoinLabel Percent
    | PowerLabel Int
