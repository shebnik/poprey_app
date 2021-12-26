import 'package:flutter/material.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/add_button.dart';

class ChooseAccountSheet extends StatelessWidget {
  final List<InstagramProfile> profiles;
  final void Function(InstagramProfile profile) profileSelected;
  final void Function(InstagramProfile profile) profileRemoved;
  final VoidCallback addAccount;

  const ChooseAccountSheet({
    Key? key,
    required this.profiles,
    required this.profileSelected,
    required this.profileRemoved,
    required this.addAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: profiles.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  var profile = profiles[index];
                  return GestureDetector(
                    child: AccountTile(
                      profile: profile,
                    ),
                    onTap: () => profileSelected(profile),
                    onLongPressEnd: (details) =>
                        showPopUpMenu(context, profile, details),
                  );
                },
              ),
            ),
            const Divider(height: 0.5),
            Padding(
              padding: const EdgeInsets.all(32),
              child: AddButton(
                text: AppLocale(context).addAccount,
                onPressed: addAccount,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showPopUpMenu(
    BuildContext context,
    InstagramProfile profile,
    LongPressEndDetails details,
  ) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    await showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dx, dy),
      items: [
        PopupMenuItem(
          value: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: const [
                Icon(
                  Icons.remove_circle_outline,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Remove',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value == 1) {
        profileRemoved(profile);
      }
    });
  }
}
