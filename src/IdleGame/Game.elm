module IdleGame.Game exposing (..)

import Duration exposing (Duration)
import IdleGame.Activity as Activity
import IdleGame.Adventuring as Adventuring exposing (Adventuring)
import IdleGame.Chore as Chore
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Combat as Combat
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Event exposing (..)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds.Activities exposing (Activity)
import IdleGame.Resource as Resource
import IdleGame.ShopItems as ShopItems exposing (ShopItems)
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Maybe.Extra
import Percent exposing (Percent)
import Quantity
import Random exposing (Generator)
import Tuple



-- Public


type alias Game =
    { seed : Random.Seed
    , xp : Skill.Record Xp
    , mxp : Activity.Record Xp
    , choresMxp : Xp
    , activity : Maybe ( Activity, Timer )
    , coin : Coin
    , resources : Resource.Amounts
    , shopItems : ShopItems
    , adventuring : Adventuring
    , combatsWon : Int
    , combatsLost : Int
    }


create : Random.Seed -> Game
create seed =
    { seed = seed
    , xp =
        { chores = Xp.int 0
        , hexes = Xp.int 0
        }
    , mxp = Activity.createRecord (Xp.int 0)
    , choresMxp = Xp.int 0
    , activity = Nothing
    , coin = Coin.int 0
    , resources = Resource.createResources
    , shopItems = ShopItems.create
    , adventuring = Adventuring.create
    , combatsWon = 0
    , combatsLost = 0
    }


type ActivityListItem
    = LockedActivity Int
    | ActivityListItem Activity


getActivityListItems : Skill.Kind -> Game -> List ActivityListItem
getActivityListItems skill game =
    let
        xp : Xp
        xp =
            Skill.getByKind skill game.xp

        convertToListItem : Activity -> ActivityListItem
        convertToListItem kind =
            let
                currentLevel : Int
                currentLevel =
                    Skill.getByKind skill game.xp
                        |> Xp.level Xp.defaultSchedule

                requiredLevel : Int
                requiredLevel =
                    (Activity.getStats kind).unlockLevel
            in
            if currentLevel >= requiredLevel then
                ActivityListItem kind

            else
                LockedActivity requiredLevel

        reducer : Activity -> { items : List ActivityListItem, lockedItem : Bool } -> { items : List ActivityListItem, lockedItem : Bool }
        reducer kind accum =
            if accum.lockedItem then
                -- If lockedItem flag is true we already added a locked item to list and should not add any more items
                accum

            else
                let
                    listItem : ActivityListItem
                    listItem =
                        convertToListItem kind

                    newItems : List ActivityListItem
                    newItems =
                        List.concat [ accum.items, [ listItem ] ]

                    newItemIsLocked : Bool
                    newItemIsLocked =
                        case listItem of
                            ActivityListItem _ ->
                                False

                            LockedActivity _ ->
                                True
                in
                { items = newItems, lockedItem = newItemIsLocked }

        result =
            List.foldl reducer { items = [], lockedItem = False } (Activity.getActivities skill)
    in
    result.items



-- Chores


type alias ActivityStatus =
    Maybe Timer


toggleActivity : Activity -> Game -> Game
toggleActivity kind game =
    let
        stats : Activity.Stats
        stats =
            Activity.getStats kind

        currentLevel : Int
        currentLevel =
            game.xp
                |> Skill.getByKind stats.unlockSkill
                |> Xp.level Xp.defaultSchedule

        requiredLevel : Int
        requiredLevel =
            stats.unlockLevel
    in
    if currentLevel < requiredLevel then
        game

    else
        let
            newActivity : Maybe ( Activity, Timer )
            newActivity =
                case game.activity of
                    Just ( k, _ ) ->
                        if kind == k then
                            Nothing

                        else
                            Just ( kind, Timer.create )

                    Nothing ->
                        Just ( kind, Timer.create )
        in
        setActivity newActivity game


activityIsActive : Activity -> Game -> Bool
activityIsActive kind game =
    case game.activity of
        Just ( k, _ ) ->
            kind == k

        Nothing ->
            False


