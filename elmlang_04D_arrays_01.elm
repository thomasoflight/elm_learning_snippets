module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)
import Array


init : ( Model, Cmd Msg )
init =
    ( Model 1 0 "init", Cmd.none )


type alias Model =
    { dieFace : Int
    , amtRolls : Int
    , arrayItem : String
    }


type Msg
    = Roll
    | NewFace Int


testArray =
    Array.fromList [ "pickle", "cabbage", "cribbage", "dalmation" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( { model | amtRolls = model.amtRolls + 1 }, Random.generate NewFace (Random.int 1 6) )

        NewFace int ->
            case Array.get int testArray of
                Just str ->
                    ({ model | arrayItem = str }) ! []

                Nothing ->
                    model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.arrayItem ]
        , button [ onClick (Roll) ] [ text ("roll") ]
        ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
