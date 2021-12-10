// ignore_for_file: prefer_const_constructors, avoid_print, unused_element, curly_braces_in_flow_control_structures, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
//
import 'package:movies_app/src/themes/theme.dart';
import 'package:movies_app/src/models/models.dart';
import 'package:movies_app/src/services/services.dart';

class SearchScreens extends StatelessWidget {
  final ScrollController scrollController;

  const SearchScreens({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MoviesData>(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => showSearch(
                              context: context,
                              delegate: SearchDelegateMovies()),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            color: Colors.grey.withOpacity(0.6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.search),
                                Text(
                                    'Buscar una serie, una peli, un género...'),
                                Icon(Icons.keyboard_voice),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.blue,
                                Colors.green.shade400,
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(text1,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(text2, style: TextStyle(fontSize: 15)),
                              SizedBox(height: 10),
                              Text(text3, style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Los más buscados',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) =>
                  _CustomSearchListMovie(movie: movie.onDisplayMovies[i]),
              childCount: movie.onDisplayMovies.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomSearchListMovie extends StatelessWidget {
  final Movies movie;

  const _CustomSearchListMovie({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'mainsearch-${movie.id}';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Container(
        width: double.infinity,
        height: 80,
        color: Colors.grey.withOpacity(0.2),
        child: Row(
          children: [
            Hero(
              tag: movie.heroId!,
              child: Container(
                width: 110,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movie.fullPosterImg),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 180,
              child: Text(movie.title,
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
            ),
            IconButton(
              icon: Icon(Icons.play_circle_outline),
              onPressed: () => Navigator.pushNamed(context, 'detailsMovies',
                  arguments: movie),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchDelegateMovies extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar una serie, una peli, un género';

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          tooltip: 'Clear',
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        ),
        Image.asset(
          'assets/avatar/superhero.png',
          width: 25,
        ),
        SizedBox(width: 10),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        tooltip: 'Back',
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => close(context, null),
      );

  Widget esperandoPeli = Container(
    child: Center(
      child: Icon(Icons.movie, size: 150, color: Colors.grey.withOpacity(0.3)),
    ),
  );

  @override
  Widget buildResults(BuildContext context) {
    FocusScope.of(context).unfocus();
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return esperandoPeli;

    final moviesProvider = Provider.of<MoviesData>(context, listen: false);
    moviesProvider.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.getStream,
      builder: (_, AsyncSnapshot<List<Movies>> snapshot) {
        if (!snapshot.hasData) return esperandoPeli;

        final movies = snapshot.data!;

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (_, i) => _MovieItems(movie: movies[i]),
        );
      },
    );
  }
}

class _MovieItems extends StatelessWidget {
  final Movies movie;

  const _MovieItems({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return Hero(
      tag: movie.heroId!,
      child: ListTile(
        leading: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: () =>
            Navigator.pushNamed(context, 'detailsMovies', arguments: movie),
      ),
    );
  }
}
