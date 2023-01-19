module Route exposing (..)

import Url.Parser as Parser exposing (Parser, (</>), int, top, map, oneOf, s, string)
import Html exposing (a)

-- ROUTING
type Route
    = Home
    | Algos String


urlParser : Parser (Route -> a) a
urlParser =
    oneOf
        [ map Home <| top
        , map Algos <| s "algos" </> string
        ]

-- PUBLIC 