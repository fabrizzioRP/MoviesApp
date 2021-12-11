// ignore_for_file: use_key_in_widget_constructors, prefer_const_declarations, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:movies_app/src/themes/theme.dart';
import 'package:movies_app/src/models/models.dart';
import 'package:movies_app/src/services/movies_data.dart';

class CreditsMovie extends StatelessWidget {
  final int movieId;

  const CreditsMovie({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesData>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getCreditMovies(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return waitForData;
          }

          final cast = snapshot.data;

          return Container(
            margin: EdgeInsets.only(bottom: 30, top: 10),
            width: double.infinity,
            height: 180,
            // color: Colors.red,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cast!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                return _CastCutom(cast: cast[i]);
              },
            ),
          );
        });
  }
}

class _CastCutom extends StatelessWidget {
  final Cast cast;

  const _CastCutom({required this.cast});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        // color: Colors.green,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(cast.fullProfilePath),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              cast.originalName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
