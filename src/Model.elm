module Model exposing (AnimeSeries, Model, initModel)


type alias AnimeSeries =
    { id : String
    , title : String
    , image : String
    , isAiring : Bool
    , totalEpisodes : Int
    , watchedEpisodes : Int
    }


type alias Model =
    { animeList : List AnimeSeries
    , isLoading : Bool
    , hasError : Bool
    }


initModel : Model
initModel =
    { animeList = []
    , isLoading = True
    , hasError = False
    }
