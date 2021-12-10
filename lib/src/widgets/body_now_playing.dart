// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, prefer_is_empty, avoid_print
import 'package:flutter/material.dart';
//
import 'package:movies_app/src/themes/theme.dart';
import 'package:movies_app/src/models/models.dart';

class BodyNowPlaying extends StatelessWidget {
  final PageController controller;
  final List<Movies> movies;

  const BodyNowPlaying({required this.controller, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      // color: Colors.yellow,
      child: (movies.length == 0)
          ? waiting
          : PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: controller,
              itemCount: movies.length, // aca va la lista de pelis
              itemBuilder: (_, i) {
                final movie = movies[i];
                movie.heroId = 'swiper-${movie.id}';
                return _BodyNowPlayingDetails(movie: movie);
              },
            ),
    );
  }
}

class _BodyNowPlayingDetails extends StatelessWidget {
  final Movies movie;
  const _BodyNowPlayingDetails({required this.movie});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, 'detailsMovies', arguments: movie),
        // print(' hero id de peli : ${movie.heroId} - ${movie.title}'),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      );
}
