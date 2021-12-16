import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poprey_app/utils/app_constants.dart';

class AppTheme {
  static const cupertinoThemeData = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: AppConstants.SFProDisplay,
      ),
    ),
  );

  static materialThemeData() {
    return ThemeData(
      primaryColor: primary,
      fontFamily: AppConstants.SFProDisplay,
      // canvasColor: Colors.transparent,
      textTheme: const TextTheme(
        caption: TextStyle(
          fontFamily: AppConstants.SFProText,
          color: Color(0xFFCECFD0),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        button: TextStyle(
          fontFamily: AppConstants.SFProText,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        headline3: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: AppConstants.SFProText,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontFamily: AppConstants.SFProDisplay,
        ),
        headline5: TextStyle(
          color: Colors.black,
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
      ),
      sliderTheme: SliderThemeData(
        trackShape: CustomTrackShape(),
      ),
    );
  }

  static const primary = Color.fromRGBO(32, 53, 76, 1);
  static const primaryBlue = Color.fromRGBO(0, 171, 223, 1);

  static Color black(double opacity) => Color.fromRGBO(0, 0, 0, opacity);
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
