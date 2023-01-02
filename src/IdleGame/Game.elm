module IdleGame.Game exposing (..)

import IdleGame.Event3 exposing (..)
import IdleGame.GameTypes exposing (..)
import IdleGame.Timer
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.XpFormulas
import Random exposing (Generator)
import Set exposing (Set)
import Svg.Attributes exposing (in_)
import Tuple



-- Public


type alias Game =
    { seed : Random.Seed
    , choresXp : Float
    , choresMxp : Float
    , activeChore : Maybe ( ChoreType, IdleGame.Timer.Timer )
    , choresData : ChoresData
    , gold : Int
    , manure : Int
    }


type alias ChoresData =
    { cleanStables : ChoreData
    , cleanBigBubba : ChoreData
    , gatherFirewood : ChoreData
    }


type alias ChoreData =
    { mxp : Float }


create : Random.Seed -> Game
create seed =
    { seed = seed
    , choresXp = 0
    , choresMxp = 0
    , activeChore = Nothing
    , choresData =
        { cleanStables = { mxp = 0 }
        , cleanBigBubba = { mxp = 0 }
        , gatherFirewood = { mxp = 0 }
        }
    , gold = 0
    , manure = 0
    }


type ChoresListItem
    = LockedChore Int
    | ChoreItem ChoreType


choreUnlockRequirements =
    [ ( CleanStables, 1 )
    , ( CleanBigBubba, 2 )
    , ( GatherFirewood, 3 )
    ]


getChoreListItems : Game -> List ChoresListItem
getChoreListItems { choresXp } =
    let
        skillLevel =
            IdleGame.XpFormulas.skillLevel choresXp

        unlockedChoreTypes =
            choreUnlockRequirements
                |> List.filter (\( _, choreLevel ) -> choreLevel <= skillLevel)
                |> List.map (\( type_, _ ) -> ChoreItem type_)

        maybeNextUnlock =
            choreUnlockRequirements
                |> List.filter (\( _, choreLevel ) -> choreLevel > skillLevel)
                |> List.sortBy Tuple.second
                |> List.head
                |> Maybe.map (\( _, level ) -> LockedChore level)
                |> Maybe.map List.singleton
                |> Maybe.withDefault []
    in
    unlockedChoreTypes ++ maybeNextUnlock



-- Chores


type alias Chore =
    -- TODO: the type_ should not be here, otherwise it's possible in the model to store a chore of the wrong type under a key
    { type_ : ChoreType
    , title : String
    , rewardText : String
    , xp : Float
    }


getChore : ChoreType -> Chore
getChore type_ =
    case type_ of
        CleanStables ->
            { type_ = CleanStables
            , title = "Clean Stables"
            , rewardText = "N/A"
            , xp = 5.0
            }

        CleanBigBubba ->
            { type_ = CleanBigBubba
            , title = "Clean Big Bubba's Stall"
            , rewardText = "N/A"
            , xp = 10.0
            }

        GatherFirewood ->
            { type_ = GatherFirewood
            , title = "Gather Firewood"
            , rewardText = "N/A"
            , xp = 15.0
            }


updateChoreData : (ChoreData -> ChoreData) -> ChoreType -> ChoresData -> ChoresData
updateChoreData fn type_ choresData =
    case type_ of
        CleanStables ->
            { choresData
                | cleanStables = fn choresData.cleanStables
            }

        CleanBigBubba ->
            { choresData
                | cleanStables = fn choresData.cleanBigBubba
            }

        GatherFirewood ->
            { choresData
                | cleanStables = fn choresData.gatherFirewood
            }


incrementChoreMxp : Float -> ChoreType -> ChoresData -> ChoresData
incrementChoreMxp amount type_ choreData =
    case type_ of
        CleanStables ->
            { choreData | cleanStables = { mxp = choreData.cleanStables.mxp + amount } }

        CleanBigBubba ->
            { choreData | cleanBigBubba = { mxp = choreData.cleanBigBubba.mxp + amount } }

        GatherFirewood ->
            { choreData | gatherFirewood = { mxp = choreData.gatherFirewood.mxp + amount } }


getMxp : ChoreType -> ChoresData -> Float
getMxp type_ choreData =
    getMastery type_ choreData
        |> IdleGame.XpFormulas.skillLevel
        |> toFloat


getMastery : ChoreType -> ChoresData -> Float
getMastery type_ choreData =
    case type_ of
        CleanStables ->
            choreData.cleanStables.mxp

        CleanBigBubba ->
            choreData.cleanBigBubba.mxp

        GatherFirewood ->
            choreData.gatherFirewood.mxp


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


