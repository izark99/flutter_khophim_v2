import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/home_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/pages/tabs/history_tab.dart';
import 'package:khophim/pages/tabs/index_tab.dart';
import 'package:khophim/pages/tabs/search_tab.dart';
import 'package:khophim/widgets/custom_bottom_navigation_bar.dart';
import 'package:khophim/widgets/custom_icon.dart';
import 'package:khophim/widgets/custom_loading.dart';
import 'package:khophim/widgets/custom_title.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.code.value != "VN"
          ? Scaffold(
              appBar: _buildAppBar(context: context),
              body: _buildBody(context: context),
              bottomNavigationBar: _buildBottomNavigationBar(context: context),
            )
          : Scaffold(
              appBar: _buildAppBar(context: context),
              body: _buildBodyDB(context: context),
            ),
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

Widget _buildBodyDB({@required BuildContext context}) {
  final HomeController controller = Get.find<HomeController>();
  return controller.results.length > 0
      ? Padding(
          padding: PAD_SYM_H05,
          child: GridView.builder(
            controller: controller.scrollController,
            itemCount: controller.getLength(controller.results.length),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),
                  color: Theme.of(context).accentColor,
                ),
                margin: PAD_ALL_05,
                padding: PAD_ALL_01,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(BORDER_RADIUS),
                        ),
                        child: Container(
                          padding: PAD_ALL_01,
                          color: Theme.of(context).canvasColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(BORDER_RADIUS),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: "https://image.tmdb.org/t/p/w500/" +
                                  controller.results[index].posterPath
                                      .toString(),
                              width: 130,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.error, size: ICON_SIZE_M),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(BORDER_RADIUS),
                      ),
                      child: Container(
                        padding: PAD_ALL_01,
                        color: Theme.of(context).canvasColor,
                        child: Container(
                          alignment: Alignment.center,
                          padding: PAD_ALL_05,
                          height: 40,
                          width: 130,
                          child: Text(
                            controller.results[index].title ?? "404",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context).accentColor,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: ASPECT_RATIO_GRIDVIEW_MOVIE,
              maxCrossAxisExtent: 130,
            ),
          ),
        )
      : CustomLoading();
}
