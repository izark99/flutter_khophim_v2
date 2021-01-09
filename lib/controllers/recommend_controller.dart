import 'package:get/get.dart';
import 'package:web_scraper/web_scraper.dart';

class RecommendController extends GetxController {
  final webScraper = WebScraper('https://dongphym.net');
  var nameList = <String>[].obs;
  var linkList = <String>[].obs;
  var imageList = <String>[].obs;
  Future<void> loadRecommendList() async {
    List<Map<String, dynamic>> _tempList = [];
    if (await webScraper.loadWebPage('/')) {
      _tempList = webScraper.getElement(
        'div.banner-wrapper > div.bn-carousel > div.bn-carousel-cell > a',
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
      }
      _tempList.clear();
      _tempList = webScraper.getElement(
        'div.banner-wrapper > div.bn-carousel > div.bn-carousel-cell > a > div.bn-carousel-img',
        ['data-original'],
      );
      for (int i = 0; i < _tempList.length; i++) {
        imageList.add(
          _tempList[i]['attributes']['data-original'],
        );
      }
      _tempList.clear();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await loadRecommendList();
  }
}
