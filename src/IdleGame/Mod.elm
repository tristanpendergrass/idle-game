module IdleGame.Mod exposing (..)

import IdleGame.Effect as Effect
import IdleGame.Kinds exposing (..)
import Percent exposing (Percent)
import Quantity
import Types exposing (..)


scopeTransformerToTags : List Tag -> Transformer -> Transformer
scopeTransformerToTags tags transformer multiplier effect =
    if Effect.hasTags tags effect then
        transformer multiplier effect

    else
        NoChange


includeVariableEffects : EffectModParams -> EffectModParams
includeVariableEffects mod =
    -- Transforms the mod to apply to not just an effect but all the subeffects of that effect, e.g. the successEffects contained in a VariableSuccess
    let
        transformer =
            mod.transformer

        newTransformer : Int -> Effect -> TransformerResult
        newTransformer multiplier taggedEffect =
            case taggedEffect.effect of
                VariableSuccess { successProbability, successEffects, failureEffects } ->
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
                                (VariableSuccess
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
            transformFn (Effect.getEffectType taggedEffect)

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


applyModToEffect : EffectModParams -> ( Effect, List Effect ) -> ( Effect, List Effect )
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


applyModsToEffect : List EffectModParams -> Effect -> ( Effect, List Effect )
applyModsToEffect =
    applyModsToEffectHelp 0


tupleToList : ( a, List a ) -> List a
tupleToList ( x, xs ) =
    x :: xs


applyModsToEffectHelp : Int -> List EffectModParams -> Effect -> ( Effect, List Effect )
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


withHowManyTimesToApplyMod : Int -> EffectModParams -> EffectModParams
withHowManyTimesToApplyMod count mod =
    { mod | count = count }


withSource : ModSource -> EffectModParams -> EffectModParams
withSource source mod =
    { mod | source = source }


withTags : List Tag -> EffectModParams -> EffectModParams
withTags tags mod =
    { mod | tags = mod.tags ++ tags }


withLabel : String -> EffectModParams -> EffectModParams
withLabel label mod =
    { mod | label = label }


composeTransformer : List Transformer -> Transformer
composeTransformer transformers count originalEffect =
    case transformers of
        [] ->
            NoChange

        transformer :: rest ->
            case transformer count originalEffect of
                NoChange ->
                    composeTransformer rest count originalEffect

                ChangeEffect changedEffect ->
                    case composeTransformer rest count changedEffect of
                        NoChange ->
                            ChangeEffect changedEffect

                        ChangeEffect changedEffect2 ->
                            ChangeEffect changedEffect2

                        ChangeAndAddEffects changedEffect2 additionalEffects2 ->
                            ChangeAndAddEffects changedEffect2 additionalEffects2

                ChangeAndAddEffects changedEffect additionalEffects ->
                    case composeTransformer rest count changedEffect of
                        NoChange ->
                            ChangeAndAddEffects changedEffect additionalEffects

                        ChangeEffect changedEffect2 ->
                            ChangeAndAddEffects changedEffect2 additionalEffects

                        ChangeAndAddEffects changedEffect2 additionalEffects2 ->
                            ChangeAndAddEffects changedEffect2 (additionalEffects ++ additionalEffects2)


xpTransformer : Percent -> Transformer
xpTransformer buff count effect =
    case Effect.getEffectType effect of
        GainXp params ->
            let
                adjustedBuff : Percent
                adjustedBuff =
                    Quantity.multiplyBy (toFloat count) buff

                newParams : GainXpParams
                newParams =
                    { params | percentIncrease = Quantity.plus params.percentIncrease adjustedBuff }
            in
            effect
                |> Effect.setEffect (GainXp newParams)
                |> ChangeEffect

        _ ->
            NoChange


coinTransformer : Percent -> Transformer
coinTransformer buff count taggedEffect =
    case Effect.getEffectType taggedEffect of
        GainCoin quantity ->
            let
                adjustedMultiplicable : GainCoinParams
                adjustedMultiplicable =
                    { quantity | percentIncrease = Quantity.plus quantity.percentIncrease (Quantity.multiplyBy (toFloat count) buff) }
            in
            taggedEffect
                |> Effect.setEffect (GainCoin adjustedMultiplicable)
                |> ChangeEffect

        _ ->
            NoChange


mxpTransformer : Percent -> Transformer
mxpTransformer buff count taggedEffect =
    case Effect.getEffectType taggedEffect of
        GainMxp params ->
            let
                adjustedBuff : Percent
                adjustedBuff =
                    Quantity.multiplyBy (toFloat count) buff

                newParams : GainMxpParams
                newParams =
                    { params | percentIncrease = Quantity.plus params.percentIncrease adjustedBuff }
            in
            taggedEffect
                |> Effect.setEffect (GainMxp newParams)
                |> ChangeEffect

        _ ->
            NoChange


resourceDoublingTransformer : Percent -> Transformer
resourceDoublingTransformer buff count taggedEffect =
    case Effect.getEffectType taggedEffect of
        GainResource { base, doublingChance, resource } ->
            taggedEffect
                |> Effect.setEffect
                    (GainResource
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
    case Effect.getEffectType taggedEffect of
        GainResource { base, doublingChance, resource } ->
            taggedEffect
                |> Effect.setEffect
                    (GainResource
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
    case Effect.getEffectType taggedEffect of
        SpendResource params ->
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
                    (SpendResource
                        { params
                            | preservationChance = buffedChance
                        }
                    )
                |> ChangeEffect

        _ ->
            NoChange


resourceSpendTransformer : Int -> Transformer
resourceSpendTransformer buff count taggedEffect =
    case Effect.getEffectType taggedEffect of
        SpendResource params ->
            taggedEffect
                |> Effect.setEffect
                    (SpendResource
                        { params
                            | base = Basics.max 0 (params.base + (buff * count))
                        }
                    )
                |> ChangeEffect

        _ ->
            NoChange


increaseSuccessTransformer : Percent -> Transformer
increaseSuccessTransformer buff count taggedEffect =
    case Effect.getEffectType taggedEffect of
        VariableSuccess params ->
            let
                newSuccessProbability =
                    Quantity.plus params.successProbability (Quantity.multiplyBy (toFloat count) buff)
                        |> Quantity.min (Percent.float 1.0)

                newEffect =
                    VariableSuccess { params | successProbability = newSuccessProbability }
            in
            ChangeEffect (Effect.setEffect newEffect taggedEffect)

        _ ->
            NoChange


addEffectsTransformer : List Effect -> Transformer
addEffectsTransformer effects count taggedEffect =
    ChangeAndAddEffects taggedEffect (List.concat (List.repeat count effects))


xpAndMxpBuff : Percent -> EffectModParams
xpAndMxpBuff buff =
    { tags = []
    , label = "Xp and Mxp Buff"
    , transformer = composeTransformer [ xpTransformer buff, mxpTransformer buff ]
    , source = AdminCrimes
    , count = 1
    }


activityXpBuff : Activity -> Percent -> EffectModParams
activityXpBuff activity amount =
    { tags = [ ActivityTag activity ]
    , label = "Activity Xp Buff"
    , transformer = xpTransformer amount
    , source = AdminCrimes
    , count = 1
    }


xpBuff : Percent -> EffectModParams
xpBuff amount =
    { tags = []
    , label = "Xp Buff"
    , transformer = xpTransformer amount
    , source = AdminCrimes
    , count = 1
    }


resourceSpendDecreaseBuff : Int -> EffectModParams
resourceSpendDecreaseBuff buff =
    -- Decrease the amount of resources spent by amount passed in
    { tags = []
    , label = "Resource Spend Decrease Buff"
    , transformer = resourceSpendTransformer (-1 * buff)
    , source = AdminCrimes
    , count = 1
    }


skillXpBuff : Skill -> Percent -> EffectModParams
skillXpBuff skill amount =
    xpBuff amount
        |> withTags [ SkillTag skill ]
        |> withLabel "Skill Xp Buff"


coinBuff : Percent -> EffectModParams
coinBuff buff =
    { tags = []
    , label = "Coin Buff"
    , transformer = coinTransformer buff
    , source = AdminCrimes
    , count = 1
    }


mxpBuff : Percent -> EffectModParams
mxpBuff buff =
    { tags = []
    , label = "Mxp Buff"
    , transformer = mxpTransformer buff
    , source = AdminCrimes
    , count = 1
    }


resourceDoublingBuff : Percent -> EffectModParams
resourceDoublingBuff buff =
    { tags = []
    , label = "Resource Doubling Buff"
    , transformer = resourceDoublingTransformer buff
    , source = AdminCrimes
    , count = 1
    }


resourceBaseBuff : Int -> EffectModParams
resourceBaseBuff buff =
    { tags = []
    , label = "Resource Base Buff"
    , transformer = resourceBaseTransformer buff
    , source = AdminCrimes
    , count = 1
    }


resourcePreservationBuff : Percent -> EffectModParams
resourcePreservationBuff buff =
    { tags = []
    , label = "Resource Preservation Buff"
    , transformer = resourcePreservationTransformer buff
    , source = AdminCrimes
    , count = 1
    }


successBuff : Percent -> EffectModParams
successBuff buff =
    { tags = []
    , label = "Success Buff"
    , transformer = increaseSuccessTransformer buff
    , source = AdminCrimes
    , count = 1
    }


addEffects : List Effect -> EffectModParams
addEffects effects =
    { tags = []
    , label = "Add Effects"
    , transformer = addEffectsTransformer effects
    , source = AdminCrimes
    , count = 1
    }


gainResourceWithProbability : Percent -> Resource -> EffectModParams
gainResourceWithProbability probability resource =
    addEffects [ Effect.gainWithProbability probability [ Effect.gainResource 1 resource ] ]
        |> withLabel "Gain Resource With Probability"


gainResource : Int -> Resource -> EffectModParams
gainResource amount resource =
    addEffects [ Effect.gainResource amount resource ]
        |> withLabel "Gain Resource"