setActivity : Maybe ( Activity, Timer ) -> Game -> Game
setActivity activity g =
    { g | activity = activity }


setMonster : Combat.MonsterKind -> Game -> Game
setMonster newMonster game =
    { game | adventuring = Adventuring.setMonster newMonster game.adventuring }


startFight : Game -> Game
startFight game =
    { game | adventuring = Adventuring.startFight game.adventuring }


stopFight : Game -> Game
stopFight game =
    { game | adventuring = Adventuring.stopFight game.adventuring }


setPlayerMove : Int -> Combat.PlayerMove -> Game -> Game
setPlayerMove index move game =
    { game | adventuring = Adventuring.setPlayerMove index move game.adventuring }


applyIntervalMods : List IntervalMod -> Duration -> Duration
applyIntervalMods mods duration =
    let
        multiplier =
            (mods
                |> List.map .percentChange
                |> List.sum
            )
                + 1
    in
    Quantity.divideBy multiplier duration


getModdedDuration : Game -> Activity -> Duration
getModdedDuration game kind =
    -- Important! Keep the application here in sync with IdleGame.Game:applyEffect
    let
        stats =
            Activity.getStats kind

        mods =
            getAllIntervalMods game
                |> List.filter
                    (\mod ->
                        mod.kind == kind
                    )
    in
    stats.duration
        |> applyIntervalMods mods


combatReward : Event
combatReward =
    Event { effects = [ gainCoin (Coin.int 25) ] }



-- resultFoldl : (a -> b -> Result e b) -> b -> List a -> Result e b
-- resultFoldl f acc list =
--     case list of
--         [] ->
--             Ok acc
--         x :: xs ->
--             case f x acc of
--                 Err e ->
--                     Err e
--                 Ok newAcc ->
--                     resultFoldl f newAcc xs
-- rewardPlayer : Game -> Generator ( Game, List Toast )
-- rewardPlayer game =
--     let
--         modifiedCombatReward =
--             applyMods (getAllMods game) combatReward
--         effects : List Effect
--         effects =
--             case modifiedCombatReward of
--                 ModdedEvent eventData ->
--                     eventData.effects
--         inter : Generator (Result GameUpdateErr ( Game, List Toast ))
--         inter =
--             resultFoldl effectReducer (Random.constant (Ok ( game, [] ))) effects
--     in
--     inter
--         |> Random.map
--             (\res ->
--                 Result.withDefault ( game, [] ) res
--             )
-- incrementCombatsWon : Game -> Game
-- incrementCombatsWon game =
--     { game | combatsWon = game.combatsWon + 1 }
-- incrementCombatsLost : Game -> Game
-- incrementCombatsLost game =
--     { game | combatsLost = game.combatsLost + 1 }
-- updateAdventuring : Duration -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
-- updateAdventuring delta generator =
--     generator
--         |> Random.andThen
--             (\( game, toasts ) ->
--                 Adventuring.update delta game.adventuring
--                     |> Random.andThen
--                         (\updateResult ->
--                             case updateResult of
--                                 Adventuring.PlayerWon timeRemaining newAdventuring ->
--                                     let
--                                         updatedGenerator : Generator ( Game, List Toast )
--                                         updatedGenerator =
--                                             game
--                                                 |> (\g -> { g | adventuring = newAdventuring })
--                                                 |> incrementCombatsWon
--                                                 |> rewardPlayer
--                                                 |> Random.map (\( g, t ) -> ( g, toasts ++ t ))
--                                     in
--                                     updateAdventuring timeRemaining updatedGenerator
--                                 Adventuring.MonsterWon timeRemaining newAdventuring ->
--                                     let
--                                         updatedGenerator : Generator ( Game, List Toast )
--                                         updatedGenerator =
--                                             game
--                                                 |> (\g -> { g | adventuring = newAdventuring })
--                                                 |> incrementCombatsLost
--                                                 |> (\g -> Random.constant ( g, toasts ))
--                                     in
--                                     updateAdventuring timeRemaining updatedGenerator
--                                 Adventuring.Continue newAdventuring ->
--                                     let
--                                         updatedGenerator : Generator ( Game, List Toast )
--                                         updatedGenerator =
--                                             game
--                                                 |> (\g -> { g | adventuring = newAdventuring })
--                                                 |> (\g -> Random.constant ( g, toasts ))
--                                     in
--                                     updatedGenerator
--                         )
--             )


