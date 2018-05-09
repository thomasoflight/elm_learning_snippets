module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


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
    , nextTopic : String
    , gifUrl : String
    }


init : String -> ( Model, Cmd Msg )
init topic =
    ( Model topic "" "waiting.gif"
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
    | UpdateTopic String
    | SetTopic
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        UpdateTopic str ->
            ( { model | nextTopic = str }, Cmd.none )

        SetTopic ->
            if String.isEmpty model.nextTopic then
                ( model, getRandomGif model.topic )
            else
                ( { model
                    | topic = model.nextTopic
                    , nextTopic = ""
                  }
                , getRandomGif model.nextTopic
                )

        NewGif (Ok newUrl) ->
            ( Model model.topic model.nextTopic newUrl, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "margin-left", "25%" )
            , ( "margin-right", "25%" )
            , ( "margin-top", "50px" )
            ]
        ]
        [ h2 [] [ text <| "Current topic: " ++ model.topic ]
        , viewTopicInput model.nextTopic
        , button [ onClick MorePlease ] [ text "More Please!" ]
        , br [] []
        , img [ src model.gifUrl ] []
        ]


viewTopicInput topic =
    div
        [ style
            [ ( "font-size", "11px" )
            , ( "margin-top", "10px" )
            , ( "margin-bottom", "20px" )
            ]
        ]
        [ input
            [ placeholder "New topic"
            , value topic
            , onInput UpdateTopic
            , onEnter SetTopic
            ]
            []
        , br [] []
        , text "Press enter to show more"
        ]



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
