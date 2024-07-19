module Evergreen.V2.IdleGame.Tab exposing (..)

import Evergreen.V2.IdleGame.Kinds


type Tab
    = Home
    | Backpack
    | Shop
    | TestingCenter
    | SkillTab Evergreen.V2.IdleGame.Kinds.Skill
