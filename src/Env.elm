module Env exposing (..)

-- The Env.elm file is for per-environment configuration.
-- See https://dashboard.lamdera.app/docs/environment for more info.


dummyConfigItem =
    ""


secretKey : String
secretKey =
    "123"


domain : String
domain =
    "http://localhost:8000"


postmarkServerToken : String
postmarkServerToken =
    "cf0f9827-45ba-4fab-bd7e-b232ad4ed297"


isProduction_ : String
isProduction_ =
    "False"


isProduction : Bool
isProduction =
    isProduction_ == "True"
