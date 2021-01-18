import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/movie_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/widgets/custom_chapter_grid_view.dart';
import 'package:khophim/widgets/custom_loading.dart';
import 'package:khophim/widgets/custom_movie_detail_image.dart';
import 'package:khophim/widgets/custom_movie_video_player.dart';

class MoviePage extends StatelessWidget {
  final MovieController _movieController = Get.find<MovieController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_movieController.movieName.value.length > 0) {
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return Scaffold(
                appBar: orientation == Orientation.portrait
                    ? AppBar(
                        brightness: Theme.of(context).primaryColorBrightness,
                        elevation: 0.0,
                        title: Text(
                          _movieController.movieName.value,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : null,
                body: Column(
                  children: [
                    _movieController.chapterLinkList.length > 0
                        ? CustomMovieVideoPlayer(
                            flickManager: _movieController.flickManager,
                          )
                        : CustomMovieDetailImage(
                            movieImage: _movieController.movieImage.value,
                          ),
                    Visibility(
                      visible: orientation == Orientation.portrait,
                      child: TextButton.icon(
                        onPressed: () => _movieController.rpErrorLink(),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.redAccent,
                        ),
                        icon: Icon(Icons.link_off_rounded, size: 20),
                        label: Text(
                          "BÁO LINK PHIM BỊ LỖI",
                          style: Get.theme.textTheme.bodyText2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _movieController.chapterNameList.length > 0 &&
                          orientation == Orientation.portrait,
                      child: Expanded(
                        child: CustomChapterGridView(
                          chapterLinkList: _movieController.chapterLinkList,
                          chapterNameList: _movieController.chapterNameList,
                          chapterLinkListHistory:
                              _movieController.chapterLinkListHistory,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _movieController.chapterLinkList.length == 0 &&
                          orientation == Orientation.portrait,
                      child: Padding(
                        padding: PAD_SYM_H10,
                        child: Text(
                          "Hiện tại phim \"" +
                              _movieController.movieName.value +
                              "\" chưa được phát hành",
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
