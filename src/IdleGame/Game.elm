module IdleGame.Game exposing (..)

import Duration exposing (Duration)
import IdleGame.Activity as Activity
import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect, EffectType)
import IdleGame.EffectErr as EffectErr exposing (EffectErr)
import IdleGame.GameTypes exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod as Mod exposing (EffectMod)
import IdleGame.OneTime as OneTimeStatus exposing (OneTimeStatus)
import IdleGame.Resource as Resource
import IdleGame.ShopUpgrade as ShopUpgrade
import IdleGame.Skill as Skill
import IdleGame.Timer as Timer exposing (Timer)
import IdleGame.Views.Icon exposing (Icon)
import IdleGame.Xp as Xp exposing (Xp)
import List.Extra
import Maybe.Extra
import Percent exposing (Percent)
import Quantity
import Random exposing (Generator)
import Random.Extra
import Svg.Attributes exposing (preserveAlpha)
import Tuple
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
    , oneTimeStatuses = OneTimeStatus.oneTimeRecord False
    }


createDev : Random.Seed -> Game
createDev seed =
    { seed = seed

    -- , xp = skillRecord (Xp.int 9999999)
    , xp = skillRecord (Xp.int 5)
    , mxp = activityRecord (Xp.int 0)
    , activity = Nothing
    , coin = Coin.int 0
    , resources = resourceRecord 0
    , ownedShopUpgrades = shopUpgradeRecord False
    , oneTimeStatuses = OneTimeStatus.oneTimeRecord False
    }


type ActivityListItem
    = LockedActivity ( Skill, Int )
    | ActivityListItem ( Activity, List Effect )


getActivityListItems : Skill -> Game -> ActivityRecord (List Effect) -> List ActivityListItem
getActivityListItems skill game cachedActivityEffects =
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
                ActivityListItem ( kind, getByActivity kind cachedActivityEffects )

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


type alias TickResolution =
    { game : Game, toasts : List Toast, bustCache : Bool }


tick : Duration -> Game -> TickResolution
tick delta game =
    let
        ( newActivity, maybeEvent ) =
            case game.activity of
                Nothing ->
                    ( game.activity, Nothing )

                Just ( activityKind, timer ) ->
                    let
                        activityEffects : List Effect
                        activityEffects =
                            Activity.getActivityEffects activityKind

                        activityDuration : Duration
                        activityDuration =
                            getModdedDuration game activityKind

                        ( newTimer, completions ) =
                            timer
                                |> Timer.increment activityDuration delta

                        event : Maybe Event
                        event =
                            if completions >= 1 then
                                Just { effects = activityEffects, count = completions }

                            else
                                Nothing
                    in
                    ( Just ( activityKind, newTimer )
                    , event
                    )

        gameAfterApplyingEvent : { game : Game, toasts : List Toast, bustCache : Bool }
        gameAfterApplyingEvent =
            case maybeEvent of
                Nothing ->
                    { game = game, toasts = [], bustCache = False }

                Just event ->
                    let
                        mods : List EffectMod
                        mods =
                            getAllMods game

                        gameGenerator : Generator ( Game, List Toast )
                        gameGenerator =
                            game
                                |> (\g ->
                                        List.foldl (applyEvent mods) (Random.constant ( g, [] )) [ event ]
                                   )

                        ( ( newGame, notifications ), newSeed ) =
                            Random.step gameGenerator game.seed
                    in
                    { game = { newGame | seed = newSeed }, toasts = notifications, bustCache = True }
    in
    { game =
        gameAfterApplyingEvent.game
            |> setActivity newActivity
    , toasts = gameAfterApplyingEvent.toasts
    , bustCache = gameAfterApplyingEvent.bustCache
    }


getPurchaseEffects : Int -> Resource -> List Effect
getPurchaseEffects amount resource =
    let
        resourceStats =
            getResourceStats resource

        cost : Coin.Coin
        cost =
            case resourceStats.buyPrice of
                Just buyPrice ->
                    Quantity.multiplyBy (toFloat amount) buyPrice
                        |> Quantity.multiplyBy -1

                Nothing ->
                    -- If trying to buy a resource with no buyPrice, assume it's a sell operation
                    case resourceStats.sellPrice of
                        Just sellPrice ->
                            Quantity.multiplyBy (toFloat amount) sellPrice

                        Nothing ->
                            Coin.zero
    in
    [ Effect.gainCoin cost, Effect.gainResource amount resource ]


attemptPurchaseResource : Int -> Resource -> Game -> Result EffectErr ApplyEffectsValue
attemptPurchaseResource amount resource game =
    let
        effects : List Effect
        effects =
            getPurchaseEffects amount resource

        mods : List EffectMod
        mods =
            getAllMods game

        gen : ApplyEffectsResultGenerator
        gen =
            applyEffects mods (List.map (\effect -> { effect = effect, count = 1 }) effects) game

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


