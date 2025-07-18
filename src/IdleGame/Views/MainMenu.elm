module IdleGame.Views.MainMenu exposing (..)

import Config
import FeatherIcons
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Kinds exposing (..)
import IdleGame.Snapshot exposing (Snapshot, getTime)
import IdleGame.Tab as Tab exposing (Tab)
import IdleGame.Views.Icon as Icon exposing (Icon)
import IdleGame.Views.Utils
import Time exposing (Posix, toDay, toMonth, toYear, utc)
import Types exposing (..)


renderTimeSinceLastPlayed : Snapshot Game -> Html FrontendMsg
renderTimeSinceLastPlayed snapshot =
    let
        lastPlayed =
            getTime snapshot

        zone =
            utc

        year =
            toYear zone lastPlayed

        month =
            toMonth zone lastPlayed |> monthToInt

        day =
            toDay zone lastPlayed

        monthToInt m =
            case m of
                Time.Jan ->
                    1

                Time.Feb ->
                    2

                Time.Mar ->
                    3

                Time.Apr ->
                    4

                Time.May ->
                    5

                Time.Jun ->
                    6

                Time.Jul ->
                    7

                Time.Aug ->
                    8

                Time.Sep ->
                    9

                Time.Oct ->
                    10

                Time.Nov ->
                    11

                Time.Dec ->
                    12

        pad n =
            if n < 10 then
                "0" ++ String.fromInt n

            else
                String.fromInt n

        dateString =
            String.fromInt year ++ "-" ++ pad month ++ "-" ++ pad day
    in
    span [ class "text-xs text-gray-500 ml-2" ]
        [ text ("Last played: " ++ dateString) ]


render : MainMenuFrontend -> Html FrontendMsg
render mainMenuFrontend =
    div [ class "w-full h-full flex justify-center p-20" ]
        [ case mainMenuFrontend.mainMenuRoute of
            -- MainMenuGatekeeper ->
            --     div [ IdleGame.Views.Utils.classes.column, class "w-[320px] bg-base-200 rounded-log p-4" ]
            --         [ h1 [ class "text-2xl font-bold text-center" ] [ text "Welcome to Idle Game" ]
            --         ]
            -- MainMenuLogin ->
            --     div [ IdleGame.Views.Utils.classes.column, class "w-[320px] bg-base-200 rounded-lg shadow-lg p-4" ]
            --         [ h1 [ class "text-2xl font-bold text-center" ] [ text "Welcome to Idle Game" ]
            --         ]
            -- MainMenuGameList ->
            -- Debug.todo ""
            MainMenuAnonymousPlay ->
                div [ IdleGame.Views.Utils.classes.column, class "w-[320px] bg-base-200 rounded-lg shadow-lg p-4" ]
                    [ h1 [ class "text-2xl font-bold text-center mb-4" ] [ text "Games" ]
                    , button [ class "btn btn-primary w-full mb-4", onClick HandleCreateGameClick ] [ text "New Game" ]
                    , ul [ class "space-y-2" ]
                        (List.indexedMap
                            (\index ( gameId, snapshot ) ->
                                li [ class "flex justify-between items-center gap-4" ]
                                    [ button [ class "btn btn-secondary", onClick (HandleStartGameClick { index = index }) ] [ text ("Game " ++ String.fromInt (index + 1)) ]
                                    , span [] [ renderTimeSinceLastPlayed snapshot ]
                                    ]
                            )
                            mainMenuFrontend.games
                        )
                    ]
        ]



-- Preserving this for reference later, it's what we had when we supported login
-- renderMainMenu : MainMenuFrontend -> Html FrontendMsg
-- renderMainMenu mainMenuFrontend =
--     let
--         renderGame : Int -> ( Id GameId, Snapshot Game ) -> Html FrontendMsg
--         renderGame index _ =
--             li []
--                 [ text ("Game " ++ String.fromInt index)
--                 , button [ onClick (HandleStartGameClick { index = index }) ] [ text "Start" ]
--                 ]
--     in
--     div [ IdleGame.Views.Utils.classes.column, class "prose" ]
--         [ h1 [] [ text "Main Menu" ]
--         , case mainMenuFrontend.user.loginStatus of
--             LoggedIn { emailAddress } ->
--                 div [ IdleGame.Views.Utils.classes.column ]
--                     [ div [] [ text ("Logged in as " ++ EmailAddress.toString emailAddress) ]
--                     , button [ class "btn", onClick HandleLogoutClick ] [ text "Log out" ]
--                     ]
--             LoginStatusPending ->
--                 div [] [ text "Authenticating..." ]
--             NotLoggedIn _ ->
--                 div [] [ text "Logged in as Anonymous" ]
--         , h2 [] [ text "Games" ]
--         , ul []
--             (List.concat
--                 [ [ li [] [ button [ class "btn btn-primary", onClick HandleCreateGameClick ] [ text "Create new game" ] ] ]
--                 , List.indexedMap renderGame mainMenuFrontend.games
--                 ]
--             )
--         , div [ IdleGame.Views.Utils.classes.column ]
--             [ input
--                 [ type_ "text"
--                 , value mainMenuFrontend.emailFormValue
--                 , onInput HandleEmailInput
--                 , class "input input-bordered"
--                 , placeholder "Email address"
--                 ]
--                 []
--             , button [ class "btn", onClick HandleCreateUserClick ] [ text "Create user" ]
--             , button [ class "btn", onClick HandleLogInClick ] [ text "Log in" ]
--             ]
--         ]
