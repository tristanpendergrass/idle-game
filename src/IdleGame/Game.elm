module IdleGame.Game exposing (..)

import FeatherIcons
import IdleGame.Timer
import IdleGame.XpFormulas
import Set exposing (Set)
import Time exposing (Posix)
import Time.Extra



-- Public


type alias Game =
    { currentTime : Posix
    , woodcuttingXp : Float
    , woodcuttingMxp : Float
    , activeTree : Maybe ( TreeType, IdleGame.Timer.Timer )
    , treeData : TreeData
    }


create : Posix -> Game
create now =
    { currentTime = now
    , woodcuttingXp = 0
    , woodcuttingMxp = 0
    , activeTree = Nothing
    , treeData =
        { elm = { mxp = 0 }
        , oak = { mxp = 0 }
        , willow = { mxp = 0 }
        }
    }


type WoodcuttingListItem
    = WoodcuttingLockedItem Int
    | WoodcuttingTree TreeType


treeUnlockRequirements =
    [ ( Elm, 1 )
    , ( Oak, 2 )
    , ( Willow, 3 )
    ]


getWoodcuttingListItems : Game -> List WoodcuttingListItem
getWoodcuttingListItems { woodcuttingXp } =
    let
        skillLevel =
            IdleGame.XpFormulas.skillLevel woodcuttingXp

        unlockedTreeTypes =
            treeUnlockRequirements
                |> List.filter (\( _, treeLevel ) -> treeLevel <= skillLevel)
                |> List.map (\( type_, _ ) -> WoodcuttingTree type_)

        maybeNextUnlock =
            treeUnlockRequirements
                |> List.filter (\( _, treeLevel ) -> treeLevel > skillLevel)
                |> List.sortBy Tuple.second
                |> List.head
                |> Maybe.map (\( _, level ) -> WoodcuttingLockedItem level)
                |> Maybe.map List.singleton
                |> Maybe.withDefault []
    in
    unlockedTreeTypes ++ maybeNextUnlock



-- Private


getTimeOfNextTick : Game -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc



-- Woodcutting


type alias Tree =
    { type_ : TreeType
    , title : String
    , rewardText : String
    , xp : Float
    }


getTree : TreeType -> Tree
getTree type_ =
    case type_ of
        Elm ->
            { type_ = Elm
            , title = "Elm"
            , rewardText = "N/A"
            , xp = 5.0
            }

        Oak ->
            { type_ = Oak
            , title = "Oak"
            , rewardText = "N/A"
            , xp = 10.0
            }

        Willow ->
            { type_ = Willow
            , title = "Elm"
            , rewardText = "N/A"
            , xp = 15.0
            }


incrementTreeMxp : Float -> TreeType -> TreeData -> TreeData
incrementTreeMxp amount type_ treeData =
    case type_ of
        Elm ->
            { treeData | elm = { mxp = treeData.elm.mxp + amount } }

        Oak ->
            { treeData | elm = { mxp = treeData.oak.mxp + amount } }

        Willow ->
            { treeData | elm = { mxp = treeData.willow.mxp + amount } }


type alias TreeData =
    { elm : { mxp : Float }
    , oak : { mxp : Float }
    , willow : { mxp : Float }
    }


getMxp : TreeType -> TreeData -> Float
getMxp type_ treeData =
    getMastery type_ treeData
        |> IdleGame.XpFormulas.skillLevel
        |> toFloat


getMastery : TreeType -> TreeData -> Float
getMastery type_ treeData =
    case type_ of
        Elm ->
            treeData.elm.mxp

        Oak ->
            treeData.oak.mxp

        Willow ->
            treeData.willow.mxp


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


type TreeType
    = Elm
    | Oak
    | Willow


toggleActiveTree : TreeType -> Game -> Game
toggleActiveTree toggleType game =
    let
        newActiveTree =
            case game.activeTree of
                Just ( type_, _ ) ->
                    if type_ == toggleType then
                        Nothing

                    else
                        Just ( toggleType, IdleGame.Timer.create 2000 )

                Nothing ->
                    Just ( toggleType, IdleGame.Timer.create 2000 )
    in
    { game | activeTree = newActiveTree }



-- skillLevelFromXp : Float -> Int
-- skillLevelFromXp xp =
-- Handle ticks


