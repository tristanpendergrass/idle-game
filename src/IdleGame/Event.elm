module IdleGame.Event exposing
    ( Event
    , EventType(..)
    , Mod
    , Tag
    , bigMasteryXpBuff
    , devGlobalXpBuff
    , gainWoodcuttingMxp
    , gainWoodcuttingXp
    , masteryXpBuff
    , modAppliesToEvent
    , modifyEvent
    )

import IdleGame.GameTypes exposing (..)


type EventType
    = WoodcuttingXp Float
    | WoodcuttingMxp Float TreeType


type alias Event =
    { type_ : EventType
    , tags : List Tag
    }



-- Tags


type Tag
    = Woodcutting
    | Xp
    | Mxp



-- Mods


type ModType
    = Percent Float


type alias Mod =
    { type_ : ModType
    , tags : List Tag
    }


modAppliesToEvent : Event -> Mod -> Bool
modAppliesToEvent event mod =
    listContains mod.tags event.tags


listContains : List a -> List a -> Bool
listContains inner outer =
    List.all (\el -> List.member el outer) inner


modifyEvent : List Mod -> Event -> Event
modifyEvent allMods event =
    let
        mods =
            allMods
                |> List.filter (modAppliesToEvent event)
    in
    case event.type_ of
        WoodcuttingXp amount ->
            let
                applyMod mod a =
                    case mod.type_ of
                        Percent p ->
                            a * (p / 100 + 1)

                finalAmount =
                    List.foldl applyMod amount mods
            in
            { event | type_ = WoodcuttingXp finalAmount }

        WoodcuttingMxp amount treeType ->
            let
                applyMod mod a =
                    case mod.type_ of
                        Percent p ->
                            a * (p / 100 + 1)

                finalAmount =
                    List.foldl applyMod amount mods
            in
            { event | type_ = WoodcuttingMxp finalAmount treeType }



-- Events


gainWoodcuttingXp : Float -> Event
gainWoodcuttingXp amount =
    { type_ = WoodcuttingXp amount
    , tags = [ Woodcutting, Xp ]
    }


gainWoodcuttingMxp : Float -> TreeType -> Event
gainWoodcuttingMxp amount type_ =
    { type_ = WoodcuttingMxp amount type_
    , tags = [ Woodcutting, Mxp ]
    }


devGlobalXpBuff : Mod
devGlobalXpBuff =
    { type_ = Percent 100.0
    , tags = [ Xp ]
    }


masteryXpBuff : Mod
masteryXpBuff =
    { type_ = Percent 100.0
    , tags = [ Woodcutting, Mxp ]
    }


bigMasteryXpBuff : Mod
bigMasteryXpBuff =
    { type_ = Percent 200.0
    , tags = [ Woodcutting, Mxp ]
    }
