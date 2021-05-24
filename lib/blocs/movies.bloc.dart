import 'package:dio/dio.dart';

class GenreModel {
  final int id;
  final String name;

  GenreModel({this.id, this.name});
}

class MovieModel {
  final String title;
  final String overview;
  final int id;
  final List genreIds;
  final bool adult;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;
  final double popularity;
  final double voteAverage;
  final int voteCount;

  MovieModel(
      {this.title,
      this.overview,
      this.id,
      this.genreIds,
      this.adult,
      this.backdropPath,
      this.posterPath,
      this.releaseDate,
      this.popularity,
      this.voteAverage,
      this.voteCount});
}

class MoviesBloc {
  List<MovieModel> movies = [];
  List<GenreModel> genres = [];

  final _dioMovies =
      Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/movie/"));
  final _dioGenre =
      Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/genre/movie/"));
  final String _apiKey = "e7b9e0f1c75bcfab8b5f93b396cae744";

  void setMovies(value) => movies = value;

  Future<List<GenreModel>> getGenres() async {
    var result =
        await _dioGenre.get("list?api_key=$_apiKey&language=en-US&page=1");
    for (var genreData in result.data["genres"]) {
      GenreModel genre = GenreModel(
        name: genreData["name"],
        id: genreData["id"],
      );
      genres.add(genre);
    }

    return genres;
  }

  Future<List<MovieModel>> getMovies() async {
    var result =
        await _dioMovies.get("popular?api_key=$_apiKey&language=en-US");

    for (var movieData in result.data["results"]) {
      MovieModel movie = MovieModel(
        title: movieData["title"],
        overview: movieData["overview"],
        id: movieData["id"],
        genreIds: movieData["genre_ids"],
        adult: movieData["adult"],
        backdropPath: movieData["backdrop_path"],
        posterPath: movieData["poster_path"],
        releaseDate: movieData["releaseDate"],
        popularity: movieData["popularity"],
        voteAverage: movieData["vote_average"],
        voteCount: movieData["vote_count"],
      );
      movies.add(movie);
    }
    print(movies);
    return movies;
  }

  String getGenreMovie(int id) {
    MovieModel movie = movies.where((element) => element.id == id).toList()[0];
    String genresNames = "";

    for (var genreId in movie.genreIds) {
      genresNames +=
          genres.where((element) => element.id == genreId).toList()[0].name;
      if (genreId != movie.genreIds.last) {
        genresNames += " / ";
      }
    }

    return genresNames;
  }
}
