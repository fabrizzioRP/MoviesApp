import 'dart:convert';

class VideosMovies {
  int id;
  List<Result> results;

  VideosMovies(this.id, this.results);

  factory VideosMovies.fromJson(String str) =>
      VideosMovies.fromMap(json.decode(str));

  factory VideosMovies.fromMap(Map<String, dynamic> json) => VideosMovies(
      json["id"],
      List<Result>.from(json["results"].map((x) => Result.fromMap(x))));
}

class Result {
  Result(
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  );

  String iso6391;
  String iso31661;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  String publishedAt;
  String id;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        json["iso_639_1"],
        json["iso_3166_1"],
        json["name"],
        json["key"],
        json["site"],
        json["size"],
        json["type"],
        json["official"],
        json["published_at"],
        json["id"],
      );
}
