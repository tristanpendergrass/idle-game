module IdleGame.Skill exposing (..)


type Skill
    = Chores
    | Hexes


type alias SkillDict a =
    { chores : a
    , hexes : a
    }


getInDict : Skill -> SkillDict a -> a
getInDict skill dict =
    case skill of
        Chores ->
            dict.chores

        Hexes ->
            dict.hexes


setInDict : Skill -> a -> SkillDict a -> SkillDict a
setInDict skill value dict =
    case skill of
        Chores ->
            { dict | chores = value }

        Hexes ->
            { dict | hexes = value }


updateInDict : Skill -> (a -> a) -> SkillDict a -> SkillDict a
updateInDict skill f dict =
    case skill of
        Chores ->
            { dict | chores = f dict.chores }

        Hexes ->
            { dict | hexes = f dict.hexes }
