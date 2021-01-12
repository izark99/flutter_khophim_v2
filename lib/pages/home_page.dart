import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:khophim/controllers/home_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/pages/tabs/favourite_tab.dart';
import 'package:khophim/pages/tabs/index_tab.dart';
import 'package:khophim/pages/tabs/search_tab.dart';
import 'package:khophim/widgets/custom_bottom_navigation_bar.dart';
import 'package:khophim/widgets/custom_icon.dart';
import 'package:khophim/widgets/custom_title.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context: context),
      body: Obx(() => _buildBody(context: context)),
      bottomNavigationBar: _buildBottomNavigationBar(context: context),
    );
  }
}

Widget _buildAppBar({@required BuildContext context}) {
  final HomeController _homeController = Get.find<HomeController>();
  return AppBar(
    brightness: Theme.of(context).primaryColorBrightness,
    elevation: 0.0,
    leading: CustomIcon(
      icon: Icons.account_circle_outlined,
      onTap: () => _homeController.showPopUpInfo(),
    ),
    centerTitle: true,
    title: CustomTitle(
      title: STR_APP_NAME,
      icon: Icons.movie,
    ),
    actions: [
      CustomIcon(
        icon: Icons.info_outline,
        onTap: () {
          _homeController.show.value = true;
          _homeController.showPopUpDonate();
        },
      ),
      SIZED_BOX_W10,
    ],
  );
}

Widget _buildBottomNavigationBar({@required BuildContext context}) {
  final HomeController _homeController = Get.find<HomeController>();
  return Obx(
    () => CustomBottomNavigationBar(
      tabs: [
        GButton(
          text: STR_HOME,
          icon: Icons.video_label,
        ),
        GButton(
          text: STR_FAVORITE,
          icon: Icons.favorite,
        ),
        GButton(
          text: STR_SEARCH,
          icon: Icons.search,
        ),
      ],
      selectedIndex: _homeController.tabIndexHomePage,
      onTabChange: (newIndex) =>
          _homeController.changeTabIndexHomePage(newIndex),
    ),
  );
}

Widget _buildBody({@required BuildContext context}) {
  final HomeController controller = Get.find<HomeController>();
  switch (controller.tabIndexHomePage) {
    case 1:
      return FavouriteTab();
      break;
    case 2:
      return SearchTab();
      break;
    default:
      return IndexTab();
  }
}
