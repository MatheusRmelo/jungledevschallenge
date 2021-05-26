class MovieModel {
  final String title;
  final String overview;
  final int id;
  final List genreIds;
  final List genres;
  final bool adult;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final int runtime;

  MovieModel(
      {this.title,
      this.overview,
      this.id,
      this.genreIds,
      this.genres,
      this.adult,
      this.backdropPath,
      this.posterPath,
      this.releaseDate,
      this.popularity,
      this.voteAverage,
      this.voteCount,
      this.runtime});
}
