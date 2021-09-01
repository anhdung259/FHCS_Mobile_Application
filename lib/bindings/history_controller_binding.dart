import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/history_repository.dart';
import 'package:get/get.dart';

class HistoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<HistoryController>(() => HistoryController(
        repository: HistoryRepository(apiClient: ApiProvider())));
  }
}
