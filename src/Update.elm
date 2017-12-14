module Update exposing (Msg, init, update)

import API exposing (getAnimeList)
import Http
import Model exposing (AnimeSeries, Model, initModel)


-- UPDATE


type Msg
    = FetchAnimeList
    | FetchCompleted (Result Http.Error (List AnimeSeries))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchAnimeList ->
            ( { model
                | isLoading = True
                , hasError = False
              }
            , fetchAnimeList
            )

        FetchCompleted (Err _) ->
            ( { model
                | isLoading = False
                , hasError = True
              }
            , Cmd.none
            )

        FetchCompleted (Ok animeList) ->
            ( { model
                | animeList =
                    List.filter (\anime -> anime.watchedEpisodes /= 0) animeList
                , isLoading = False
              }
            , Cmd.none
            )



-- COMMANDS


fetchAnimeList : Cmd Msg
fetchAnimeList =
    Http.send FetchCompleted getAnimeList


init : ( Model, Cmd Msg )
init =
    ( initModel, fetchAnimeList )
