Snippet 01 - Currying
============

![Ellie](https://ellie-app.com/d9NxJPPr7a1/1)

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
