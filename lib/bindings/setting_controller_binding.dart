import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/setting_repository.dart';
import 'package:get/get.dart';

class SettingControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<SettingController>(() => SettingController(
        repository: SettingRepository(apiClient: ApiProvider())));
  }
}
