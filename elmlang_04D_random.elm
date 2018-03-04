module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes as HtmlAttrs
import Svg exposing (circle, rect, svg)
import Svg.Attributes exposing (..)
import Random exposing (..)
import String
import Array exposing (Array)


init : ( Model, Cmd Msg )
init =
    ( Model allCoordinates [ ( 0.5, 0.5 ) ] [ ( 0.5, 0.5 ) ] 0, Cmd.none )


half int =
    int / 2


px int =
    (toString int) ++ "px"


allCoordinates =
    Array.fromList
        [ [ ( 0.5, 0.5 ) ]
        , [ ( 0.2, 0.2 ), ( 0.8, 0.8 ) ]
        , [ ( 0.5, 0.2 ), ( 0.5, 0.5 ), ( 0.5, 0.8 ) ]
        , [ ( 0.2, 0.2 ), ( 0.8, 0.2 ), ( 0.2, 0.8 ), ( 0.8, 0.8 ) ]
        , [ ( 0.2, 0.2 ), ( 0.8, 0.2 ), ( 0.2, 0.8 ), ( 0.8, 0.8 ), ( 0.5, 0.5 ) ]
        , [ ( 0.2, 0.2 ), ( 0.8, 0.2 ), ( 0.2, 0.5 ), ( 0.8, 0.5 ), ( 0.2, 0.8 ), ( 0.8, 0.8 ) ]
        ]


type alias Model =
    { diePositions : Array Coordinates
    , dieFace : Coordinates
    , dieFaceB : Coordinates
    , amtRolls : Int
    }


type alias Coordinates =
    List ( Float, Float )


type Msg
    = Roll
    | NewFace Int
    | NewFaceB Int


dieRender selCoordinates a b rectW rectH =
    let
        circleMaker coordinate =
            let
                ( x, y ) =
                    coordinate
            in
                circle [ cx (px (a + (rectW * x))), cy (px (b + (rectH * y))), r "8" ] []
    in
        List.map circleMaker selCoordinates


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( { model | amtRolls = model.amtRolls + 1 }, Random.generate NewFace (Random.int 1 6) )

        NewFace int ->
            case Array.get int model.diePositions of
                Just coordinates ->
                    ( { model
                        | dieFace = coordinates
                      }
                    , Random.generate NewFaceB (Random.int 1 6)
                    )

                Nothing ->
                    model ! []

        NewFaceB int ->
            case Array.get int model.diePositions of
                Just coordinates ->
                    ({ model
                        | dieFaceB = coordinates
                     }
                    )
                        ! []

                Nothing ->
                    model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    let
        viewWidth =
            600

        viewHeight =
            100

        rectW =
            100

        rectH =
            100

        c =
            half rectW

        center =
            (2 * rectW) + c

        a =
            half (viewWidth - center)

        a2 =
            a + rectW + c

        b =
            60

        rectOneX =
            px a

        rectTwoX =
            px a2

        rectOneY =
            px b

        rectoTwoY =
            px b
    in
        div []
            [ svg [ width "100%", height "400", viewBox (String.join " " [ "0", "40", (toString viewWidth), (toString viewHeight) ]) ]
                ((dieRender (model.dieFace) a b rectW rectH)
                    ++ (dieRender (model.dieFaceB) a2 b rectW rectH)
                    ++ [ rect
                            [ x rectOneX
                            , y rectOneY
                            , width (toString rectW)
                            , height (toString rectH)
                            , rx (toString (12))
                            , ry (toString (15))
                            , fill "none"
                            , strokeWidth "1px"
                            , stroke "#666"
                            ]
                            []
                       , rect
                            [ x rectTwoX
                            , y rectOneY
                            , width (toString rectW)
                            , height (toString rectH)
                            , rx (toString (12))
                            , ry (toString (15))
                            , fill "none"
                            , strokeWidth "1px"
                            , stroke "#666"
                            ]
                            []
                       ]
                )
            , div []
                [ button
                    [ type_ "text"
                    , onClick (Roll)
                    , HtmlAttrs.style
                        [ ( "max-width", "30%" )
                        , ( "margin-left", "35%" )
                        , ( "margin-right", "35%" )
                        , ( "margin-top", "4%" )
                        , ( "padding", "1% 10% 1% 10%" )
                        , ( "border-radius", "12px" )
                        , ( "border", "3px solid" )
                        , ( "font-size", "40px" )
                        , ( "letter-spacing", "3px" )
                        , ( "text-transform", "uppercase" )
                        , ( "font-weight", "700" )
                        , ( "background-color", "#fff" )
                        ]
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
