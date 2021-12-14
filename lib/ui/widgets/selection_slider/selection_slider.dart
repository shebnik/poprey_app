import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionSlider extends StatelessWidget {
  const SelectionSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<SharedPreferencesController>();
    // var model = controller.getInstagramModel();

    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor.fromHex('#F7F8FB'),
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 9.5, left: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (model != null)
            //   Flexible(
            //     child: Text(
            //       model.toString(),
            //       style: TextStyle(color: AppTheme.secondary),
            //     ),

            //   )
          ],
        ),
      ),
    );
  }
}
