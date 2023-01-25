module Main exposing (main)

import Url
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)

import Router
import Template

-- MODEL

type alias Model =
    { navKey : Nav.Key
    , route : Router.Route
    , url : Url.Url
    }

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { navKey = key
      , route = Router.toRoute url
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
      ( { model | route = Router.toRoute url, url = url }
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
  , body = [ Template.render ]
      
  }

elmHtml : Model -> List (Html Msg)
elmHtml model =
  [ text "The current URL is: "
  , b [] [ text (Url.toString model.url) ]
  , ul []
      [ navItem "/"
      , navItem "/algorithm/zebra"
      , navItem "/algorithm/double-linked-list-search"
      , navItem "/algorithm/quick-sort"
      , navItem "/algorithm/graph-path-finding"
      ]
  ]
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