module IdleGame.Views.TestingCenter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Mod exposing (..)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Timer
import IdleGame.Views.Activity
import IdleGame.Views.Bag
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Shop
import IdleGame.Views.SubjectViews
import IdleGame.Views.UnderConstruction
import IdleGame.Views.Utils
import Types exposing (..)


render : Game -> Html FrontendMsg
render game =
    div [] []
