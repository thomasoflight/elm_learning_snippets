Snippet 10 - Json Decoders!
============

```elm
module Main exposing (..)

import Html exposing (..)
import Json.Decode exposing (..)


str_result =
    decodeString string "\"mouse\""


int_result =
    decodeString int "2001"


flt_result =
    decodeString float "44.456"


list_result =
    decodeString (list string) "[\"inni\", \"meeni\", \"mynni\"]"


singleFieldObj =
    let
        decoder =
            field "hats" string
    in
        decodeString decoder "{\"hats\": \"she owns many hats\"}"


twoFieldObj =
    let
        decoder =
            map2 (\a b -> ( a, b ))
                (field "hat A" string)
                (field "hat B" string)

        sampleObj =
            "{\"hat A\": \"simple hat\", \"hat B\": \"white hat with feather\"}"
    in
        decodeString decoder sampleObj


multiFieldObj =
    let
        decoder =
            map3 (\c d e -> { c = c, d = d, e = e })
                (field "feather" string)
                (field "leather" string)
                (field "knitted" string)

        sampleObj =
            "{\"feather\": \"with feathers!\", \"leather\": \"soft leather!\", \"knitted\": \"what fine yarn!\"}"
    in
        decodeString decoder sampleObj


main =
    div []
        [ h3 [] [ text "basic decoders" ]
        , p [] [ text (toString str_result) ]
        , p [] [ text (toString int_result) ]
        , p [] [ text (toString flt_result) ]
        , p [] [ text (toString list_result) ]
        , h3 [] [ text "object decoders" ]
        , p [] [ text (toString singleFieldObj) ]
        , p [] [ text (toString twoFieldObj) ]
        , p [] [ text (toString multiFieldObj) ]
        ]
```

Snippet 10B - Json Decoders w/ NoRedInk Pipeline !
============
```elm
module Main exposing (..)

import Html exposing (..)
import Json.Decode exposing (string, int, list, Decoder, decodeString)
import Json.Decode.Pipeline exposing (decode, required, optional)


{- This one is a little bit trickier -}


( anotherMultiFieldObj, anotherMultiOptional ) =
    let
        buildObj a b c =
            { a = a, b = b, c = c }

        pipelineDecoder =
            decode buildObj
                |> required "feather" string
                |> required "leather" string
                |> optional "knitted" string "(default value)"

        sampleObj =
            "{\"feather\": \"with feathers!\", \"leather\": \"soft leather!\", \"knitted\": \"what fine yarn!\"}"

        sampleObjOptional =
            "{\"feather\": \"with feathers!\", \"leather\": \"soft leather!\"}"
    in
        ( decodeString pipelineDecoder sampleObj, decodeString pipelineDecoder sampleObjOptional )


main =
    div []
        [ h3 [] [ text "pipeline" ]
        , p [] [ text "with optional field:" ]
        , li [] [ text (toString anotherMultiFieldObj) ]
        , p [] [ text "without optional field, uses default:" ]
        , li [] [ text (toString anotherMultiOptional) ]
        ]


```
