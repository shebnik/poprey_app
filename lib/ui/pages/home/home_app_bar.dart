import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {

  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: SvgPicture.asset(
          AppAssets.menuIcon,
        ),
        onPressed: () {},
      ),
      centerTitle: true,
      title: const Text(AppConstants.appName),
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
