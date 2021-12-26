import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/choose_posts/choose_posts_controller.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/add_button.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
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
    controller.scrollController = ScrollController(initialScrollOffset: 0.1)
      ..addListener(handleScrolling);
  }

  @override
  void dispose() {
    controller.scrollController.removeListener(handleScrolling);
    super.dispose();
  }

  void handleScrolling() {
    if (controller.scrollController.offset >=
        controller.scrollController.position.maxScrollExtent) {
      if (controller.canLoadMore()) {
        controller.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrderAppBar(title: 'Selected Account'),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BottomResetNavigation(
            resetPressed: controller.resetPressed,
            nextPressed: () => controller.nextPressed(context),
          ),
        ),
      ),
    );
  }

  Widget pageBody() {
    return Stack(
      children: [
        Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.isAccountListShown.value
                  ? Expanded(child: accountsWidget())
                  : accountsWidget(),
              const SizedBox(height: 26),
              Text(
                'Choose Posts',
                style: Theme.of(context).textTheme.headline3?.apply(
                      color: AppTheme.primary(context),
                    ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: choosePosts(),
              ),
            ],
          );
        }),

        // IgnorePointer(
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       height: MediaQuery.of(context).size.height / 3.6,
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [
        //             Color.fromRGBO(247, 248, 251, 1),
        //             Color.fromRGBO(247, 248, 251, 0),
        //           ],
        //           begin: Alignment.bottomCenter,
        //           end: Alignment.topCenter,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget accountsWidget() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: constraints.maxHeight / 2,
        ),
        color: AppTheme.isLightTheme(context)
            ? const Color(0xFFF7F8FB)
            : const Color(0xFF080704),
        child: Obx(() {
          return GestureDetector(
            onVerticalDragEnd: (details) => controller.isAccountListShown.value
                ? null
                : controller.toggleList(),
            child: Column(
              children: [
                controller.isAccountListShown.value
                    ? Expanded(
                        child: accountsList(),
                      )
                    : accountsList(),
                if (controller.isAccountListShown.value) ...[
                  const Divider(height: 0.5),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: AddButton(
                      text: 'Add Account',
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
                )
              ],
            ),
          );
        }),
      );
    });
  }

  Widget accountsList() {
    return ListView.builder(
      controller: ScrollController(),
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
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
    );
  }

  Widget choosePosts() {
    return RawScrollbar(
      crossAxisMargin: 15,
      thumbColor: AppTheme.primaryColor,
      radius: const Radius.circular(30),
      child: SingleChildScrollView(
        controller: controller.scrollController,
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