applyEvent : List EffectMod -> Event -> Generator ( Game, List Toast ) -> Generator ( Game, List Toast )
applyEvent mods { effects, count } =
    -- TODO: revisit this function's name. Why we need this and applyEffects?
    Random.andThen
        (\( game, toasts ) ->
            applyEffects mods (List.map (\effect -> { effect = effect, count = count }) effects) game
                |> Random.andThen
                    (\res ->
                        case res of
                            Err err ->
                                let
                                    toast : Toast
                                    toast =
                                        getToastForErr err
                                in
                                Random.constant ( game, toast :: toasts )

                            Ok val ->
                                Random.constant ( val.game, toasts ++ val.toasts )
                    )
        )


getToastForErr : EffectErr -> Toast
getToastForErr err =
    case err of
        EffectErr.NegativeAmount ->
            NegativeAmountErr

        EffectErr.TestAlreadyCompleted ->
            TestAlreadyCompleted

        EffectErr.TestNotUnlocked ->
            TestNotUnlocked


type alias ApplyEffectsValue =
    { game : Game, toasts : List Toast }


type alias ApplyEffectsResultGenerator =
    Generator (Result EffectErr ApplyEffectsValue)


applyEffects : List EffectMod -> List { effect : Effect, count : Int } -> Game -> ApplyEffectsResultGenerator
applyEffects mods effects game =
    case effects of
        [] ->
            Random.constant (Ok { game = game, toasts = [] })

        { effect, count } :: rest ->
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

                                    additionalEffectsFromEffect : List { effect : Effect, count : Int }
                                    additionalEffectsFromEffect =
                                        applyEffectVal.additionalEffects

                                    allAdditionalEffects : List { effect : Effect, count : Int }
                                    allAdditionalEffects =
                                        List.concat
                                            [ rest
                                            , List.map (\additionalEffect -> { effect = additionalEffect, count = count }) additionalEffectsFromMod
                                            , additionalEffectsFromEffect
                                            ]
                                in
                                applyEffects mods allAdditionalEffects g
                                    |> Random.andThen
                                        (\res2 ->
                                            case res2 of
                                                Err e2 ->
                                                    Random.constant (Err e2)

                                                Ok val ->
                                                    Random.constant (Ok { game = val.game, toasts = val.toasts ++ toasts })
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



-- probabilityGeneratorMulti : Int -> Percent -> Generator Int
-- probabilityGeneratorMulti count probability =
--     List.repeat count (probabilityGenerator probability)
--         |> Random.Extra.combine
--         |> Random.map (List.filter identity >> List.length)


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
    { game : Game, toasts : List Toast, additionalEffects : List { effect : Effect, count : Int }, additionalMods : List EffectMod }


type alias ApplyEffectResultGenerator =
    Generator (Result EffectErr ApplyEffectValue)


applyEffect : Effect -> Int -> Game -> ApplyEffectResultGenerator
applyEffect effect count game =
    case effect.oneTimeStatus of
        OneTimeStatus.OneTime oneTimeId ->
            if OneTimeStatus.getByOneTimeId oneTimeId game.oneTimeStatuses then
                Random.constant (Ok { game = game, toasts = [], additionalEffects = [], additionalMods = [] })

            else
                let
                    newGame : Game
                    newGame =
                        { game | oneTimeStatuses = OneTimeStatus.claimOneTime oneTimeId game.oneTimeStatuses }
                in
                -- NOTE we are passing `1` instead of `count` here since we're in the branch of a one-time effect.
                effectReducer effect 1 newGame

        OneTimeStatus.NotOneTime ->
            effectReducer effect count game


type alias EffectWithCount =
    { count : Int, effect : Effect }


splitListHelp : Int -> List (List a) -> List a -> List (List a)
splitListHelp max soFar list =
    case list of
        [] ->
            soFar

        _ ->
            let
                chunk : List a
                chunk =
                    List.take max list

                newSoFar : List (List a)
                newSoFar =
                    soFar ++ [ chunk ]
            in
            splitListHelp max newSoFar (List.drop max list)


splitList : Int -> List a -> List (List a)
splitList max list =
    splitListHelp max [] list


combineLarge : List (Generator a) -> Generator (List a)
combineLarge generators =
    let
        generatorLists : List (List (Generator a))
        generatorLists =
            splitList 100 generators

        combinedGenerators : List (Generator (List a))
        combinedGenerators =
            List.map Random.Extra.combine generatorLists
    in
    Random.Extra.combine combinedGenerators
        |> Random.map List.concat


combine : List (Random.Generator a) -> Random.Generator (List a)
combine generators =
    generators
        |> List.foldr
            (\generator generatorSoFar ->
                Random.map2 (::) generator generatorSoFar
            )
            (Random.constant [])


effectReducer : Effect -> Int -> Game -> ApplyEffectResultGenerator
effectReducer effect count game =
    if count == 0 then
        Random.constant (Ok { game = game, toasts = [], additionalEffects = [], additionalMods = [] })

    else
        case Effect.getEffectType effect of
            Effect.NoOp ->
                Random.constant (Ok { game = game, toasts = [], additionalEffects = [], additionalMods = [] })

            Effect.VariableSuccess { successProbability, successEffects, failureEffects } ->
                combineLarge (List.repeat count (probabilityGenerator successProbability))
                    |> Random.map
                        (\results ->
                            let
                                numSuccesses : Int
                                numSuccesses =
                                    List.length <| List.filter identity results

                                numFailures : Int
                                numFailures =
                                    count - numSuccesses

                                effects : List { effect : Effect, count : Int }
                                effects =
                                    List.concat
                                        [ if numSuccesses > 0 then
                                            List.map (\successEffect -> { effect = successEffect, count = numSuccesses }) successEffects

                                          else
                                            []
                                        , if numFailures > 0 then
                                            List.map (\failureEffect -> { effect = failureEffect, count = numFailures }) failureEffects

                                          else
                                            []
                                        ]
                            in
                            Ok (ApplyEffectValue game [] effects [])
                        )

            Effect.OneOf firstEffect restEffects ->
                combine (List.repeat count (Random.uniform firstEffect restEffects))
                    |> Random.map
                        (\results ->
                            let
                                effectCounts : List { effect : Effect, count : Int }
                                effectCounts =
                                    results
                                        |> List.Extra.gatherEquals
                                        |> List.map (\( e, rest ) -> { effect = e, count = 1 + List.length rest })
                            in
                            Ok (ApplyEffectValue game [] effectCounts [])
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

            Effect.SpendResource { base, resource, preservationChance, reducedBy } ->
                probabilityGenerator preservationChance
                    |> Random.map
                        (\preserved ->
                            let
                                handleReducedBy : Int -> Int
                                handleReducedBy amount =
                                    case reducedBy of
                                        Nothing ->
                                            amount

                                        Just (Effect.ReducedByFlat reductionResource) ->
                                            amount - getByResource reductionResource game.resources

                                        Just (Effect.ReducedByPercent reductionResource percentReduction) ->
                                            let
                                                reductionResourceAmount : Float
                                                reductionResourceAmount =
                                                    toFloat (getByResource reductionResource game.resources)
                                            in
                                            Percent.reduceIntByPercent (Quantity.multiplyBy reductionResourceAmount percentReduction) amount

                                adjustedAmount : Int
                                adjustedAmount =
                                    base
                                        |> handleReducedBy
                                        -- Player can't "spend" a negative amount of resources
                                        |> max 0
                            in
                            if preserved then
                                adjustResource resource 0 game

                            else
                                adjustResource resource (-1 * adjustedAmount * count) game
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
                    |> Random.constant
                    |> Random.map Ok

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


getShopItemMods : Game -> List EffectMod
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
        getFromActivity : Activity -> List IntervalMod
        getFromActivity activity =
            let
                activityMastery : Activity.Mastery
                activityMastery =
                    Activity.getActivityMasteries activity

                mxp : Xp
                mxp =
                    getByActivity activity game.mxp

                masteryLevel : Int
                masteryLevel =
                    Xp.level Xp.defaultSchedule mxp
            in
            Activity.masteryModsAtLevel masteryLevel activityMastery
                |> List.filterMap
                    (\mod ->
                        case mod of
                            Activity.IntervalMod intervalMod ->
                                Just intervalMod

                            _ ->
                                Nothing
                    )
    in
    List.concatMap getFromActivity allActivities


getMasteryRewards : Game -> Activity -> List Activity.MasteryMod
getMasteryRewards game activity =
    let
        activityMastery : Activity.Mastery
        activityMastery =
            Activity.getActivityMasteries activity

        mxp : Xp
        mxp =
            getByActivity activity game.mxp

        masteryLevel : Int
        masteryLevel =
            Xp.level Xp.defaultSchedule mxp
    in
    Activity.masteryModsAtLevel masteryLevel activityMastery


getActivityMods : Game -> List EffectMod
getActivityMods game =
    let
        getGameMod : Activity.MasteryMod -> Maybe EffectMod
        getGameMod reward =
            case reward of
                Activity.EffectMod mod ->
                    Just mod

                _ ->
                    Nothing
    in
    allActivities
        |> List.concatMap (getMasteryRewards game)
        |> List.filterMap getGameMod


addActivityTagToMods : Activity -> List EffectMod -> List EffectMod
addActivityTagToMods activity =
    List.map (Mod.withTags [ Effect.ActivityTag activity ])


getAllMods : Game -> List EffectMod
getAllMods game =
    []
        ++ getActivityMods game
        ++ getShopItemMods game



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
