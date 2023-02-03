module IdleGame.Event exposing (..)

import IdleGame.GameTypes exposing (ChoreType)
import IdleGame.Resource as Resource



-- Config


type Tag
    = Chores
    | Xp
    | Mxp
    | ChoreTag ChoreType


type Skill
    = ChoresSkill


type ModSource
    = AdminCrimes
    | ShopItem



-- Events


type alias EventData =
    { effects : List Effect
    , tags : List Tag
    }


type Event
    = Event EventData


type ModdedEvent
    = ModdedEvent EventData



-- Effects


type EffectType
    = VariableSuccess { successProbability : Float, successEffects : List Effect, failureEffects : List Effect }
    | GainResource { base : Int, doublingChance : Float } Resource.Kind
    | GainXp { base : Float, multiplier : Float } Skill
    | GainChoreMxp { multiplier : Float } ChoreType
    | GainGold { base : Int, doublingChance : Float }


type Effect
    = Effect
        { type_ : EffectType
        , tags : List Tag
        }


getType : Effect -> EffectType
getType (Effect { type_ }) =
    type_


setType : EffectType -> Effect -> Effect
setType newType (Effect data) =
    Effect { data | type_ = newType }



-- Mods


type alias Mod =
    { tags : List Tag
    , label : String
    , transformer : Transformer
    , multiplier : Int
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
                                    List.concatMap (applyModsToEffect 0 [ { mod | transformer = newTransformer } ]) successEffects
                            in
                            ( successEffects /= newEffects, newEffects )

                        ( failureEffectsDidChange, newFailureEffects ) =
                            let
                                newEffects : List Effect
                                newEffects =
                                    List.concatMap (applyModsToEffect 0 [ mod ]) failureEffects
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
useSimpleTransformerHelp depth transformFn multiplier effect =
    let
        newEffectType =
            transformFn (getType effect)

        newEffect =
            effect
                |> setType newEffectType
    in
    if multiplier > 1 && depth < 20 then
        useSimpleTransformerHelp (depth + 1) transformFn (multiplier - 1) newEffect

    else
        ChangeEffect newEffect


applyModToEffect : Mod -> ( Effect, List Effect ) -> ( Effect, List Effect )
applyModToEffect mod ( effectAccum, furtherEffectsAccum ) =
    if effectHasTags mod.tags effectAccum then
        case mod.transformer mod.multiplier effectAccum of
            NoChange ->
                ( effectAccum, furtherEffectsAccum )

            ChangeEffect changedEffect ->
                ( changedEffect, furtherEffectsAccum )

            ChangeAndAddEffects changedEffect changedFurtherEffects ->
                ( changedEffect, furtherEffectsAccum ++ changedFurtherEffects )

    else
        ( effectAccum, furtherEffectsAccum )


applyModsToEffect : Int -> List Mod -> Effect -> List Effect
applyModsToEffect depth mods effect =
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
                List.concatMap (applyModsToEffect (depth + 1) mods) furtherEffects

            else
                []
           )


applyModsToEvent : List Mod -> Event -> ModdedEvent
applyModsToEvent mods (Event eventData) =
    ModdedEvent
        { eventData
          -- | effects = List.concatMap (applyTransformersToEffect 0 transformers) eventData.effects
            | effects = List.concatMap (applyModsToEffect 0 mods) eventData.effects
        }


withMods : List Mod -> Event -> ModdedEvent
withMods mods event =
    applyModsToEvent mods event


withMultiplier : Int -> Mod -> Mod
withMultiplier multiplier mod =
    { mod | multiplier = multiplier }


withSource : ModSource -> Mod -> Mod
withSource source mod =
    { mod | source = source }


modWithTags : List Tag -> Mod -> Mod
modWithTags tags mod =
    { mod | tags = mod.tags ++ tags }


xpTransformer : Float -> Transformer
xpTransformer buff effectMultiplier effect =
    case getType effect of
        GainXp { base, multiplier } skill ->
            effect
                |> setType (GainXp { base = base, multiplier = multiplier + (buff * toFloat effectMultiplier) } skill)
                |> ChangeEffect

        _ ->
            NoChange


mxpTransformer : Float -> Transformer
mxpTransformer buff effectMultiplier effect =
    case getType effect of
        GainChoreMxp { multiplier } chore ->
            effect
                |> setType (GainChoreMxp { multiplier = multiplier + (buff * toFloat effectMultiplier) } chore)
                |> ChangeEffect

        _ ->
            NoChange


xpModLabel : Float -> String
xpModLabel multiplier =
    "+" ++ String.fromInt (floor (multiplier * 100)) ++ "% XP"


mxpModLabel : Float -> String
mxpModLabel multiplier =
    "+" ++ String.fromInt (floor (multiplier * 100)) ++ "% Mastery XP"


devGlobalXpBuff : Mod
devGlobalXpBuff =
    { tags = [ Xp ]
    , label = xpModLabel 1.0
    , transformer = xpTransformer 1.0
    , source = AdminCrimes
    , multiplier = 1
    }


choresXpBuff : Float -> Mod
choresXpBuff buff =
    { tags = [ Chores, Xp ]
    , label = xpModLabel buff
    , transformer = xpTransformer buff
    , source = AdminCrimes
    , multiplier = 1
    }


choresMxpBuff : Float -> Mod
choresMxpBuff buff =
    { tags = []
    , label = mxpModLabel buff
    , transformer = mxpTransformer buff
    , source = AdminCrimes
    , multiplier = 1
    }
