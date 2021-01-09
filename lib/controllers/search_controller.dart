import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:web_scraper/web_scraper.dart';

class SearchController extends GetxController {
  RxBool first = true.obs;
  RxBool minText = false.obs;
  RxBool showTextFormField = true.obs;
  final webScraper = WebScraper('https://dongphym.net');
  var nameList = <String>[].obs;
  var linkList = <String>[].obs;
  var imageList = <String>[].obs;
  final TextEditingController searchText = TextEditingController();
  void clear() {
    nameList?.clear();
    linkList?.clear();
    imageList?.clear();
  }

  Future<void> loadSearchList() async {
    clear();
    first.value = false;
    if (searchText.text.length < 5) {
      clear();
      minText.value = true;
    } else {
      List<Map<String, dynamic>> _tempList = [];
      if (await webScraper
          .loadWebPage('/content/search?t=kw&q=${searchText.text}')) {
        _tempList = webScraper.getElement(
          'div.wrapper > div.container > div > div.flex-wrap-movielist > a.movie-item',
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
          'div.wrapper > div.container > div > div.flex-wrap-movielist > a.movie-item > div.pl-carousel-img',
          ['data-original'],
        );
        for (int i = 0; i < _tempList.length; i++) {
          imageList.add(
            _tempList[i]['attributes']['data-original'],
          );
        }
        _tempList.clear();
      }

      minText.value = false;
    }
  }

  void loadMore(int page) async {
    List<Map<String, dynamic>> _tempList = [];
    List<String> _tempListString = [];
    if (await webScraper
        .loadWebPage('/content/search?t=kw&q=${searchText.text}&p=$page')) {
      _tempList = webScraper.getElement(
        'div.wrapper > div.container > div > div.flex-wrap-movielist > a.movie-item',
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
        'div.wrapper > div.container > div > div.flex-wrap-movielist > a.movie-item > div.pl-carousel-img',
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
    if (scrollController.position.keepScrollOffset) {
      FocusScope.of(Get.context).requestFocus(FocusNode());
    }
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      showTextFormField.value = true;
    } else {
      showTextFormField.value = false;
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
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
