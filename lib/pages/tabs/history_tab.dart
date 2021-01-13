import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/history_controller.dart';
import 'package:khophim/widgets/custom_movie_grid_view.dart';

class HistoryTab extends StatelessWidget {
  final HistoryController controller = Get.find<HistoryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.nameList.length > 0
          ? CustomMovieGridView(
              imageList: controller.imageList,
              linkList: controller.linkList,
              nameList: controller.nameList,
              itemCount: controller.nameList.length,
              name: "",
              scrollController: null,
            )
          : Container(),
    );
  }
}
