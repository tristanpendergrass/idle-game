module IdleGame.Chores exposing
    ( Chore
    , ChoreData
    , Id
    , create
    , getActivityProgress
    , getChoreData
    , getId
    , handleAnimationFrame
    , isActive
    , masteryLevelFromXp
    , masteryLevelPercentFromXp
    , skillLevelFromXp
    , skillLevelPercentFromXp
    , toggleActiveChore
    )

import IdleGame.Timer
import Time


type Chore
    = Chore Id ChoreData ActivityStatus


type alias ActivityStatus =
    Maybe IdleGame.Timer.Timer


type alias Id =
    Int


type alias ChoreData =
    { title : String, rewardText : String, skillXpGranted : Int, masteryXpGranted : Int, masteryXp : Int }


create : Id -> ChoreData -> Chore
create id choreData =
    Chore id choreData Nothing


skillLevelFromXp : Int -> Int
skillLevelFromXp xp =
    xp // 100 + 1


skillLevelPercentFromXp : Int -> Float
skillLevelPercentFromXp xp =
    remainderBy 100 xp
        |> toFloat


masteryLevelFromXp : Int -> Int
masteryLevelFromXp xp =
    xp // 10 + 1


masteryLevelPercentFromXp : Int -> Float
masteryLevelPercentFromXp xp =
    remainderBy 10 xp
        |> toFloat


toggleActiveChore : Id -> Int -> List Chore -> List Chore
toggleActiveChore toggleId now chores =
    chores
        |> List.map
            (\(Chore id choreData activityStatus) ->
                if id == toggleId then
                    let
                        newActivityStatus =
                            case activityStatus of
                                Nothing ->
                                    Just (IdleGame.Timer.create now 2500)

                                Just _ ->
                                    Nothing
                    in
                    Chore id choreData newActivityStatus

                else
                    Chore id choreData Nothing
            )


isActive : Chore -> Bool
isActive (Chore _ _ activityStatus) =
    not (activityStatus == Nothing)


getActivityProgress : Int -> Chore -> Maybe Float
getActivityProgress now (Chore _ _ activityStatus) =
    activityStatus
        |> Maybe.map
            (\timer ->
                IdleGame.Timer.percentComplete now timer
            )


getId : Chore -> Id
getId (Chore id _ _) =
    id


getChoreData : Chore -> ChoreData
getChoreData (Chore _ choreData _) =
    choreData


handleAnimationFrameHelper : Int -> Chore -> ( Chore, { skillXp : Int, masteryXp : Int } )
handleAnimationFrameHelper now (Chore id choreData maybeActivityTimer) =
    case maybeActivityTimer of
        Nothing ->
            ( Chore id choreData maybeActivityTimer, { skillXp = 0, masteryXp = 0 } )

        Just timer ->
            let
                ( newTimer, timesCompleted ) =
                    IdleGame.Timer.update now timer

                newChoreData =
                    { choreData | masteryXp = choreData.masteryXp + timesCompleted * choreData.masteryXpGranted }

                skillXpGranted =
                    choreData.skillXpGranted * timesCompleted

                masteryXpGranted =
                    choreData.masteryXpGranted * timesCompleted
            in
            ( Chore id choreData (Just newTimer), { skillXp = skillXpGranted, masteryXp = masteryXpGranted } )


handleAnimationFrame : Int -> List Chore -> ( List Chore, { skillXpGained : Int, masteryXpGained : Int } )
handleAnimationFrame now chores =
    List.foldr
        (\chore accum ->
            let
                ( newChore, { skillXp, masteryXp } ) =
                    handleAnimationFrameHelper now chore

                ( accumChores, accumXps ) =
                    accum
            in
            ( newChore :: accumChores, { skillXpGained = skillXp + accumXps.skillXpGained, masteryXpGained = masteryXp + accumXps.masteryXpGained } )
        )
        ( [], { skillXpGained = 0, masteryXpGained = 0 } )
        chores


tick : GameObject -> GameObject
tick gameObject =
    let
        ( newChores, { skillXpGained, masteryXpGained } ) =
            List.foldr
                (\chore accum ->
                    let
                        ( newChore, { skillXp, masteryXp } ) =
                            handleAnimationFrameHelper now chore

                        ( accumChores, accumXps ) =
                            accum
                    in
                    ( newChore :: accumChores, { skillXpGained = skillXp + accumXps.skillXpGained, masteryXpGained = masteryXp + accumXps.masteryXpGained } )
                )
                ( [], { skillXpGained = 0, masteryXpGained = 0 } )
                gameObject.chores
    in
    Debug.todo "Implement tick"
