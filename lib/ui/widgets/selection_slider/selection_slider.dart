import 'package:flutter/cupertino.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/utils/hex_color.dart';

class SelectionSlider extends StatelessWidget {
  final List<Plan> plan;

  const SelectionSlider({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: HexColor.fromHex('#F7F8FB'),
        color: CupertinoColors.activeBlue,
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Column(),
    );
  }
}
