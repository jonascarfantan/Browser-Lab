module Router exposing (Route(..), toRoute)

import Url.Parser as Parser exposing (Parser, (</>), top, oneOf, s, string)
import Browser.Navigation as Navigation
import Url exposing (Url)
import Html exposing (Attribute)
import Html.Attributes as Attr

-- ROUTING
type Route
    = Home
    | Algorithm String
    | NotFound

routeParser : Parser (Route -> a) a
routeParser =
    oneOf
    [ Parser.map Home top
    , Parser.map Algorithm (s "algorithm" </> string)
    ]

toRoute : Url -> Route
toRoute url =
    url
    |> Parser.parse routeParser
    |> Maybe.withDefault NotFound
    

