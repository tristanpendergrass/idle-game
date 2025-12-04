module Evergreen.V1.Route exposing (..)

import Evergreen.V1.Id


type Route
    = RootRoute
    | ServerInfoRoute


type Token
    = NoToken
    | LoginToken (Evergreen.V1.Id.Id Evergreen.V1.Id.LoginToken)
