import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt _tabIndexHomePage = 0.obs;
  int get tabIndexHomePage => _tabIndexHomePage.value;
  void changeTabIndexHomePage(int newIndex) {
    _tabIndexHomePage.value = newIndex;
  }
}
