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


includeVariableEffects : Transformer -> Transformer
includeVariableEffects transformer effect =
    case getType effect of
        VariableSuccess { successProbability, successEffects, failureEffects } ->
            let
                ( successEffectsDidChange, newSuccessEffects ) =
                    let
                        newEffects : List Effect
                        newEffects =
                            List.concatMap (modifyEffect 0 [ transformer ]) successEffects
                    in
                    ( True, newEffects )

                ( failureEffectsDidChange, newFailureEffects ) =
                    let
                        newEffects : List Effect
                        newEffects =
                            List.concatMap (modifyEffect 0 [ transformer ]) failureEffects
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


applyModToEffect : Transformer -> ( Effect, List Effect ) -> ( Effect, List Effect )
applyModToEffect transformer ( effectAccum, furtherEffectsAccum ) =
    case transformer effectAccum of
        NoChange ->
            ( effectAccum, furtherEffectsAccum )

        ChangeEffect changedEffect ->
            ( changedEffect, furtherEffectsAccum )

        ChangeAndAddEffects changedEffect changedFurtherEffects ->
            ( changedEffect, furtherEffectsAccum ++ changedFurtherEffects )


modifyEffect : Int -> List Transformer -> Effect -> List Effect
modifyEffect depth transformers effect =
    let
        result : ( Effect, List Effect )
        result =
            List.foldl applyModToEffect ( effect, [] ) transformers

        ( newEffect, furtherEffects ) =
            result
    in
    newEffect
        -- The depth < 20 is an arbitrary limit that shouldn't usually be reached. It should be rare for a "further effect" to trigger
        -- a mod that gives another further effect and have that repeat more than 20 times, if so the player just doesn't get the benefit -- :)
        :: (if depth < 20 then
                List.concatMap (modifyEffect (depth + 1) transformers) furtherEffects

            else
                [ newEffect ]
           )


type ModFilter
    = NoFilter
    | FilterToTags (List Tag)


filterModsToTags : List Tag -> List Mod -> List Mod
filterModsToTags =
    Debug.todo ""


modifyEvent : List Mod -> ModFilter -> Event -> ModdedEvent
modifyEvent mods modFilter (Event eventData) =
    let
        -- filteredMods =
        --     case modFilter of
        --         NoFilter ->
        --             mods
        --         FilterToTags tags ->
        --             filterModsToTags tags mods
        transformers =
            List.map .transformer mods

        newEffects : List Effect
        newEffects =
            List.concatMap (modifyEffect 0 transformers) eventData.effects
    in
    ModdedEvent { eventData | effects = newEffects }