tick : Duration -> Game -> ( Game, List Toast )
tick delta game =
    let
        ( newActivity, events ) =
            case game.activity of
                Nothing ->
                    ( game.activity, [] )

                Just ( activityKind, timer ) ->
                    let
                        stats : Activity.Stats
                        stats =
                            Activity.getStats activityKind

                        activityDuration : Duration
                        activityDuration =
                            getModdedDuration game activityKind

                        ( newTimer, completions ) =
                            timer
                                |> Timer.increment activityDuration delta

                        newEvents : List Event
                        newEvents =
                            List.repeat completions stats.event
                    in
                    ( Just ( activityKind, newTimer )
                    , newEvents
                    )

        -- modifiedEvents =
        --     case events of
        --         -- Optimization so we don't calculate mods if there's no effects to apply them to
        --         [] ->
        --             []
        --         _ ->
        --             let
        --                 mods =
        --                     getAllMods game
        --             in
        --             List.map (applyMods mods) events
        -- effects : List Effect
        -- effects =
        --     modifiedEvents
        --         |> List.concatMap (\(ModdedEvent eventData) -> eventData.effects)
        gameGenerator : Generator ( Game, List Toast )
        gameGenerator =
            game
                |> setActivity newActivity
                -- |> (\g -> updateAdventuring delta (Random.constant ( g, [] )))
                |> (\g -> List.foldl applyEvent (Random.constant ( g, [] )) events)

        ( ( newGame, notifications ), newSeed ) =
            Random.step gameGenerator game.seed
    in
    ( { newGame | seed = newSeed }, notifications )


applyEvent : Event -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
applyEvent event =
    Random.andThen
        (\( game, toasts ) ->
            let
                effects : List Effect
                effects =
                    case event of
                        Event data ->
                            data.effects
            in
            applyEffects effects game
                |> Random.andThen
                    (\res ->
                        case res of
                            Err _ ->
                                Random.constant ( game, toasts )

                            Ok val ->
                                Random.constant ( val.game, toasts ++ val.toasts )
                    )
        )


type alias ApplyEffectsValue =
    { game : Game, toasts : List Toast }


type alias ApplyEffectsResultGenerator =
    Generator (Result EffectErr ApplyEffectsValue)


applyEffects : List Effect -> Game -> ApplyEffectsResultGenerator
applyEffects effects game =
    case effects of
        [] ->
            Random.constant (Ok { game = game, toasts = [] })

        effect :: rest ->
            let
                ( moddedEffect, additionalEffectsFromMod ) =
                    applyModsToEffect (getAllMods game) effect
            in
            applyEffect moddedEffect game
                |> Random.andThen
                    (\applyEffectResult ->
                        case applyEffectResult of
                            Err e ->
                                Random.constant (Err e)

                            Ok applyEffectVal ->
                                let
                                    g : Game
                                    g =
                                        applyEffectVal.game

                                    toasts : List Toast
                                    toasts =
                                        applyEffectVal.toasts

                                    additionalEffects : List Effect
                                    additionalEffects =
                                        applyEffectVal.additionalEffects
                                in
                                applyEffects (rest ++ additionalEffectsFromMod ++ additionalEffects) g
                                    |> Random.andThen
                                        (\res2 ->
                                            case res2 of
                                                Err e2 ->
                                                    Random.constant (Err e2)

                                                Ok val ->
                                                    Random.constant (Ok { game = val.game, toasts = val.toasts ++ toasts })
                                        )
                    )


type EffectErr
    = EffectErr


mapGeneratorResult : (a -> Generator (Result e a)) -> Generator (Result e a) -> Generator (Result e a)
mapGeneratorResult fn =
    Random.andThen
        (\res ->
            case res of
                Ok a ->
                    fn a

                Err err ->
                    Random.constant (Err err)
        )



