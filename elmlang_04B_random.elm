module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)
import Array exposing (..)
import Style
import Element


init : ( Model, Cmd Msg )
init =
    ( Model firstCatPhoto 0 catPhotos, Cmd.none )


type alias Model =
    { dieFace : String
    , amtRolls : Int
    , catPhotos : Array String
    }


baseUrl =
    "elmlang_04_photos/"


catPhotoEndings =
    [ "c1.jpg"
    , "c2.jpg"
    , "c3.jpg"
    , "c4.jpg"
    , "c5.jpg"
    , "c6.jpg"
    ]


firstCatPhoto =
    "elmlang_04_photos/c1.jpg"


catPhotos =
    Array.fromList <| List.map (\a -> baseUrl ++ a) catPhotoEndings


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( { model | amtRolls = model.amtRolls + 1 }, Random.generate NewFace (Random.int 1 6) )

        NewFace int ->
            case (Array.get int model.catPhotos) of
                Nothing ->
                    model ! []

                Just str ->
                    ({ model | dieFace = str }) ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ p [] [ img [ style [ ( "max-width", "500px" ) ], src (model.dieFace) ] [] ]
        , p
            [ style
                [ ( "top", "20px" )
                , ( "left", "225px" )
                , ( "position", "absolute" )
                ]
            ]
            [ button
                [ style [ ( "padding", "20px" ) ]
                , onClick (Roll)
                ]
                [ text ("roll") ]
            ]
        ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- module Main exposing (..)
--
-- import Html exposing (..)
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
-- import Array exposing (..)
-- import List
-- import Random exposing (..)
--
--
-- init : ( Model, Cmd Msg )
-- init =
--     ( Model firstCatPhoto 0 catPhotos, Cmd.none )
--
--
--
--
-- firstCatPhoto =
--     baseUrl ++ "c1.jpg"
--
--
--
--
-- type alias CatPic =
--     String
--
--
-- type alias CatPhotos =
--     Array CatPic
--
--
--
--
--
-- type Msg
--     = Roll
--     | NewFace
--
--
--
-- -- | ChooseRandomCatpic
--
--
-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         Roll ->
--             ( model, Random.Generator NewFace ( Random.int 1, 6 ) )
--
--         NewFace int ->
--             ({ model | dieFace = (Array.get int model.catPhotos) })
--
--
--
-- -- pdate : Msg -> Model -> (Model, Cmd Msg)
-- -- update msg model =
-- --   case msg of
-- --     Roll ->
-- --       (model, Random.generate NewFace (Random.int 1 6))
-- --
-- --     NewFace newFace ->
-- --       (Model newFace, Cmd.none)
--
--
-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     Sub.none
--
--
-- view : Model -> Html Msg
-- view model =
--     div []
--         [ h1 [] [ text (toString model.dieFace) ]
--         , button [ onClick (Roll model.catPhotos) ] [ text ("roll") ]
--         , p [] [ text ("Amount Rolled: " ++ toString model.amtRolls) ]
--         ]
--
--
--
-- -- text <| toString catPhotos
--
--
-- main =
--     Html.program
--         { init = init
--         , update = update
--         , view = view
--         , subscriptions = subscriptions
--         }
