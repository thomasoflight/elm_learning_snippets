module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Svg exposing (circle, rect, svg)
import Svg.Attributes exposing (..)
import Random exposing (..)
import String
import Array


init : ( Model, Cmd Msg )
init =
    ( Model allCoordinates.a allCoordinates.a 0, Cmd.none )


half int =
    int / 2


px int =
    (toString int) ++ "px"


allCoordinates =
    { a = [ ( 0.5, 0.5 ) ]
    , b = [ ( 0.2, 0.2 ), ( 0.8, 0.8 ) ]
    , c = [ ( 0.5, 0.2 ), ( 0.5, 0.5 ), ( 0.5, 0.8 ) ]
    , d = [ ( 0.2, 0.2 ), ( 0.8, 0.2 ), ( 0.2, 0.8 ), ( 0.8, 0.8 ) ]
    , e = [ ( 0.2, 0.2 ), ( 0.8, 0.2 ), ( 0.2, 0.8 ), ( 0.8, 0.8 ), ( 0.5, 0.5 ) ]
    , f = [ ( 0.2, 0.2 ), ( 0.8, 0.2 ), ( 0.2, 0.5 ), ( 0.8, 0.5 ), ( 0.2, 0.8 ), ( 0.8, 0.8 ) ]
    }


type alias Model =
    { dieFace : List Tuple
    , dieFaceB : List Tuple
    , amtRolls : Int
    }


type Msg
    = Roll
    | NewFace Int
    | NewFaceB Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( { model | amtRolls = model.amtRolls + 1 }, Random.Generator NewFace (Random.int 1 6) )

        NewFace int ->
            ( { model
                | dieFace = int
                , dieFaceB = int
              }
            , Random.generate NewFaceB (Random.int 1 6)
            )

        NewFaceB int ->
            ({ model | dieFaceB = int }) ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ text "Die Face A: "
            , b [] [ text (toString model.dieFace) ]
            ]
        , p []
            [ text "Die Face B: "
            , b [] [ text (toString model.dieFaceB) ]
            ]
        , button [ onClick (Roll) ] [ text ("roll") ]
        , p [] [ text ("Amount Rolled: " ++ toString model.amtRolls) ]
        ]


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



--
-- dieRender selCoordinates a b rectW rectH =
--     let
--         circleMaker coordinate =
--             let
--                 ( x, y ) =
--                     coordinate
--             in
--                 circle [ cx (px (a + (rectW * x))), cy (px (b + (rectH * y))), r "8" ] []
--     in
--         List.map circleMaker selCoordinates
--
--
-- view =
--     let
--         viewWidth =
--             600
--
--         rectW =
--             100
--
--         rectH =
--             100
--
--         c =
--             half rectW
--
--         center =
--             (2 * rectW) + c
--
--         a =
--             half (viewWidth - center)
--
--         a2 =
--             a + rectW + c
--
--         b =
--             60
--
--         rectOneX =
--             px a
--
--         rectTwoX =
--             px a2
--
--         rectOneY =
--             px b
--
--         rectoTwoY =
--             px b
--     in
--         svg [ viewBox (String.join " " [ "0", "0", (toString viewWidth), (toString viewWidth) ]) ]
--             ((dieRender (allCoordinates.f) a b rectW rectH)
--                 ++ (dieRender (allCoordinates.a) a2 b rectW rectH)
--                 ++ [ rect
--                         [ x rectOneX
--                         , y rectOneY
--                         , width (toString rectW)
--                         , height (toString rectH)
--                         , rx (toString (12))
--                         , ry (toString (15))
--                         , fill "none"
--                         , strokeWidth "1px"
--                         , stroke "#666"
--                         ]
--                         []
--                    , rect
--                         [ x rectTwoX
--                         , y rectOneY
--                         , width (toString rectW)
--                         , height (toString rectH)
--                         , rx (toString (12))
--                         , ry (toString (15))
--                         , fill "none"
--                         , strokeWidth "1px"
--                         , stroke "#666"
--                         ]
--                         []
--                    ]
--             )
