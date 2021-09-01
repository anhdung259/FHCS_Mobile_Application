import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_repository.dart';
import 'package:get/get.dart';

class MedicineControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<MedicineController>(() => MedicineController(
        repository: MedicineRepository(apiClient: ApiProvider())));
  }
}
