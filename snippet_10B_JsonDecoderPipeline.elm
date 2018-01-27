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
