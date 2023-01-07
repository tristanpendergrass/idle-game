module IdleGame.Event3 exposing (..)

import IdleGame.Event exposing (Event)
import IdleGame.GameTypes exposing (ChoreType)



-- Config


type Tag
    = Chores
    | Xp
    | Mxp


type Skill
    = ChoresSkill


type Resource
    = Manure
    | Ore
    | Ingot
    | Ruby


type ModSource
    = AdminCrimes



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
    | GainResource { base : Int, doublingChance : Float } Resource
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
    Effect -> TransformerResult


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
scopeTransformerToTags tags transformer effect =
    if effectHasTags tags effect then
        transformer effect

    else
        NoChange


includeVariableEffects : Transformer -> Transformer
includeVariableEffects transformer effect =
    case getType effect of
        VariableSuccess { successProbability, successEffects, failureEffects } ->
            let
                ( successEffectsDidChange, newSuccessEffects ) =
                    let
                        newEffects : List Effect
                        newEffects =
                            List.concatMap (applyTransformersToEffect 0 [ transformer ]) successEffects
                    in
                    ( True, newEffects )

                ( failureEffectsDidChange, newFailureEffects ) =
                    let
                        newEffects : List Effect
                        newEffects =
                            List.concatMap (applyTransformersToEffect 0 [ transformer ]) failureEffects
                    in
                    ( True, newEffects )

                effectDidChange =
                    successEffectsDidChange || failureEffectsDidChange
            in
            if effectDidChange then
                ChangeEffect <| setType (VariableSuccess { successProbability = successProbability, successEffects = newSuccessEffects, failureEffects = newFailureEffects }) effect

            else
                NoChange

        _ ->
            transformer effect


useSimpleTransformer : SimpleTransformer -> Transformer
useSimpleTransformer transformFn effect =
    let
        newEffectType =
            transformFn (getType effect)

        newEffect =
            effect
                |> setType newEffectType
    in
    ChangeEffect newEffect


transformEffect : Transformer -> ( Effect, List Effect ) -> ( Effect, List Effect )
transformEffect transformer ( effectAccum, furtherEffectsAccum ) =
    case transformer effectAccum of
        NoChange ->
            ( effectAccum, furtherEffectsAccum )

        ChangeEffect changedEffect ->
            ( changedEffect, furtherEffectsAccum )

        ChangeAndAddEffects changedEffect changedFurtherEffects ->
            ( changedEffect, furtherEffectsAccum ++ changedFurtherEffects )


applyTransformersToEffect : Int -> List Transformer -> Effect -> List Effect
applyTransformersToEffect depth transformers effect =
    let
        ( newEffect, furtherEffects ) =
            List.foldl
                (\transformer accum -> transformEffect transformer accum)
                ( effect, [] )
                transformers
    in
    newEffect
        -- The depth < 20 is an arbitrary limit that shouldn't usually be reached. It should be rare for a "further effect" to trigger
        -- a mod that gives another further effect and have that repeat more than 20 times, if so the player just doesn't get the benefit -- :)
        :: (if depth < 20 then
                List.concatMap (applyTransformersToEffect (depth + 1) transformers) furtherEffects

            else
                []
           )


applyModsToEvent : List Mod -> Event -> ModdedEvent
applyModsToEvent mods (Event eventData) =
    let
        transformers =
            mods
                |> List.map
                    (\{ transformer, multiplier } ->
                        multiplyTransformer multiplier transformer
                    )
    in
    ModdedEvent
        { eventData
            | effects = List.concatMap (applyTransformersToEffect 0 transformers) eventData.effects
        }


multiplyTransformer : Int -> Transformer -> Transformer
multiplyTransformer multiplier fn effect =
    let
        result =
            fn effect
    in
    case result of
        NoChange ->
            result

        ChangeEffect newEffect ->
            if multiplier <= 1 then
                result

            else
                multiplyTransformer (multiplier - 1) fn newEffect

        ChangeAndAddEffects newEffect newAdditions ->
            if multiplier <= 1 then
                result

            else
                case multiplyTransformer (multiplier - 1) fn newEffect of
                    NoChange ->
                        result

                    ChangeEffect e ->
                        ChangeAndAddEffects e newAdditions

                    ChangeAndAddEffects e a ->
                        ChangeAndAddEffects e a


withMods : List Mod -> Event -> ModdedEvent
withMods mods event =
    applyModsToEvent mods event


withMultiplier : Int -> Mod -> Mod
withMultiplier multiplier mod =
    { mod | multiplier = multiplier }
