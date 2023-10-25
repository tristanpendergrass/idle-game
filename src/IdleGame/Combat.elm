module IdleGame.Combat exposing
    ( Combat
    , Prediction(..)
    , addPlayerPower
    , create
    , getMonsterPower
    , getPlayerPower
    , getVictoryPrediction
    , resolve
    )

import Random


type Combat
    = Combat CombatState


type alias CombatState =
    { monsterPower : Int
    , playerPower : Int
    }


create : { monsterPower : Int, playerPower : Int } -> Combat
create { monsterPower, playerPower } =
    Combat
        { monsterPower = monsterPower
        , playerPower = playerPower
        }


getMonsterPower : Combat -> Int
getMonsterPower (Combat state) =
    state.monsterPower


getPlayerPower : Combat -> Int
getPlayerPower (Combat state) =
    state.playerPower


addPlayerPower : Int -> Combat -> Combat
addPlayerPower amount (Combat state) =
    Combat { state | playerPower = state.playerPower + amount }


type alias CombatResult =
    { playerWon : Bool }


type alias CombatResultGenerator =
    Random.Generator CombatResult


bool : Random.Generator Bool
bool =
    Random.map (\n -> n < 20) (Random.int 1 100)


resolve : Combat -> CombatResultGenerator
resolve (Combat { monsterPower, playerPower }) =
    Random.map3
        (\monsterRoll playerRoll tieBreaker ->
            let
                playerWon : Bool
                playerWon =
                    if monsterRoll == playerRoll then
                        tieBreaker

                    else
                        playerRoll > monsterRoll
            in
            { playerWon = playerWon }
        )
        (Random.int 1 monsterPower)
        (Random.int 1 playerPower)
        bool


type Prediction
    = VeryLow
    | Low
    | AboutEven
    | Good
    | VeryGood


getVictoryPrediction : Combat -> Prediction
getVictoryPrediction (Combat { monsterPower, playerPower }) =
    let
        difference : Int
        difference =
            playerPower - monsterPower

        percentDifference : Float
        percentDifference =
            toFloat difference / toFloat monsterPower
    in
    if percentDifference < -0.25 then
        VeryLow

    else if percentDifference < -0.1 then
        Low

    else if percentDifference < 0.1 then
        AboutEven

    else if percentDifference < 0.25 then
        Good

    else
        VeryGood
