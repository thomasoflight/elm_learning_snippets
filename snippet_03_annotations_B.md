Snippet 03 B - Annotations, Another Helping
==============

![Ellie](https://ellie-app.com/b945x2L3da1/1)

```elm
module Main exposing (..)

import Html exposing (..)


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
     [text <| toString bees
    , text " become"
    , h4 [] [text <| toString <| (insectsIntoWasp bees)]
    ]
```
