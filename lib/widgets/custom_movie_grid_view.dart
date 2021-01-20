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
  final bool showDel;
  final bool ok;

  const CustomMovieGridView({
    Key key,
    @required this.name,
    @required this.scrollController,
    @required this.itemCount,
    @required this.nameList,
    @required this.imageList,
    @required this.linkList,
    @required this.showDel,
    @required this.ok,
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
            return Stack(
              children: [
                GestureDetector(
                  onTap: ok
                      ? () {
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
                        }
                      : () {},
                  child: CustomMovieItem(
                    name: nameList[index],
                    image: imageList[index],
                  ),
                ),
                showDel
                    ? Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () => Get.find<HistoryController>()
                              .delHistoryMovie(url: linkList[index]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(BORDER_RADIUS),
                            child: Container(
                              padding: PAD_ALL_01,
                              color: Theme.of(context).accentColor,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS),
                                child: Container(
                                  padding: PAD_ALL_05,
                                  color: Theme.of(context)
                                      .canvasColor
                                      .withOpacity(0.8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Theme.of(context).accentColor,
                                        size: 16,
                                      ),
                                      SIZED_BOX_W05,
                                      Text(
                                        "XOÁ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
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
