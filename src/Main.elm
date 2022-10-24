module Main exposing (..)

import Browser
import Browser.Events exposing (onVisibilityChange)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import IdleGame.Tabs
import IdleGame.Types exposing (..)
import IdleGame.Views.Content
import IdleGame.Views.Drawer
import IdleGame.Views.WelcomeBackModal
import Task
import Time


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init () =
    ( { tabs = IdleGame.Tabs.initialTabs
      , showWelcomeBackModal = False
      , gameObject =
            { currentTime = Time.posixFromMillis 0
            , wood = 0
            , boatLevel = 0
            , woodcuttingXp = 0
            , boatbuildingXp = 0
            }
      , woodcuttings =
            [ IdleGame.Woodcutting.create 0
                { title = "Clean Stables", rewardText = "+5 gold", skillXpGranted = 5, masteryXpGranted = 15, masteryXp = 235 }
            , IdleGame.Woodcutting.create 1
                { title = "Clean Big Bubba's Stall", rewardText = "+15 gold", skillXpGranted = 10, masteryXpGranted = 1, masteryXp = 0 }
            ]
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case msg of
        NoOp ->
            noOp

        WithTime getMsg ->
            ( model, Cmd.batch [ Task.perform getMsg Time.now ] )

        ToggleActiveTree toggleId now ->
            ( { model | woodcutting = IdleGame.Woodcutting.toggleActiveWoodcutting toggleId (Time.posixToMillis now) model.woodcutting }, Cmd.none )

        HandleAnimationFrame nowPosix ->
            let
                now =
                    Time.posixToMillis nowPosix

                -- handle woodcutting
                ( newWoodcutting, { skillXpGained, masteryXpGained } ) =
                    IdleGame.Woodcutting.handleAnimationFrame now model.woodcutting
            in
            ( { model | woodcutting = newWoodcutting, skillXp = model.skillXp + skillXpGained, masteryXp = model.masteryXp + masteryXpGained, now = now }, Cmd.none )

        HandleVisibilityChange visibility ->
            if visibility == Browser.Events.Visible then
                ( { model | showWelcomeBackModal = True }, Cmd.none )

            else
                noOp

        CloseWelcomeBackModal ->
            ( { model | showWelcomeBackModal = False }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame HandleAnimationFrame
        , Browser.Events.onVisibilityChange HandleVisibilityChange
        ]


view : Model -> Html Msg
view model =
    let
        css =
            -- There's an experimental technique to include styles in header instead of body https://dashboard.lamdera.app/docs/html-head
            -- We're not using it for now because it's experimental but might be useful if we want to eliminate the flicker from the css loading in
            [ node "link" [ rel "stylesheet", href "/tailwind.css" ] []
            ]
    in
    div []
        (css
            ++ [ div [ class "bg-base-100 drawer drawer-mobile" ]
                    [ input [ id "drawer", type_ "checkbox", class "drawer-toggle" ] []
                    , IdleGame.Views.Content.renderContent model
                    , IdleGame.Views.Drawer.renderDrawer model
                    ]
               ]
            ++ (if model.showWelcomeBackModal then
                    [ IdleGame.Views.WelcomeBackModal.render model
                    ]

                else
                    []
               )
        )


create : Id -> WoodcuttingData -> Woodcutting
create id woodcuttingData =
    Woodcutting id woodcuttingData Nothing


toggleActiveWoodcutting : Id -> Int -> List Woodcutting -> List Woodcutting
toggleActiveWoodcutting toggleId now woodcuttings =
    woodcuttings
        |> List.map
            (\(Woodcutting id woodcuttingData activityStatus) ->
                if id == toggleId then
                    let
                        newActivityStatus =
                            case activityStatus of
                                Nothing ->
                                    Just (IdleGame.Timer.create now 2500)

                                Just _ ->
                                    Nothing
                    in
                    Woodcutting id woodcuttingData newActivityStatus

                else
                    Woodcutting id woodcuttingData Nothing
            )


isActive : Woodcutting -> Bool
isActive (Woodcutting _ _ activityStatus) =
    not (activityStatus == Nothing)


getId : Woodcutting -> Id
getId (Woodcutting id _ _) =
    id


getWoodcuttingData : Woodcutting -> WoodcuttingData
getWoodcuttingData (Woodcutting _ woodcuttingData _) =
    woodcuttingData


handleAnimationFrameHelper : Int -> Woodcutting -> ( Woodcutting, { skillXp : Int, masteryXp : Int } )
handleAnimationFrameHelper now (Woodcutting id woodcuttingData maybeActivityTimer) =
    case maybeActivityTimer of
        Nothing ->
            ( Woodcutting id woodcuttingData maybeActivityTimer, { skillXp = 0, masteryXp = 0 } )

        Just timer ->
            let
                ( newTimer, timesCompleted ) =
                    IdleGame.Timer.update now timer

                newWoodcuttingData =
                    { woodcuttingData | masteryXp = woodcuttingData.masteryXp + timesCompleted * woodcuttingData.masteryXpGranted }

                skillXpGranted =
                    woodcuttingData.skillXpGranted * timesCompleted

                masteryXpGranted =
                    woodcuttingData.masteryXpGranted * timesCompleted
            in
            ( Woodcutting id woodcuttingData (Just newTimer), { skillXp = skillXpGranted, masteryXp = masteryXpGranted } )


handleAnimationFrame : Int -> List Woodcutting -> ( List Woodcutting, { skillXpGained : Int, masteryXpGained : Int } )
handleAnimationFrame now woodcuttings =
    List.foldr
        (\woodcutting accum ->
            let
                ( newWoodcutting, { skillXp, masteryXp } ) =
                    handleAnimationFrameHelper now woodcutting

                ( accumWoodcuttings, accumXps ) =
                    accum
            in
            ( newWoodcutting :: accumWoodcuttings, { skillXpGained = skillXp + accumXps.skillXpGained, masteryXpGained = masteryXp + accumXps.masteryXpGained } )
        )
        ( [], { skillXpGained = 0, masteryXpGained = 0 } )
        woodcuttings


tick : GameObject -> GameObject
tick gameObject =
    let
        ( newWoodcuttings, { skillXpGained, masteryXpGained } ) =
            List.foldr
                (\woodcutting accum ->
                    let
                        ( newWoodcutting, { skillXp, masteryXp } ) =
                            handleAnimationFrameHelper now woodcutting

                        ( accumWoodcuttings, accumXps ) =
                            accum
                    in
                    ( newWoodcutting :: accumWoodcuttings, { skillXpGained = skillXp + accumXps.skillXpGained, masteryXpGained = masteryXp + accumXps.masteryXpGained } )
                )
                ( [], { skillXpGained = 0, masteryXpGained = 0 } )
                gameObject.woodcuttings
    in
    Debug.todo "Implement tick"



-- GameObject stuff


getTimeOfNextTick : GameObject -> Posix
getTimeOfNextTick =
    .currentTime >> Time.Extra.add Time.Extra.Millisecond 20 Time.utc


tick : GameObject -> GameObject
tick gameObject =
    gameObject
        |> IdleGame.Woodcuttings.tick


updateGameObject : Posix -> GameObject -> GameObject
updateGameObject now gameObject =
    if getTimeOfNextTick gameObject <= now then
        gameObject
            |> tick
            |> updateGameObject now

    else
        gameObject



-- Diff stuff


type Gain
    = XpGain
    | ResourceGain


type Loss
    = ResourceLoss


type alias GameObjectDiff =
    { gains : List Gain
    , losses : List Loss
    }


diff : GameObject -> GameObject -> GameObjectDiff
diff gameObject1 gameObject2 =
    Debug.todo "Implement diff"
