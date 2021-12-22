import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';

class HomeNavigationBar extends StatelessWidget with PreferredSizeWidget {
  final bool applyElevation;

  const HomeNavigationBar({
    Key? key,
    this.applyElevation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: applyElevation ? 0.04 : 0.0,
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
