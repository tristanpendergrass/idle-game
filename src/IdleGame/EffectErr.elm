module IdleGame.EffectErr exposing (..)

{-| Errors that can occur when applying an effect.
-}


type EffectErr
    = NegativeAmount -- Tried to subtract something and it went negative
    | TestAlreadyCompleted -- Tried to complete a test that had already been done
    | TestNotUnlocked -- Tried to complete a test that was not unlocked
