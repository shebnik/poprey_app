import 'package:flutter/material.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AccountTile extends StatelessWidget {
  final InstagramProfile profile;
  final double radius;
  final bool selectable;

  const AccountTile({
    Key? key,
    required this.profile,
    this.radius = 25,
    this.selectable = false,
  }) : super(key: key);

  String get followers => '${Utils.formatNumber(profile.followers)} followers';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: radius,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: profile.profilePicUrl,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.username,
                style: Theme.of(context).textTheme.headline3?.apply(
                      color: profile.isSelected ?? false
                          ? AppTheme.primaryBlue
                          : null,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                followers,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (profile.isSelected ?? false) ...[
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                ],
                if (profile.isSelected == false && selectable) ...[
                  const Icon(
                    Icons.circle_outlined,
                    color: Color(0xFFC6C6C9),
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
