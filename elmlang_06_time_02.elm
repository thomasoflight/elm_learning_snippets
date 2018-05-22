module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import String
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Task
import Time exposing (Time, hour, minute, now, second)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


initTime =
    Time.now
        |> Task.perform InitTime



-- MODEL


type alias Model =
    { secHand : Time
    , minHand : Time
    , hourHand : Time
    , clockIsRunning : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { secHand = 0
      , minHand = 0
      , hourHand = 0
      , clockIsRunning = True
      }
    , initTime
    )



-- UPDATE


type Msg
    = InitTime Time
    | TickSec Time
    | TickMin Time
    | TickHr Time
    | Pause


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InitTime time ->
            { model
                | secHand = time
                , minHand = time
                , hourHand = time
            }
                ! []

        TickSec newTime ->
            { model
                | secHand = newTime
            }
                ! []

        TickMin newTime ->
            { model
                | minHand = newTime
            }
                ! []

        TickHr newTime ->
            { model
                | hourHand = newTime
            }
                ! []

        Pause ->
            { model
                | clockIsRunning =
                    not model.clockIsRunning
            }
                ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.clockIsRunning == True then
        Sub.batch
            [ Time.every (second / 1) TickSec
            , Time.every (minute / 1) TickMin
            , Time.every (hour / 1) TickHr
            ]
    else
        Sub.none


view : Model -> Html Msg
view model =
    let
        angleSecnds =
            turns (Time.inSeconds model.secHand / 60)

        angleMins =
            turns (Time.inMinutes model.minHand / 60)

        angleHrs =
            turns (Time.inHours model.hourHand / 12)

        scndX2 =
            toString (50 + 40 * cos angleSecnds)

        scndY2 =
            toString (50 + 40 * sin angleSecnds)

        scndX2B =
            toString (50 + 36 * cos angleSecnds)

        scndY2B =
            toString (50 + 36 * sin angleSecnds)

        minX2 =
            toString (50 + 38 * cos angleMins)

        minY2 =
            toString (50 + 38 * sin angleMins)

        hourX2 =
            toString (50 + 28 * cos angleHrs)

        hourY2 =
            toString (50 + 28 * sin angleHrs)

        ( pColor, pText ) =
            viewPauser model.clockIsRunning
    in
    Html.div [ Html.Attributes.style [ ( "text-align", "center" ) ] ]
        [ svg [ width "100%", height "500", viewBox "0 0  100 150" ]
            [ viewClockFace model
            , rect
                [ x "20"
                , y "105"
                , width "60"
                , height "15"
                , fill pColor
                , onClick Pause
                ]
                []
            , text_ [ x "20", y "115", textLength "40", dx "10", Svg.Attributes.style "font-size: 10px", onClick Pause ] [ text pText ]
            ]

        --, text <| toString <| "debug"
        -- *** DEBUG *** ---
        ]



-- *** DEBUG *** --
--, Html.br [] []
--, text <| toString <| Time.inSeconds model.secHand
--, Html.br [] []
--, text <| toString <| Time.inMinutes model.minHand * 60
--, Html.br [] []
--, text <| toString <| Time.inHours model.hourHand * 3600


viewClockHand center radian angle color =
    let
        xHandEnd =
            toString <| 50 + radian * cos angle

        yHandEnd =
            toString <| 50 + radian * sin angle
    in
    svg []
        [ line [ x1 center, y1 center, x2 xHandEnd, y2 yHandEnd, stroke color ] [] ]


viewTwoToneHand center body tip angle colorBody colorTip =
    let
        xHandTip =
            toString <| 50 + body * cos angle

        yHandTip =
            toString <| 50 + body * sin angle

        xHandBody =
            toString <| 50 + (body - tip) * cos angle

        yHandBody =
            toString <| 50 + (body - tip) * sin angle
    in
    svg
        []
        [ line [ x1 center, y1 center, x2 xHandTip, y2 yHandTip, stroke colorTip ] []
        , line [ x1 center, y1 center, x2 xHandBody, y2 yHandBody, stroke colorBody ] []
        ]


viewClockFace model =
    let
        angleSecnds =
            turns (Time.inSeconds model.secHand / 60)

        angleMins =
            turns (Time.inMinutes model.minHand / 60)

        angleHrs =
            turns (Time.inHours model.hourHand / 12)

        scndX2 =
            toString (50 + 40 * cos angleSecnds)

        scndY2 =
            toString (50 + 40 * sin angleSecnds)

        scndX2B =
            toString (50 + 36 * cos angleSecnds)

        scndY2B =
            toString (50 + 36 * sin angleSecnds)

        minX2 =
            toString (50 + 38 * cos angleMins)

        minY2 =
            toString (50 + 38 * sin angleMins)

        hourX2 =
            toString (50 + 28 * cos angleHrs)

        hourY2 =
            toString (50 + 28 * sin angleHrs)

        ( pColor, pText ) =
            viewPauser model.clockIsRunning
    in
    svg []
        [ circle [ cx "50", cy "50", r "45", fill "#0B79CE", stroke pColor ] []
        , viewClockHand "50" 28 angleHrs "#00CD81"
        , viewClockHand "50" 38 angleMins "#AAAAAA"
        , viewTwoToneHand "50" 40 4 angleSecnds "#023963" "#F0B992"
        ]


viewPauser bool =
    if bool == True then
        ( "#5cb883", "running" )
    else
        ( "#eb663d", "paused" )
