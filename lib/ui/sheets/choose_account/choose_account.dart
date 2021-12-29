import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/sheets/choose_account/choose_account_controller.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/add_button.dart';
import 'package:poprey_app/ui/widgets/bottom_shadow.dart';
import 'package:poprey_app/utils/app_theme.dart';

class ChooseAccountSheet extends StatefulWidget {
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
  State<ChooseAccountSheet> createState() => _ChooseAccountSheetState();
}

class _ChooseAccountSheetState extends State<ChooseAccountSheet> {
  late ChooseAccountController controller;
  late RxList<InstagramProfile> profiles;

  @override
  void initState() {
    super.initState();
    profiles = widget.profiles.obs;
    controller = ChooseAccountController();

    controller.accountsListScrollController = ScrollController()
      ..addListener(controller.accountsListHandleScrolling);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      controller.accountsListHandleScrolling();
    });
  }

  @override
  void dispose() {
    controller.accountsListScrollController
        .removeListener(controller.accountsListHandleScrolling);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Obx(() {
                    return ListView.separated(
                      controller: controller.accountsListScrollController,
                      shrinkWrap: true,
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
                          onTap: () => widget.profileSelected(profile),
                          onLongPressEnd: (details) =>
                              showPopUpMenu(context, profile, details),
                        );
                      },
                    );
                  }),
                  Obx(
                    () => BottomShadow(
                      isEnabled: controller.isAccountsShadowShown.value,
                      height: 70,
                      color: AppTheme.isLightTheme(context) ? const Color(0xFFF7F8FB): const Color(0xFF080704),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0.5),
            Padding(
              padding: const EdgeInsets.all(32),
              child: AddButton(
                text: AppLocale(context).addAccount,
                onPressed: widget.addAccount,
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
              children: [
                const Icon(
                  Icons.remove_circle_outline,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocale(context).remove,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value == 1) {
        profiles.remove(profile);
        widget.profileRemoved(profile);
      }
    });
  }
}
