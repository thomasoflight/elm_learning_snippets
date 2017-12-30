module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String exposing (any, contains, join, isEmpty)
import Char exposing (isUpper, isLower, isDigit)
import List


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
        ( color, isMatch ) =
            if List.any isEmpty [ model.password, model.name ] then
                ( "pink", "one or more fields missing my friend" )
            else if model.password == model.passwordRepeat && not allConditionsMet then
                ( "blue", "passwords match but... other stuff is off" )
            else if model.password == model.passwordRepeat && allConditionsMet then
                ( "green", "match" )
            else
                ( "red", "not a match" )

        requiredLength =
            if String.length model.password < 9 then
                "Too short"
            else
                ":)"

        requiredChars =
            if not (any isLower model.password) then
                "Needs lowercase letters"
            else if not (any isUpper model.password) then
                "Needs upperscase letters"
            else
                ":)"

        requiredDigits =
            if not (any isDigit model.password) then
                "Needs to have digits"
            else
                ":)"

        allConditionsMet =
            List.all (contains ":)") [ requiredLength, requiredChars, requiredDigits ]
    in
        div []
            [ h3 [ style [ ( "color", color ) ] ] [ text isMatch ]
            , ul []
                [ li [] [ text requiredLength ]
                , li [] [ text requiredChars ]
                , li [] [ text requiredDigits ]
                ]
            ]
