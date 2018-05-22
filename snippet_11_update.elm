module Main exposing (main)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random


{- THIS SNIPPET IS ABOUT LEARNING TO CHAIN
   TOGETHER UPDATES TO THE VIRTUAL DOM WITH CMD MESSAGES
   MAKING USE OF LET/IN
-}


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { age : Int
    , gift : String
    }


type Msg
    = Grow
    | Gift Int



-- MODEL


init =
    Model 0 "cherubim" ! []


gifts =
    Array.fromList [ "car", "cat", "bell", "radio" ]



--UPDATE


update msg model =
    case msg of
        Grow ->
            let
                newModel =
                    Model (model.age + 1) "..."
            in
            ( newModel, Random.generate Gift (Random.int 0 3) )

        Gift int ->
            case Array.get int gifts of
                Just gift ->
                    ( { model | gift = gift }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )



-- VIEW


view model =
    let
        masonAge =
            toString model.age
    in
    div
        [ style
            [ ( "max-width", "400px" )
            , ( "margin", "0 auto" )
            , ( "padding-top", "40px" )
            , ( "text-align", "center" )
            ]
        ]
        [ text <| "Mason is now: " ++ masonAge
        , br [] []
        , text <| "Mason gets a: " ++ model.gift
        , br [] []
        , button
            [ onClick Grow
            , style
                [ ( "background-color", "black" )
                , ( "color", "white" )
                , ( "border", "solid black 1px" )
                , ( "border-radius", "4px" )
                , ( "padding", "5px" )
                ]
            ]
            [ text "Happy Birthday!" ]
        ]



--fetchPresent =
