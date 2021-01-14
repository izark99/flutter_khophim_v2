import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/animated_movies_controller.dart';
import 'package:khophim/controllers/recommend_controller.dart';
import 'package:khophim/controllers/theater_movies_controller.dart';
import 'package:khophim/controllers/tv_series_controller.dart';
import 'package:khophim/controllers/tv_shows_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/pages/see_all_page.dart';
import 'package:khophim/widgets/custom_category_title.dart';
import 'package:khophim/widgets/custom_loading.dart';
import 'package:khophim/widgets/custom_movie_list_view.dart';
import 'package:khophim/widgets/custom_swiper.dart';

class IndexTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SIZED_BOX_H10,
          _buildRecommend(
            context: context,
            controller: Get.find<RecommendController>(),
          ),
          _buildListViewHorizontal(
            context: context,
            controller: Get.find<TVSeriesController>(),
            category: STR_TV_SERIES,
            onTap: () => Get.to(
              SeeAllPage(
                controller: Get.find<TVSeriesController>(),
                name: STR_TV_SERIES,
              ),
            ),
          ),
          _buildListViewHorizontal(
            context: context,
            controller: Get.find<TheaterMoviesController>(),
            category: STR_THEATER_MOVIE,
            onTap: () => Get.to(
              SeeAllPage(
                controller: Get.find<TheaterMoviesController>(),
                name: STR_THEATER_MOVIE,
              ),
            ),
          ),
          _buildListViewHorizontal(
            context: context,
            controller: Get.find<AnimatedMoviesController>(),
            category: STR_ANIMATED_MOVIE,
            onTap: () => Get.to(
              SeeAllPage(
                controller: Get.find<AnimatedMoviesController>(),
                name: STR_ANIMATED_MOVIE,
              ),
            ),
          ),
          _buildListViewHorizontal(
            context: context,
            controller: Get.find<TVShowsController>(),
            category: STR_TV_SHOW,
            onTap: () => Get.to(
              SeeAllPage(
                controller: Get.find<TVShowsController>(),
                name: STR_TV_SHOW,
              ),
            ),
          ),
          SIZED_BOX_H10,
        ],
      ),
    );
  }
}

Widget _buildRecommend({
  @required BuildContext context,
  @required RecommendController controller,
}) {
  return Container(
    height: MediaQuery.of(context).size.width / 2,
    child: Obx(
      () {
        if (controller.imageDList.length > 5) {
          return CustomSwiper(
            imageList: controller.imageList,
            nameList: controller.nameList,
            linkList: controller.linkList,
            imageDList: controller.imageDList,
          );
        } else {
          return CustomLoading();
        }
      },
    ),
  );
}

Widget _buildListViewHorizontal({
  @required BuildContext context,
  @required controller,
  @required String category,
  @required Function onTap,
}) {
  return Column(
    children: [
      SIZED_BOX_H20,
      CustomCategoryTitle(
        title: category,
        onPressed: onTap,
      ),
      SIZED_BOX_H10,
      Container(
        height: 206,
        child: Obx(
          () {
            if (controller.nameList.length > 0) {
              return CustomMovieListView(
                imageList: controller.imageList,
                nameList: controller.nameList,
                linkList: controller.linkList,
              );
            } else {
              return CustomLoading();
            }
          },
        ),
      ),
    ],
  );
}
