import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/add_button.dart';
import 'package:poprey_app/ui/widgets/bottom_shadow.dart';
import 'package:poprey_app/ui/widgets/home_indicator.dart';
import 'package:poprey_app/ui/widgets/instagram_accounts/instagram_accounts_controller.dart';
import 'package:poprey_app/utils/app_theme.dart';

class InstagramAccounts extends StatefulWidget {
  const InstagramAccounts({
    Key? key,
    required this.constraints,
    required this.controller,
  }) : super(key: key);

  final BoxConstraints constraints;
  final InstagramAccountsController controller;

  @override
  State<InstagramAccounts> createState() => _InstagramAccountsState();
}

class _InstagramAccountsState extends State<InstagramAccounts> {
  late final InstagramAccountsController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.accountsListScrollController =
        ScrollController(initialScrollOffset: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: widget.constraints.maxHeight / 2),
      color: AppTheme.isLightTheme(context)
          ? const Color(0xFFF7F8FB)
          : const Color(0xFF080704),
      child: Obx(() {
        bool isListShown = controller.isAccountListShown.value;
        return GestureDetector(
          onVerticalDragEnd: (details) =>
              isListShown ? null : controller.toggleList(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Stack(
                  children: [
                    accountsList(),
                    if (isListShown) ...[
                      Obx(
                        () => BottomShadow(
                          isEnabled: controller.isAccountsShadowShown.value,
                          height: 70,
                          color: AppTheme.isLightTheme(context)
                              ? const Color(0xFFF7F8FB)
                              : const Color(0xFF080704),
                        ),
                      )
                    ],
                  ],
                ),
              ),
              if (isListShown) ...[
                const Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AddButton(
                    text: AppLocale(context).addAccount,
                    onPressed: () => controller.addAccount(context),
                  ),
                ),
              ],
              GestureDetector(
                onTap: controller.toggleList,
                onVerticalDragEnd: (details) => controller.toggleList(),
                child: SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [HomeIndicator()],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget accountsList() {
    return NotificationListener<ScrollNotification>(
      onNotification: controller.accountsListScrollControllerNotification,
      child: ListView.builder(
        controller: controller.accountsListScrollController,
        shrinkWrap: true,
        itemCount: controller.getAccountListCount(),
        itemBuilder: (context, index) {
          var profile = controller.profilesManager.profiles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: InkWell(
              onTap: () => controller.accountTap(profile),
              child: AccountTile(
                profile: profile,
                radius: 16,
                selectable: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
