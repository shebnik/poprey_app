import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppTheme {
  static const primary = Color.fromRGBO(32, 53, 76, 1);

  static const theme = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: 'SF Pro Display',
      ),
    ),
  );

  static Color black(double opacity) => Color.fromRGBO(0, 0, 0, opacity);
}
