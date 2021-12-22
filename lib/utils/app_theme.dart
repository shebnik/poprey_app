import 'package:flutter/material.dart';
import 'package:poprey_app/utils/app_constants.dart';

class AppTheme {
  static final _defaultTheme = ThemeData(
    primaryColor: primary,
    fontFamily: AppConstants.SFProDisplay,
    // canvasColor: Colors.transparent,
    dividerColor: const Color(0xFFC6C6C9),
    sliderTheme: SliderThemeData(
      trackShape: CustomTrackShape(),
    ),
  );

  static ThemeData themeLight = _defaultTheme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFCFCFC),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: _appBarTitleStyle.copyWith(
        color: Colors.black,
      ),
    ),
    textTheme: _textTheme.copyWith(
      headline3: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontFamily: AppConstants.SFProText,
      ),
      headline4: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: AppConstants.SFProDisplay,
      ),
      headline5: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 10,
        fontFamily: AppConstants.SFProDisplay,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );
  static ThemeData themeDark = _defaultTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF030303),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: _appBarTitleStyle.copyWith(
        color: Colors.white,
      ),
    ),
    textTheme: _textTheme.copyWith(),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: AppConstants.SFProText,
        fontWeight: FontWeight.w400,
        color: Color(0xFFCECFD0),
      ),
    ),
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
    caption: TextStyle(
      fontFamily: AppConstants.SFProText,
      color: Color(0xFFCECFD0),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    subtitle1: TextStyle(
      fontFamily: AppConstants.SFProText,
      color: primary,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    subtitle2: TextStyle(
      fontFamily: AppConstants.SFProText,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    headline3: TextStyle(
      // color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: AppConstants.SFProText,
    ),
    headline4: TextStyle(
      // color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      fontFamily: AppConstants.SFProDisplay,
    ),
    headline5: TextStyle(
      // color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 10,
      fontFamily: AppConstants.SFProDisplay,
    ),
    headline6: TextStyle(
      color: Color.fromRGBO(169, 175, 182, 1),
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: AppConstants.SFProDisplay,
    ),
  );

  static const primary = Color(0xFF20354C);
  static const primaryBlue = Color(0xFF00ABDF);

  static isLightTheme(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light;
  }

  static Color getBrightnessColor(BuildContext context) {
    return isLightTheme(context) ? Colors.white : Colors.black;
  }

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
