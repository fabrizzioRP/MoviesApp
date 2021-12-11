// ignore_for_file: avoid_print, unused_local_variable, prefer_const_constructors, unnecessary_new
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/helpers/debouncer.dart';
//
import 'package:movies_app/src/models/models.dart';

class MoviesData extends ChangeNotifier {
  final _apiKey = '232564939f42a9b8c9f3c315c6c02df0';
  final _baseUrl = 'api.themoviedb.org';
  final _language = 'es-ES';

  List<Movies> onDisplayMovies = [];

  List<Movies> onPopularMovies = [];

  Map<int, List<Cast>> creditMovies = {};

  Map<int, List<Result>> videosMovies = {};

  int _popularPage = 0;

  MoviesData() {
    // print('Movies Provider Inicializado');
    getOnDisplayMovies();
    getOnPopularMovies();
  }

  _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlaying.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getOnPopularMovies() async {
    _popularPage++;

    if (_popularPage <= 3) {
      final jsonData = await _getJsonData('3/movie/popular', _popularPage);
      final popularResponse = PopularMovies.fromJson(jsonData);

      onPopularMovies = [...onPopularMovies, ...popularResponse.results];
      notifyListeners();
    }
  }

  Future<List<Cast>> getCreditMovies(int idMovie) async {
    if (creditMovies.containsKey(idMovie)) return creditMovies[idMovie]!;

    final jsonData = await _getJsonData('3/movie/$idMovie/credits');
    final creditResponse = CreditResponse.fromJson(jsonData);
    creditMovies[idMovie] = creditResponse.cast;
    return creditResponse.cast;
  }

  Future<List<Result>> getVideoMovies(int idMovie) async {
    if (videosMovies.containsKey(idMovie)) return videosMovies[idMovie]!;

    final jsonData = await _getJsonData('3/movie/$idMovie/videos');
    final videosResponse = VideosMovies.fromJson(jsonData);

    if (videosResponse.results.length == 2) {
      videosResponse.results.removeAt(1);
    }

    videosMovies[idMovie] = videosResponse.results;
    return videosResponse.results;
  }

  // Stream
  final debouncer = new Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movies>> _suggestionsStreamcontroller =
      StreamController.broadcast();

  Stream<List<Movies>> get getStream => _suggestionsStreamcontroller.stream;

  void closeStream() => _suggestionsStreamcontroller.close();

  Future<List<Movies>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = Search.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchterm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestionsStreamcontroller.add(results);
    };

    final timer = Timer.periodic(
        Duration(milliseconds: 300), (_) => debouncer.value = searchterm);

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
