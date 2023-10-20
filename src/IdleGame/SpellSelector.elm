module IdleGame.SpellSelector exposing (..)

import IdleGame.Resource as Resource


type alias SpellSelector =
    { spell : Maybe Resource.Kind }


getOptions : List Resource.Kind
getOptions =
    Resource.allSpells


create : SpellSelector
create =
    { spell = Nothing }
