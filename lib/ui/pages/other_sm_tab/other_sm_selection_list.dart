import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:poprey_app/ui/pages/other_sm_tab/other_sm_tab_controller.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class OtherSMSelectionList extends StatelessWidget {
  final OtherSmTabController controller;

  const OtherSMSelectionList({
    required this.controller,
    Key? key,
  }) : super(key: key);

  static const otherSmImagesPath = [
    AppAssets.all,
    AppAssets.youtube,
    AppAssets.tiktok,
    AppAssets.facebook,
    AppAssets.spotify,
    AppAssets.twitter,
    AppAssets.vk,
  ];

  static const otherSmTitles = [
    AppConstants.All,
    AppConstants.YouTube,
    AppConstants.TikTok,
    AppConstants.Facebook,
    AppConstants.Spotify,
    AppConstants.Twitter,
    AppConstants.VK,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      decoration: BoxDecoration(
        color: AppTheme.getBrightnessColor(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        separatorBuilder: (context, index) => const SizedBox(width: 25),
        itemBuilder: (context, index) {
          return InkWell(
            child: Obx(
              () {
                bool _isSelected = controller.selectedIndex.value == index;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      otherSmImagesPath[index],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      otherSmTitles[index],
                      style: TextStyle(
                        fontFamily: AppConstants.SFProText,
                        fontSize: 10,
                        fontWeight:
                            _isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: _isSelected
                            ? AppTheme.primaryBlue
                            : AppTheme.primary(context)
                      ),
                    )
                  ],
                );
              },
            ),
            onTap: () => controller.onSelected(index),
          );
        },
      ),
    );
  }
}
