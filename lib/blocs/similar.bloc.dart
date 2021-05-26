import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jungledevs/models/genre_model.dart';
import 'package:jungledevs/models/movie_model.dart';

class SimilarBloc {
  List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;
  final _dioMovies =
      Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/movie/"));
  final _dioGenre =
      Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/genre/movie/"));
  final String _apiKey = "e7b9e0f1c75bcfab8b5f93b396cae744";

  final _movieController = StreamController<List<MovieModel>>();

  Stream<List<MovieModel>> get myStream => _movieController.stream;

  Future<void> getSimilarMovies(int id) async {
    var result =
        await _dioMovies.get("$id/similar?api_key=$_apiKey&language=en-US");

    for (var movieData in result.data["results"]) {
      MovieModel movie = MovieModel(
        title: movieData["title"],
        overview: movieData["overview"],
        id: movieData["id"],
        genreIds: movieData["genre_ids"],
        adult: movieData["adult"],
        backdropPath: movieData["backdrop_path"],
        posterPath: movieData["poster_path"],
        releaseDate: movieData["release_date"],
        popularity: movieData["popularity"],
        voteAverage: movieData["vote_average"].toDouble(),
        voteCount: movieData["vote_count"],
      );
      _movies.add(movie);
    }
    _movieController.sink.add(_movies);
  }

  closeStream() {
    _movieController.close();
  }

  Future<List<GenreModel>> getGenres() async {
    List<GenreModel> genres = [];
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
        await _dioMovies.get("top_rated?api_key=$_apiKey&language=en-US");

    for (var movieData in result.data["results"]) {
      MovieModel movie = MovieModel(
        title: movieData["title"],
        overview: movieData["overview"],
        id: movieData["id"],
        genreIds: movieData["genre_ids"],
        adult: movieData["adult"],
        backdropPath: movieData["backdrop_path"],
        posterPath: movieData["poster_path"],
        releaseDate: movieData["release_date"],
        popularity: movieData["popularity"],
        voteAverage: movieData["vote_average"].toDouble(),
        voteCount: movieData["vote_count"],
      );
      movies.add(movie);
    }
    return movies;
  }

  String getGenreMovie(int index, List<GenreModel> genresPar) {
    MovieModel movie = _movies[index];
    String genresNames = "";

    for (var genreId in movie.genreIds) {
      genresNames +=
          genresPar.where((element) => element.id == genreId).toList()[0].name;
      if (genreId != movie.genreIds.last) {
        genresNames += " / ";
      }
    }

    return genresNames;
  }

  String getReleaseYear(int index) {
    MovieModel movie = _movies[index];
    String releaseYear = movie.releaseDate[0] +
        movie.releaseDate[1] +
        movie.releaseDate[2] +
        movie.releaseDate[3];

    return releaseYear;
  }

  int getStars(int index) {
    MovieModel movie = _movies[index];
    int stars = movie.voteAverage ~/ 2;
    return stars;
  }
}
