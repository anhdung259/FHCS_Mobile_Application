import 'package:fhcs_mobile_application/controller/account/account_controller.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/account_repository.dart';
import 'package:get/get.dart';

class AccountControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<AccountController>(() => AccountController(
        accountRepository: AccountRepository(apiClient: ApiProvider())));
  }
}
