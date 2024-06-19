module IdleGame.Game exposing (..)

import Duration exposing (Duration)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (Mod)
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Xp as Xp exposing (Xp)
import Maybe.Extra
import Percent exposing (Percent)
import Quantity
import Random exposing (Generator)
import Types exposing (..)



-- Public


createProd : Random.Seed -> Game
createProd seed =
    { seed = seed
    , xp = skillRecord (Xp.int 0)
    , mxp = activityRecord (Xp.int 0)
    , activity = Nothing
    , coin = Coin.int 0
    , resources = resourceRecord 0
    , ownedShopUpgrades = shopUpgradeRecord False
    }


createDev : Random.Seed -> Game
createDev seed =
    { seed = seed
    , xp = skillRecord (Xp.int 9999999)
    , mxp = activityRecord (Xp.int 0)
    , activity = Nothing
    , coin = Coin.int 0
    , resources = resourceRecord 0
    , ownedShopUpgrades = shopUpgradeRecord False
    }


type ActivityListItem
    = LockedActivity ( Skill, Int )
    | ActivityListItem Activity


getActivityListItems : Skill -> Game -> List ActivityListItem
getActivityListItems skill game =
    let
        convertToListItem : Activity -> ActivityListItem
        convertToListItem kind =
            let
                stats : ActivityStats
                stats =
                    getActivityStats kind

                currentLevel : Int
                currentLevel =
                    getBySkill stats.skill game.xp
                        |> Xp.level Xp.defaultSchedule
            in
            if currentLevel >= stats.level then
                ActivityListItem kind

            else
                LockedActivity ( stats.skill, stats.level )

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
            List.foldl reducer { items = [], lockedItem = False } (Activity.getBySkill skill)
    in
    result.items



-- Chores


type alias ActivityStatus =
    Maybe Timer


toggleActivity : Activity -> Game -> Game
toggleActivity kind game =
    let
        stats : ActivityStats
        stats =
            getActivityStats kind

        canToggle : Bool
        canToggle =
            let
                currentLevel : Int
                currentLevel =
                    getBySkill stats.skill game.xp
                        |> Xp.level Xp.defaultSchedule
            in
            currentLevel >= stats.level
    in
    if canToggle then
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


