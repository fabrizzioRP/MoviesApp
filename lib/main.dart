// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
//
import 'src/themes/theme.dart';
import 'src/screens/screens.dart';
import 'package:movies_app/src/services/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MoviesData()),
          ChangeNotifierProvider(create: (_) => MenuProvider()),
        ],
        child: MyApp(),
      );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        initialRoute: 'splashscreen',
        routes: {
          'splashscreen': (_) => SplashScreen(),
          'homescreen': (_) => HomeScreen(),
          'detailsMovies': (_) => DetailsMoviesScreen(),
        },
        theme: uxTheme,
      );
}