timeOfNextTick : Game -> Posix
timeOfNextTick game =
    game
        |> .currentTime
        |> Time.Extra.add Time.Extra.Millisecond IdleGame.Timer.tickDuration Time.utc


setCurrentTime : Time.Posix -> Game -> Game
setCurrentTime time g =
    { g | currentTime = time }


setActiveTree : Maybe ( TreeType, IdleGame.Timer.Timer ) -> Game -> Game
setActiveTree activeTree g =
    { g | activeTree = activeTree }


tick : Game -> Game
tick game =
    let
        ( newActiveTree, events ) =
            case game.activeTree of
                Nothing ->
                    ( game.activeTree, [] )

                Just ( treeType, timer ) ->
                    let
                        ( newTimer, completions ) =
                            IdleGame.Timer.tick timer

                        tree =
                            getTree treeType

                        mxpGained =
                            getMxp tree.type_ game.treeData
                    in
                    ( Just ( treeType, newTimer ), List.repeat completions (gainWoodcuttingXp tree.xp) ++ List.repeat completions (gainWoodcuttingMxp mxpGained tree.type_) )

        mods =
            getAllMods game

        modifiedEvents =
            List.map (modifyEvent mods) events
    in
    game
        |> setActiveTree newActiveTree
        |> (\g -> List.foldl applyEvent g modifiedEvents)
        |> setCurrentTime (timeOfNextTick game)


applyEvent : Event -> Game -> Game
applyEvent event game =
    case event.type_ of
        WoodcuttingXp amount ->
            { game | woodcuttingXp = game.woodcuttingXp + amount }

        WoodcuttingMxp amount treeType ->
            { game
                | woodcuttingMxp = game.woodcuttingMxp + (amount / 2)
                , treeData = incrementTreeMxp amount treeType game.treeData
            }


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


updateGameToTime : Posix -> Game -> Game
updateGameToTime now game =
    let
        shouldTick =
            Time.posixToMillis now >= Time.posixToMillis (timeOfNextTick game)
    in
    if shouldTick then
        -- Note: be careful with the next line causing stack overflows. It is written in a particular way to allow Tail-call elimination and should stay that way.
        -- Additional reading: https://jfmengels.net/tail-call-optimization/
        updateGameToTime now (tick game)

    else
        game


updateCurrentTime : Posix -> Game -> Game
updateCurrentTime now game =
    { game | currentTime = now }



-- Time passes logic


type alias TimePassesItemGain =
    { amount : Int
    , title : String
    , icon : FeatherIcons.Icon
    }


type alias TimePassesItemLoss =
    { amount : Int
    , title : String
    , icon : FeatherIcons.Icon
    }


type alias TimePassesXpGain =
    { amount : Int
    , title : String
    }


type alias TimePassesData =
    { timePassed : Int
    , xpGains : List TimePassesXpGain
    , itemGains : List TimePassesItemGain
    , itemLosses : List TimePassesItemLoss
    }


getTimePassesData : Game -> Game -> TimePassesData
getTimePassesData oldGame newGame =
    { timePassed = Time.posixToMillis newGame.currentTime - Time.posixToMillis oldGame.currentTime
    , xpGains =
        [ { title = "Woodchopping XP"
          , amount = floor newGame.woodcuttingXp - floor oldGame.woodcuttingXp
          }
        ]
    , itemGains = []
    , itemLosses = []
    }



-- Events


type Tag
    = Woodcutting
    | Xp
    | Mxp


type EventType
    = WoodcuttingXp Float
    | WoodcuttingMxp Float TreeType


type alias Event =
    { type_ : EventType
    , tags : List Tag
    }


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


type ModType
    = Percent Float


type alias Mod =
    { type_ : ModType
    , tags : List Tag
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


getAllMods : Game -> List Mod
getAllMods game =
    []
        ++ [ devGlobalXpBuff ]
        ++ (if game.woodcuttingMxp > 10 then
                [ masteryXpBuff ]

            else
                [ bigMasteryXpBuff ]
           )


modAppliesToEvent : Event -> Mod -> Bool
modAppliesToEvent event mod =
    listContains mod.tags event.tags


listContains : List a -> List a -> Bool
listContains inner outer =
    List.all (\el -> List.member el outer) inner
