module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import String


main =
    Html.program
        { init = init "piano"
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    }


init : String -> ( Model, Cmd Msg )
init topic =
    ( Model topic "waiting.gif"
    , getRandomGif topic
    )


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Decode.succeed msg
            else
                Decode.fail "not ENTER"
    in
    on "keydown" (Decode.andThen isEnter keyCode)



-- UPDATE


type Msg
    = MorePlease
    | SetNewTopic String
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        -- wow it's so cool that you can do this!!!
        SetNewTopic str ->
            let
                newModel =
                    { model | topic = str }
            in
            ( newModel, getRandomGif newModel.topic )

        NewGif (Ok newUrl) ->
            { model
                | topic = model.topic
                , gifUrl = newUrl
            }
                ! []

        NewGif (Err msg) ->
            { model
                | gifUrl = toString msg
            }
                ! []



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "view"
        ]
        [ h2 [] [ text <| "Current topic: " ++ model.topic ]
        , viewTopicSelector
        , div []
            [ button [ onClick MorePlease ] [ text "More Please!" ]
            , br [] []
            , viewResult model.gifUrl
            ]
        ]


viewTopicSelector =
    div
        [ class "dropdown"

        --style
        --[ ( "font-size", "11px" )
        --, ( "margin-top", "10px" )
        --, ( "margin-bottom", "20px" )
        --]
        ]
        [ button [ class "dropdown" ] [ text "available topics" ]
        , nav
            [ class "dropdown-content" ]
            [ ul
                []
                [ a [] [ li [ onClick (SetNewTopic "backgammon") ] [ text "backgammon" ] ]
                , a [] [ li [ onClick (SetNewTopic "Avengers") ] [ text "Avengers" ] ]
                , a [] [ li [ onClick (SetNewTopic "New Orleans") ] [ text "New Orleans" ] ]
                , a [] [ li [ onClick (SetNewTopic "cheese") ] [ text "cheese" ] ]
                ]
            ]
        ]


viewResult str =
    if String.left 6 str == "https:" then
        img [ src str ] []
    else
        div
            [ style
                [ ( "margin", "0 auto" )
                , ( "padding-top", "160px" )
                , ( "text-align", "center" )
                , ( "font-size", "14px" )
                ]
            ]
            [ text str ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
    Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
