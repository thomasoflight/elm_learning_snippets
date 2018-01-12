module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style, type_, placeholder)
import Html.Events exposing (onInput, onClick)
import Char exposing (isUpper, isLower, isDigit)
import String
import List


{--String and List imported without 'exposing' to show
    where and how the packages are being used...
-}


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
    , age : String
    , submitted : Bool
    }


model : Model
model =
    Model "" "" "" "" False



-- model : Model
-- model = {name = "", password = "", passwordRepeat = ""}


type Msg
    = Name String
    | Password String
    | PasswordRepeat String
    | Age String
    | Submit Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordRepeat password ->
            { model | passwordRepeat = password }

        Age age ->
            { model | age = age }

        Submit bool ->
            { model | submitted = bool }


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "text", placeholder "Password", onInput Password ] []
        , input [ type_ "text", placeholder "Retype Password", onInput PasswordRepeat ] []
        , input [ type_ "text", placeholder "Age", onInput Age ] []
        , button [ type_ "submit", onClick (Submit True) ] [ text "submit" ]
        , (if model.submitted == True then
            viewValidation model
           else
            div [] []
          )
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( color, isMatch ) =
            if
                List.any String.isEmpty
                    [ model.password
                    , model.name
                    , model.age
                    ]
            then
                ( "pink", "one or more fields missing my friend" )
            else if model.password == model.passwordRepeat && not allConditionsMet then
                ( "blue", "passwords match but... other stuff is off" )
            else if model.password == model.passwordRepeat && allConditionsMet then
                ( "green", "match" )
            else
                ( "red", "not a match" )

        requiredLength =
            if String.length model.password < 9 then
                "Password: Too short"
            else
                ":)"

        requiredChars =
            if not (String.any isLower model.password) then
                "Password: Needs lowercase letters"
            else if not (String.any isUpper model.password) then
                "Password: upperscase letters"
            else
                ":)"

        requiredDigits =
            if not (String.any isDigit model.password) then
                "Password: Needs to have numbers"
            else
                ":)"

        requiredAgeFormat =
            if String.isEmpty model.age || not (String.all isDigit model.age) then
                "Age: Needs numbers only, please"
            else
                ":)"

        allConditionsMet =
            List.all (String.contains ":)")
                [ requiredLength
                , requiredChars
                , requiredDigits
                , requiredAgeFormat
                ]
    in
        div []
            [ h3 [ style [ ( "color", color ) ] ] [ text isMatch ]
            , ul []
                [ li [] [ text requiredLength ]
                , li [] [ text requiredChars ]
                , li [] [ text requiredDigits ]
                , li [] [ text requiredAgeFormat ]
                ]
            ]
