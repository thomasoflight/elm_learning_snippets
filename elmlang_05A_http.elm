module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http exposing (..)
import Http.Error exposing (..)
import Json.Decode as JsonDec
import List
import String


type alias Model =
    { topic : String
    , gifUrl : String
    }


type Msg
    = MorePlease
    | NewGif (Result Http.Error String)


init : ( Model, Cmd Msg )
init =
    ( Model "cats" "elmlang_04_photos/c1.jpg", Cmd.none )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topics )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , img [ src model.gif ] []
        , button [ onClick MorePlease ] [ text "More Please!" ]
        ]


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
