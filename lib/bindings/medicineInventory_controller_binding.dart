import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_inventory_repository.dart';
import 'package:get/get.dart';

class MedicineInventoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<MedicineInventoryController>(() => MedicineInventoryController(
        repository: MedicineInventoryRepository(apiClient: ApiProvider())));
  }
}
