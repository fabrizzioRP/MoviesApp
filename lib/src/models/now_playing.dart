import 'dart:convert';

import 'models.dart';

class NowPlaying {
  Dates dates;
  int page;
  int totalPages;
  int totalResults;
  List<Movies> results;

  NowPlaying({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlaying.fromJson(String str) =>
      NowPlaying.fromMap(json.decode(str));

  factory NowPlaying.fromMap(Map<String, dynamic> json) => NowPlaying(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        results:
            List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
      );
}

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}
