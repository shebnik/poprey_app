// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'app_theme.dart';

// class Widgets {
//   static Widget get empty => Container();

//   static Widget get loading => const Center(child: CircularProgressIndicator());

//   static Widget get doneIcon => const Center(
//         child: Icon(
//           Icons.check_circle_outline,
//           color: Colors.green,
//           size: 60,
//         ),
//       );

//   static Widget get errorIcon => const Center(
//         child: Icon(
//           Icons.error_outline,
//           color: Colors.red,
//           size: 60,
//         ),
//       );

//   static Widget get divider => Container(
//         height: 1,
//         color: Colors.black.withOpacity(0.1),
//       );

//   static SizedBox spacer({double? height = 15, double? width = 15}) =>
//       SizedBox(height: height, width: width);

//   static Widget text({
//     required String text,
//     double? fontSize,
//     FontWeight? fontWeight,
//     Color? color,
//     TextAlign? textAlign,
//     int? maxLines,
//     bool? softWrap,
//   }) {
//     return Text(
//       text,
//       style: GoogleFonts.nunito(
//         fontSize: fontSize ?? 14,
//         fontWeight: fontWeight ?? FontWeight.normal,
//         color: color ?? Colors.black,
//       ),
//       textAlign: textAlign,
//       maxLines: maxLines,
//       softWrap: softWrap,
//     );
//   }

//   static TextStyle getTextStyle({
//     double? fontSize,
//     FontWeight? fontWeight,
//     Color? color,
//     double? height,
//   }) {
//     return GoogleFonts.montserrat(
//       fontSize: fontSize ?? 14,
//       fontWeight: fontWeight,
//       color: color,
//       height: height,
//     );
//   }

//   static ElevatedButton elevatedButton({
//     required Widget child,
//     required VoidCallback onPressed,
//     bool disabled = false,
//     bool rounded = false,
//   }) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         shape: rounded
//             ? MaterialStateProperty.all(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               )
//             : null,
//         backgroundColor: MaterialStateProperty.resolveWith(
//           (states) => disabled ? AppTheme.black(0.35) : AppTheme.primary,
//         ),
//       ),
//       child: child,
//       onPressed: disabled ? null : onPressed,
//     );
//   }

//   static TextButton textButton({
//     required String text,
//     required VoidCallback onPressed,
//     bool disabled = false,
//   }) {
//     return TextButton(
//       child: Widgets.text(
//         text: text,
//         color: disabled ? AppTheme.black(0.35) : AppTheme.primary,
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//       onPressed: disabled ? null : onPressed,
//     );
//   }
// static Widget futureWidget({
//     required Future<dynamic> future,
//     required Widget Function(BuildContext, AsyncSnapshot) onDidInitialize,
//   }) {
//     return FutureBuilder(
//       future: future,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           return onDidInitialize(context, snapshot);
//         } else if (snapshot.hasError) {
//           return Widgets.errorIcon;
//         } else {
//           return Widgets.loading;
//         }
//       },
//     );
//   }
// }


// class SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight
//     extends SliverGridDelegate {
//   /// Creates a delegate that makes grid layouts with a fixed number of tiles in
//   /// the cross axis.
//   ///
//   /// All of the arguments must not be null. The `mainAxisSpacing` and
//   /// `crossAxisSpacing` arguments must not be negative. The `crossAxisCount`
//   /// and `childAspectRatio` arguments must be greater than zero.
//   const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight({
//     required this.crossAxisCount,
//     this.mainAxisSpacing = 0.0,
//     this.crossAxisSpacing = 0.0,
//     this.height = 56.0,
//   })  : assert(crossAxisCount > 0),
//         assert(mainAxisSpacing >= 0),
//         assert(crossAxisSpacing >= 0),
//         assert(height > 0);

//   /// The number of children in the cross axis.
//   final int crossAxisCount;

//   /// The number of logical pixels between each child along the main axis.
//   final double mainAxisSpacing;

//   /// The number of logical pixels between each child along the cross axis.
//   final double crossAxisSpacing;

//   /// The height of the crossAxis.
//   final double height;

//   bool _debugAssertIsValid() {
//     assert(crossAxisCount > 0);
//     assert(mainAxisSpacing >= 0.0);
//     assert(crossAxisSpacing >= 0.0);
//     assert(height > 0.0);
//     return true;
//   }

//   @override
//   SliverGridLayout getLayout(SliverConstraints constraints) {
//     assert(_debugAssertIsValid());
//     final double usableCrossAxisExtent =
//         constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
//     final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
//     final double childMainAxisExtent = height;
//     return SliverGridRegularTileLayout(
//       crossAxisCount: crossAxisCount,
//       mainAxisStride: childMainAxisExtent + mainAxisSpacing,
//       crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
//       childMainAxisExtent: childMainAxisExtent,
//       childCrossAxisExtent: childCrossAxisExtent,
//       reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
//     );
//   }

//   @override
//   bool shouldRelayout(
//       SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight oldDelegate) {
//     return oldDelegate.crossAxisCount != crossAxisCount ||
//         oldDelegate.mainAxisSpacing != mainAxisSpacing ||
//         oldDelegate.crossAxisSpacing != crossAxisSpacing ||
//         oldDelegate.height != height;
//   }
// }


