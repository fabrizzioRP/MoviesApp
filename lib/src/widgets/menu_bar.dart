// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:movies_app/src/services/menu_provider.dart';

class ButtomComponents {
  final VoidCallback onPressed;
  final IconData icon;

  const ButtomComponents({required this.icon, required this.onPressed});
}

class MenuBarWidget extends StatelessWidget {
  final List<ButtomComponents> items;
  final bool mostrarMenu;
  final Color background;
  final Color activeColor;
  final Color inactiveColor;

  MenuBarWidget({
    this.mostrarMenu = true,
    this.background = Colors.black,
    this.activeColor = Colors.blueGrey,
    this.inactiveColor = Colors.white,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (mostrarMenu) ? 1 : 0, // aca hacer condicion
      duration: Duration(milliseconds: 300),
      child: Builder(
        builder: (_) {
          Provider.of<MenuProvider>(context, listen: false).activeColor =
              activeColor;
          Provider.of<MenuProvider>(context, listen: false).inactiveColor =
              inactiveColor;
          Provider.of<MenuProvider>(context, listen: false).background =
              background;

          return _MenuBackground(
            child: _MenuItems(items: items),
          );
        },
      ),
    );
  }
}

class _MenuBackground extends StatelessWidget {
  final Widget child;

  const _MenuBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    final background = Provider.of<MenuProvider>(context).background;
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: -5,
          )
        ],
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<ButtomComponents> items;

  const _MenuItems({required this.items});
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (i) => _Items(i, items[i])),
      );
}

class _Items extends StatelessWidget {
  final int index;
  final ButtomComponents item;

  const _Items(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final styleProvider = Provider.of<MenuProvider>(context);

    Color colorSelect;
    double tamanoSelect;

    if (styleProvider.itemSeleccionado == index) {
      colorSelect = styleProvider.activeColor;
      tamanoSelect = 30;
    } else {
      colorSelect = styleProvider.inactiveColor;
      tamanoSelect = 25;
    }

    return GestureDetector(
      onTap: () {
        Provider.of<MenuProvider>(context, listen: false).itemSeleccionado =
            index;
        item.onPressed();
      },
      child: Icon(
        item.icon,
        color: colorSelect,
        size: tamanoSelect,
      ),
    );
  }
}
