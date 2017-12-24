import Html exposing (..)

-- MODEL
-- the alias is a convenient nickname for all the shit the model holds

type alias Model = { ... }


-- UPDATE

type Msg = Reset | ...

update : Msg -> Model -> Model
update msg model = 
  case msg of 
    Reset -> ... -- update in some manner
    
    OtherAction -> ... -- another update

-- VIEW

view: Model -> Html Msg
