import 'package:get/get.dart';
import 'package:khophim/models/account_model.dart';
import 'package:khophim/services/database_service.dart';

import 'history_controller.dart';

class AccountController extends GetxController {
  final DatabaseService database = DatabaseService();
  Rx<AccountModel> _account = AccountModel().obs;

  set account(AccountModel value) => this._account.value = value;
  AccountModel get account => _account.value;

  void clear() {
    _account.value = AccountModel();
  }

  @override
  void onReady() {
    super.onReady();
    ever(
      _account,
      (value) {
        if (_account.value?.uid != null) {
          Get.find<HistoryController>().nameList.bindStream(
                database.streamHistoryNameList(
                  uid: _account.value.uid,
                  limit: Get.find<HistoryController>().limit.value,
                ),
              );
          Get.find<HistoryController>().linkList.bindStream(
                database.streamHistoryLinkList(
                  uid: _account.value.uid,
                  limit: Get.find<HistoryController>().limit.value,
                ),
              );
          Get.find<HistoryController>().imageList.bindStream(
                database.streamHistoryImageList(
                  uid: _account.value.uid,
                  limit: Get.find<HistoryController>().limit.value,
                ),
              );
        } else {
          Get.find<HistoryController>().nameList.clear();
          Get.find<HistoryController>().imageList.clear();
          Get.find<HistoryController>().linkList.clear();
        }
      },
    );
  }
}
