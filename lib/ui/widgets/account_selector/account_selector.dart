import 'package:flutter/material.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/bottom_sheet/app_bottom_sheet_controller.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class AccountSelector extends StatelessWidget {
  final BottomSheetController controller;

  const AccountSelector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: controller.profileManager.profiles.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            var profile = controller.profileManager.profiles[index];
            return GestureDetector(
              child: AccountTile(
                profile: profile,
              ),
              onTap: () async {
                await controller.profileManager.selectProfile(profile);
                controller.setLoginData();
                controller.isAccountSelector.value = false;
              },
            );
          },
        ),
        Container(
          color: const Color(0xFFC6C6C9),
          width: double.infinity,
          height: 0.4,
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: TextButton(
            onPressed: () {
              controller.clearLoginData();
              controller.isAccountSelector.value = false;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add,
                  color: AppTheme.primaryBlue,
                ),
                SizedBox(width: 18),
                Text(
                  'Add Account',
                  style: TextStyle(
                    fontFamily: AppConstants.SFProText,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
