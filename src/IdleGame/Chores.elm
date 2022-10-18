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


toggleActiveChore : Id -> Time.Posix -> List Chore -> List Chore
toggleActiveChore toggleId now chores =
    chores
        |> List.map
            (\(Chore id choreData activityStatus) ->
                if id == toggleId then
                    let
                        newActivityStatus =
                            case activityStatus of
                                Nothing ->
                                    Just (IdleGame.Timer.create 2500)

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


getActivityProgress : Chore -> Maybe Float
getActivityProgress (Chore _ _ activityStatus) =
    activityStatus
        |> Maybe.map
            (\timer ->
                IdleGame.Timer.percentComplete timer
            )


getId : Chore -> Id
getId (Chore id _ _) =
    id


getChoreData : Chore -> ChoreData
getChoreData (Chore _ choreData _) =
    choreData


handleAnimationFrameHelper : Float -> Chore -> ( Chore, Int )
handleAnimationFrameHelper delta (Chore id choreData maybeActivityTimer) =
    case maybeActivityTimer of
        Nothing ->
            ( Chore id choreData maybeActivityTimer, 0 )

        Just timer ->
            let
                ( newTimer, timesCompleted ) =
                    IdleGame.Timer.increment delta timer

                newChoreData =
                    { choreData | masteryXp = choreData.masteryXp + timesCompleted * choreData.masteryXpGranted }

                skillXpGranted =
                    choreData.skillXpGranted * timesCompleted
            in
            ( Chore id choreData (Just newTimer), skillXpGranted )


handleAnimationFrame : Float -> List Chore -> ( List Chore, Int )
handleAnimationFrame delta chores =
    List.foldr
        (\chore accum ->
            let
                ( newChore, skillXp ) =
                    handleAnimationFrameHelper delta chore

                ( accumChores, accumSkillXp ) =
                    accum
            in
            ( newChore :: accumChores, skillXp + accumSkillXp )
        )
        ( [], 0 )
        chores
