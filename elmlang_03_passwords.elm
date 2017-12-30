module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (..)
import Char exposing (isUpper, isLower, isDigit)
import List
import Result


main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\model -> Sub.none)
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Name name ->
            ( { model | name = name }, Cmd.none )

        Password password ->
            ( { model | password = password }, Cmd.none )

        PasswordRepeat password ->
            ( { model | passwordRepeat = password }, Cmd.none )

        Age age ->
            ( { model | age = age }, Cmd.none )

        Submit bool ->
            ( { model | submitted = bool }, Cmd.none )


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
                List.any isEmpty
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

        requiredAgeFormat =
            if isEmpty model.age || not (all isDigit model.age) then
                "Needs numbers only, please"
            else
                ":)"

        allConditionsMet =
            List.all (contains ":)")
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
