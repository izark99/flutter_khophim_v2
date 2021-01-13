import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/services/database_service.dart';

import 'account_controller.dart';
import 'auth_controller.dart';

class HistoryController extends GetxController {
  final DatabaseService database = DatabaseService();
  ScrollController scrollController = ScrollController();
  RxInt limit = 15.obs;
  RxInt maxLength = 0.obs;
  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (limit.value > maxLength.value) {
        limit.value = maxLength.value;
      } else {
        limit.value = limit.value + 15;
      }
    }
  }

  var nameList = <String>[].obs;
  var linkList = <String>[].obs;
  var imageList = <String>[].obs;

  void addToHistoryList({
    @required String url,
    @required String name,
    @required String img,
  }) async {
    await database.addToHistoryList(
      uid: Get.find<AccountController>().account.uid,
      url: url,
      img: img,
      name: name,
    );
  }

  @override
  void onReady() async {
    super.onReady();
    scrollController.addListener(scrollListener);
    ever(
      imageList,
      (value) async {
        maxLength.value = await database.getLengthHistoryList(
            uid: Get.find<AuthController>().user.uid);
      },
    );
    ever(
      limit,
      (int value) {
        if (Get.find<AuthController>().user.uid != null) {
          nameList.bindStream(
            database.streamHistoryNameList(
              uid: Get.find<AuthController>().user.uid,
              limit: value,
            ),
          );
          linkList.bindStream(
            database.streamHistoryLinkList(
              uid: Get.find<AuthController>().user.uid,
              limit: value,
            ),
          );
          imageList.bindStream(
            database.streamHistoryImageList(
              uid: Get.find<AuthController>().user.uid,
              limit: value,
            ),
          );
        } else {
          imageList.clear();
          nameList.clear();
          linkList.clear();
        }
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
