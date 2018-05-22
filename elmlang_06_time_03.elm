module Main exposing (..)

import Html exposing (Html, br, button, div)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { time : Time
    , state : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 True, Cmd.none )



-- UPDATE


type Msg
    = Tick Time
    | Toggle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }, Cmd.none )

        Toggle ->
            ( toggleState model, Cmd.none )



-- UTILITIES


toggleState : Model -> Model
toggleState model =
    { model | state = not model.state }


printWithLeadingZero : Int -> String
printWithLeadingZero number =
    if number < 10 then
        "0" ++ toString number
    else
        toString number


degressCorrection : Float
degressCorrection =
    90.0



-- The correction we must do on our analog clock to show 12 pointing up instead to the right


degressForHour : Float
degressForHour =
    360.0 / 12.0



-- We divide the total degrees of a full circle by the full hours of the day to get the degrees per hour


degreesForMinute : Float
degreesForMinute =
    360.0 / 60.0



-- We divide the total degrees of a full circle by the full minutes of the hour to get the degrees per minute


convertToDegrees : Int -> Float -> Float
convertToDegrees value degreesPerPoint =
    degrees ((toFloat value * degreesPerPoint) - degressCorrection)


minutesToDegrees : Int -> Float
minutesToDegrees minutes =
    convertToDegrees minutes degreesForMinute


hoursToDegrees : Int -> Float
hoursToDegrees hours =
    convertToDegrees hours degressForHour



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.state of
        True ->
            Time.every second Tick

        False ->
            Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        secsec =
            turns (Time.inSeconds model.time)

        secondHandX =
            toString (50 + 40 * cos secsec)

        secondHandY =
            toString (50 + 40 * sin secsec)

        minmin =
            turns (Time.inMinutes model.time)

        minuteHandX =
            toString (50 + 35 * cos minmin)

        minuteHandY =
            toString (50 + 35 * sin minmin)

        hrhr =
            turns (Time.inHours model.time)

        hourHandX =
            toString (50 + 30 * cos hrhr)

        hourHandY =
            toString (50 + 30 * sin hrhr)

        --currentTime =
        --    printWithLeadingZero hourOfDay ++ ":" ++ printWithLeadingZero minuteOfHour ++ ":" ++ printWithLeadingZero secondOfMinute
    in
    div []
        [ div [] [ text "hi" ]
        , svg [ viewBox "0 0 100 100", width "300px" ]
            [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
            , line [ x1 "50", y1 "50", x2 secondHandX, y2 secondHandY, stroke "#ee0000" ] []
            , line [ x1 "50", y1 "50", x2 minuteHandX, y2 minuteHandY, stroke "#0000ee" ] []
            , line [ x1 "50", y1 "50", x2 hourHandX, y2 hourHandY, stroke "#023963" ] []
            ]
        , br [] []
        , button [ onClick Toggle ] [ text "Toggle Clock Status" ]
        ]
