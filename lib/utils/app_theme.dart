import 'package:flutter/cupertino.dart';

class AppTheme {
  static const theme = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: 'SF Pro Display',
      ),
    ),
  );

  static const primary = Color.fromRGBO(32, 53, 76, 1);
  static const secondary = Color.fromRGBO(0, 171, 223, 1);

  static Color black(double opacity) => Color.fromRGBO(0, 0, 0, opacity);
}
