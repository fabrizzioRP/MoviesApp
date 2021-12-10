import 'dart:convert';

import 'models.dart';

class Search {
  Search({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  int page, totalPages, totalResults;
  List<Movies> results;

  factory Search.fromJson(String str) => Search.fromMap(json.decode(str));

  factory Search.fromMap(Map<String, dynamic> json) => Search(
        page: json["page"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        results:
            List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
      );
}
