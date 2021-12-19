import 'package:flutter/material.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/utils.dart';

class AccountTile extends StatelessWidget {
  final InstagramProfile profile;
  final double radius;

  const AccountTile({
    Key? key,
    required this.profile,
    this.radius = 32,
  }) : super(key: key);

  String get followers =>
      '${Utils.formatNumber(profile.followers)} followers';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 22),
      leading: CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(
          profile.profilePicUrl,
        ),
      ),
      title: Text(
        profile.username,
        style: Theme.of(context).textTheme.headline3!.apply(
              color: profile.isSelected ? AppTheme.primaryBlue : Colors.black,
            ),
      ),
      subtitle: Text(
        followers,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      trailing: profile.isSelected
          ? const Icon(
              Icons.check_circle,
              color: AppTheme.primaryBlue,
              size: 20,
            )
          : null,
    );
  }
}
