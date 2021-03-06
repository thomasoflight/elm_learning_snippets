module Main exposing (..)

import Html exposing (..)
import Array exposing (..)


{-
   > List.map (\a -> 9) [1, 2]
   [9,9] : List number
   > mapper = List.map
   <function> : (a -> b) -> List a -> List b
   > mapper (\a -> 9) [1, 2, 4]
   [9,9,9] : List number
   > mapperNines = mapper (\a -> 9)
   <function> : List a -> List number
   > mapperNines [2, 5, 6]
   [9,9,9] : List number
   I want to demonstrate that Currying is pieces going together
-}


beesIntoWasps someBees =
    List.map (\a -> "wasp") someBees


wasps : List String
wasps =
    [ "wasp", "wasp", "wasp" ]


bees : List String
bees =
    [ "bee", "bee", "bee" ]


main : Html msg
main =
    text "hi"