-- effectReducer : Effect -> GameUpdateGen -> GameUpdateGen
-- effectReducer effect =
--     let
--         fn : ( Game, List Toast ) -> GameUpdateGen
--         fn ( game, notifications ) =
--             applyEffect effect game
--                 |> Random.map
--                     (\res ->
--                         res
--                             |> Result.map (\( newGame, newToasts, newEffects ) -> ( newGame, notifications ++ newToasts, newEffects ))
--                     )
--     in
--     mapGeneratorResult fn


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


calculateActivityMxp : Activity -> Game -> Xp
calculateActivityMxp kind game =
    let
        stats =
            Activity.getStats kind

        mxp : Xp
        mxp =
            game.mxp
                |> Activity.getByKind kind

        currentMasteryLevel : Int
        currentMasteryLevel =
            Xp.level Xp.defaultSchedule mxp
    in
    toFloat currentMasteryLevel
        * Duration.inSeconds stats.duration
        |> floor
        |> Xp.int


type alias ApplyEffectValue =
    -- When applying an effect a toast is generated to inform the player what happened
    { game : Game, toasts : List Toast, additionalEffects : List Effect }


type alias ApplyEffectResultGenerator =
    Generator (Result EffectErr ApplyEffectValue)


applyEffect : Effect -> Game -> ApplyEffectResultGenerator
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
                        Random.constant (Ok (ApplyEffectValue game [] chosenEffects))
                    )

        GainCoin { base, multiplier } ->
            let
                product : Coin
                product =
                    Quantity.multiplyBy multiplier base
            in
            addCoin product game
                |> Random.constant

        GainResource quantity resource ->
            intGenerator quantity
                |> Random.map (\amount -> addResource resource amount game)

        GainXp quantity skill ->
            { game = addXp skill (Quantity.multiplyBy quantity.multiplier quantity.base) game
            , toasts = []
            , additionalEffects = []
            }
                |> Random.constant
                |> Random.map Ok

        GainMxp quantity kind ->
            let
                base : Xp
                base =
                    calculateActivityMxp kind game

                mxp : Xp
                mxp =
                    Quantity.multiplyBy quantity.multiplier base

                masteryPoolXp : Xp
                masteryPoolXp =
                    Quantity.multiplyBy quantity.multiplier base
                        |> Quantity.multiplyBy 0.5
            in
            game
                |> addMxp kind mxp
                |> addMasteryPoolXp masteryPoolXp
                |> (\newGame -> Random.constant (ApplyEffectValue newGame [] []))
                |> Random.map Ok


addXp : Skill.Kind -> Xp -> Game -> Game
addXp skill amount game =
    case skill of
        Skill.Chores ->
            { game | xp = Skill.updateByKind Skill.Chores (Quantity.plus amount) game.xp }

        Skill.Hexes ->
            { game | xp = Skill.updateByKind Skill.Hexes (Quantity.plus amount) game.xp }


addMxp : Activity -> Xp -> Game -> Game
addMxp kind amount game =
    let
        fn mxp =
            Quantity.plus mxp amount
    in
    { game
        | mxp =
            game.mxp
                |> Activity.updateByKind kind fn
    }


addMasteryPoolXp : Xp -> Game -> Game
addMasteryPoolXp amount game =
    { game | choresMxp = Quantity.plus game.choresMxp amount }


addResource : Resource.Kind -> Int -> Game -> Result EffectErr ApplyEffectValue
addResource resource amount game =
    let
        newResources : Result Resource.Err Resource.Amounts
        newResources =
            Resource.add resource amount game.resources
    in
    case newResources of
        Err Resource.NegativeAmount ->
            Err EffectErr

        Ok val ->
            Ok
                { game = { game | resources = val }
                , toasts = [ GainedResource amount resource ]
                , additionalEffects = []
                }


addCoin : Coin -> Game -> Result EffectErr ApplyEffectValue
addCoin amount game =
    let
        newCoin : Coin
        newCoin =
            Quantity.plus game.coin amount

        isAllowed : Bool
        isAllowed =
            Quantity.greaterThanOrEqualTo (Coin.int 0) newCoin
    in
    if isAllowed then
        Ok
            { game = { game | coin = newCoin }
            , toasts = [ GainedCoin amount ]
            , additionalEffects = []
            }

    else
        Err EffectErr


