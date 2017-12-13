module View exposing (view)

import Css exposing (backgroundImage, color, hex, url)
import Html as UnstyledHtml
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, src)
import Model exposing (AnimeSeries, Model)
import Update exposing (Msg)


view : Model -> UnstyledHtml.Html Msg
view model =
    toUnstyled <|
        div [ class "container" ]
            [ title
            , content model
            ]


title : Html Msg
title =
    h1 [ class "title" ]
        [ text "YayuP's Watching List" ]


content : Model -> Html Msg
content model =
    if model.hasError then
        errorMessage
    else if model.isLoading then
        loadingMessage
    else
        animeList model.animeList



-- ERRORS


errorMessage : Html Msg
errorMessage =
    h2 [ class "error-message" ]
        [ text "Unable to fetch the list. Please try again later." ]



-- LOADING


loadingMessage : Html Msg
loadingMessage =
    h2 [ class "loading-message" ]
        [ text "Fetching..." ]



-- ANIME LIST


animeList : List AnimeSeries -> Html Msg
animeList list =
    ul [ class "anime-list" ]
        (List.map animeItem list)


animeItem : AnimeSeries -> Html Msg
animeItem anime =
    li
        [ class "anime-item"
        , css [ backgroundImage (url anime.image) ]
        ]
        [ watchedCounter anime ]


watchedCounter : AnimeSeries -> Html Msg
watchedCounter anime =
    h2
        [ class "episodes-tag"
        , css
            [ color
                (hex <| baseColorForEpisodesText anime)
            ]
        ]
        [ span [ class "watched-text" ]
            [ text (currentEpisodesText anime.watchedEpisodes) ]
        , span [ class "total-text" ]
            [ text (totalEpisodesText anime.totalEpisodes) ]
        ]



-- UTILS


baseColorForEpisodesText : AnimeSeries -> String
baseColorForEpisodesText anime =
    if anime.watchedEpisodes == 0 && anime.totalEpisodes /= 0 then
        "c53434"
    else if anime.watchedEpisodes == anime.totalEpisodes then
        "4fbb46"
    else
        "fcfcfc"


currentEpisodesText : Int -> String
currentEpisodesText episodes =
    String.pad 2 '0' (toString episodes)


totalEpisodesText : Int -> String
totalEpisodesText episodes =
    if episodes == 0 then
        " / ??"
    else
        " / "
            ++ String.pad 2 '0' (toString episodes)
