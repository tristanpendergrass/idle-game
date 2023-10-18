module IdleGame.Combat exposing
    ( Combat
    , addPlayerStrength
    , create
    , getMonsterStrength
    , resolve
    )

import Random


type Combat
    = Combat CombatState


type alias CombatState =
    { monsterStrength : Int
    , playerStrength : Int
    }


create : { monsterStrength : Int, playerStrength : Int } -> Combat
create { monsterStrength, playerStrength } =
    Combat
        { monsterStrength = monsterStrength
        , playerStrength = playerStrength
        }


getMonsterStrength : Combat -> Int
getMonsterStrength (Combat state) =
    state.monsterStrength


addPlayerStrength : Int -> Combat -> Combat
addPlayerStrength amount (Combat state) =
    Combat { state | playerStrength = state.playerStrength + amount }


type alias CombatResult =
    { playerWon : Bool }


type alias CombatResultGenerator =
    Random.Generator CombatResult


resolve : Combat -> CombatResultGenerator
resolve (Combat { monsterStrength, playerStrength }) =
    Random.map2
        (\monsterRoll playerRoll ->
            { playerWon = playerRoll >= monsterRoll }
        )
        (Random.int 1 monsterStrength)
        (Random.int 1 playerStrength)