applyIntervalMods : List IntervalMod -> Duration -> Duration
applyIntervalMods mods duration =
    let
        multiplier =
            (mods
                |> List.map .percentChange
                |> List.map Percent.toFloat
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
            getActivityStats kind

        mods =
            getAllIntervalMods game
                |> List.filter
                    (\mod ->
                        mod.kind == kind
                    )
    in
    stats.duration
        |> applyIntervalMods mods


combatReward : List Effect
combatReward =
    [ Effect.gainCoin (Coin.int 25) ]


type alias Event =
    { effects : List Effect, count : Int }


tick : Duration -> Game -> ( Game, List Toast )
tick delta game =
    let
        ( newActivity, eventSkilling ) =
            case game.activity of
                Nothing ->
                    ( game.activity, Nothing )

                Just ( activityKind, timer ) ->
                    let
                        effectStats : Activity.EffectStats
                        effectStats =
                            Activity.getEffectStats activityKind

                        activityDuration : Duration
                        activityDuration =
                            getModdedDuration game activityKind

                        ( newTimer, completions ) =
                            timer
                                |> Timer.increment activityDuration delta

                        maybeEvent : Maybe Event
                        maybeEvent =
                            if completions >= 1 then
                                Just { effects = effectStats.effects, count = completions }

                            else
                                Nothing
                    in
                    ( Just ( activityKind, newTimer )
                    , maybeEvent
                    )

        mods : List Mod
        mods =
            getAllMods game

        gameGenerator : Generator ( Game, List Toast )
        gameGenerator =
            game
                |> setActivity newActivity
                |> (\g -> List.foldl (applyEvent mods) (Random.constant ( g, [] )) (List.filterMap identity [ eventSkilling ]))

        ( ( newGame, notifications ), newSeed ) =
            Random.step gameGenerator game.seed
    in
    ( { newGame | seed = newSeed }, notifications )


getPurchaseEffects : Int -> Resource -> List Effect
getPurchaseEffects amount resource =
    case (getResourceStats resource).price of
        Just price ->
            let
                cost : Coin.Coin
                cost =
                    Quantity.multiplyBy (toFloat amount) price
                        |> Quantity.multiplyBy -1
            in
            [ Effect.gainCoin cost, Effect.gainResource amount resource ]

        Nothing ->
            []


attemptPurchaseResource : Int -> Resource -> Game -> Result EffectErr ApplyEffectsValue
attemptPurchaseResource amount resource game =
    let
        effects : List Effect
        effects =
            getPurchaseEffects amount resource

        mods : List Mod
        mods =
            getAllMods game

        gen : ApplyEffectsResultGenerator
        gen =
            applyEffects mods effects 1 game

        ( result, newSeed ) =
            Random.step gen game.seed
    in
    Result.map
        (\applyEffectsResult ->
            { applyEffectsResult
                | game = setSeed newSeed applyEffectsResult.game
            }
        )
        result


setSeed : Random.Seed -> Game -> Game
setSeed seed game =
    { game | seed = seed }


priceToPurchaseResource : Int -> ( Resource, Coin ) -> Game -> Coin
priceToPurchaseResource amount ( resource, price ) game =
    -- TODO: incorporate mods that might alter price
    Quantity.multiplyBy (toFloat amount) price


applyEvent : List Mod -> Event -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
applyEvent mods { effects, count } =
    -- TODO: revisit this function's name. Why we need this and applyEffects?
    Random.andThen
        (\( game, toasts ) ->
            applyEffects mods effects count game
                |> Random.map
                    (\res ->
                        case res of
                            Err err ->
                                let
                                    toast : Toast
                                    toast =
                                        getToastForErr err
                                in
                                ( game, toast :: toasts )

                            Ok val ->
                                ( val.game, toasts ++ val.toasts )
                    )
        )


getToastForErr : EffectErr -> Toast
getToastForErr err =
    case err of
        EffectErr.NegativeAmount ->
            NegativeAmountErr


type alias ApplyEffectsValue =
    { game : Game, toasts : List Toast }


type alias ApplyEffectsResultGenerator =
    Generator (Result EffectErr ApplyEffectsValue)


applyEffects : List Mod -> List Effect -> Int -> Game -> ApplyEffectsResultGenerator
applyEffects mods effects count game =
    case effects of
        [] ->
            Random.constant (Ok { game = game, toasts = [] })

        effect :: rest ->
            let
                ( moddedEffect, additionalEffectsFromMod ) =
                    Mod.applyModsToEffect mods effect
            in
            applyEffect moddedEffect count game
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
                                applyEffects mods (rest ++ additionalEffectsFromMod ++ additionalEffects) count g
                                    |> Random.map
                                        (\res2 ->
                                            case res2 of
                                                Err e2 ->
                                                    Err e2

                                                Ok val ->
                                                    Ok { game = val.game, toasts = val.toasts ++ toasts }
                                        )
                    )


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


probabilityGenerator : Percent -> Generator Bool
probabilityGenerator probability =
    Random.float 0 1
        |> Random.map
            (\num ->
                num < Percent.toFloat probability
            )


calculateActivityMxp : Activity -> Game -> Xp
calculateActivityMxp kind game =
    let
        stats =
            getActivityStats kind

        mxp : Xp
        mxp =
            game.mxp
                |> getByActivity kind

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
    { game : Game, toasts : List Toast, additionalEffects : List Effect, additionalMods : List Mod }


type alias ApplyEffectResultGenerator =
    Generator (Result EffectErr ApplyEffectValue)


