module IdleGame.Mod exposing (..)

import IdleGame.Combat as Combat exposing (Combat)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Skill as Skill
import IdleGame.Views.Utils
import Percent exposing (Percent)


type ModSource
    = AdminCrimes
    | ShopItem


type alias Mod =
    { tags : List Effect.Tag
    , label : ModLabel
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



-- variableEffectsTransformer : Transformer
-- variableEffectsTransformer multiplier effect =
--     case Effect.getEffect effect of
--         Effect.VariableSuccess {successProbability, successEffects, failureEffects} ->
--             effect
--                 |> Effect.setEffect (Effect.VariableSuccess
--                     { successProbability = successProbability
--                     , successEffects =
--                     }
--                 )
--                 |> ChangeEffect


includeVariableEffects : Mod -> Mod
includeVariableEffects mod =
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


modWithTags : List Effect.Tag -> Mod -> Mod
modWithTags tags mod =
    { mod | tags = mod.tags ++ tags }


xpTransformer : Float -> Transformer
xpTransformer buff repetitions effect =
    case Effect.getEffect effect of
        Effect.GainXp quantity skill ->
            let
                adjustedBuff =
                    buff * toFloat repetitions

                adjustedMultiplicable =
                    { quantity | multiplier = quantity.multiplier * adjustedBuff }
            in
            effect
                |> Effect.setEffect (Effect.GainXp adjustedMultiplicable skill)
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
        Effect.GainMxp quantity chore ->
            let
                adjustedBuff =
                    buff * toFloat repetitions

                adjustedMultiplicable =
                    { quantity | multiplier = quantity.multiplier * adjustedBuff }
            in
            taggedEffect
                |> Effect.setEffect (Effect.GainMxp adjustedMultiplicable chore)
                |> ChangeEffect

        _ ->
            NoChange


resourceTransformer : Float -> Transformer
resourceTransformer buff repetitions taggedEffect =
    case Effect.getEffect taggedEffect of
        Effect.GainResource { base, doublingChance } kind ->
            taggedEffect
                |> Effect.setEffect (Effect.GainResource { base = base, doublingChance = doublingChance + (buff * toFloat repetitions) } kind)
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


xpBuff : Float -> Mod
xpBuff amount =
    { tags = [ Effect.XpTag ]
    , label = XpModLabel amount
    , transformer = xpTransformer amount
    , source = AdminCrimes
    , repetitions = 1
    }


choresXpBuff : Float -> Mod
choresXpBuff buff =
    { tags = [ Effect.SkillTag Skill.Chores, Effect.XpTag ]
    , label = XpModLabel buff
    , transformer = xpTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


coinBuff : Float -> Mod
coinBuff buff =
    { tags = []
    , label = CoinModLabel buff
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
    , label = ResourceModLabel buff
    , transformer = resourceTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


successBuff : Float -> Mod
successBuff buff =
    { tags = []
    , label = SuccessModLabel buff
    , transformer = increaseSuccessTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


powerBuff : Int -> Mod
powerBuff buff =
    { tags = []
    , label = PowerModLabel buff
    , transformer = powerTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


type ModLabel
    = XpModLabel Float
    | MxpModLabel Float
    | ResourceModLabel Float
    | SuccessModLabel Float
    | CoinModLabel Float
    | PowerModLabel Int


modLabelToString : ModLabel -> String
modLabelToString modLabel =
    case modLabel of
        XpModLabel buff ->
            "+" ++ IdleGame.Views.Utils.intToString (floor (buff * 100)) ++ "% XP"

        MxpModLabel buff ->
            "+" ++ IdleGame.Views.Utils.intToString (floor (buff * 100)) ++ "% Mastery XP"

        ResourceModLabel buff ->
            "+" ++ IdleGame.Views.Utils.intToString (floor (buff * 100)) ++ "% chance to double items"

        SuccessModLabel buff ->
            "+" ++ IdleGame.Views.Utils.intToString (floor (buff * 100)) ++ "% chance to gain an item"

        CoinModLabel buff ->
            "+" ++ IdleGame.Views.Utils.intToString (floor (buff * 100)) ++ "% Coin"

        PowerModLabel buff ->
            "+" ++ IdleGame.Views.Utils.intToString buff ++ " Power"


intervalModLabelToString : IntervalModLabel -> String
intervalModLabelToString modLabel =
    case modLabel of
        IntervalModLabel buff ->
            "+" ++ IdleGame.Views.Utils.floatToString 2 (Percent.toPercentage buff) ++ "% faster"
