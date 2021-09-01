import 'package:fhcs_mobile_application/controller/forgot_account/forgot_account_controller.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/forgot_password_repository.dart';
import 'package:get/get.dart';

class ForgotAccountBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<ForgotAccountController>(() => ForgotAccountController(
        repository: ForgotPasswordRepository(apiClient: ApiProvider())));
  }
}
