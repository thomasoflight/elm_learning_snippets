module Main exposing (..)

import Html exposing (Html, program)
import Svg exposing (circle, rect, svg)
import Svg.Attributes exposing (..)
import String


main =
    view


half int =
    int / 2


px int =
    (toString int) ++ "px"


view =
    let
        w =
            600

        rectW =
            100

        rectH =
            100

        c =
            half rectW

        center =
            (2 * rectW) + c

        a =
            half (w - center)

        a2 =
            a + rectW + c

        rectOneX =
            px a

        rectoTwoX =
            px a2

        rectOneY =
            px 75

        rectoTwoY =
            px 75
    in
        svg [ viewBox (String.join " " [ "0", "0", (toString w), (toString w) ]) ]
            [ rect
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
                [ x rectoTwoX
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
