import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/movie_controller.dart';
import 'package:khophim/helpers/constant.dart';

import 'custom_movie_item.dart';

class CustomMovieListView extends StatelessWidget {
  final List<String> imageList;
  final List<String> nameList;
  final List<String> linkList;

  const CustomMovieListView({
    Key key,
    @required this.imageList,
    @required this.nameList,
    @required this.linkList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PAD_SYM_H05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final MovieController movieController =
                  Get.find<MovieController>();
              movieController.clear();
              movieController.loadDetail(linkList[index]);
              Get.toNamed("/Movie");
            },
            child: CustomMovieItem(
              image: imageList[index],
              name: nameList[index],
            ),
          );
        },
      ),
    );
  }
}
