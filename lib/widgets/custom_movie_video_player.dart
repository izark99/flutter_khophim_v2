import 'package:cached_flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomMovieVideoPlayer extends StatefulWidget {
  final FlickManager flickManager;

  const CustomMovieVideoPlayer({
    Key key,
    @required this.flickManager,
  }) : super(key: key);

  @override
  _CustomMovieVideoPlayerState createState() => _CustomMovieVideoPlayerState();
}

class _CustomMovieVideoPlayerState extends State<CustomMovieVideoPlayer> {
  @override
  void dispose() {
    super.dispose();
    widget.flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 9 / 16,
      child: FlickVideoPlayer(
        preferredDeviceOrientation: [
          DeviceOrientation.portraitUp,
        ],
        preferredDeviceOrientationFullscreen: [DeviceOrientation.landscapeLeft],
        flickManager: widget.flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          videoFit: BoxFit.fitWidth,
          controls: FlickPortraitControls(),
        ),
        flickVideoWithControlsFullscreen: FlickVideoWithControls(
          videoFit: BoxFit.contain,
          controls: FlickLandscapeControls(),
        ),
      ),
    );
  }
}
