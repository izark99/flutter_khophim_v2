import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/auth_controller.dart';

import 'auth_page.dart';
import 'home_page.dart';

class RootPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _authController.user.value?.uid != null ? HomePage() : AuthPage(),
    );
  }
}