applyEffect : Effect -> Int -> Game -> ApplyEffectResultGenerator
applyEffect effect count game =
    case Effect.getEffect effect of
        Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
            probabilityGenerator successProbability
                |> Random.map
                    (\succeeded ->
                        let
                            chosenEffects =
                                if succeeded then
                                    successEffects

                                else
                                    failureEffects
                        in
                        Ok (ApplyEffectValue game [] chosenEffects [])
                    )

        Effect.GainCoin { base, percentIncrease } ->
            let
                product : Coin
                product =
                    base
                        |> Quantity.multiplyBy (Percent.toMultiplier percentIncrease)
                        |> Quantity.multiplyBy (toFloat count)
            in
            addCoin product game
                |> Random.constant

        Effect.GainResource { base, resource, doublingChance } ->
            probabilityGenerator doublingChance
                |> Random.map
                    (\doubled ->
                        let
                            result : Int
                            result =
                                if doubled then
                                    2 * base * count

                                else
                                    base * count
                        in
                        adjustResource resource result game
                    )

        Effect.SpendResource { base, resource, preservationChance } ->
            probabilityGenerator preservationChance
                |> Random.map
                    (\preserved ->
                        if preserved then
                            adjustResource resource 0 game

                        else
                            adjustResource resource (-1 * base * count) game
                    )

        Effect.GainXp { base, percentIncrease, skill } ->
            let
                xp : Xp
                xp =
                    base
                        |> Quantity.multiplyBy (Percent.toMultiplier percentIncrease)
                        |> Quantity.multiplyBy (toFloat count)
            in
            { game = addXp skill xp game
            , toasts = []
            , additionalEffects = []
            , additionalMods = []
            }
                |> Ok
                |> Random.constant

        Effect.GainMxp params ->
            let
                base : Xp
                base =
                    calculateActivityMxp params.activity game

                mxp : Xp
                mxp =
                    base
                        |> Quantity.multiplyBy (Percent.toMultiplier params.percentIncrease)
                        |> Quantity.multiplyBy (toFloat count)
            in
            game
                |> addMxp params.activity mxp
                |> (\newGame -> Random.constant (ApplyEffectValue newGame [] [] []))
                |> Random.map Ok


addXp : Skill -> Xp -> Game -> Game
addXp skill amount game =
    { game | xp = Skill.updateBySkill skill (Quantity.plus amount) game.xp }


addMxp : Activity -> Xp -> Game -> Game
addMxp kind amount game =
    let
        fn mxp =
            Quantity.plus mxp amount
    in
    { game
        | mxp =
            game.mxp
                |> Activity.updateByKindActivity kind fn
    }


adjustResource : Resource -> Int -> Game -> Result EffectErr ApplyEffectValue
adjustResource resource amount game =
    let
        newResources : Result EffectErr (ResourceRecord Int)
        newResources =
            Resource.add resource amount game.resources
    in
    newResources
        |> Result.map
            (\val ->
                { game = { game | resources = val }
                , toasts = [ GainedResource amount resource ]
                , additionalEffects = []
                , additionalMods = []
                }
            )


addCoin : Coin -> Game -> Result EffectErr ApplyEffectValue
addCoin amount game =
    let
        newCoin : Coin
        newCoin =
            Quantity.plus game.coin amount

        isNegative : Bool
        isNegative =
            Quantity.lessThan (Coin.int 0) newCoin
    in
    if isNegative then
        Err EffectErr.NegativeAmount

    else
        Ok
            { game = { game | coin = newCoin }
            , toasts = [ GainedCoin amount ]
            , additionalEffects = []
            , additionalMods = []
            }


diff : List a -> List a -> List a
diff list1 list2 =
    List.concat
        [ List.filter (\item -> not (List.member item list2)) list1
        , List.filter (\item -> not (List.member item list1)) list2
        ]


