import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static final primarySwatch = MaterialColor(0xFF0EBFA9, colors);

  static final Map<int, Color> colors = {
    50: const Color.fromRGBO(0, 171, 223, .1),
    100: const Color.fromRGBO(0, 171, 223, .2),
    200: const Color.fromRGBO(0, 171, 223, .3),
    300: const Color.fromRGBO(0, 171, 223, .4),
    400: const Color.fromRGBO(0, 171, 223, .5),
    500: const Color.fromRGBO(0, 171, 223, .6),
    600: const Color.fromRGBO(0, 171, 223, .7),
    700: const Color.fromRGBO(0, 171, 223, .8),
    800: const Color.fromRGBO(0, 171, 223, .9),
    900: const Color.fromRGBO(0, 171, 223, 1.0),
  };

  static const lightBlue = Color.fromRGBO(0, 171, 223, 1.0);

  static const primary = Color.fromRGBO(0, 171, 223, 1);

  static const primaryBlue = Color.fromRGBO(91, 16, 255, 1.0);

  static const snackBar = Color.fromRGBO(247, 247, 247, 1.0);

  static const chip = Color.fromRGBO(244, 244, 244, 1);

  static const shadow = Color.fromRGBO(0, 0, 0, 0.16);

  static const lightBlack = Color.fromRGBO(56, 56, 56, 1);

  static Color black(double opacity) => Color.fromRGBO(0, 0, 0, opacity);

  static random([int? index]) {
    Random random = Random();
    final randomColors = [
      Colors.lightBlue,
      Colors.amber,
      Colors.red,
      Colors.black,
      Colors.pink,
      Colors.orange,
      Colors.green,
      Colors.lightGreen,
      Colors.brown,
      Colors.cyan,
    ];
    return randomColors[index ?? random.nextInt(10)];
  }
}
