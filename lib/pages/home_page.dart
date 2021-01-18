import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/home_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/pages/tabs/history_tab.dart';
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
      currentIndex: _homeController.tabIndexHomePage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.video_label),
          label: STR_HOME,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: STR_HISTORY,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: STR_SEARCH,
        ),
      ],
      onTap: (newIndex) => _homeController.changeTabIndexHomePage(newIndex),
    ),
  );
}

Widget _buildBody({@required BuildContext context}) {
  final HomeController controller = Get.find<HomeController>();
  switch (controller.tabIndexHomePage) {
    case 1:
      return HistoryTab();
      break;
    case 2:
      return SearchTab();
      break;
    default:
      return IndexTab();
  }
}
