import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/movie_controller.dart';
import 'package:khophim/helpers/constant.dart';

class CustomChapterGridView extends StatelessWidget {
  final List<String> chapterNameList;
  final List<String> chapterLinkList;
  final List<String> chapterLinkListHistory;
  const CustomChapterGridView({
    Key key,
    @required this.chapterNameList,
    @required this.chapterLinkList,
    @required this.chapterLinkListHistory,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PAD_ALL_10,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
          itemCount: chapterLinkList.length,
          itemBuilder: (BuildContext context, int index) {
            final MovieController _movieController =
                Get.find<MovieController>();
            return Obx(
              () => Stack(
                children: [
                  TextButton(
                    onPressed: () {
                      _movieController.changeChapter(index);
                    },
                    style: TextButton.styleFrom(
                      primary: _movieController.index.value == index
                          ? Colors.white
                          : Theme.of(context).canvasColor,
                      backgroundColor: _movieController.index.value == index
                          ? Color.fromRGBO(100, 149, 237, 1.0)
                          : Theme.of(context).accentColor,
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      padding: PAD_SYM_H10,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        chapterNameList[index].replaceAll("Thuyết Minh", "TM"),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  chapterLinkListHistory.contains(chapterLinkList[index])
                      ? Positioned(
                          right: 1,
                          top: 1,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.redAccent,
                            size: 12,
                          ),
                        )
                      : Container(),
                ],
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