toggleActiveChore : ChoreType -> Game -> Game
toggleActiveChore toggleType game =
    let
        newActiveChore =
            case game.activeChore of
                Just ( type_, _ ) ->
                    if type_ == toggleType then
                        Nothing

                    else
                        Just ( toggleType, IdleGame.Timer.create 2000 )

                Nothing ->
                    Just ( toggleType, IdleGame.Timer.create 2000 )
    in
    { game | activeChore = newActiveChore }


setActiveChore : Maybe ( ChoreType, IdleGame.Timer.Timer ) -> Game -> Game
setActiveChore activeChore g =
    { g | activeChore = activeChore }


tick : Game -> Game
tick game =
    let
        ( newActiveChore, events ) =
            case game.activeChore of
                Nothing ->
                    ( game.activeChore, [] )

                Just ( choreType, timer ) ->
                    let
                        ( newTimer, completions ) =
                            IdleGame.Timer.tick timer

                        chore =
                            getChore choreType

                        activeChore =
                            Just ( choreType, newTimer )

                        newEvents =
                            []
                                ++ List.repeat completions (triggerChore chore)
                    in
                    ( activeChore
                    , newEvents
                    )

        mods =
            getAllMods game

        filter =
            Debug.todo ""

        modifiedEvents =
            List.map (modifyEvent mods filter) events

        effects : List Effect
        effects =
            modifiedEvents
                |> List.concatMap (\(ModdedEvent eventData) -> eventData.effects)

        gameGenerator =
            game
                |> setActiveChore newActiveChore
                |> (\g -> List.foldl effectReducer (Random.constant g) effects)

        ( newGame, newSeed ) =
            Random.step gameGenerator game.seed
    in
    { newGame | seed = newSeed }


effectReducer : Effect -> Generator Game -> Generator Game
effectReducer effect =
    Random.andThen (applyEffect effect)


successGenerator : Float -> Generator Bool
successGenerator probability =
    Random.float 0 1
        |> Random.map
            (\num ->
                num < probability
            )


intGenerator : { base : Int, doublingChance : Float } -> Generator Int
intGenerator { base, doublingChance } =
    successGenerator doublingChance
        |> Random.map
            (\doubled ->
                if doubled then
                    base * 2

                else
                    base
            )


floatGenerator : { base : Float, multiplier : Float } -> Generator Float
floatGenerator { base, multiplier } =
    Random.constant <| base * multiplier


applyEffect : Effect -> Game -> Generator Game
applyEffect effect game =
    case getType effect of
        VariableSuccess { successProbability, successEffects, failureEffects } ->
            successGenerator successProbability
                |> Random.andThen
                    (\succeeded ->
                        let
                            chosenEffects =
                                if succeeded then
                                    successEffects

                                else
                                    failureEffects
                        in
                        List.foldl effectReducer (Random.constant game) chosenEffects
                    )

        GainResource quantity resource ->
            intGenerator quantity
                |> Random.map (\amount -> addResource resource amount game)

        GainXp quantity skill ->
            floatGenerator quantity
                |> Random.map (\amount -> addXp skill amount game)

        GainChoreMxp { multiplier } choreType ->
            let
                base =
                    getMxp choreType game.choresData
            in
            Random.constant <| addMxp choreType (base * multiplier) game

        GainGold quantity ->
            intGenerator quantity
                |> Random.map (\amount -> addGold amount game)


addResource : Resource -> Int -> Game -> Game
addResource resource amount game =
    case resource of
        Manure ->
            { game | manure = game.manure + amount }

        _ ->
            game


addXp : Skill -> Float -> Game -> Game
addXp resource amount game =
    case resource of
        ChoresSkill ->
            { game | choresXp = game.choresXp + amount }


addMxp : ChoreType -> Float -> Game -> Game
addMxp chore amount game =
    let
        fn : ChoreData -> ChoreData
        fn { mxp } =
            { mxp = mxp + amount }
    in
    { game | choresData = updateChoreData fn chore game.choresData }


addGold : Int -> Game -> Game
addGold amount game =
    { game | gold = game.gold + amount }


applyEvent : ModdedEvent -> Game -> Random.Generator Game
applyEvent (ModdedEvent eventData) game =
    List.foldl
        (applyEffect >> Random.andThen)
        (Random.constant game)
        eventData.effects


triggerChore : Chore -> Event
triggerChore { xp, type_ } =
    Event
        { effects =
            [ Effect { type_ = GainXp { base = xp, multiplier = 1.0 } ChoresSkill, tags = [ Xp ] }
            , Effect { type_ = GainResource { base = 1, doublingChance = 0 } Manure, tags = [] }
            , Effect { type_ = GainChoreMxp { multiplier = 1.0 } type_, tags = [ Mxp ] }
            ]
        , tags = [ Chores ]
        }



-- Time passes logic


