import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/helpers/constant.dart';
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
        radius: 10,
        title: "",
        backgroundColor: Get.theme.canvasColor,
        titleStyle: Get.theme.textTheme.headline5.copyWith(
          color: Colors.black87,
          height: 0,
        ),
        content: Column(
          children: [
            ColorizeAnimatedTextKit(
              repeatForever: true,
              textAlign: TextAlign.center,
              textStyle:
                  Get.theme.textTheme.headline5.copyWith(color: Colors.black87),
              text: ["THÔNG TIN ỨNG DỤNG"],
              colors: [
                Colors.purple,
                Colors.blue,
                Colors.yellow,
                Colors.red,
              ],
            ),
            SIZED_BOX_H10,
            Column(
              children: [
                SIZED_BOX_H10,
                Text(
                  "Ứng dụng được phát triển bởi Izark. Nếu bạn thích nó, hãy Donate ♥",
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.bodyText1
                      .copyWith(color: Get.theme.accentColor),
                ),
                TextButton.icon(
                  onPressed: () async {
                    String url = "https://nhantien.momo.vn/khophim";
                    await launch(url);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.redAccent,
                  ),
                  icon: Icon(Icons.account_balance_outlined),
                  label: Text(
                    "Donate qua MOMO",
                    style: Get.theme.textTheme.bodyText1
                        .copyWith(color: Colors.white),
                  ),
                ),
                SIZED_BOX_H05,
              ],
            ),
            SIZED_BOX_H10,
            Column(
              children: [
                SIZED_BOX_H10,
                Text(
                  "Theo dõi kênh Telegram để nhận thông báo về phiên bản mới nhất",
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.bodyText1
                      .copyWith(color: Get.theme.accentColor),
                ),
                TextButton.icon(
                  onPressed: () async {
                    String url = "https://t.me/kho_phim";
                    await launch(url);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.deepOrange,
                  ),
                  icon: Icon(Icons.group_outlined),
                  label: Text(
                    "Theo dõi kênh Telegram",
                    style: Get.theme.textTheme.bodyText1
                        .copyWith(color: Colors.white),
                  ),
                ),
                SIZED_BOX_H05,
              ],
            ),
          ],
        ),
      );
    }
    show.value = false;
  }
}
