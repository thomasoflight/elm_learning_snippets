Snippet 01 - Currying
============


```elm
module Main exposing (..)

import Html exposing (..)


curries =
    [ "green", "yellow", "red" ]


addCurry spiciness str =
    str ++ " curry" ++ ", " ++ spiciness


main =
    -- text <| addCurry "green" "mild"
    text <| String.join " *** " <| List.map (addCurry "spicy") curries
```
