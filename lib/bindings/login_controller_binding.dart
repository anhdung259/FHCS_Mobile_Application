import 'package:fhcs_mobile_application/controller/login/login_controller.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/login_repository.dart';
import 'package:get/get.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<LoginController>(() => LoginController(
        loginRepository: LoginRepository(apiClient: ApiProvider())));
  }
}
