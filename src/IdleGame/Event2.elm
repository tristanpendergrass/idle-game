module IdleGame.Event2 exposing (..)

import IdleGame.Event exposing (Event)
import IdleGame.GameTypes exposing (ChoreType)
import List.Nonempty exposing (Nonempty)


type Tag
    = Chores
    | Xp
    | Mxp


type Event
    = Event EventData


type ModdedEvent
    = ModdedEvent EventData


type alias EventData =
    { title : String
    , effects : Effects
    , tags : List Tag
    }


type Effects
    = Determinate { effects : List Effect }
    | Indeterminate { effects : List Effect, probability : Float, failEffects : List Effect }


type EffectType
    = GainResource { base : Int, multiplier : Float } Resource
    | GainXp { base : Float, multiplier : Float } Skill
    | GainChoreMxp { base : Float, multiplier : Float } ChoreType


gainChoresXp : Float -> EffectType
gainChoresXp amount =
    GainXp { base = amount, multiplier = 1.0 } ChoresSkill


gainManure : Int -> EffectType
gainManure amount =
    GainResource { base = amount, multiplier = 1.0 } Manure


setMultiplier : Float -> { a | multiplier : Float } -> { a | multiplier : Float }
setMultiplier newMultiplier obj =
    { obj | multiplier = newMultiplier }


type alias Effect =
    { type_ : EffectType
    , tags : List Tag
    }


type Skill
    = ChoresSkill


type Resource
    = Manure


type Tree
    = Elm


type ModSource
    = AdminCrimes


type TransformerResult
    = NoChange
    | Change Effects


type alias Transformer =
    Effect -> TransformerResult


type alias Mod =
    { tags : List Tag
    , label : String
    , transformer : Transformer
    , source : ModSource
    }


setEffectType : EffectType -> Effect -> Effect
setEffectType newType effect =
    { effect | type_ = newType }


applyModToEffect : Mod -> ( Effect, List Effect ) -> ( Effect, List Effect )
applyModToEffect mod ( effectAccum, furtherEffectsAccum ) =
    -- case mod.transformer effectAccum of
    --     NoChange ->
    --         ( effectAccum, furtherEffectsAccum )
    --     Change changedEffect ->
    --         ( changedEffect, furtherEffectsAccum )
    Debug.todo ""


modifyEffect : Int -> List Mod -> Effect -> List Effect
modifyEffect depth mods effect =
    let
        initVal : ( Effect, List Effect )
        initVal =
            ( effect, [] )

        newStuff : ( Effect, List Effect )
        newStuff =
            List.foldl applyModToEffect initVal mods

        ( newEffect, furtherEffects ) =
            newStuff
    in
    newEffect
        -- The depth < 20 is an arbitrary limit that shouldn't usually be reached. It should be rare for a "further effect" to trigger
        -- a mod that gives another further effect and have that repeat more than 20 times, if so the player just doesn't get the benefit -- :)
        :: (if depth < 20 then
                List.concatMap (modifyEffect (depth + 1) mods) furtherEffects

            else
                [ newEffect ]
           )


modifyEvent : List Mod -> Event -> ModdedEvent
modifyEvent mods (Event eventData) =
    let
        newEffects : Effects
        newEffects =
            case eventData.effects of
                Determinate { effects } ->
                    let
                        newEffectsList =
                            List.concatMap (modifyEffect 0 mods) effects
                    in
                    Determinate { effects = newEffectsList }

                Indeterminate { effects, probability, failEffects } ->
                    Debug.todo "Imp"
    in
    ModdedEvent { eventData | effects = newEffects }
