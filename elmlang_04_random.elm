module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model 1 0, Cmd.none )


type alias Model =
    { dieFace : Int
    , amtRolls : Int
    }


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( { model | amtRolls = model.amtRolls + 1 }, Random.generate NewFace (Random.int 1 6) )

        NewFace int ->
            ({ model | dieFace = int }) ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.dieFace) ]
        , button [ onClick (Roll) ] [ text ("roll") ]
        , p [] [ text ("Amount Rolled: " ++ toString model.amtRolls) ]
        ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
