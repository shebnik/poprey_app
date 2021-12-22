import 'package:flutter/material.dart';
import 'package:poprey_app/utils/app_constants.dart';

class AppTheme {
  static final _defaultTheme = ThemeData(
    primaryColor: primary,
    fontFamily: AppConstants.SFProDisplay,
    // canvasColor: Colors.transparent,
    sliderTheme: SliderThemeData(
      trackShape: CustomTrackShape(),
    ),
  );

  static ThemeData themeLight = _defaultTheme.copyWith(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: _appBarTitleStyle.copyWith(
        color: Colors.black,
      ),
    ),
    textTheme: _textTheme.copyWith(),
  );
  static ThemeData themeDark = _defaultTheme.copyWith(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: _appBarTitleStyle.copyWith(
        color: Colors.white,
      ),
    ),
    textTheme: _textTheme.copyWith(),
  );

  static const TextStyle _appBarTitleStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const TextTheme _textTheme = TextTheme(
    button: TextStyle(
      fontFamily: AppConstants.SFProText,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    // caption: TextStyle(
    //   fontFamily: AppConstants.SFProText,
    //   color: Color(0xFFCECFD0),
    //   fontWeight: FontWeight.w400,
    //   fontSize: 14,
    // ),
    // subtitle1: TextStyle(
    //   fontFamily: AppConstants.SFProText,
    //   color: primary,
    //   fontWeight: FontWeight.w400,
    //   fontSize: 12,
    // ),
    // subtitle2: TextStyle(
    //   fontFamily: AppConstants.SFProText,
    //   color: Colors.white,
    //   fontWeight: FontWeight.w400,
    //   fontSize: 12,
    // ),
    // headline3: TextStyle(
    //   color: Colors.black,
    //   fontWeight: FontWeight.w600,
    //   fontSize: 16,
    //   fontFamily: AppConstants.SFProText,
    // ),
    // headline4: TextStyle(
    //   color: Colors.black,
    //   fontWeight: FontWeight.w700,
    //   fontSize: 14,
    //   fontFamily: AppConstants.SFProDisplay,
    // ),
    // headline5: TextStyle(
    //   color: Colors.black,
    //   fontWeight: FontWeight.w600,
    //   fontSize: 10,
    //   fontFamily: AppConstants.SFProDisplay,
    // ),
    // headline6: TextStyle(
    //   color: Color.fromRGBO(169, 175, 182, 1),
    //   fontWeight: FontWeight.w400,
    //   fontSize: 10,
    //   fontFamily: AppConstants.SFProDisplay,
    // ),
  );

  static const primary = Color.fromRGBO(32, 53, 76, 1);
  static const primaryBlue = Color.fromRGBO(0, 171, 223, 1);

  // static const cupertinoThemeData = CupertinoThemeData(
  //   textTheme: CupertinoTextThemeData(
  //     textStyle: TextStyle(
  //       fontFamily: AppConstants.SFProDisplay,
  //     ),
  //   ),
  // );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
