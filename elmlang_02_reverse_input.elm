module Main exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


-- MAIN


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { content : String
    }


model : Model
model =
    { content = "" }



-- UPDATE
-- I guess I need to include the String type to account for how onInput works,
-- but I've never seen two parameters together in a Msg like this.
-- Why does Change need a second parameter?


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        -- newContent represents whatever text is displayed in the input field, right?
        -- since newContent isn't defined anywhere else, I assumed its "captured"
        -- under the hood by onInput and stored
        Change newContent ->
            { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        ]
