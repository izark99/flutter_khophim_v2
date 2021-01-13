import 'package:get/get.dart';
import 'package:web_scraper/web_scraper.dart';

import 'home_controller.dart';

class RecommendController extends GetxController {
  final webScraper = WebScraper('https://dongphym.net');
  var nameList = <String>[].obs;
  var linkList = <String>[].obs;
  var imageList = <String>[].obs;
  var imageDList = <String>[].obs;

  Future<String> getImgD(String url) async {
    url = url.replaceAll('https://dongphym.net', "").trim();
    List<Map<String, dynamic>> _tempList = [];
    if (await webScraper.loadWebPage(url)) {
      _tempList = webScraper.getElement(
        'div.wrapper > div.container > div.row > div.col-sm-4 > div.center > img',
        ['data-original'],
      );
      return _tempList[0]['attributes']['data-original'].toString();
    }
    return "Error";
  }

  Future<void> loadRecommendList() async {
    List<Map<String, dynamic>> _tempList = [];
    if (await webScraper
        .loadWebPage('/album/dong-de-cu-cho-ban_qTH59gYv.html')) {
      _tempList = webScraper.getElement(
        'div.wrapper > div.container > div.flex-wrap-movielist > a.movie-item > div.pl-carousel-img',
        ['data-original'],
      );
      for (int i = 0; i < _tempList.length; i++) {
        imageList.add(
          _tempList[i]['attributes']['data-original'],
        );
      }
      _tempList.clear();
      _tempList = webScraper.getElement(
        'div.wrapper > div.container > div.flex-wrap-movielist > a.movie-item',
        ['title', 'href'],
      );
      for (int i = 0; i < _tempList.length; i++) {
        nameList.add(
          _tempList[i]['attributes']['title'],
        );
      }
      for (int i = 0; i < _tempList.length; i++) {
        linkList.add(
          _tempList[i]['attributes']['href'],
        );
        imageDList.add(await getImgD(_tempList[i]['attributes']['href']));
      }
      _tempList.clear();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    HomeController().showPopUpDonate();
    await loadRecommendList();
  }
}
