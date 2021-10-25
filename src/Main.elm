module Main exposing (main)

import Bootstrap.CDN as CND
import Bootstrap.Button as Button
import Bootstrap.Grid as Grid
import Bootstrap.Form.Input as Input
import Bootstrap.Navbar as Navbar
import Browser.Navigation as Navigation
import Bootstrap.Utilities.Spacing as Spacing
import Browser exposing (UrlRequest)
import Color exposing (..)
import Html exposing (Html, div, text, h1, h2)
import Html.Attributes exposing (..)
import Json.Decode as Decode
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)

-- import Route exposing (decode, routeParser)
import Page.Home as HomePage
import Page.About as AboutPage
import Page.Explore as ExplorePage
import Page.NotFound as NotFoundPage

type alias Model =
    { navKey : Navigation.Key
    , page : Page
    , navState : Navbar.State
    }

type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State


type Page 
    = Home
    | About
    | Explore
    | NotFound


main : Program Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        }


init : Decode.Value -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate url { navKey = key, navState = navState, page = Home }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )


view : Model -> Browser.Document Msg
view model =
    { title = "Elm Bootstrap"
    , body =
        [ div []
              [ CND.stylesheet
              , menu model 
              , mainContent model
              ]
        ]
    }

mainContent : Model -> Html Msg
mainContent model =
        case model.page of
            Home ->
                HomePage.view

            About ->
                AboutPage.view

            Explore ->
                ExplorePage.view

            NotFound ->
                NotFoundPage.view


menu : Model -> Html Msg
menu model =
    Navbar.config NavMsg
        |> Navbar.withAnimation
        |> Navbar.lightCustom Color.white
        |> Navbar.brand [ href "#" ] [ text "FLOW" ]
        |> Navbar.items
            [ Navbar.itemLink [ href "#about" ] [ text "ABOUT" ]
            , Navbar.itemLink [ href "#explore" ] [ text "EXPLORE" ]
            ]
        |> Navbar.view model.navState

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink req ->
             case req of
                 Browser.Internal url ->
                     ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                 Browser.External href ->
                     ( model, Navigation.load href )

        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ( { model | navState = state }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg


urlUpdate : Url -> Model -> ( Model, Cmd msg )
urlUpdate url model =
    case decode url of
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )

        Just route ->
            ( { model | page = route }, Cmd.none )

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