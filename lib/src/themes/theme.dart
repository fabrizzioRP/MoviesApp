// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_equal_for_default_values, avoid_print, prefer_const_declarations, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:movies_app/src/widgets/widgets.dart';
import 'package:movies_app/src/services/services.dart';

ThemeData uxTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black,
);

final waiting = Center(child: CircularProgressIndicator());

final primaryColor = Color(0xFFE50914);

List<ButtomComponents> items2(BuildContext context) {
  final provider = Provider.of<MenuProvider>(context);
  return [
    ButtomComponents(icon: Icons.home, onPressed: () => provider.screen = 0),
    ButtomComponents(icon: Icons.search, onPressed: () => provider.screen = 1),
    ButtomComponents(
        icon: Icons.notification_add, onPressed: () => print('Notifications')),
  ];
}

final String text1 = 'Explorar y recorrer Netflix es cada vez más fácil';
final String text2 = 'Filtra todo el catalogo por categora, idioma y más.';
final String text3 = 'Ir a Filtros >';

final Widget waitForData = Container(
  width: double.infinity,
  height: 180,
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        CupertinoActivityIndicator(),
        SizedBox(height: 15),
        Text('No hay Data :( '),
      ],
    ),
  ),
);


// Navigator.pushNamed(context, 'homescreen');
// Navigator.of(context).pop();