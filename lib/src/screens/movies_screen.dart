// ignore_for_file: prefer_final_fields, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, prefer_is_empty, use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:movies_app/src/themes/theme.dart';
import 'package:movies_app/src/widgets/widgets.dart';
import 'package:movies_app/src/services/services.dart';

class MoviesMainScreen extends StatelessWidget {
  final ScrollController scrollController;
  PageController _pageController = PageController();

  MoviesMainScreen({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MoviesData>(context);

    // print('IMPRIMIENDO DE LA FUNCION : ${dataProvider.getVideoMovies(634649)}');
    // print('IMPRIMIENDO DEL MAPA: ${dataProvider.videosMovies[634649]![0].key}');

    return Container(
      child: CustomScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        // ignore: prefer_const_literals_to_create_immutables
        slivers: [
          _CustomSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // PELIS NUEVAS :
                BodyNowPlaying(
                    controller: _pageController,
                    movies: dataProvider.onDisplayMovies),
                // CATEGORIAS DE PELIS :
                Container(
                  width: double.infinity,
                  height: 250,
                  // color: Colors.green,
                  child: (dataProvider.onPopularMovies.length == 0)
                      ? waiting
                      : PopularMoviesCategories(
                          moviesp: dataProvider.onPopularMovies,
                          titulo: 'Recomendaciones para ti',
                          onNextPage: () => dataProvider.getOnPopularMovies(),
                        ),
                ),
                // SOLO PARA EL EFECTO
                Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black12,
      expandedHeight: 110,
      automaticallyImplyLeading: false,
      pinned: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Opacity(
          opacity: 0.6,
          child: Image.network(
              'https://cafeconmokadotcom1.files.wordpress.com/2016/01/butacas-cine.jpg'),
        ),
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.arrow_back_ios, color: primaryColor),
              ),
              SizedBox(width: 15),
              Hero(
                tag: 'logonetflix',
                child: Image.asset(
                  'assets/logonetflix.png',
                  width: 130,
                ),
              ),
              SizedBox(width: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Hero(
                  tag: 'avatar-superhero',
                  child: Image.asset(
                    'assets/avatar/superhero.png',
                    width: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FadeInImage(
//             placeholder: AssetImage('assets/loading.gif'), // cambiar png
//             image: NetworkImage(
//                 'https://cafeconmokadotcom1.files.wordpress.com/2016/01/butacas-cine.jpg'),
//             fit: BoxFit.cover,
//             fadeInDuration: Duration(seconds: 2),
//             fadeInCurve: Curves.easeIn,
//           ),
