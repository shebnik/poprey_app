import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/pages/choose_posts/choose_posts_controller.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/add_button.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/ui/widgets/bottom_shadow.dart';
import 'package:poprey_app/ui/widgets/home_indicator.dart';
import 'package:poprey_app/ui/widgets/instagram_post_widget.dart';
import 'package:poprey_app/ui/widgets/order_app_bar.dart';
import 'package:poprey_app/ui/widgets/app_widgets.dart';
import 'package:poprey_app/utils/app_theme.dart';

class ChoosePosts extends StatefulWidget {
  static const routeName = '/choosePosts';

  const ChoosePosts({
    Key? key,
  }) : super(key: key);

  @override
  _ChoosePostsState createState() => _ChoosePostsState();
}

class _ChoosePostsState extends State<ChoosePosts> {
  late final ChoosePostsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChoosePostsController());

    controller.accountsListScrollController =
        ScrollController(initialScrollOffset: 0);

    controller.choosePostsScrollController =
        ScrollController(initialScrollOffset: 0.1)
          ..addListener(controller.choosePostsHandleScrolling);
  }

  @override
  void dispose() {
    controller.choosePostsScrollController
        .removeListener(controller.choosePostsHandleScrolling);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderAppBar(title: AppLocale(context).selectedAccount),
      body: SafeArea(
        child: pageBody(),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, -10),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BottomResetNavigation(
              resetPressed: controller.resetPressed,
              nextPressed: () => controller.nextPressed(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget pageBody() {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              accountsWidget(constraints),
              Expanded(child: choosePosts()),
            ],
          ),
        ),
        Obx(
          () => BottomShadow(
            isEnabled: controller.isBottomShadowShown.value,
          ),
        ),
      ],
    );
  }

  Widget accountsWidget(constraints) {
    return Container(
      constraints: BoxConstraints(maxHeight: constraints.maxHeight / 2),
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
                          color: const Color(0xFFF7F8FB),
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
                    children: const [
                      HomeIndicator(),
                    ],
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
              onTap: () => controller.accountSelected(profile),
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

  Widget choosePosts() {
    return Column(
      children: [
        const SizedBox(height: 26),
        Text(
          AppLocale(context).choosePosts,
          style: Theme.of(context).textTheme.headline3?.apply(
                color: AppTheme.primary(context),
              ),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: RawScrollbar(
            crossAxisMargin: 15,
            thumbColor: AppTheme.primaryColor,
            radius: const Radius.circular(30),
            child: SingleChildScrollView(
              controller: controller.choosePostsScrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Column(
                  children: [
                    postsGrid(),
                    const SizedBox(height: 16),
                    Obx(
                      () => controller.isPostsLoading.value
                          ? AppWidgets.loading
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget postsGrid() {
    return Obx(() {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Obx(() {
            var post = controller.posts[index];
            return SelectImageWidget(
              imageUrl: post.thumbnailSrc,
              onTap: () => controller.postSelected(post),
              countInfo: controller.selectedPlan.countInfo,
              isSelected: controller.selectedPosts.contains(post),
              count: controller.count,
            );
          });
        },
      );
    });
  }
}
