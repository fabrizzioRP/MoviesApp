// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_is_empty, sized_box_for_whitespace, avoid_print, unused_field, unnecessary_new
import 'package:flutter/material.dart';
//
import 'package:movies_app/src/models/models.dart';

class PopularMoviesCategories extends StatefulWidget {
  final String? titulo;
  final List<Movies> moviesp;
  final Function onNextPage;

  const PopularMoviesCategories(
      {required this.moviesp, required this.titulo, required this.onNextPage});

  @override
  State<PopularMoviesCategories> createState() =>
      _PopularMoviesCategoriesState();
}

class _PopularMoviesCategoriesState extends State<PopularMoviesCategories> {
  final ScrollController scrollController = new ScrollController();

  getNewPopularMovies() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        widget.onNextPage();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getNewPopularMovies();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.titulo!,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: widget.moviesp.length,
            itemBuilder: (_, i) {
              final movie = widget.moviesp[i];
              movie.heroId = '$i-${widget.moviesp[i].id}';
              return _PopularMovieCustoms(movie: movie, size: size);
            },
          ),
        ),
      ],
    );
  }
}

class _PopularMovieCustoms extends StatelessWidget {
  final Movies movie;
  final Size size;

  const _PopularMovieCustoms({required this.movie, required this.size});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, 'detailsMovies', arguments: movie),
        // print(' hero id peli popular : ${movie.heroId} - ${movie.title}'),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Container(
            width: size.width * 0.35,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );
}
