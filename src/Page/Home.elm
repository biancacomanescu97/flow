module Page.Home exposing (..)

import Html exposing (Html, div, video)
import Html.Attributes exposing (..)
import Html exposing (video)
import Json.Encode exposing (bool)

view : Html msg
view =
    div [ style "position" "absolute"
        , style "top" "0"
        , style "bottom" "0"
        , style "z-index" "-1"
        ] 
        [ video [ src "/assets/videos/Yoga.mp4"
                , attribute "autoplay" "true"
                , property "muted" (bool True)
                , property "loop" (bool True)
                , preload "none"
                , style "height" "100%" 
                , style "width" "100%"
                , style "object-fit" "cover"
                ] []
        ]