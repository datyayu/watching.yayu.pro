module API exposing (getAnimeList)

import Http
import Json.Decode as Decode
import Model exposing (AnimeSeries)


-- CONSTANTS


apiEndpoint : String
apiEndpoint =
    "https://rowanmsoq3.execute-api.us-east-1.amazonaws.com/dev/animelist?user=aoitsu"



-- HTTP REQUESTS


getAnimeList : Http.Request (List AnimeSeries)
getAnimeList =
    Http.get apiEndpoint decodeAnimeList



-- DECODERS


decodeAnimeList : Decode.Decoder (List AnimeSeries)
decodeAnimeList =
    Decode.list decodeAnimeSeries


decodeAnimeSeries : Decode.Decoder AnimeSeries
decodeAnimeSeries =
    Decode.map6 AnimeSeries
        (Decode.field "id" Decode.string)
        (Decode.field "title" Decode.string)
        (Decode.field "image" Decode.string)
        (Decode.field "isAiring" Decode.bool)
        (Decode.field "totalEpisodes" Decode.int)
        (Decode.field "watchedEpisodes" Decode.int)
