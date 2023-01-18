module Route exposing (..)

import Url.Parser as Parser exposing (Parser, (</>), int, top, map, oneOf, s, string)
import Html exposing (a)

-- ROUTING
type Route
    = Home String
    | Algo String

routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map Algo (s "algo" </> string)
        ]

-- PUBLIC 