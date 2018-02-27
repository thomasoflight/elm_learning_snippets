module Main exposing (..)

import Html exposing (Html, program)
import Svg exposing (circle, line, svg)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


main =
    view


view =
    svg [ viewBox "-10 -10 100 100", width "600px" ]
        [ circle [ cx "15", cy "15", r "5", fill "#0B79CE" ] []
        , circle [ cx "45", cy "15", r "5", fill "#0B79CE" ] []
        , circle [ cx "15", cy "45", r "5", fill "#0B79CE" ] []
        , circle [ cx "45", cy "45", r "5", fill "#0B79CE" ] []
        , circle [ cx "15", cy "75", r "5", fill "#0B79CE" ] []
        , circle [ cx "45", cy "75", r "5", fill "#0B79CE" ] []
        ]
