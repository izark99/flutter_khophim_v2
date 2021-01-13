import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/services/auth_service.dart';
import 'package:khophim/services/database_service.dart';
import 'package:khophim/widgets/custom_button.dart';
import 'package:khophim/widgets/custom_loading.dart';
import 'package:khophim/widgets/custom_text_form_field.dart';

import 'account_controller.dart';
import 'history_controller.dart';

class AuthController extends GetxController {
  final AuthService auth = AuthService();
  final DatabaseService database = DatabaseService();
  final RxBool isSignInUI = true.obs;
  final RxBool obscureText = true.obs;
  Rx<User> _user = Rx<User>();
  User get user => _user.value;
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController emailTextForgot = TextEditingController();
  final TextEditingController currentPasswordText = TextEditingController();
  final TextEditingController newPasswordText = TextEditingController();

  void changeUI() {
    isSignInUI.value = !isSignInUI.value;
  }

  void showHide() {
    obscureText.value = !obscureText.value;
  }

  void showBottomSheet() {
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
                  "QUÊN MẬT KHẨU",
                  style: Get.context.textTheme.headline5,
                ),
                SIZED_BOX_H10,
                CustomTextFormField(
                  autofocus: true,
                  controller: emailTextForgot,
                  hint: 'Email của bạn',
                  useOnChanged: false,
                ),
                SIZED_BOX_H10,
                CustomButton(
                  buttonName: "GỬI EMAIL KHÔI PHỤC",
                  onPressed: () => fotgotPassword(),
                  textStyle: Get.context.textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 10,
      title: "",
      backgroundColor: Get.theme.canvasColor,
      titleStyle: Get.theme.textTheme.headline5.copyWith(
        color: Colors.black87,
        height: 0,
      ),
      content: CustomLoading(text: "ĐANG TẠO TÀI KHOẢN"),
      onWillPop: () async => false,
    );
    String resultAuth = await auth.signUp(
      email: emailText.text.trim(),
      password: passwordText.text.trim(),
    );
    Get.back();
    if (resultAuth != "Success") {
      switch (resultAuth) {
        case "Email or password is empty":
          Get.snackbar(
            "ĐĂNG KÝ THẤT BẠI",
            "Email hoặc mật khẩu không được để trống",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "Email is wrong format":
          Get.snackbar(
            "ĐĂNG KÝ THẤT BẠI",
            "Email bị sai định dạng",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "Email address is already in use":
          Get.snackbar(
            "ĐĂNG KÝ THẤT BẠI",
            "Email này đã được sử dụng",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "No internet connection":
          Get.snackbar(
            "ĐĂNG KÝ THẤT BẠI",
            "Không có kết nối Internet",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        default:
          Get.snackbar(
            "ĐĂNG KÝ THẤT BẠI",
            resultAuth,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
      }
    } else {
      await database.createAccount(
        uid: user.uid,
        email: emailText.text,
      );
      emailText.clear();
      passwordText.clear();
      emailTextForgot.clear();
    }
  }

  void signIn() async {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 10,
      title: "",
      backgroundColor: Get.theme.canvasColor,
      titleStyle: Get.theme.textTheme.headline5.copyWith(
        color: Colors.black87,
        height: 0,
      ),
      content: CustomLoading(text: "ĐANG ĐĂNG NHẬP"),
      onWillPop: () async => false,
    );
    String resultAuth = await auth.signIn(
      email: emailText.text.trim(),
      password: passwordText.text.trim(),
    );
    Get.back();
    if (resultAuth != "Success") {
      switch (resultAuth) {
        case "Email or password is empty":
          Get.snackbar(
            "ĐĂNG NHẬP THẤT BẠI",
            "Email hoặc mật khẩu không được để trống",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "Email is wrong format":
          Get.snackbar(
            "ĐĂNG NHẬP THẤT BẠI",
            "Email bị sai định dạng",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "Account with this email doesn't exist":
          Get.snackbar(
            "ĐĂNG NHẬP THẤT BẠI",
            "Tài khoản với email này không tồn tại",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "Wrong password":
          Get.snackbar(
            "ĐĂNG NHẬP THẤT BẠI",
            "Mật khẩu không chính xác",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "No internet connection":
          Get.snackbar(
            "ĐĂNG NHẬP THẤT BẠI",
            "Không có kết nối Internet",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        default:
          Get.snackbar(
            "ĐĂNG NHẬP THẤT BẠI",
            resultAuth,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
      }
    } else {
      emailText.clear();
      passwordText.clear();
      emailTextForgot.clear();
    }
  }

  void signOut() async {
    emailText.clear();
    passwordText.clear();
    emailTextForgot.clear();
    isSignInUI.value = true;
    await auth.signOut();
  }

  void fotgotPassword() async {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 10,
      title: "",
      backgroundColor: Get.theme.canvasColor,
      titleStyle: Get.theme.textTheme.headline5.copyWith(
        color: Colors.black87,
        height: 0,
      ),
      content: CustomLoading(text: "ĐANG GỬI EMAIL KHÔI PHỤC"),
      onWillPop: () async => false,
    );
    String resultAuth = await auth.forgotPassword(
      email: emailTextForgot.text.trim(),
    );
    if (resultAuth != "Success") {
      switch (resultAuth) {
        case "Email is empty":
          Get.snackbar(
            "GỬI EMAIL KHÔI PHỤC THẤT BẠI",
            "Email không được để trống",
            snackPosition: SnackPosition.TOP,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "Email is wrong format":
          Get.snackbar(
            "GỬI EMAIL KHÔI PHỤC THẤT BẠI",
            "Email bị sai định dạng",
            snackPosition: SnackPosition.TOP,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "Account with this email doesn't exist":
          Get.snackbar(
            "GỬI EMAIL KHÔI PHỤC THẤT BẠI",
            "Tài khoản với email này không tồn tại",
            snackPosition: SnackPosition.TOP,
            colorText: Get.context.theme.accentColor,
          );
          break;
        case "No internet connection":
          Get.snackbar(
            "GỬI EMAIL KHÔI PHỤC THẤT BẠI",
            "Không có kết nối Internet",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.context.theme.accentColor,
          );
          break;
        default:
          Get.snackbar(
            "GỬI EMAIL KHÔI PHỤC THẤT BẠI",
            resultAuth,
            snackPosition: SnackPosition.TOP,
            colorText: Get.context.theme.accentColor,
          );
          break;
      }
    } else {
      Get.back();
      emailText.clear();
      passwordText.clear();
      emailTextForgot.clear();
      Get.snackbar(
        "GỬI EMAIL KHÔI PHỤC THÀNH CÔNG",
        "Gửi email khôi phục thành công, vui lòng kiểm tra email và làm theo hướng dẫn",
        snackPosition: SnackPosition.TOP,
        colorText: Get.context.theme.accentColor,
      );
    }
  }

  void changePassword() async {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 10,
      title: "",
      backgroundColor: Get.theme.canvasColor,
      titleStyle: Get.theme.textTheme.headline5.copyWith(
        color: Colors.black87,
        height: 0,
      ),
      content: CustomLoading(text: "ĐANG ĐỔI MẬT KHẨU"),
      onWillPop: () async => false,
    );
    String result =
        await auth.validatePassword(currentPassword: currentPasswordText.text);
    Get.back();
    if (result != "Success") {
      switch (result) {
        case "Wrong password":
          Get.snackbar(
            "ĐỔI MẬT KHẨU THẤT BẠI",
            "Mật khẩu hiện tại không chính xác",
            snackPosition: SnackPosition.TOP,
            colorText: Get.context.theme.accentColor,
          );
          break;
        default:
          Get.snackbar(
            "ĐỔI MẬT KHẨU THẤT BẠI",
            result,
            snackPosition: SnackPosition.TOP,
            colorText: Get.context.theme.accentColor,
          );
          break;
      }
    } else {
      String resultChangePass =
          await auth.changePassword(newPassword: newPasswordText.text.trim());
      if (resultChangePass != "Success") {
        Get.snackbar(
          "ĐỔI MẬT KHẨU THẤT BẠI",
          resultChangePass,
          snackPosition: SnackPosition.TOP,
          colorText: Get.context.theme.accentColor,
        );
      } else {
        Get.back();
        currentPasswordText.clear();
        newPasswordText.clear();
        Get.snackbar(
          "ĐỔI MẬT KHẨU THÀNH CÔNG",
          "Mật khẩu của tài khoản đã được cập nhật thành công",
          snackPosition: SnackPosition.TOP,
          colorText: Get.context.theme.accentColor,
        );
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    _user.bindStream(auth?.user);
    ever(
      _user,
      (User value) async {
        if (value != null) {
          Get.find<AccountController>().account = await database.getAccountInfo(
            uid: value.uid,
          );
          Get.find<HistoryController>().nameList.bindStream(database
              .streamHistoryNameList(uid: Get.find<AuthController>().user.uid));
          Get.find<HistoryController>().linkList.bindStream(database
              .streamHistoryLinkList(uid: Get.find<AuthController>().user.uid));
          Get.find<HistoryController>().imageList.bindStream(
              database.streamHistoryImageList(
                  uid: Get.find<AuthController>().user.uid));
        } else {
          Get.find<AccountController>().clear();
          Get.find<HistoryController>().nameList.clear();
          Get.find<HistoryController>().imageList.clear();
          Get.find<HistoryController>().linkList.clear();
        }
      },
    );
  }
}
