import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jungledevs/models/movie_model.dart';

class MovieBloc {
  MovieModel _movie = MovieModel();
  MovieModel get movie => _movie;
  final _dioMovie =
      Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/movie/"));
  final _dioGenre =
      Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/genre/movie/"));
  final String _apiKey = "e7b9e0f1c75bcfab8b5f93b396cae744";

  final _movieController = StreamController<MovieModel>();

  Stream<MovieModel> get myStream => _movieController.stream;

  Future<void> getMovie(int id) async {
    var result = await _dioMovie.get("$id?api_key=$_apiKey&language=en-US");
    var movieData = result.data;
    _movie = MovieModel(
        title: movieData["title"],
        overview: movieData["overview"],
        id: movieData["id"],
        genreIds: movieData["genre_ids"],
        genres: movieData["genres"],
        adult: movieData["adult"],
        backdropPath: movieData["backdrop_path"],
        posterPath: movieData["poster_path"],
        releaseDate: movieData["release_date"],
        popularity: movieData["popularity"],
        voteAverage: movieData["vote_average"].toDouble(),
        voteCount: movieData["vote_count"],
        runtime: movieData["runtime"]);
    _movieController.sink.add(_movie);
  }

  closeStream() {
    _movieController.close();
  }

  String getGenreMovie() {
    String genresNames = "";

    for (var genre in _movie.genres) {
      genresNames += genre["name"];
      if (genre != _movie.genres.last) {
        genresNames += " / ";
      }
    }

    return genresNames;
  }

  String getReleaseYear() {
    String releaseYear = _movie.releaseDate[0] +
        _movie.releaseDate[1] +
        _movie.releaseDate[2] +
        _movie.releaseDate[3];

    return releaseYear;
  }

  String getTime() {
    Duration d = Duration(minutes: _movie.runtime);
    String runtime = '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    return runtime;
  }

  int getStars() {
    int stars = _movie.voteAverage ~/ 2;
    return stars;
  }
}
