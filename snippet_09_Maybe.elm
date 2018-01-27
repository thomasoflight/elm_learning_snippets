module Main exposing (..)

import Html exposing (..)
import List


-- the mage keeps track of the swords warriors use by casting spells
-- the mage either casts hollow sword for the warrior or it casts Just


type alias Sword =
    String


hollowSword =
    Nothing


type alias Warrior =
    { name : String
    , weapon : Maybe Sword
    }


fireWarrior =
    Warrior "John" (Just "Fire Sword")


iceWarrior =
    Warrior "Katrina" Nothing



-- hollow sword


lightWarrior =
    Warrior "Kieran" (Just "Light Sword")


weaponOfDestiny : Warrior -> Sword
weaponOfDestiny warrior =
    case warrior.weapon of
        Nothing ->
            "This warrior bears the hollow sword"

        Just weapon ->
            --revealedSwords = List.filter (\a -> a == destinySword) Just item
            "This warrior consults the `Mage of Maybe` and now holds: " ++ weapon


main =
    text (weaponOfDestiny iceWarrior)
