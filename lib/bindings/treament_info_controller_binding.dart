import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/treatment_repository.dart';
import 'package:get/get.dart';

class TreatmentInfoControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<TreatmentInfoController>(() => TreatmentInfoController(
        repository: TreatmentInfoRepository(apiClient: ApiProvider())));
  }
}
