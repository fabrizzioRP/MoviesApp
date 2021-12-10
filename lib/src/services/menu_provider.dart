// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  int _itemSeleccionado = 0;
  bool _showMenu = true;
  Color _background = Colors.white;
  Color _activeColor = Colors.black;
  Color _inactiveColor = Colors.blueGrey;

  bool get showMenu => _showMenu;

  set showMenu(bool show) {
    _showMenu = show;
    notifyListeners();
  }

  int get itemSeleccionado => _itemSeleccionado;

  set itemSeleccionado(int value) {
    _itemSeleccionado = value;
    notifyListeners();
  }

  Color get background => _background;

  set background(Color background) {
    _background = background;
  }

  Color get activeColor => _activeColor;

  set activeColor(Color activeColor) {
    _activeColor = activeColor;
  }

  Color get inactiveColor => _inactiveColor;

  set inactiveColor(Color inactiveColor) {
    _inactiveColor = inactiveColor;
  }

  int _screen = 0;

  int get screen => _screen;

  set screen(int value) {
    _screen = value;
    notifyListeners();
  }
}
