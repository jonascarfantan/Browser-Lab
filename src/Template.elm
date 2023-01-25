module Template exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)

-- COLOR
bgPrim : Color
bgPrim = rgb255 92 99 118
bgSec : Color
bgSec = rgb255 209 195 223
fontPrim : Color
fontPrim = rgb255 255 255 255

fontSec : Color
fontSec = rgb255 38 38 38

-- PUBLIC

render : Html msg
render =
    layout [] <|
        column
            [ height fill, width fill ]
            [ header, body, footer ]

-- INTERNAL

-- TEMPLATE PART 3 ROWS

-- 1ST ROW HEADER
header : Element msg
header =
    row 
        [ height <| fillPortion 1
        , width fill
        , Background.color <| bgPrim
        , Font.color <| fontPrim
        ] [ text "BrowserLab"]

-- 2ND ROW BODY
body : Element msg
body =
    row
        [ height <| fillPortion 10
        , width fill
        ] [ asideNav, bodyContent ]

asideNav : Element msg
asideNav = 
    column
        [ height fill
        , width <| fillPortion 1
        , Background.color <| bgPrim
        , Font.color <| fontPrim
        ] [
            text "Menu"
        ]

bodyContent : Element msg
bodyContent =
    column
        [ height fill
        , width <| fillPortion 5
        , Background.color <| bgSec
        , Font.color <| fontSec 
        ] [
            text "Body content"
        ]

-- 3RD ROW FOOTER
footer : Element msg
footer =
    row
        [ height <| fillPortion 1
        , width fill
        , Background.color <| bgPrim
        , Font.color <| fontPrim
        ] [ text "Footer" ]