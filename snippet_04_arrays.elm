module Main exposing (..)

import Html exposing (..)
import Array exposing (..)


insectsIntoYouDecide : (insect -> otherInsect) -> List insect -> List otherInsect
insectsIntoYouDecide insectTransformer insects =
    List.map insectTransformer insects


insectsIntoWasp : List String -> List String
insectsIntoWasp someBees =
    List.map (\a -> "wasp") someBees


wasps : List String
wasps =
    [ "wasp", "wasp", "wasp" ]


bees : List String
bees =
    [ "bee", "bee", "bee" ]


main =
    div []
        [ text <| toString bees
        , text " become"
        , h4 [] [ text <| toString <| (insectsIntoWasp bees) ]
        ]
