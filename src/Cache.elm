module Cache exposing (..)


type Cache a
    = Cache (Maybe a)


create : Cache a
create =
    Cache Nothing
