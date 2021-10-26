module Page.About exposing (..)

import Html exposing (Html, div, img)
import Html.Attributes exposing (..)

view : Html msg
view =
    div [ style "text-align" "center" ] 
        [ img [ src "/assets/images/work-in-progress.gif" ] [] ]