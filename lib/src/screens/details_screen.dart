// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
//
import 'package:movies_app/src/themes/theme.dart';
import 'package:movies_app/src/models/models.dart';
import 'package:movies_app/src/widgets/widgets.dart';
import 'package:movies_app/src/widgets/video_movie.dart';

class DetailsMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movies;
    // final String? videoURL = dataProvider[movie.id]![0].key;
    // print(dataProvider[movie.id]![0].key);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _CustomAppBarDetails(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterMoviesDetails(movie: movie),
                _OverViewMovie(movie: movie),
                SizedBox(height: 30),
                VideoMoviePlayer(movieId: movie.id),
                SizedBox(height: 30),
                CreditsMovie(movieId: movie.id),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBarDetails extends StatelessWidget {
  final Movies movie;
  const _CustomAppBarDetails({required this.movie});

  @override
  Widget build(BuildContext context) => SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        expandedHeight: 300,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'), // cambiar png
            image: NetworkImage(movie.fullBackdropImg),
            fit: BoxFit.fill,
            fadeInDuration: Duration(seconds: 2),
            fadeInCurve: Curves.easeIn,
          ),
          title: Container(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            alignment: Alignment.bottomCenter,
            child: Text(movie.title,
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ),
        ),
      );
}

class _PosterMoviesDetails extends StatelessWidget {
  final Movies movie;
  const _PosterMoviesDetails({required this.movie});
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 20, bottom: 10),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 110,
            height: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.fullPosterImg,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, loadingProgress) =>
                      (loadingProgress == null)
                          ? child
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 190),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3),
                SizedBox(height: 5),
                Text(movie.originalTitle,
                    style: textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.stars, size: 15, color: Colors.yellow[700]),
                    SizedBox(width: 5),
                    Text(movie.voteAverage.toString(),
                        style: textTheme.caption),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverViewMovie extends StatelessWidget {
  final Movies movie;
  const _OverViewMovie({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
