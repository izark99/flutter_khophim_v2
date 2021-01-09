import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/widgets/custom_movie_grid_view.dart';
import 'package:khophim/widgets/custom_loading.dart';

class SeeAllPage extends StatelessWidget {
  final controller;
  final String name;

  const SeeAllPage({
    Key key,
    @required this.controller,
    @required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.nameList.length > 0) {
          return CustomMovieGridView(
            name: name,
            scrollController: controller.scrollController,
            itemCount: controller.getLength(controller.nameList.length),
            nameList: controller.nameList,
            imageList: controller.imageList,
            linkList: controller.linkList,
          );
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
