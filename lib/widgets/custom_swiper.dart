import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/movie_controller.dart';
import 'package:khophim/helpers/constant.dart';

class CustomSwiper extends StatelessWidget {
  final List<String> nameList;
  final List<String> imageList;
  final List<String> linkList;
  const CustomSwiper({
    Key key,
    @required this.imageList,
    @required this.nameList,
    @required this.linkList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            final MovieController movieController = Get.find<MovieController>();
            movieController.clear();
            movieController.loadDetail(linkList[index]);
            Get.toNamed("/Movie");
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(BORDER_RADIUS),
            child: Container(
              color: Theme.of(context).accentColor,
              padding: PAD_ALL_01,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(BORDER_RADIUS),
                    child: Column(
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageList[index],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                backgroundColor: Theme.of(context).canvasColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Icons.error,
                                size: ICON_SIZE_M,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            nameList[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context).accentColor,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: imageList.length,
      viewportFraction: 0.8,
      scale: 0.9,
      autoplay: true,
    );
  }
}
