module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = myModel
        , update = myUpdater
        , view = myView
        }


myModel : Int
myModel =
    0


type Msg
    = Decr
    | Incr
    | Reset


myUpdater : Msg -> Int -> Int
myUpdater msg model =
    case msg of
        Decr ->
            model - 1

        Incr ->
            model + 1

        Reset ->
            myModel


myView : Int -> Html Msg
myView model =
    div []
        [ button [ onClick Decr ] [ text "-" ]
        , text (toString model)
        , button [ onClick Incr ] [ text "+" ]
        , div []
            [ button [ onClick Reset ] [ text "reset" ]
            ]
        ]
