// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
import 'package:movies_app/src/themes/theme.dart';
import 'package:movies_app/src/models/models.dart';
import 'package:movies_app/src/services/services.dart';

class VideoMoviePlayer extends StatelessWidget {
  final int movieId;

  const VideoMoviePlayer({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesData>(context, listen: false);
    return FutureBuilder(
        future: moviesProvider.getVideoMovies(movieId),
        builder: (_, AsyncSnapshot<List<Result>> snapshot) {
          if (!snapshot.hasData) return waitForData;

          final results = snapshot.data;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: double.infinity,
            height: 300,
            child: VideoMoviePlayer1(
                youtubeURL:
                    'https://www.youtube.com/watch?v=${results![0].key}'),
          );
        });
  }
}

class VideoMoviePlayer1 extends StatefulWidget {
  final String? youtubeURL;

  const VideoMoviePlayer1({required this.youtubeURL});

  @override
  _VideoMoviePlayerState createState() => _VideoMoviePlayerState();
}

class _VideoMoviePlayerState extends State<VideoMoviePlayer1> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayerController.convertUrlToId(widget.youtubeURL!)!,
      params: const YoutubePlayerParams(
        loop: true,
        color: 'transparent',
        desktopMode: true,
        strictRelatedVideos: true,
        showFullscreenButton: !kIsWeb,
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: YoutubePlayerIFrame(
        controller: _controller,
      ),
    );
  }
}
