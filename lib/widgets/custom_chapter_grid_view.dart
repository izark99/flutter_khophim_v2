import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/movie_controller.dart';
import 'package:khophim/helpers/constant.dart';

class CustomChapterGridView extends StatelessWidget {
  final List<String> chapterNameList;
  final List<String> chapterLinkList;
  const CustomChapterGridView({
    Key key,
    @required this.chapterNameList,
    @required this.chapterLinkList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PAD_ALL_10,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
          itemCount: chapterNameList.length,
          itemBuilder: (BuildContext context, int index) {
            final MovieController _movieController =
                Get.find<MovieController>();
            return Obx(
              () => FlatButton(
                color: _movieController.index.value == index
                    ? Color.fromRGBO(100, 149, 237, 1.0)
                    : Theme.of(context).accentColor,
                onPressed: () {
                  _movieController.changeChapter(index);
                },
                child: Obx(
                  () => Text(
                    "Tập " +
                        chapterNameList[index]
                            .toString()
                            .replaceAll("Thuyết Minh", "TM"),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: _movieController.index.value == index
                              ? Colors.white
                              : Theme.of(context).canvasColor,
                        ),
                  ),
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: CROSS_GRIDVIEW_CHAPTER,
            mainAxisSpacing: SPACING,
            crossAxisSpacing: SPACING,
            childAspectRatio: ASPECT_RATIO_GRIDVIEW_CHAPTER,
          ),
        ),
      ),
    );
  }
}
