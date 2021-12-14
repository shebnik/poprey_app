
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtherSMSelectionList extends StatefulWidget {
  const OtherSMSelectionList({
    Key? key,
  }) : super(key: key);

  @override
  State<OtherSMSelectionList> createState() => _OtherSMSelectionListState();
}

class _OtherSMSelectionListState extends State<OtherSMSelectionList> {

  static const otherSmImagesPath = [
    AppAssets.all,
    AppAssets.youtube,
    AppAssets.tiktok,
    AppAssets.facebook,
    AppAssets.spotify,
    AppAssets.twitter,
    AppAssets.vk,
  ];

  final otherSmTitles = [
    AppLocalizations.of(context)!.all,
    'YouTube',
    'TikTok',
    'Facebook',
    'Spotify',
    'Twitter',
    'VK',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      decoration: BoxDecoration(
        color: Colors.white,
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                otherSmImagesPath[index],
              ),
              SizedBox(height: 8),
              Text(
                otherSmTitles[index],
              )
            ],
          );
        },
      ),
    );
  }
}