getTimePassesData : Game -> Game -> Maybe TimePassesData
getTimePassesData originalGame currentGame =
    let
        xpGainOfSkill : Skill -> Maybe TimePassesXpGain
        xpGainOfSkill skill =
            let
                originalXp : Xp
                originalXp =
                    getBySkill skill originalGame.xp

                currentXp : Xp
                currentXp =
                    getBySkill skill currentGame.xp
            in
            if originalXp == currentXp then
                Nothing

            else
                Just { skill = skill, originalXp = originalXp, currentXp = currentXp }

        xpGains : List TimePassesXpGain
        xpGains =
            allSkills
                |> List.filterMap xpGainOfSkill

        resourcesDiff =
            Resource.getDiff { original = originalGame.resources, current = currentGame.resources }

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
                )
    in
    if hasNewData then
        Just
            { xpGains = xpGains
            , coinGains = coinGains
            , resourcesDiff = resourcesDiff
            }

    else
        Nothing



-- Events


getShopItemMods : Game -> List Mod
getShopItemMods game =
    game.ownedShopUpgrades
        |> ShopUpgrade.toOwnedItems
        |> List.map (\shopItem -> (ShopUpgrade.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopUpgrade.ShopItemMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getShopItemIntervalMods : Game -> List IntervalMod
getShopItemIntervalMods game =
    game.ownedShopUpgrades
        |> ShopUpgrade.toOwnedItems
        |> List.map (\shopItem -> (ShopUpgrade.getStats shopItem).reward)
        |> List.filterMap
            (\reward ->
                case reward of
                    ShopUpgrade.ShopItemIntervalMod mods ->
                        Just mods

                    _ ->
                        Nothing
            )
        |> List.concat


getMasteryIntervalMods : Game -> List IntervalMod
getMasteryIntervalMods game =
    let
        masteryRewards : List Activity.MasteryReward
        masteryRewards =
            allActivities
                |> List.concatMap
                    (\activity ->
                        let
                            effectStats : Activity.EffectStats
                            effectStats =
                                Activity.getEffectStats activity

                            mxp : Xp
                            mxp =
                                getByActivity activity game.mxp

                            masteryLevel : Int
                            masteryLevel =
                                Xp.level Xp.defaultSchedule mxp
                        in
                        case effectStats.mastery of
                            Just mastery ->
                                mastery
                                    |> List.filterMap
                                        (\( level, reward ) ->
                                            if masteryLevel >= level then
                                                Just reward

                                            else
                                                Nothing
                                        )

                            Nothing ->
                                []
                    )

        mods : List IntervalMod
        mods =
            masteryRewards
                |> List.filterMap
                    (\reward ->
                        case reward of
                            Activity.IntervalMod mod ->
                                Just mod

                            _ ->
                                Nothing
                    )
    in
    mods


getMasteryRewards : Game -> Activity -> List Activity.MasteryReward
getMasteryRewards game activity =
    let
        effectStats : Activity.EffectStats
        effectStats =
            Activity.getEffectStats activity

        mxp : Xp
        mxp =
            getByActivity activity game.mxp

        masteryLevel : Int
        masteryLevel =
            Xp.level Xp.defaultSchedule mxp
    in
    case effectStats.mastery of
        Just mastery ->
            mastery
                |> List.filterMap
                    (\( level, reward ) ->
                        if masteryLevel >= level then
                            Just reward

                        else
                            Nothing
                    )

        Nothing ->
            []


getActivityMods : Game -> List Mod
getActivityMods game =
    let
        getGameMod : Activity.MasteryReward -> Maybe Mod
        getGameMod reward =
            case reward of
                Activity.GameMod mod ->
                    Just mod

                _ ->
                    Nothing
    in
    allActivities
        |> List.concatMap (getMasteryRewards game)
        |> List.filterMap getGameMod


addActivityTagToMods : Activity -> List Mod -> List Mod
addActivityTagToMods activity =
    List.map (Mod.withTags [ Effect.ActivityTag activity ])


getAllMods : Game -> List Mod
getAllMods game =
    List.concat
        [ getActivityMods game
        , getShopItemMods game
        ]



-- |> List.map Mod.includeVariableEffects
-- Originally thought we might want only some mods to have this, now I think all should?
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


getMaxPurchase : Coin -> Game -> Int
getMaxPurchase price game =
    let
        playerCoin : Coin
        playerCoin =
            game.coin
    in
    floor (Quantity.ratio playerCoin price)
