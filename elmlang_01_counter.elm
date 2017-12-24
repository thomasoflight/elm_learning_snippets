module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = 0
        , view = view
        , update = update
        }


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


view model =
    div []
        [ button [ onClick Increment ] [ text "increment" ]
        , button [ onClick Decrement ] [ text "decrement" ]
        , text (toString model)
        ]
