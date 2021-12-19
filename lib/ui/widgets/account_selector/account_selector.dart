import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poprey_app/ui/widgets/widgets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class AccountSelector extends StatelessWidget {
  final SelectedPlan selectedPlan;

  AccountSelector({Key? key, required this.selectedPlan}) : super(key: key);

  final profileManager = InstagramProfilesManager();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: profileManager.profiles.length,
            itemBuilder: (context, index) {
              var profile = profileManager.profiles[index];
              return GestureDetector(
                child: AccountTile(
                  profile: profile,
                ),
                onTap: () async {
                  await profileManager.selectProfile(profile);
                  _getBack();
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
              onPressed: _getBack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    color: AppTheme.primaryBlue,
                    size: 14,
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
      ),
    );
  }

  void _getBack() {
    Get.back();
    Widgets.showBottomSheet(
      AppBottomSheet(
        selectedPlan: selectedPlan,
      ),
    );
  }
}
