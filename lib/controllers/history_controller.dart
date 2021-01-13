import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/services/database_service.dart';

import 'account_controller.dart';

class HistoryController extends GetxController {
  final DatabaseService database = DatabaseService();
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
}
