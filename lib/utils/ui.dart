import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class UI {
  static Widget get empty => Container();

  static Widget get loading => const Center(child: CircularProgressIndicator());

  static Widget get doneIcon => const Center(
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 60,
        ),
      );

  static Widget get errorIcon => const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
      );

  static Widget get divider => Container(
        height: 1,
        color: Colors.black.withOpacity(0.1),
      );

  static SizedBox spacer({double? height = 15, double? width = 15}) =>
      SizedBox(height: height, width: width);

  static Widget text({
    required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    bool? softWrap,
  }) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  static TextStyle getTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static ElevatedButton elevatedButton({
    required Widget child,
    required VoidCallback onPressed,
    bool disabled = false,
    bool rounded = false,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: rounded
            ? MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              )
            : null,
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => disabled ? AppColors.black(0.35) : AppColors.primary,
        ),
      ),
      child: child,
      onPressed: disabled ? null : onPressed,
    );
  }

  static TextButton textButton({
    required String text,
    required VoidCallback onPressed,
    bool disabled = false,
  }) {
    return TextButton(
      child: UI.text(
        text: text,
        color: disabled ? AppColors.black(0.35) : AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      onPressed: disabled ? null : onPressed,
    );
  }
}
