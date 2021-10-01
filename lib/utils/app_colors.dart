import 'package:flutter/material.dart';

class AppColors {
  static final primarySwatch = MaterialColor(0xFF0EBFA9, colors);

  static final Map<int, Color> colors = {
    50: Color.fromRGBO(0, 171, 223, .1),
    100: Color.fromRGBO(0, 171, 223, .2),
    200: Color.fromRGBO(0, 171, 223, .3),
    300: Color.fromRGBO(0, 171, 223, .4),
    400: Color.fromRGBO(0, 171, 223, .5),
    500: Color.fromRGBO(0, 171, 223, .6),
    600: Color.fromRGBO(0, 171, 223, .7),
    700: Color.fromRGBO(0, 171, 223, .8),
    800: Color.fromRGBO(0, 171, 223, .9),
    900: Color.fromRGBO(0, 171, 223, 1.0),
  };

  static final lightBlue = Color.fromRGBO(0, 171, 223, 1.0);

  static final primary = Color.fromRGBO(0, 171, 223, 1);

  static final primaryBlue = Color.fromRGBO(91, 16, 255, 1.0);

  static final snackBar = Color.fromRGBO(247, 247, 247, 1.0);

  static final chip = Color.fromRGBO(245, 245, 245, 1);

  static final shadow = Color.fromRGBO(0, 0, 0, 0.16);

  static final lightBlack = Color.fromRGBO(56, 56, 56, 1);

  static Color black(double opacity) => Color.fromRGBO(0, 0, 0, opacity);

  static final AEAEAE =
      Color.fromRGBO(174, 174, 174, 1); // ignore: non_constant_identifier_names

  static final FC1CAE =
      Color.fromRGBO(252, 28, 174, 1); // ignore: non_constant_identifier_names
}
