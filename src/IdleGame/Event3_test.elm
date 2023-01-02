module IdleGame.Event3_test exposing (..)

import Expect exposing (..)
import IdleGame.Event3 exposing (..)
import Test exposing (..)


withModsEquals : List Mod -> ModdedEvent -> Event -> Expectation
withModsEquals mods moddedEvent event =
    Expect.equal moddedEvent (applyModsToEvent mods event)


withMods : List Mod -> Event -> ModdedEvent
withMods mods event =
    applyModsToEvent mods event


mockEffect : EffectType -> Effect
mockEffect type_ =
    Effect { type_ = type_, tags = [] }


mockEvent : List EffectType -> Event
mockEvent effects =
    Event
        { effects = List.map mockEffect effects
        , tags = []
        }


mockModdedEvent : List EffectType -> ModdedEvent
mockModdedEvent effects =
    ModdedEvent
        { effects = List.map mockEffect effects
        , tags = []
        }


mockMod : Transformer -> Mod
mockMod transformer =
    { tags = []
    , label = "Test"
    , transformer = transformer
    , source = AdminCrimes
    }


xpIncreaser : Float -> Transformer
xpIncreaser buff =
    useSimpleTransformer
        (\effectType ->
            case effectType of
                GainXp { base, multiplier } skill ->
                    GainXp { base = base, multiplier = multiplier + buff } skill

                _ ->
                    effectType
        )


probabilityIncreaser : Float -> Transformer
probabilityIncreaser amount =
    useSimpleTransformer
        (\effectType ->
            case effectType of
                VariableSuccess { successProbability, successEffects, failureEffects } ->
                    VariableSuccess
                        { successProbability = successProbability + amount
                        , successEffects = successEffects
                        , failureEffects = failureEffects
                        }

                _ ->
                    effectType
        )


manureGiver : Transformer
manureGiver effect =
    -- Grants 1 Manure every time any amount of a resource other than manure is gained
    case getType effect of
        GainResource { base } resource ->
            if resource == Manure || base <= 0 then
                NoChange

            else
                ChangeAndAddEffects effect [ mockEffect (getResource 1 Manure) ]

        _ ->
            NoChange


testMods : { mods : List Mod, event : Event, moddedEvent : ModdedEvent } -> Expectation
testMods { mods, event, moddedEvent } =
    event
        |> withMods mods
        |> equal moddedEvent


getGold : Int -> EffectType
getGold amount =
    GainGold { base = amount, doublingChance = 0 }


getResource : Int -> Resource -> EffectType
getResource amount resource =
    GainResource { base = amount, doublingChance = 0.0 } resource


getChoresXp : Float -> EffectType
getChoresXp amount =
    GainXp { base = amount, multiplier = 1.0 } ChoresSkill


smeltOre : Float -> EffectType
smeltOre successProbability =
    VariableSuccess
        { successProbability = successProbability
        , successEffects =
            [ mockEffect <| GainResource { base = -1, doublingChance = 0 } Ore
            , mockEffect <| GainResource { base = 1, doublingChance = 0 } Ingot
            ]
        , failureEffects =
            [ mockEffect <| GainResource { base = -1, doublingChance = 0 } Ore
            ]
        }


eventWithTags : List Tag -> Event -> Event
eventWithTags tags (Event eventData) =
    Event { eventData | tags = List.concat [ tags, eventData.tags ] }


moddedEventWithTags : List Tag -> ModdedEvent -> ModdedEvent
moddedEventWithTags tags (ModdedEvent eventData) =
    ModdedEvent { eventData | tags = List.concat [ tags, eventData.tags ] }


scopeModToTags : List Tag -> Mod -> Mod
scopeModToTags tags mod =
    { mod | transformer = scopeTransformerToTags tags mod.transformer }


suite : Test
suite =
    describe "modifyEvent"
        [ test "does nothing when no mods passed in" <|
            \_ ->
                testMods
                    { mods = []
                    , event = mockEvent [ getChoresXp 10 ]
                    , moddedEvent = mockModdedEvent [ getChoresXp 10 ]
                    }
        , test "applies one mod" <|
            \_ ->
                testMods
                    { mods = [ mockMod (xpIncreaser 0.1) ]
                    , event = mockEvent [ getChoresXp 10 ]
                    , moddedEvent =
                        mockModdedEvent [ GainXp { base = 10, multiplier = 1.1 } ChoresSkill ]
                    }
        , test "applies multiple mods" <|
            \_ ->
                testMods
                    { mods = [ mockMod (xpIncreaser 0.1), mockMod (xpIncreaser 0.2) ]
                    , event = mockEvent [ getChoresXp 10 ]
                    , moddedEvent =
                        mockModdedEvent [ GainXp { base = 10, multiplier = 1.3 } ChoresSkill ]
                    }
        , test "applies a mod with further effects" <|
            \_ ->
                testMods
                    { mods = [ mockMod manureGiver ]
                    , event = mockEvent [ getResource 1 Ore ]
                    , moddedEvent =
                        mockModdedEvent
                            [ getResource 1 Ore
                            , getResource 1 Manure
                            ]
                    }
        , test "applies a mod that changes a probability" <|
            \_ ->
                testMods
                    { mods = [ mockMod (probabilityIncreaser 0.1) ]
                    , event = mockEvent [ smeltOre 0.5 ]
                    , moddedEvent = mockModdedEvent [ smeltOre 0.6 ]
                    }
        , test "includeVariableEffects causes mods to apply to sub-effects of VariableSuccess" <|
            \_ ->
                testMods
                    { mods = [ mockMod (includeVariableEffects manureGiver) ]
                    , event = mockEvent [ smeltOre 0.5 ]
                    , moddedEvent =
                        mockModdedEvent
                            [ VariableSuccess
                                { successProbability = 0.5
                                , successEffects =
                                    [ mockEffect <| GainResource { base = -1, doublingChance = 0 } Ore
                                    , mockEffect <| GainResource { base = 1, doublingChance = 0 } Ingot
                                    , mockEffect <| GainResource { base = 1, doublingChance = 0 } Manure
                                    ]
                                , failureEffects =
                                    [ mockEffect <| GainResource { base = -1, doublingChance = 0 } Ore
                                    ]
                                }
                            ]
                    }
        , test "scopeTransformerToTags prevents a mod working if it has a tag that doesn't match the event" <|
            \_ ->
                testMods
                    { mods =
                        [ mockMod (xpIncreaser 0.1)
                            |> scopeModToTags [ Chores ]
                        ]
                    , event = mockEvent [ getChoresXp 10 ]
                    , moddedEvent =
                        mockModdedEvent [ GainXp { base = 10, multiplier = 1 } ChoresSkill ]
                    }
        , test "scopeTransformerToTags allows a mod to work if it has a tags that match the event" <|
            \_ ->
                testMods
                    { mods =
                        [ mockMod (xpIncreaser 0.1)
                            |> scopeModToTags [ Chores ]
                        ]
                    , event = mockEvent [ getChoresXp 10 ] |> eventWithTags [ Chores ]
                    , moddedEvent =
                        mockModdedEvent [ GainXp { base = 10, multiplier = 1 } ChoresSkill ]
                            |> moddedEventWithTags [ Chores ]
                    }
        ]
