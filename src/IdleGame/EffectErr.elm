module IdleGame.EffectErr exposing (..)

{-| Errors that can occur when applying an effect.
-}


type EffectErr
    = NegativeAmount -- Tried to subtract something and it went negative
    | QuestAlreadyComplete -- Tried to complete a quest that was already complete
