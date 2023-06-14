module IdleGame.Event exposing (..)

import IdleGame.Chore as Chore
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.GameTypes exposing (..)
import IdleGame.Multiplicable as Multiplicable exposing (Multiplicable)
import IdleGame.Resource as Resource
import IdleGame.Skill exposing (Skill(..), SkillDict)
import IdleGame.Views.Utils
import IdleGame.Xp as Xp exposing (Xp)



-- Config


type
    Tag
    -- TODO: refactor into a Tag module so references can be Tag.Skill?
    = SkillTag Skill
    | XpTag
    | MxpTag
    | ChoreTag Chore.Kind


type ModSource
    = AdminCrimes
    | ShopItem



-- Events


type alias EventData =
    { effects : List Effect
    }


type Event
    = Event EventData


type ModdedEvent
    = ModdedEvent EventData



-- Effects


type EffectType
    = VariableSuccess { successProbability : Float, successEffects : List Effect, failureEffects : List Effect }
    | GainResource { base : Int, doublingChance : Float } Resource.Kind
    | GainXp { base : Xp, multiplier : Float } Skill
    | GainChoreMxp { base : Xp, multiplier : Float } Chore.Kind
    | GainCoin Multiplicable


type Effect
    = Effect
        { type_ : EffectType
        , tags : List Tag
        }


getEffects : Event -> List Effect
getEffects (Event { effects }) =
    effects


getEffectsModded : ModdedEvent -> List Effect
getEffectsModded (ModdedEvent { effects }) =
    effects


getType : Effect -> EffectType
getType (Effect { type_ }) =
    type_


setType : EffectType -> Effect -> Effect
setType newType (Effect data) =
    Effect { data | type_ = newType }



-- Mods


