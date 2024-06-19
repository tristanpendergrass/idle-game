module IdleGame.Views.UnderConstruction exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import IdleGame.Views.Icon as Icon
import Types exposing (..)


render : Html FrontendMsg
render =
    div [ class "t-column p-6 pb-16 max-w-[1920px] min-w-[375px]" ]
        [ div [ class "w-full flex justify-center items-center" ]
            [ div [ class "flex gap-2" ]
                [ Icon.underConstruction
                    |> Icon.toHtml
                , span [] [ text "Under construction" ]
                ]
            ]
        ]
