import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poprey_app/utils/app_constants.dart';

class AppTheme {
  static final _defaultTheme = ThemeData(
    primaryColor: primaryColor,
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
      subtitle2: const TextStyle(
        fontFamily: AppConstants.SFProText,
        fontWeight: FontWeight.w400,
        fontSize: 12,
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
    textTheme: _textTheme.copyWith(
      headline2: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: AppConstants.SFProDisplay,
      ),
    ),
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
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    subtitle2: TextStyle(
      fontFamily: AppConstants.SFProText,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      fontFamily: AppConstants.SFProText,
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

  static Color primary(BuildContext context) =>
      isLightTheme(context) ? primaryColor : primaryColorDark;
  static const primaryColor = Color(0xFF20354C);
  static const primaryColorDark = Color(0xffdfcab3);
  static const primaryBlue = Color(0xFF00ABDF);

  static isLightTheme(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light;
  }

  static Color getBrightnessColor(BuildContext context) {
    return isLightTheme(context) ? Colors.white : Colors.black;
  }

  static LinearGradient getAppGradient([double? opacity]) {
    return LinearGradient(
      colors: [
        const Color(0xFFFE616C).withOpacity(opacity ?? 1),
        const Color(0xFFFFC071).withOpacity(opacity ?? 1),
      ],
    );
  }

  static void setOverlayStyle([Color? color, BuildContext? context]) {
    final overlay = getSystemOverlayStyle(context);
    SystemChrome.setSystemUIOverlayStyle(
      color != null
          ? overlay.copyWith(systemNavigationBarColor: color)
          : overlay,
    );
  }

  static SystemUiOverlayStyle getSystemOverlayStyle(BuildContext? context) {
    return context != null
        ? isLightTheme(context)
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.light;
  }
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