type alias Mod =
    { tags : List Tag
    , label : ModLabel
    , transformer : Transformer
    , repetitions : Int
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


effectHasTags : List Tag -> Effect -> Bool
effectHasTags mandatoryTags (Effect { tags }) =
    List.all
        (\tag ->
            List.member tag tags
        )
        mandatoryTags


scopeTransformerToTags : List Tag -> Transformer -> Transformer
scopeTransformerToTags tags transformer multiplier effect =
    if effectHasTags tags effect then
        transformer multiplier effect

    else
        NoChange



-- variableEffectsTransformer : Transformer
-- variableEffectsTransformer multiplier effect =
--     case getType effect of
--         VariableSuccess {successProbability, successEffects, failureEffects} ->
--             effect
--                 |> setType (VariableSuccess
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

        newTransformer : Int -> Effect -> TransformerResult
        newTransformer multiplier effect =
            case getType effect of
                VariableSuccess { successProbability, successEffects, failureEffects } ->
                    let
                        ( successEffectsDidChange, newSuccessEffects ) =
                            let
                                newEffects : List Effect
                                newEffects =
                                    List.concatMap (applyModsToEffect [ { mod | transformer = newTransformer } ]) successEffects
                            in
                            ( successEffects /= newEffects, newEffects )

                        ( failureEffectsDidChange, newFailureEffects ) =
                            let
                                newEffects : List Effect
                                newEffects =
                                    List.concatMap (applyModsToEffect [ mod ]) failureEffects
                            in
                            ( failureEffects /= newEffects, newEffects )

                        effectDidChange =
                            successEffectsDidChange || failureEffectsDidChange
                    in
                    if effectDidChange then
                        effect
                            |> setType
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
                    transformer multiplier effect
    in
    { mod | transformer = newTransformer }


useSimpleTransformer : SimpleTransformer -> Transformer
useSimpleTransformer =
    -- TODO: add unit test for recursive transformer only working 20x
    useSimpleTransformerHelp 0


useSimpleTransformerHelp : Int -> SimpleTransformer -> Transformer
useSimpleTransformerHelp depth transformFn repetitions effect =
    let
        newEffectType =
            transformFn (getType effect)

        newEffect =
            effect
                |> setType newEffectType
    in
    if repetitions > 1 && depth < 20 then
        useSimpleTransformerHelp (depth + 1) transformFn (repetitions - 1) newEffect

    else if repetitions == 0 then
        NoChange

    else
        ChangeEffect newEffect


applyModToEffect : Mod -> ( Effect, List Effect ) -> ( Effect, List Effect )
applyModToEffect mod ( effectAccum, furtherEffectsAccum ) =
    if effectHasTags mod.tags effectAccum then
        case mod.transformer mod.repetitions effectAccum of
            NoChange ->
                ( effectAccum, furtherEffectsAccum )

            ChangeEffect changedEffect ->
                ( changedEffect, furtherEffectsAccum )

            ChangeAndAddEffects changedEffect changedFurtherEffects ->
                ( changedEffect, furtherEffectsAccum ++ changedFurtherEffects )

    else
        ( effectAccum, furtherEffectsAccum )


applyModsToEffect : List Mod -> Effect -> List Effect
applyModsToEffect =
    applyModsToEffectHelp 0


applyModsToEffectHelp : Int -> List Mod -> Effect -> List Effect
applyModsToEffectHelp depth mods effect =
    let
        ( newEffect, furtherEffects ) =
            List.foldl
                (\mod accum ->
                    if effectHasTags mod.tags effect then
                        applyModToEffect mod accum

                    else
                        accum
                )
                ( effect, [] )
                mods
    in
    newEffect
        -- TODO: unit test this 20 threshold?
        -- The depth < 20 is an arbitrary limit that shouldn't usually be reached. It should be rare for a "further effect" to trigger
        -- a mod that gives another further effect and have that repeat more than 20 times, if so the player just doesn't get the benefit -- :)
        :: (if depth < 20 then
                List.concatMap (applyModsToEffectHelp (depth + 1) mods) furtherEffects

            else
                []
           )


applyMods : List Mod -> Event -> ModdedEvent
applyMods mods (Event eventData) =
    ModdedEvent
        { eventData
          -- | effects = List.concatMap (applyTransformersToEffect 0 transformers) eventData.effects
            | effects = List.concatMap (applyModsToEffect mods) eventData.effects
        }


withMods : List Mod -> Event -> ModdedEvent
withMods mods event =
    applyMods mods event


withHowManyTimesToApplyMod : Int -> Mod -> Mod
withHowManyTimesToApplyMod repetitions mod =
    { mod | repetitions = repetitions }


withSource : ModSource -> Mod -> Mod
withSource source mod =
    { mod | source = source }


modWithTags : List Tag -> Mod -> Mod
modWithTags tags mod =
    { mod | tags = mod.tags ++ tags }


xpTransformer : Float -> Transformer
xpTransformer buff repetitions effect =
    case getType effect of
        GainXp quantity skill ->
            let
                adjustedBuff =
                    buff * toFloat repetitions

                adjustedMultiplicable =
                    { quantity | multiplier = quantity.multiplier * adjustedBuff }
            in
            effect
                |> setType (GainXp adjustedMultiplicable skill)
                |> ChangeEffect

        _ ->
            NoChange


coinTransformer : Float -> Transformer
coinTransformer buff repetitions effect =
    case getType effect of
        GainCoin quantity ->
            let
                adjustedBuff =
                    buff * toFloat repetitions

                adjustedMultiplicable =
                    quantity
                        |> Multiplicable.addMultiplier adjustedBuff
            in
            effect
                |> setType (GainCoin adjustedMultiplicable)
                |> ChangeEffect

        _ ->
            NoChange


mxpTransformer : Float -> Transformer
mxpTransformer buff repetitions effect =
    case getType effect of
        GainChoreMxp quantity chore ->
            let
                adjustedBuff =
                    buff * toFloat repetitions

                adjustedMultiplicable =
                    { quantity | multiplier = quantity.multiplier * adjustedBuff }
            in
            effect
                |> setType (GainChoreMxp adjustedMultiplicable chore)
                |> ChangeEffect

        _ ->
            NoChange


resourceTransformer : Float -> Transformer
resourceTransformer buff repetitions effect =
    case getType effect of
        GainResource { base, doublingChance } kind ->
            effect
                |> setType (GainResource { base = base, doublingChance = doublingChance + (buff * toFloat repetitions) } kind)
                |> ChangeEffect

        _ ->
            NoChange


increaseSuccessTransformer : Float -> Transformer
increaseSuccessTransformer buff repetitions effect =
    case getType effect of
        VariableSuccess params ->
            let
                newSuccessProbability =
                    (params.successProbability + buff * toFloat repetitions)
                        |> min 1.0

                newEffectType =
                    VariableSuccess { params | successProbability = newSuccessProbability }
            in
            ChangeEffect (setType newEffectType effect)

        _ ->
            NoChange


devGlobalXpBuff : Mod
devGlobalXpBuff =
    { tags = [ XpTag ]
    , label = XpModLabel 1
    , transformer = xpTransformer 1.0
    , source = AdminCrimes
    , repetitions = 1
    }


choresXpBuff : Float -> Mod
choresXpBuff buff =
    { tags = [ SkillTag Chores, XpTag ]
    , label = XpModLabel buff
    , transformer = xpTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


choresCoinBuff : Float -> Mod
choresCoinBuff buff =
    { tags = [ SkillTag Chores ]
    , label = CoinModLabel buff
    , transformer = coinTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


choresMxpBuff : Float -> Mod
choresMxpBuff buff =
    { tags = []
    , label = MxpModLabel buff
    , transformer = mxpTransformer buff
    , source = AdminCrimes
    , repetitions = 1
    }


choresResourceBuff : Float -> Mod
choresResourceBuff buff =
    { tags = [ SkillTag Chores ]
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


type ModLabel
    = XpModLabel Float
    | MxpModLabel Float
    | ResourceModLabel Float
    | SuccessModLabel Float
    | CoinModLabel Float


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


orderEffects : Effect -> Effect -> Order
orderEffects effect1 effect2 =
    -- TODO: order these properly, e.g. coin before XP, resource before coin
    LT
