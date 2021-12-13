import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/hex_color.dart';

class AppNavigationBar extends StatelessWidget
    with ObstructingPreferredSizeWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      backgroundColor: HexColor.fromHex('#FFFFFF'),
      leading: GestureDetector(
        child: SvgPicture.asset(
          AppAssets.menuIcon,
        ),
        onTap: () {},
      ),
      middle: const Text(
        AppConstants.appName,
      ),
      trailing: GestureDetector(
        child: SvgPicture.asset(
          AppAssets.mailIcon,
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }
}
