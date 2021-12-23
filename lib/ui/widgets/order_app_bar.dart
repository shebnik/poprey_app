import 'package:flutter/material.dart';

import 'package:poprey_app/utils/app_theme.dart';

class OrderAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const OrderAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppTheme.primaryBlue),
      backgroundColor: AppTheme.isLightTheme(context)
          ? const Color(0xFFF7F8FB)
          : const Color(0xFF080704),
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3?.apply(
              color: AppTheme.primary,
            ),
      ),
    );
  }
}
