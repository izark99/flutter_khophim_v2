import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/auth_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/widgets/custom_button.dart';
import 'package:khophim/widgets/custom_text_form_field.dart';

class AuthPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: PAD_SYM_H20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    _authController.isSignInUI.value ? "ĐĂNG NHẬP" : "ĐĂNG KÝ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SIZED_BOX_H20,
                CustomTextFormField(
                  controller: _authController.emailText,
                  hint: 'Email của bạn',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).accentColor,
                  ),
                  useOnChanged: false,
                ),
                SIZED_BOX_H10,
                Obx(
                  () => CustomTextFormField(
                    controller: _authController.passwordText,
                    hint: 'Mật khẩu của bạn',
                    obscureText: _authController.obscureText.value,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).accentColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => _authController.showHide(),
                      child: Icon(
                        _authController.obscureText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    useOnChanged: false,
                  ),
                ),
                Obx(
                  () => _authController.isSignInUI.value
                      ? TextButton(
                          onPressed: () => _authController.showBottomSheet(),
                          child: Text(
                            "Quên mật khẩu?",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      : SIZED_BOX_H10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => CustomButton(
                      buttonName: _authController.isSignInUI.value
                          ? "ĐĂNG NHẬP"
                          : "ĐĂNG KÝ",
                      onPressed: _authController.isSignInUI.value
                          ? () => _authController.signIn()
                          : () => _authController.signUp(),
                      textStyle: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _authController.changeUI(),
                  child: Obx(
                    () => Text(
                      _authController.isSignInUI.value
                          ? "Thành viên mới? Đăng ký tài khoản"
                          : "Đã có tài khoản? Đăng nhập thôi",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