type alias TimePassesItemGain =
    { amount : Int
    , title : String
    , icon : Icon
    }


type alias TimePassesItemLoss =
    { amount : Int
    , title : String
    , icon : Icon
    }


type alias TimePassesXpGain =
    { amount : Int
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , itemGains : List TimePassesItemGain
    , itemLosses : List TimePassesItemLoss
    }


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData oldGame newGame =
    let
        choresXpAmount =
            floor newGame.choresXp - floor oldGame.choresXp

        hasNewData =
            choresXpAmount > 0
    in
    if hasNewData then
        Just
            { xpGains =
                [ { title = "Chores XP"
                  , amount = choresXpAmount
                  }
                ]
            , itemGains = []
            , itemLosses = []
            }

    else
        Nothing



-- Events


type alias MasteryPoolCheckpoints =
    { ten : Mod
    , twentyFive : Mod
    , fifty : Mod
    , ninetyFive : Mod
    }


choreMasteryPoolCheckpoints : MasteryPoolCheckpoints
choreMasteryPoolCheckpoints =
    { ten = choresXpBuff 0.25
    , twentyFive = choresMxpBuff 0.1
    , fifty = choresXpBuff 0.25
    , ninetyFive = choresMxpBuff 0.1
    }


type alias MasteryUnlocks =
    { perLevel : Mod
    , checkpoints : List ( Int, Mod )
    }



-- choreMasteryUnlocks : MasteryUnlocks
-- choreMasteryUnlocks =
--     { perLevel = IdleGame.Event.choresXpBuff 1
--     , checkpoints = []
--     }
-- getChoreMasteryMods : Game -> List Mod
-- getChoreMasteryMods game =
--     case game.activeChore of
--         Nothing ->
--             []
--         Just activeChore ->
--             let
--                 ()
--                 mxp =
--                     getMxp activeChore.type_ game.choresData
--                 masteryLevel =
--                     IdleGame.XpFormulas.skillLevel mxp
--             in
--             []
--                 ++ List.repeat


getChoreMasteryPoolMods : Game -> List Mod
getChoreMasteryPoolMods game =
    let
        mxpPercent =
            IdleGame.XpFormulas.masteryPoolPercent game.choresMxp

        checkpoints =
            choreMasteryPoolCheckpoints
    in
    if mxpPercent >= 95 then
        [ checkpoints.ten
        , checkpoints.twentyFive
        , checkpoints.fifty
        , checkpoints.ninetyFive
        ]

    else if mxpPercent >= 50 then
        [ checkpoints.ten
        , checkpoints.twentyFive
        , checkpoints.fifty
        ]

    else if mxpPercent >= 25 then
        [ checkpoints.ten
        , checkpoints.twentyFive
        ]

    else if mxpPercent >= 10 then
        [ checkpoints.ten ]

    else
        []


xpTransformer : Float -> Transformer
xpTransformer buff effect =
    -- case effect.type_ of
    --     GainXp { base, multiplier } skill ->
    --         effect
    --             |> setEffectType (GainXp { base = base, multiplier = multiplier + buff } skill)
    --             |> ChangeEffect
    --     _ ->
    --         NoChange
    Debug.todo ""


mxpTransformer : Float -> Transformer
mxpTransformer buff effect =
    -- case effect.type_ of
    --     GainChoreMxp { base, multiplier } chore ->
    --         effect
    --             |> setEffectType (GainChoreMxp { base = base, multiplier = multiplier + buff } chore)
    --             |> Change
    --     _ ->
    --         NoChange
    Debug.todo ""


xpModLabel : Float -> String
xpModLabel multiplier =
    "+" ++ String.fromInt (floor (multiplier * 100)) ++ "% XP"


mxpModLabel : Float -> String
mxpModLabel multiplier =
    "+" ++ String.fromInt (floor (multiplier * 100)) ++ "% Mastery XP"


devGlobalXpBuff : Mod
devGlobalXpBuff =
    { tags = [ Xp ]
    , label = xpModLabel 0.05
    , transformer = xpTransformer 0.05
    , source = AdminCrimes
    }


choresXpBuff : Float -> Mod
choresXpBuff buff =
    { tags = [ Chores, Xp ]
    , label = xpModLabel buff
    , transformer = xpTransformer buff
    , source = AdminCrimes
    }


choresMxpBuff : Float -> Mod
choresMxpBuff buff =
    { tags = []
    , label = mxpModLabel buff
    , transformer = mxpTransformer buff
    , source = AdminCrimes
    }


getAllMods : Game -> List Mod
getAllMods game =
    []
        ++ [ devGlobalXpBuff ]
        ++ getChoreMasteryPoolMods game



-- ++ getChoreMasteryMods game
