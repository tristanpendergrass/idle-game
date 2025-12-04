module Evergreen.V1.IdleGame.Tab exposing (..)

import Evergreen.V1.IdleGame.Kinds


type Tab
    = Home
    | Backpack
    | Shop
    | SkillTab Evergreen.V1.IdleGame.Kinds.Skill
