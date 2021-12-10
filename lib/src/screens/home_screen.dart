// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_print, avoid_function_literals_in_foreach_calls, prefer_final_fields, unused_field, prefer_is_empty, sized_box_for_whitespace, must_be_immutable, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
//
import 'package:movies_app/src/themes/theme.dart';
import 'package:movies_app/src/screens/screens.dart';
import 'package:movies_app/src/widgets/widgets.dart';
import 'package:movies_app/src/services/services.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final consumeProvider = Provider.of<MenuProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          _ScreenOptions(screenSelected: consumeProvider.screen),
          _MenuLocationsButtoms(),
        ],
      ),
    );
  }
}

class _ScreenOptions extends StatefulWidget {
  final int screenSelected;

  const _ScreenOptions({required this.screenSelected});

  @override
  State<_ScreenOptions> createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends State<_ScreenOptions> {
  ScrollController _scrollController = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > scrollAnterior &&
          _scrollController.offset > 150) {
        Provider.of<MenuProvider>(context, listen: false).showMenu = false;
      } else {
        Provider.of<MenuProvider>(context, listen: false).showMenu = true;
      }

      scrollAnterior = _scrollController.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.screenSelected) {
      case 0:
        return MoviesMainScreen(scrollController: _scrollController);
      case 1:
        return SearchScreens(scrollController: _scrollController);
      default:
        return MoviesMainScreen(scrollController: _scrollController);
    }
  }
}

class _MenuLocationsButtoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Positioned(
        bottom: 40,
        left: 0,
        right: 0,
        child: Container(
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: MenuBarWidget(
              mostrarMenu: Provider.of<MenuProvider>(context).showMenu,
              items: items2(context),
              background: primaryColor,
              inactiveColor: Colors.black54,
              activeColor: Colors.black,
            ),
          ),
        ),
      );
}
