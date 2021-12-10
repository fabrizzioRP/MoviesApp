import 'dart:convert';

class Movies {
  int voteCount, id;
  double voteAverage, popularity;
  bool adult, video;
  String originalLanguage, originalTitle, title, overview;
  String? backdropPath, releaseDate, posterPath;
  List<int> genreIds;

  String? heroId;

  Movies({
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    required this.adult,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  get fullPosterImg => (posterPath != null)
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : 'https://i.stack.imgur.com/GNhxO.png';

  get fullBackdropImg => (backdropPath != null)
      ? 'https://image.tmdb.org/t/p/w500$backdropPath'
      : 'https://i.stack.imgur.com/GNhxO.png';

  factory Movies.fromJson(String str) => Movies.fromMap(json.decode(str));

  factory Movies.fromMap(Map<String, dynamic> json) => Movies(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      );
}
