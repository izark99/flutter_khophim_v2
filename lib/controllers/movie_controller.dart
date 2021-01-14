import 'package:cached_flick_video_player/flick_video_player.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/account_controller.dart';
import 'package:khophim/services/database_service.dart';
import 'package:web_scraper/web_scraper.dart';

import 'auth_controller.dart';

class MovieController extends GetxController {
  final DatabaseService database = DatabaseService();
  final webScraper = WebScraper('https://dongphym.net');
  var chapterNameList = <String>[].obs;
  var chapterLinkList = <String>[].obs;
  var chapterLinkListHistory = <String>[].obs;
  RxString movieName = "".obs;
  RxString movieImage = "".obs;
  RxString codeMovie = "".obs;
  var codeChapterList = <String>[].obs;
  FlickManager flickManager;
  RxInt index = 0.obs;
  RxString urlChangeChapter = "".obs;
  RxString urlMovie = "".obs;

  void clear() {
    chapterNameList.clear();
    chapterLinkList.clear();
    movieName.value = "";
    movieImage.value = "";
    codeMovie.value = "";
    codeChapterList.clear();
    index.value = 0;
    urlChangeChapter.value = "";
    chapterLinkListHistory.clear();
    urlMovie.value = "";
  }

  void loadDetail(String url) async {
    urlMovie.value = url;
    String urlTemp = url.replaceAll('https://dongphym.net', "").trim();
    codeMovie.value = url.split("_")[1].split(".html")[0];
    List<Map<String, dynamic>> _tempList = [];
    if (await webScraper.loadWebPage(urlTemp)) {
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
        ['title', 'href', 'data-id'],
      );
      for (int i = 0; i < _tempList.length; i++) {
        chapterLinkList.add(_tempList[i]['attributes']['href']);
        chapterNameList.add(_tempList[i]['attributes']['title']);
        codeChapterList.add(_tempList[i]['attributes']['data-id']);
      }
      _tempList.clear();
      if (chapterLinkList.length > 0) {
        this.index.value = chapterLinkList.length - 1;
        urlChangeChapter.value = chapterLinkList[this.index.value];
        flickManager = FlickManager(
          videoPlayerController: CachedVideoPlayerController.network(
              "https://asia00.fbcdn.space/rawhls/${codeMovie.value}/${codeChapterList[this.index.value]}-b2.m3u8"),
        );
        await database.addChapter(
            uid: Get.find<AccountController>().account.uid,
            url: url.replaceAll("/", ">"),
            urlChapter: chapterLinkList[this.index.value]);
      }
    }
  }

  void changeChapter(int index) async {
    this.index.value = index;

    flickManager.handleChangeVideo(
      CachedVideoPlayerController.network(
          "https://asia00.fbcdn.space/rawhls/${codeMovie.value}/${codeChapterList[this.index.value]}-b2.m3u8"),
    );
    await database.addChapter(
        uid: Get.find<AccountController>().account.uid,
        url: urlMovie.value.replaceAll("/", ">"),
        urlChapter: chapterLinkList[this.index.value]);
  }

  @override
  void onReady() {
    super.onReady();
    ever(
      urlChangeChapter,
      (value) {
        chapterLinkListHistory.bindStream(
          database.streamChapter(
              uid: Get.find<AuthController>().user.uid, url: urlMovie.value),
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    flickManager.dispose();
  }
}
