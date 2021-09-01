import 'package:fhcs_mobile_application/controller/batches/importMedicineController.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/import_medicine_repository.dart';
import 'package:get/get.dart';

class ImportMedicineControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<ImportMedicineController>(() => ImportMedicineController(
        importMedicineRepository:
            ImportMedicineRepository(apiClient: ApiProvider())));
  }
}
