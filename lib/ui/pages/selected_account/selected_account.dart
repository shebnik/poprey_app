import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account_controller.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/add_button.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/ui/widgets/home_indicator.dart';
import 'package:poprey_app/ui/widgets/widgets.dart';
import 'package:poprey_app/utils/app_theme.dart';

class SelectedAccount extends StatefulWidget {
  static const routeName = '/selectedAccount';

  const SelectedAccount({
    Key? key,
  }) : super(key: key);

  @override
  _SelectedAccountState createState() => _SelectedAccountState();
}

class _SelectedAccountState extends State<SelectedAccount> {
  late final SelectedAccountController controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SelectedAccountController());
    _scrollController = ScrollController()..addListener(handleScrolling);
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }

  void handleScrolling() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      print(controller.posts.length);
      if (!controller.isPostsLoading.value && controller.posts.length < 48) {
        controller.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppTheme.primaryBlue),
        backgroundColor: const Color(0xFFF7F8FB),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Selected Account',
          style: Theme.of(context).textTheme.headline3!.apply(
                color: AppTheme.primary,
              ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(32),
        //   child: AccountTile(
        //     profile: controller.profile,
        //     radius: 16,
        //   ),
        // ),
      ),
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
          padding: const EdgeInsets.only(right: 12, top: 20),
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
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            accountsWidget(),
            const SizedBox(height: 26),
            Text(
              'Choose Posts',
              style: Theme.of(context).textTheme.headline3!.apply(
                    color: AppTheme.primary,
                  ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: choosePosts(),
            ),
          ],
        ),

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
    return Container(
      color: const Color(0xFFF7F8FB),
      child: Obx(() {
        return GestureDetector(
          onVerticalDragEnd: (details) => controller.toggleList(),
          child: Column(
            children: [
              ListView.builder(
                controller: ScrollController(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.getAccountListCount(),
                itemBuilder: (context, index) {
                  var profile = controller.profilesManager.profiles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
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
              if (controller.isAccountListShown.value) ...[
                const Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: AddButton(
                    text: 'Add Account',
                    onPressed: controller.addAccount,
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
  }

  Widget choosePosts() {
    return RawScrollbar(
      crossAxisMargin: 15,
      thumbColor: AppTheme.primary,
      radius: const Radius.circular(30),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            children: [
              postsGrid(),
              const SizedBox(height: 16),
              Obx(
                () => controller.isPostsLoading.value
                    ? Widgets.loading
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
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: GestureDetector(
                onTap: () => controller.postSelected(post),
                child: Stack(
                  children: [
                    Image.network(
                      post.thumbnailSrc,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    if (controller.selectedPosts.contains(post)) ...[
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(4, 4, 4, 0.6),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                controller.count,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          });
        },
      );
    });
  }
}
