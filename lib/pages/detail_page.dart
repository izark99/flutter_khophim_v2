import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/models/detail_model.dart';
import 'package:khophim/services/res_service.dart';
import 'package:khophim/widgets/custom_button.dart';
import 'package:khophim/widgets/custom_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final int movieID;

  const DetailPage({Key key, @required this.movieID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailModel>(
      future: ResService().getDetail(movieID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500/" +
                    snapshot.data.posterPath,
                width: 130,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.error, size: ICON_SIZE_M),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: new Container(
                  color: Theme.of(context).canvasColor.withOpacity(0.2),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: PAD_ALL_10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SIZED_BOX_H20,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: "https://image.tmdb.org/t/p/w500/" +
                                snapshot.data.posterPath,
                            width: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.error, size: ICON_SIZE_M),
                            ),
                          ),
                        ),
                        SIZED_BOX_H20,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: PAD_ALL_10,
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.8),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data.title,
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.center,
                                ),
                                SIZED_BOX_H05,
                                Text(
                                  snapshot.data.voteAverage.toString() + "/10",
                                  style: Theme.of(context).textTheme.headline5,
                                  textAlign: TextAlign.center,
                                ),
                                SIZED_BOX_H15,
                                Text(
                                  snapshot.data.overview.isEmpty
                                      ? "CHƯA CÓ ĐÁNH GIÁ"
                                      : snapshot.data.overview,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(wordSpacing: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SIZED_BOX_H15,
                        CustomButton(
                          onPressed: () async {
                            String url =
                                "https://www.google.com/search?q=${snapshot.data.title.toString()}";
                            await launch(url);
                          },
                          buttonName: "TÌM TRÊN GOOGLE",
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
