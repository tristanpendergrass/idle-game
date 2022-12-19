module IdleGame.Event exposing
    ( Event
    , EventType(..)
    , Mod
    , Tag
    , choresMxpBuff
    , choresXpBuff
    , devGlobalXpBuff
    , gainChoresMxp
    , gainChoresXp
    , modAppliesToEvent
    , modifyEvent
    )

import IdleGame.GameTypes exposing (..)


type EventType
    = ChoresXp Float
    | ChoresMxp Float ChoreType


type alias Event =
    { type_ : EventType
    , tags : List Tag
    }



-- Tags


type Tag
    = Chores
    | Xp
    | Mxp



-- Mods


type ModType
    = Percent Float


type alias Mod =
    { type_ : ModType
    , tags : List Tag
    , label : String
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
        ChoresXp amount ->
            let
                applyMod mod a =
                    case mod.type_ of
                        Percent p ->
                            a * (p / 100 + 1)

                finalAmount =
                    List.foldl applyMod amount mods
            in
            { event | type_ = ChoresXp finalAmount }

        ChoresMxp amount treeType ->
            let
                applyMod mod a =
                    case mod.type_ of
                        Percent p ->
                            a * (p / 100 + 1)

                finalAmount =
                    List.foldl applyMod amount mods
            in
            { event | type_ = ChoresMxp finalAmount treeType }



-- Events


gainChoresXp : Float -> Event
gainChoresXp amount =
    { type_ = ChoresXp amount
    , tags = [ Chores, Xp ]
    }


gainChoresMxp : Float -> ChoreType -> Event
gainChoresMxp amount type_ =
    { type_ = ChoresMxp amount type_
    , tags = [ Chores, Mxp ]
    }



-- Mods


devGlobalXpBuff : Mod
devGlobalXpBuff =
    { type_ = Percent 100.0
    , tags = [ Xp ]
    , label = "+100% Global XP"
    }


choresMxpBuff : Float -> Mod
choresMxpBuff percent =
    { type_ = Percent percent
    , tags = [ Chores, Mxp ]
    , label = "+" ++ String.fromInt (floor percent) ++ "% Chores Mastery XP"
    }


choresXpBuff : Float -> Mod
choresXpBuff percent =
    { type_ = Percent percent
    , tags = [ Chores, Xp ]
    , label = "+" ++ String.fromInt (floor percent) ++ "% Chores XP"
    }
