Snippet 06 - Destructuring
============

[Ellie](https://ellie-app.com/rrKy493KFa1/0)

```elm
module Main exposing (..)

import Html exposing (..)


type MyThing
    = AString String
    | AnInt Int
    | ATuple ( String, Int )


unionFn : MyThing -> String
unionFn thing =
    case thing of
        AString s ->
            "It was a string: " ++ s

        AnInt i ->
            "It was an integer: " ++ toString i

        ATuple ( t_a, t_b ) ->
            "It was a tuple to unpack with values: " ++ t_a ++ " " ++ toString t_b


main =
    div []
        [ text <| unionFn (AString "baby")
        , br [] []
        , text <| unionFn (AnInt 30)
        , br [] []
        , text <| unionFn (ATuple ( "baby", 30 ))
        ]
```
