import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/hex_color.dart';

class HomeNavigationBar extends StatelessWidget with PreferredSizeWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.04,
      backgroundColor: HexColor.fromHex('#FFFFFF'),
      leading: IconButton(
        icon: SvgPicture.asset(
          AppAssets.menuIcon,
        ),
        onPressed: () {},
      ),
      centerTitle: true,
      title: const Text(
        AppConstants.appName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            AppAssets.mailIcon,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
