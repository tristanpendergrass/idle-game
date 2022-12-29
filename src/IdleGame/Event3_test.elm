module IdleGame.Event3_test exposing (..)

import Expect exposing (..)
import IdleGame.Event3 exposing (..)
import Test exposing (..)


withModsEquals : List Mod -> ModdedEvent -> Event -> Expectation
withModsEquals mods moddedEvent event =
    Expect.equal moddedEvent (modifyEvent mods event)


withMods : List Mod -> Event -> ModdedEvent
withMods mods event =
    modifyEvent mods event


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


manureGiver : Transformer
manureGiver effect =
    case getType effect of
        GainXp _ _ ->
            ChangeAndAddEffects effect [ mockEffect (getResource 1 Manure) ]

        _ ->
            NoChange


testMods : { mods : List Mod, event : Event, moddedEvent : ModdedEvent } -> Expectation
testMods { mods, event, moddedEvent } =
    event
        |> withMods mods
        |> equal moddedEvent


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
                    , event = mockEvent [ getChoresXp 10 ]
                    , moddedEvent =
                        mockModdedEvent
                            [ getChoresXp 10
                            , getResource 1 Manure
                            ]
                    }
        ]
