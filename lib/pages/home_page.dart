import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:khophim/controllers/home_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/pages/tabs/index_tab.dart';
import 'package:khophim/widgets/custom_bottom_navigation_bar.dart';
import 'package:khophim/widgets/custom_title.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context: context),
      body: _buildBody(context: context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

Widget _buildAppBar({@required BuildContext context}) {
  return AppBar(
    brightness: Theme.of(context).primaryColorBrightness,
    elevation: 0.0,
    title: CustomTitle(
      title: STR_APP_NAME,
      icon: Icons.movie,
    ),
  );
}

Widget _buildBottomNavigationBar() {
  final HomeController _homeController = Get.find<HomeController>();
  return Obx(
    () => CustomBottomNavigationBar(
      tabs: [
        GButton(
          text: STR_HOME,
          icon: Icons.video_label,
        ),
        GButton(
          text: STR_SEARCH,
          icon: Icons.search,
        ),
        GButton(
          text: STR_FAVORITE,
          icon: Icons.favorite,
        ),
        GButton(
          text: STR_PROFILE,
          icon: Icons.person,
        ),
      ],
      selectedIndex: _homeController.tabIndexHomePage,
      onTabChange: (newIndex) =>
          _homeController.changeTabIndexHomePage(newIndex),
    ),
  );
}

Widget _buildBody({@required BuildContext context}) {
  return IndexTab();
}
