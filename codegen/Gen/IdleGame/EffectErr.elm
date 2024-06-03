module Gen.IdleGame.EffectErr exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "IdleGame", "EffectErr" ]


annotation_ : { effectErr : Type.Annotation }
annotation_ =
    { effectErr = Type.namedWith [ "IdleGame", "EffectErr" ] "EffectErr" [] }


make_ : { negativeAmount : Elm.Expression }
make_ =
    { negativeAmount =
        Elm.value
            { importFrom = [ "IdleGame", "EffectErr" ]
            , name = "NegativeAmount"
            , annotation = Just (Type.namedWith [] "EffectErr" [])
            }
    }


caseOf_ :
    { effectErr :
        Elm.Expression
        -> { effectErrTags_0_0 | negativeAmount : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { effectErr =
        \effectErrExpression effectErrTags ->
            Elm.Case.custom
                effectErrExpression
                (Type.namedWith [ "IdleGame", "EffectErr" ] "EffectErr" [])
                [ Elm.Case.branch0 "NegativeAmount" effectErrTags.negativeAmount
                ]
    }