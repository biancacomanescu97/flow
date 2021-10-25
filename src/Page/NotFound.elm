module Page.NotFound exposing (..)

import Html exposing (Html, text, h1, div)
import Html.Attributes exposing (..)

view : Html msg
view =
    div [ style "text-align" "center" ] 
        [ h1 [] [ text "Not found" ]
        , text "Sorry couldn't find that page"
        ]