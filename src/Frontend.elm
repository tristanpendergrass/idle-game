module Frontend exposing (app)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events exposing (onVisibilityChange)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Game exposing (Game)
import IdleGame.Tabs
import IdleGame.Timer
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.MasteryCheckpoints
import IdleGame.Views.ModalWrapper
import IdleGame.Views.TimePasses
import Json.Decode as D
import Json.Decode.Pipeline exposing (..)
import Json.Encode as E
import Lamdera
import Task
import Time exposing (Posix)
import Time.Extra
import Types exposing (..)
import Url exposing (Url)


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = view
        }


init : Url -> Nav.Key -> ( FrontendModel, Cmd FrontendMsg )
init url key =
    ( { key = key
      , tabs = IdleGame.Tabs.initialTabs -- TODO: most of the config for tabs should not live in the model but in a config function. only being enabled/disabled should be in model
      , isVisible = True

      --   , activeModal = Nothing
      , activeModal = Just ChoreMasteryCheckpointsModal
      , saveGameTimer = IdleGame.Timer.create 1000
      , gameState = Nothing
      }
    , Cmd.none
    )



-- Update


updateGameToTime : Posix -> ( Posix, Game ) -> ( Posix, Game )
updateGameToTime now ( oldTick, game ) =
    let
        nextTick =
            Time.Extra.add Time.Extra.Millisecond IdleGame.Timer.tickDuration Time.utc oldTick

        shouldTick =
            Time.posixToMillis now >= Time.posixToMillis nextTick
    in
    if shouldTick then
        -- Note: be careful with the next line causing a stack overflow. It is written in a particular way to allow Tail-call elimination and should stay that way.
        -- Additional reading: https://jfmengels.net/tail-call-optimization/
        updateGameToTime now ( nextTick, IdleGame.Game.tick game )

    else
        ( oldTick, game )


setCurrentTime : Posix -> GameState -> GameState
setCurrentTime now gameState =
    { gameState | currentTime = now }


laterGameState : GameState -> GameState -> GameState
laterGameState left right =
    if Time.posixToMillis left.lastTick < Time.posixToMillis right.lastTick then
        right

    else
        left


setGameState : Maybe GameState -> FrontendModel -> FrontendModel
setGameState newGameState model =
    { model | gameState = newGameState }


mapGame : (Game -> Game) -> FrontendModel -> FrontendModel
mapGame fn model =
    { model | gameState = Maybe.map (\gameState -> { gameState | game = fn gameState.game }) model.gameState }


setIsVisible : Bool -> FrontendModel -> FrontendModel
setIsVisible isVisible model =
    { model | isVisible = isVisible }


setActiveModal : Maybe Modal -> FrontendModel -> FrontendModel
setActiveModal activeModal model =
    { model | activeModal = activeModal }


createTimePassesModal : GameState -> Maybe Modal
createTimePassesModal gameState =
    let
        { currentTime, lastTick, game } =
            gameState

        ( newTick, newGame ) =
            updateGameToTime currentTime ( lastTick, game )

        timePassed =
            Time.posixToMillis newTick
                - Time.posixToMillis lastTick
                |> Time.millisToPosix
    in
    IdleGame.Game.getTimePassesData game newGame
        |> Maybe.map (TimePassesModal timePassed)


update : FrontendMsg -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOp ->
            noOp

        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            noOp

        InitializeGameWithTime serverGameState now ->
            let
                newGameState =
                    model.gameState
                        -- Note: only setting the gameState in case its local value is Nothing because we only want this to be for initialization
                        |> Maybe.withDefault (setCurrentTime now serverGameState)
            in
            ( model
                |> setGameState (Just newGameState)
            , Cmd.none
            )

        ToggleActiveChore toggleId ->
            ( model
                |> mapGame (IdleGame.Game.toggleActiveChore toggleId)
            , Cmd.none
            )

        HandleAnimationFrame now ->
            case model.gameState of
                Nothing ->
                    noOp

                Just gameState ->
                    if model.isVisible then
                        let
                            ( newTick, newGame ) =
                                updateGameToTime now ( gameState.lastTick, gameState.game )

                            newGameState =
                                { gameState | currentTime = now, lastTick = newTick, game = newGame }

                            delta =
                                Time.posixToMillis now - Time.posixToMillis gameState.currentTime

                            ( newSaveGameTimer, saveGameCompletions ) =
                                IdleGame.Timer.increment delta model.saveGameTimer

                            shouldSaveGame =
                                saveGameCompletions > 0

                            saveGameCmd =
                                Lamdera.sendToBackend (Save newGameState)
                        in
                        ( { model
                            | gameState = Just newGameState
                            , saveGameTimer = newSaveGameTimer
                          }
                        , if shouldSaveGame then
                            saveGameCmd

                          else
                            Cmd.none
                        )

                    else
                        ( { model | gameState = Just { gameState | currentTime = now } }, Cmd.none )

        HandleVisibilityChange visibility ->
            case model.gameState of
                Nothing ->
                    noOp

                Just gameState ->
                    if visibility == Browser.Events.Visible then
                        let
                            newActiveModal =
                                case createTimePassesModal gameState of
                                    Just timePassesModal ->
                                        Just timePassesModal

                                    Nothing ->
                                        model.activeModal
                        in
                        ( model
                            |> setActiveModal newActiveModal
                            |> setIsVisible True
                        , Cmd.none
                        )

                    else
                        ( model
                            |> setIsVisible False
                        , Cmd.none
                        )

        CloseModal ->
            ( model
                |> setActiveModal Nothing
            , Cmd.none
            )

        OpenMasteryCheckpointsModal ->
            ( model
                |> setActiveModal (Just ChoreMasteryCheckpointsModal)
            , Cmd.none
            )


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        InitializeGame gameState ->
            ( model, Task.perform (InitializeGameWithTime gameState) Time.now )


subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onVisibilityChange HandleVisibilityChange
        ]


view : FrontendModel -> Document FrontendMsg
view model =
    let
        css =
            -- There's an experimental technique to include styles in header instead of body https://dashboard.lamdera.app/docs/html-head
            -- We're not using it for now because it's experimental but might be useful if we want to eliminate the flicker from the css loading in
            [ node "link" [ rel "stylesheet", href "/output.css" ] []
            ]
    in
    { title = "Idle Game"
    , body =
        case model.gameState of
            Nothing ->
                css

            Just { game } ->
                css
                    ++ [ div [ class "bg-base-100 drawer drawer-mobile" ]
                            [ input [ id "drawer", type_ "checkbox", class "drawer-toggle" ] []
                            , IdleGame.Views.Content.renderContent game
                            , IdleGame.Views.Drawer.renderDrawer game model.tabs
                            ]
                       ]
                    ++ (case model.activeModal of
                            Nothing ->
                                []

                            Just (TimePassesModal timePassed timePassesData) ->
                                let
                                    children =
                                        IdleGame.Views.TimePasses.render timePassed timePassesData
                                in
                                [ IdleGame.Views.ModalWrapper.create children
                                    |> IdleGame.Views.ModalWrapper.withBorderColor "secondary"
                                    |> IdleGame.Views.ModalWrapper.render
                                ]

                            Just ChoreMasteryCheckpointsModal ->
                                let
                                    children =
                                        IdleGame.Views.MasteryCheckpoints.render { mxp = game.choresMxp, checkpoints = IdleGame.Game.choreMasteryPoolCheckpoints }
                                in
                                [ IdleGame.Views.ModalWrapper.create children
                                    |> IdleGame.Views.ModalWrapper.render
                                ]
                       )
    }
