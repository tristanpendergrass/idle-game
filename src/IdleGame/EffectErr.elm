module IdleGame.EffectErr exposing (..)

{-| Errors that can occur when applying an effect.
-}


type EffectErr
    = NegativeAmount -- Tried to subtract something and it went negative
    | TestAlreadyCompleted -- Tried to complete a test that had already been done
    | OneTimeEffectAlreadyApplied -- Tried to apply a one-time effect that had already been applied
    | TestNotUnlocked -- Tried to complete a test that was not unlocked
