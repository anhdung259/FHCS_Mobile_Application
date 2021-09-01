import 'package:fhcs_mobile_application/controller/notification/notificationController.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/notification_repository.dart';
import 'package:get/get.dart';

class NotificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    // any controllers you need for this page you can lazy init here without setting fenix to true
    Get.lazyPut<NotificationController>(() => NotificationController(
        repository: NotificationRepository(apiClient: ApiProvider())));
  }
}
