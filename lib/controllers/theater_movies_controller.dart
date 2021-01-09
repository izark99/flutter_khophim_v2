import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:web_scraper/web_scraper.dart';

class TheaterMoviesController extends GetxController {
  final webScraper = WebScraper('https://dongphym.net');
  var nameList = <String>[].obs;
  var linkList = <String>[].obs;
  var imageList = <String>[].obs;
  Future<void> loadTheaterMoviesList() async {
    List<Map<String, dynamic>> _tempList = [];
    if (await webScraper.loadWebPage('/album/phim-chieu-rap_XAcsAQ9V.html')) {
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
      }
      _tempList.clear();
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
    }
  }

  void loadMore(int page) async {
    List<Map<String, dynamic>> _tempList = [];
    List<String> _tempListString = [];
    if (await webScraper
        .loadWebPage('/album/phim-chieu-rap_XAcsAQ9V.html?p=$page')) {
      _tempList = webScraper.getElement(
        'div.flex-wrap-movielist > a.movie-item',
        ['title', 'href'],
      );
      for (int i = 0; i < _tempList.length; i++) {
        _tempListString.add(
          _tempList[i]['attributes']['title'],
        );
      }
      nameList += _tempListString;
      _tempListString.clear();
      for (int i = 0; i < _tempList.length; i++) {
        _tempListString.add(
          _tempList[i]['attributes']['href'],
        );
      }
      linkList += _tempListString;
      _tempListString.clear();
      _tempList = webScraper.getElement(
        'div.flex-wrap-movielist > a.movie-item > div.pl-carousel-img',
        ['data-original'],
      );
      for (int i = 0; i < _tempList.length; i++) {
        _tempListString.add(
          _tempList[i]['attributes']['data-original'],
        );
      }
      imageList += _tempListString;
      _tempListString.clear();
      _tempList.clear();
      update();
    }
  }

  ScrollController scrollController = ScrollController();
  int page = 1;
  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadMore(page);
      page++;
    }
  }

  getLength(int length) {
    int newLength;
    for (int i = 0; i < length; i++) {
      if (i % CROSS_GRIDVIEW_MOVIE == 0) {
        newLength = i;
      }
    }
    return newLength;
  }

  @override
  void onReady() async {
    super.onReady();
    await loadTheaterMoviesList();
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
