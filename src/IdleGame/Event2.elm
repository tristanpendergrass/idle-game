module IdleGame.Event2 exposing (..)


type Tag
    = Tag


type alias Event =
    { title : String
    , effects : Effects
    , tags : List Tag
    }


type Effects
    = Definite { effects : List Effect }
    | Indefinite { effects : List Effect, probability : Float, failEffects : List Effect }


type EffectType
    = GainResource Int Resource
    | GainXp Float Skill


type alias Effect =
    { type_ : EffectType
    , tags : List Tag
    }


type Skill
    = Chores


type Resource
    = Wood


type Tree
    = Elm


type ModSource
    = AdminCrimes


type alias Mod =
    { tags : List Tag
    , label : String
    , transformer : EffectType -> List EffectType
    , source : ModSource
    }
