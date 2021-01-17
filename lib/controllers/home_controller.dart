import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/account_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/widgets/custom_button.dart';
import 'package:khophim/widgets/custom_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_time_format/date_time_format.dart';

import 'auth_controller.dart';

class HomeController extends GetxController {
  RxInt _tabIndexHomePage = 0.obs;
  RxBool show = true.obs;
  RxBool hideCurrentPassword = true.obs;
  RxBool hideNewPassword = true.obs;

  int get tabIndexHomePage => _tabIndexHomePage.value;
  void changeTabIndexHomePage(int newIndex) {
    _tabIndexHomePage.value = newIndex;
  }

  void showHideCurrentPassword() {
    hideCurrentPassword.value = !hideCurrentPassword.value;
  }

  void showHideNewPassword() {
    hideNewPassword.value = !hideNewPassword.value;
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
                Container(
                  width: Get.context.size.width,
                  child: TextButton.icon(
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
                ),
                SIZED_BOX_H05,
              ],
            ),
            SIZED_BOX_H05,
            Column(
              children: [
                SIZED_BOX_H10,
                Text(
                  "Theo dõi kênh Telegram để nhận thông báo về phiên bản mới nhất",
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.bodyText1
                      .copyWith(color: Get.theme.accentColor),
                ),
                Container(
                  width: Get.context.size.width,
                  child: TextButton.icon(
                    onPressed: () async {
                      String url = "https://t.me/kho_phim";
                      await launch(url);
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.lightBlue,
                    ),
                    icon: Icon(Icons.group_outlined),
                    label: Text(
                      "Theo dõi kênh Telegram",
                      style: Get.theme.textTheme.bodyText1
                          .copyWith(color: Colors.white),
                    ),
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

  void showPopUpInfo() {
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
          Text(
            "THÔNG TIN TÀI KHOẢN",
            style: Get.context.theme.textTheme.headline5,
          ),
          SIZED_BOX_H10,
          Obx(
            () => Get.find<AccountController>().account.email != null
                ? Text(
                    "Email: " + Get.find<AccountController>().account.email,
                    style: Get.context.theme.textTheme.bodyText1,
                  )
                : Container(),
          ),
          SIZED_BOX_H10,
          Obx(
            () => Get.find<AccountController>().account.createAt != null
                ? Text(
                    "Ngày tạo: " +
                        Get.find<AccountController>()
                            .account
                            .createAt
                            .format('d/m/Y'),
                    style: Get.context.theme.textTheme.bodyText1,
                  )
                : Container(),
          ),
          SIZED_BOX_H10,
          Obx(
            () => Get.find<AccountController>().account.createAt != null
                ? Text(
                    "Loại tài khoản: " +
                        Get.find<AccountController>().account.type,
                    style: Get.context.theme.textTheme.bodyText1,
                  )
                : Container(),
          ),
          SIZED_BOX_H10,
          Container(
            width: Get.context.size.width,
            child: TextButton.icon(
              onPressed: () {
                Get.find<AuthController>().currentPasswordText.clear();
                Get.find<AuthController>().newPasswordText.clear();
                showBottomSheet();
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.lightBlue,
              ),
              icon: Icon(Icons.lock_outline),
              label: Text(
                "ĐỔI MẬT KHẨU",
                style:
                    Get.theme.textTheme.bodyText1.copyWith(color: Colors.white),
              ),
            ),
          ),
          Container(
            width: Get.context.size.width,
            child: TextButton.icon(
              onPressed: () {
                Get.back();
                Get.find<AuthController>().signOut();
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.redAccent,
              ),
              icon: Icon(Icons.exit_to_app_outlined),
              label: Text(
                "ĐĂNG XUẤT",
                style:
                    Get.theme.textTheme.bodyText1.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet() {
    Get.back();
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Get.context.theme.accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: PAD_ALL_01,
        margin: PAD_ALL_10,
        child: Container(
          padding: PAD_ALL_10,
          decoration: BoxDecoration(
            color: Get.context.theme.canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SIZED_BOX_H05,
                Text(
                  "ĐỔI MẬT KHẨU",
                  style: Get.context.textTheme.headline5,
                ),
                SIZED_BOX_H10,
                Obx(
                  () => CustomTextFormField(
                    obscureText: hideCurrentPassword.value,
                    autofocus: true,
                    controller: Get.find<AuthController>().currentPasswordText,
                    hint: 'Mật khẩu hiện tại',
                    useOnChanged: false,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Get.context.theme.accentColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => showHideCurrentPassword(),
                      child: Icon(
                        hideCurrentPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Get.context.theme.accentColor,
                      ),
                    ),
                  ),
                ),
                SIZED_BOX_H10,
                Obx(
                  () => CustomTextFormField(
                    obscureText: hideNewPassword.value,
                    autofocus: true,
                    controller: Get.find<AuthController>().newPasswordText,
                    hint: 'Mật khẩu mới',
                    useOnChanged: false,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Get.context.theme.accentColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => showHideNewPassword(),
                      child: Icon(
                        hideNewPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Get.context.theme.accentColor,
                      ),
                    ),
                  ),
                ),
                SIZED_BOX_H10,
                CustomButton(
                  buttonName: "ĐỔI MẬT KHẨU",
                  onPressed: () => Get.find<AuthController>().changePassword(),
                  textStyle: Get.context.textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