type alias TimePassesResourceGain =
    { amount : Int
    , title : String
    }


type alias TimePassesResourceLoss =
    { amount : Int
    , title : String
    }


type alias TimePassesXpGain =
    { originalXp : Xp
    , currentXp : Xp
    , title : String
    }


type alias TimePassesData =
    { xpGains : List TimePassesXpGain
    , coinGains : Maybe Coin
    , resourcesDiff : Resource.Diff
    , combatsWonDiff : Int
    , combatsLostDiff : Int
    }


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData originalGame currentGame =
    let
        xpGains =
            if originalGame.xp.chores == currentGame.xp.chores then
                []

            else
                [ { title = "Chores", originalXp = originalGame.xp.chores, currentXp = currentGame.xp.chores } ]

        resourcesDiff =
            Resource.getDiff { original = originalGame.resources, current = currentGame.resources }

        combatsWonDiff =
            currentGame.combatsWon - originalGame.combatsWon

        combatsLostDiff =
            currentGame.combatsLost - originalGame.combatsLost

        coinGains : Maybe Coin
        coinGains =
            if Coin.toInt currentGame.coin > Coin.toInt originalGame.coin then
                Just <| Quantity.difference currentGame.coin originalGame.coin

            else
                Nothing

        hasNewData =
            not <|
                (List.isEmpty xpGains
                    && Resource.isEmptyDiff resourcesDiff
                    && Maybe.Extra.isNothing coinGains
                    && (combatsWonDiff == 0)
                    && (combatsLostDiff == 0)
                )
    in
    if hasNewData then
        Just
            { xpGains = xpGains
            , coinGains = coinGains
            , resourcesDiff = resourcesDiff
            , combatsWonDiff = combatsWonDiff
            , combatsLostDiff = combatsLostDiff
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
    , twentyFive = choresCoinBuff 0.15
    , fifty = choresMxpBuff 0.25
    , ninetyFive =
        choresResourceBuff 1.0
            |> includeVariableEffects
    }


getChoreMasteryPoolMods : Game -> List Mod
getChoreMasteryPoolMods game =
    let
        mxpPercent =
            Xp.levelPercent Xp.defaultSchedule game.choresMxp
                |> Percent.toPercentage

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


getShopItemMods : Game -> List Mod
getShopItemMods game =
    game.shopItems
        |> ShopItems.toOwnedItems
        |> List.map (\shopItem -> (ShopItems.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopItems.ShopItemMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getShopItemIntervalMods : Game -> List IntervalMod
getShopItemIntervalMods game =
    game.shopItems
        -- |> (\x -> Debug.log "foobar inside getShopItemIntervalMods" x)
        |> ShopItems.toOwnedItems
        |> List.map (\shopItem -> (ShopItems.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopItems.ShopItemIntervalMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getMasteryIntervalMods : Game -> List IntervalMod
getMasteryIntervalMods game =
    Activity.allKinds
        |> List.map
            (\kind ->
                let
                    mxp : Xp
                    mxp =
                        Activity.getByKind kind game.mxp

                    masteryLevel : Int
                    masteryLevel =
                        Xp.level Xp.defaultSchedule mxp

                    timesToApplyMod =
                        if masteryLevel >= 99 then
                            2

                        else if masteryLevel >= 50 then
                            1

                        else
                            0
                in
                { kind = kind
                , percentChange = timesToApplyMod * 0.1
                }
            )


getAllMods : Game -> List Mod
getAllMods game =
    getChoreMasteryPoolMods game
        -- ++ getChoreUnlocksMods game
        ++ getShopItemMods game



-- Interval Mods


getAllIntervalMods : Game -> List IntervalMod
getAllIntervalMods game =
    let
        shopItemIntervalMods =
            getShopItemIntervalMods game

        choreUnlockIntervalMods =
            getMasteryIntervalMods game
    in
    shopItemIntervalMods ++ choreUnlockIntervalMods



--
