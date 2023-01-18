module IdleGame.Resource exposing (..)


type Resource
    = Manure
    | Ore
    | Ingot
    | Ruby
    | Stick


toString : Resource -> String
toString resource =
    case resource of
        Manure ->
            "Manure"

        Ore ->
            "Ore"

        Ingot ->
            "Ingot"

        Ruby ->
            "Ruby"

        Stick ->
            "Stick"
