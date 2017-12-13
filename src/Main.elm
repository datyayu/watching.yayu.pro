module Main exposing (..)

import Html exposing (Html, div, text)
import Model exposing (Model)
import Update exposing (Msg, init, update)
import View exposing (view)


---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
