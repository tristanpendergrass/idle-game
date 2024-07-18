module Evergreen.V1.IdleGame.Tab exposing (..)

import Evergreen.V1.IdleGame.Kinds


type Tab
    = Backpack
    | Shop
    | TestingCenter
    | SkillTab Evergreen.V1.IdleGame.Kinds.Skill
