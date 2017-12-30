module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    { name : String
    , password : String
    , passwordRepeat : String
    }


model : Model
model =
    Model "" "" ""



-- model : Model
-- model = {name = "", password = "", passwordRepeat = ""}


type Msg
    = Name String
    | Password String
    | PasswordRepeat String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordRepeat password ->
            { model | passwordRepeat = password }


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "text", placeholder "Password", onInput Password ] []
        , input [ type_ "text", placeholder "Retype Password", onInput PasswordRepeat ] []
        , viewValidation model
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( color, message ) =
            if model.password == model.passwordRepeat then
                ( "green", "match" )
            else
                ( "red", "not a match" )

        lengthStatus =
            if String.length model.password < 9 then
                "too short"
            else
                ""
    in
        div [ style [ ( "color", color ) ] ]
            [ text (message)
            , br [] []
            , text (lengthStatus)
            ]
