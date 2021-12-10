import 'dart:convert';
//
import 'package:movies_app/src/models/models.dart';

class PopularMovies {
  int page, totalPages, totalResults;
  List<Movies> results;

  PopularMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMovies.fromJson(String str) =>
      PopularMovies.fromMap(json.decode(str));

  factory PopularMovies.fromMap(Map<String, dynamic> json) => PopularMovies(
        page: json["page"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        results:
            List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
      );
}
