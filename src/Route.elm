module Route exposing (..)

import Bootstrap.Navbar as Navbar
import Bootstrap.Modal as Modal
import Browser.Navigation as Navigation
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)

type Page 
    = Home
    | About
    | Explore
    | NotFound

decode : Url -> Maybe Page
decode url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
    |> UrlParser.parse routeParser


routeParser : Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map About (s "about")
        , UrlParser.map Explore (s "explore")
        ]
