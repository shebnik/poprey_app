import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UI {
  static Widget get empty => Container();

  static Widget get loading => const Center(child: CircularProgressIndicator());

  static Widget get doneIcon => const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      );

  static Widget get divider =>
        Container(
          height: 1,
          color: Colors.black.withOpacity(0.3),
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
      style: GoogleFonts.montserrat(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
