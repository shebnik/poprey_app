import 'package:flutter/material.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/add_button.dart';

class ChooseAccount extends StatelessWidget {
  final List<InstagramProfile> profiles;
  final void Function(InstagramProfile profile) profileSelected;
  final VoidCallback addAccount;

  const ChooseAccount({
    Key? key,
    required this.profiles,
    required this.profileSelected,
    required this.addAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: MaxHeight = screen / 2
    return SafeArea(
      child: Wrap(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: profiles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              var profile = profiles[index];
              return GestureDetector(
                child: AccountTile(
                  profile: profile,
                ),
                onTap: () => profileSelected(profile),
              );
            },
          ),
          const Divider(height: 0.5),
          Padding(
            padding: const EdgeInsets.all(32),
            child: AddButton(
              text: 'Add Account',
              onPressed: addAccount,
            ),
          ),
        ],
      ),
    );
  }
}
