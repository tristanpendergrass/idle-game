module IdleGame.Event3 exposing (..)

import IdleGame.Event exposing (Event)
import IdleGame.GameTypes exposing (ChoreType)


type Tag
    = Chores
    | Xp
    | Mxp


type Event
    = Event EventData


type ModdedEvent
    = ModdedEvent EventData


type alias EventData =
    { effects : List Effect
    , tags : List Tag
    }


type EffectType
    = Splitter (List ( Float, List Effect ))
    | GainResource { base : Int, doublingChance : Float } Resource
    | GainXp { base : Float, multiplier : Float } Skill
    | GainChoreMxp { base : Float, multiplier : Float } ChoreType
    | GainGold { base : Int, multiplier : Float }


type Effect
    = Effect
        { type_ : EffectType
        , tags : List Tag
        }


type Skill
    = ChoresSkill


type Resource
    = Manure
    | Ore
    | Ingot
    | Ruby


type Tree
    = Elm


type ModSource
    = AdminCrimes


getType : Effect -> EffectType
getType (Effect { type_ }) =
    type_


setEffectType : EffectType -> Effect -> Effect
setEffectType newType (Effect data) =
    Effect { data | type_ = newType }



-- Sample effects


getGold : Int -> EffectType
getGold amount =
    GainGold { base = amount, multiplier = 1.0 }


getResource : Int -> Resource -> EffectType
getResource amount resource =
    GainResource { base = amount, doublingChance = 0.0 } resource


getChoresXp : Float -> EffectType
getChoresXp amount =
    GainXp { base = amount, multiplier = 1.0 } ChoresSkill



-- Sample events
-- cleanStables : Event
-- cleanStables =
--     Event
--         { effects = [ ( 1.0, [ Determinate (getResource 1 Manure) ] ) ]
--         , tags = []
--         }
-- smeltOre : Event
-- smeltOre =
--     Event
--         { effects =
--             [ ( 0.5
--               , [ Determinate <| getResource -1 Ore ]
--               )
--             , ( 0.5
--               , [ Determinate <| getResource -1 Ore
--                 , Determinate <| getResource 1 Ingot
--                 ]
--               )
--             ]
--         , tags = []
--         }
-- smeltOrePlusGold : Event
-- smeltOrePlusGold =
--     Event
--         { effects =
--             [ ( 0.5
--               , [ Determinate <| getResource -1 Ore ]
--               )
--             , ( 0.5
--               , [ Determinate <| getResource -1 Ore
--                 , Determinate <| getResource 1 Ingot
--                 , Indeterminate
--                     [ ( 0.1
--                       , [ Determinate <| getGold 5 ]
--                       )
--                     ]
--                 ]
--               )
--             ]
--         , tags = []
--         }
-- smeltOrePlusGoldAndRuby : Event
-- smeltOrePlusGoldAndRuby =
--     Event
--         { effects =
--             [ ( 0.5
--               , [ Determinate <| getResource -1 Ore ]
--               )
--             , ( 0.5
--               , [ Determinate <| getResource -1 Ore
--                 , Determinate <| getResource 1 Ingot
--                 , Indeterminate
--                     [ ( 0.1
--                       , [ Determinate <| getGold 5
--                         , Indeterminate
--                             [ ( 0.25
--                               , [ Determinate <| getResource 1 Ruby
--                                 ]
--                               )
--                             ]
--                         ]
--                       )
--                     ]
--                 ]
--               )
--             ]
--         , tags = []
--         }
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


useSimpleTransformer : SimpleTransformer -> Transformer
useSimpleTransformer transformFn effect =
    let
        newEffectType =
            transformFn (getType effect)

        newEffect =
            effect
                |> setEffectType newEffectType
    in
    ChangeEffect newEffect


extraManureMod : Mod
extraManureMod =
    { tags = []
    , label = "Get extra manure 10% of the time"
    , transformer =
        useSimpleTransformer
            (\effectType ->
                case effectType of
                    GainResource { base, doublingChance } Manure ->
                        GainResource { base = base, doublingChance = doublingChance + 0.1 } Manure

                    _ ->
                        effectType
            )
    , source = AdminCrimes
    }



-- modifyEvent


applyModToEffect : Mod -> ( Effect, List Effect ) -> ( Effect, List Effect )
applyModToEffect mod ( effectAccum, furtherEffectsAccum ) =
    case mod.transformer effectAccum of
        NoChange ->
            ( effectAccum, furtherEffectsAccum )

        ChangeEffect changedEffect ->
            ( changedEffect, furtherEffectsAccum )

        ChangeAndAddEffects changedEffect changedFurtherEffects ->
            ( changedEffect, furtherEffectsAccum ++ changedFurtherEffects )


modifyEffect : Int -> List Mod -> Effect -> List Effect
modifyEffect depth mods effect =
    let
        result : ( Effect, List Effect )
        result =
            List.foldl applyModToEffect ( effect, [] ) mods

        ( newEffect, furtherEffects ) =
            result
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
        newEffects : List Effect
        newEffects =
            List.concatMap (modifyEffect 0 mods) eventData.effects
    in
    ModdedEvent { eventData | effects = newEffects }
