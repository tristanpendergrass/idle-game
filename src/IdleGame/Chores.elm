module IdleGame.Chores exposing (..)


type Chore
    = Chore ChoreData { isActive : Bool }


type alias ChoreData =
    { title : String, rewardText : String, skillXpGranted : Int, masteryXpGranted : Int, masteryXp : Int }


skillLevelFromXp : Int -> Int
skillLevelFromXp xp =
    xp // 100 + 1


skillLevelPercentFromXp : Int -> Float
skillLevelPercentFromXp xp =
    remainderBy 100 xp
        |> toFloat


masteryLevelFromXp : Int -> Int
masteryLevelFromXp xp =
    xp // 100 + 1


masteryLevelPercentFromXp : Int -> Float
masteryLevelPercentFromXp xp =
    remainderBy 100 xp
        |> toFloat
