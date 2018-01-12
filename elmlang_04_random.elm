module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model 1 0, Cmd.none )


type alias Model =
    { dieFace : Int
    , amtRolls : Int
    }


type Msg
    = Roll Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll int ->
            ( { model | dieFace = int }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.dieFace) ]
        , button [ onClick (Roll 6) ] [ text ("roll") ]
        , p [] [ text ("Amount Rolled: " ++ toString model.amtRolls) ]
        ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
