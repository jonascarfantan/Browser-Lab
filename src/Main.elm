module Main exposing (main)

import Url
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Dict exposing (update)

import Url.Parser as Parser exposing (Parser, (</>))
import Html exposing (a)

-- ROUTING
type Route
    = Home
    | Algos String
    | Error404 String

routeToString : Maybe Route -> String
routeToString route =
  case route of
    Just (Algos algo) -> algo
    Just Home -> "/"
    Just (Error404 badUrl) -> badUrl
    _ -> "Nothing"

urlParser : Parser (Route -> a) a
urlParser =
    Parser.oneOf
        [ Parser.map Home <| Parser.top
        , Parser.map Algos <| Parser.s "algos" </> Parser.string
        , Parser.map Error404 <| Parser.string
        ] 

-- MODEL

type alias Model =
    { navKey : Nav.Key
    , route : Maybe Route
    , url : Url.Url
    }

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { navKey = key
      , route = Parser.parse urlParser url
      , url = url
      }
    , Cmd.none)

-- UPDATE
type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of

    LinkClicked urlRequest ->

      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.navKey (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | route = Parser.parse urlParser url, url = url }
      , Cmd.none
      )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

-- VIEW

view : Model -> Browser.Document Msg
view model =
  { title = "URL Interceptor"
  , body =
      [ text "The current URL is: "
      , b [] [ text (routeToString model.route) ]
      , ul []
          [ navItem "/"
          , navItem "/algos/zebra"
          , navItem "/algos/double-linked-list-search"
          , navItem "/algos/quick-sort"
          , navItem "/algos/graph-path-finding"
          ]
      ]
  }


navItem : String -> Html msg
navItem path =
  li [] [ a [ href path ] [ text path ] ]

-- MAIN
main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }