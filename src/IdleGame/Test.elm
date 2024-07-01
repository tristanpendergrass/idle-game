module IdleGame.Test exposing (..)

import IdleGame.Coin as Coin exposing (Coin)
import IdleGame.Counter as Counter exposing (Counter)
import IdleGame.Effect as Effect exposing (Effect)
import IdleGame.Game as Game
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.Resource as Resource
import IdleGame.Views.Effect as EffectView
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Types exposing (..)


type alias Test =
    { costs : List Effect
    , gains : List Effect
    , label : String
    }
