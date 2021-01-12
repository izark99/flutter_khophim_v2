import 'package:get/get.dart';
import 'package:khophim/models/account_model.dart';

class AccountController extends GetxController {
  Rx<AccountModel> _account = AccountModel().obs;

  set account(AccountModel value) => this._account.value = value;
  AccountModel get account => _account.value;

  void clear() {
    _account.value = AccountModel();
  }
}
