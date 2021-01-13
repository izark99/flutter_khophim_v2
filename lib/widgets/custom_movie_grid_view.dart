import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/history_controller.dart';
import 'package:khophim/controllers/movie_controller.dart';
import 'package:khophim/helpers/constant.dart';

import 'custom_movie_item.dart';

class CustomMovieGridView extends StatelessWidget {
  final String name;
  final ScrollController scrollController;
  final int itemCount;
  final List<String> nameList;
  final List<String> imageList;
  final List<String> linkList;

  const CustomMovieGridView({
    Key key,
    @required this.name,
    @required this.scrollController,
    @required this.itemCount,
    @required this.nameList,
    @required this.imageList,
    @required this.linkList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: name.isEmpty
          ? null
          : AppBar(
              brightness: Theme.of(context).primaryColorBrightness,
              elevation: 0.0,
              title: Text(
                name,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.start,
              ),
            ),
      body: Padding(
        padding: PAD_SYM_H05,
        child: GridView.builder(
          controller: scrollController,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                final MovieController movieController =
                    Get.find<MovieController>();
                final HistoryController historyController =
                    Get.find<HistoryController>();
                historyController.addToHistoryList(
                  url: linkList[index],
                  name: nameList[index],
                  img: imageList[index],
                );
                movieController.clear();
                movieController.loadDetail(linkList[index]);
                Get.toNamed("/Movie");
              },
              child: CustomMovieItem(
                name: nameList[index],
                image: imageList[index],
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: ASPECT_RATIO_GRIDVIEW_MOVIE,
            maxCrossAxisExtent: 130,
          ),
        ),
      ),
    );
  }
}
