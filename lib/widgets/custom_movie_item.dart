import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';

class CustomMovieItem extends StatelessWidget {
  final String name;
  final String image;

  const CustomMovieItem({
    Key key,
    @required this.name,
    @required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        color: Theme.of(context).accentColor,
      ),
      margin: PAD_ALL_05,
      padding: PAD_ALL_01,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(BORDER_RADIUS),
              ),
              child: Container(
                padding: PAD_ALL_01,
                color: Theme.of(context).canvasColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(BORDER_RADIUS),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: 130,
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
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(BORDER_RADIUS),
            ),
            child: Container(
              padding: PAD_ALL_01,
              color: Theme.of(context).canvasColor,
              child: Container(
                alignment: Alignment.center,
                padding: PAD_ALL_05,
                height: 40,
                width: 130,
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
