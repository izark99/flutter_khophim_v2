import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  RxInt _tabIndexHomePage = 0.obs;
  RxBool show = true.obs;
  int get tabIndexHomePage => _tabIndexHomePage.value;
  void changeTabIndexHomePage(int newIndex) {
    _tabIndexHomePage.value = newIndex;
  }

  void showPopUpDonate() {
    if (show.value == true) {
      Get.defaultDialog(
        radius: 20,
        title: "ỦNG HỘ TÁC GIẢ",
        backgroundColor: Colors.white,
        titleStyle:
            Get.theme.textTheme.headline5.copyWith(color: Colors.black87),
        content: Text(
          "Ứng dụng được phát triển bởi Izark Nguyễn. Nếu bạn thích nó, hãy Donate cho mình <3",
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.bodyText1.copyWith(color: Colors.black87),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              String url = "https://nhantien.momo.vn/khophim";
              await launch(url);
            },
            child: Text(
              ">> Donate qua MOMO <<",
              style:
                  Get.theme.textTheme.bodyText1.copyWith(color: Colors.black87),
            ),
          )
        ],
      );
    }
    show.value = false;
  }
}
