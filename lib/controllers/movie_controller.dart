import 'package:cached_flick_video_player/flick_video_player.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:get/state_manager.dart';
import 'package:web_scraper/web_scraper.dart';

class MovieController extends GetxController {
  final webScraper = WebScraper('https://dongphym.net');
  var chapterNameList = <String>[].obs;
  var chapterLinkList = <String>[].obs;
  RxString movieName = "".obs;
  RxString movieImage = "".obs;
  RxString codeMovie = "".obs;
  RxString codeChapter = "".obs;
  FlickManager flickManager;
  RxInt index = 0.obs;

  void clear() {
    chapterNameList.clear();
    chapterLinkList.clear();
    movieName.value = "";
    movieImage.value = "";
    codeMovie.value = "";
    codeChapter.value = "";
    index.value = 0;
  }

  void loadDetail(String url) async {
    url = url.replaceAll('https://dongphym.net', "").trim();
    codeMovie.value = url.split("_")[1].split(".html")[0];
    List<Map<String, dynamic>> _tempList = [];
    if (await webScraper.loadWebPage(url)) {
      _tempList = webScraper.getElement(
        'div.wrapper > div.container > div.row > div.col-sm-4 > div.center > img',
        ['title'],
      );
      movieName.value = _tempList[0]['attributes']['title'].toString();
      _tempList.clear();
      _tempList = webScraper.getElement(
        'div.wrapper > div.container > div.row > div.col-sm-4 > div.center > img',
        ['data-original'],
      );
      movieImage.value = _tempList[0]['attributes']['data-original'].toString();
      _tempList.clear();
      _tempList = webScraper.getElement(
        'div.wrapper > div.container > div.row > div.col-sm-8 > div.movie-rate > div.rate-star > div.movie-eps-all > div.movie-eps-wrapper > a.movie-eps-item',
        ['title', 'href'],
      );
      for (int i = 0; i < _tempList.length; i++) {
        chapterLinkList.add(_tempList[i]['attributes']['href']);
        chapterNameList
            .add(_tempList[i]['attributes']['title'].replaceAll("Tập ", ""));
      }
      _tempList.clear();
      if (chapterLinkList.length > 0) {
        codeChapter.value =
            chapterLinkList[index.value].split("_")[1].split(".html")[0];
        flickManager = FlickManager(
          videoPlayerController: CachedVideoPlayerController.network(
              "https://asia00.fbcdn.space/rawhls/${codeMovie.value}/${codeChapter.value}-b2.m3u8"),
        );
      }
    }
  }

  void changeChapter(int index) {
    this.index.value = index;
    codeChapter.value =
        chapterLinkList[this.index.value].split("_")[1].split(".html")[0];
    flickManager.handleChangeVideo(
      CachedVideoPlayerController.network(
          "https://asia00.fbcdn.space/rawhls/${codeMovie.value}/${codeChapter.value}-b2.m3u8"),
    );
  }

  @override
  void onClose() {
    super.onClose();
    flickManager.dispose();
  }
}
