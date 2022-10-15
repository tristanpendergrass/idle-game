module IdleGame.Chores exposing (..)


type Chore
    = Chore Id ChoreData


type alias Id =
    Int


type alias ChoreData =
    { title : String, rewardText : String, skillXpGranted : Int, masteryXpGranted : Int, masteryXp : Int, isActive : Bool }


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


toggleActiveChore : Id -> List Chore -> List Chore
toggleActiveChore toggleId chores =
    chores
        |> List.map
            (\(Chore id choreData) ->
                if id == toggleId then
                    Chore id { choreData | isActive = not choreData.isActive }

                else
                    Chore id { choreData | isActive = False }
            )
