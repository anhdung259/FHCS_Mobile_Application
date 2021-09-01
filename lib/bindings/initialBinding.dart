import 'package:fhcs_mobile_application/controller/account/account_controller.dart';
import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/controller/forgot_account/forgot_account_controller.dart';
import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/controller/login/login_controller.dart';
import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/account_repository.dart';
import 'package:fhcs_mobile_application/data/repository/forgot_password_repository.dart';
import 'package:fhcs_mobile_application/data/repository/history_repository.dart';
import 'package:fhcs_mobile_application/data/repository/import_batch_repository.dart';
import 'package:fhcs_mobile_application/data/repository/import_medicine_repository.dart';
import 'package:fhcs_mobile_application/data/repository/login_repository.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_inventory_repository.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_repository.dart';
import 'package:fhcs_mobile_application/data/repository/setting_repository.dart';
import 'package:fhcs_mobile_application/data/repository/treatment_repository.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotAccountController>(() => ForgotAccountController(
        repository: ForgotPasswordRepository(apiClient: ApiProvider())));
    Get.lazyPut<MedicineController>(() => MedicineController(
        repository: MedicineRepository(apiClient: ApiProvider())));

    Get.lazyPut<LoginController>(() => LoginController(
        loginRepository: LoginRepository(apiClient: ApiProvider())));
    Get.lazyPut<AccountController>(() => AccountController(
        accountRepository: AccountRepository(apiClient: ApiProvider())));
    Get.lazyPut<BatchesMedicineController>(() => BatchesMedicineController(
        importBatchRepository: ImportBatchRepository(apiClient: ApiProvider()),
        importMedicineRepository:
            ImportMedicineRepository(apiClient: ApiProvider())));
    Get.lazyPut<MedicineInventoryController>(() => MedicineInventoryController(
        repository: MedicineInventoryRepository(apiClient: ApiProvider())));
    Get.lazyPut<TreatmentInfoController>(() => TreatmentInfoController(
        repository: TreatmentInfoRepository(apiClient: ApiProvider())));
    Get.lazyPut<HistoryController>(() => HistoryController(
        repository: HistoryRepository(apiClient: ApiProvider())));
    Get.lazyPut<SettingController>(() => SettingController(
        repository: SettingRepository(apiClient: ApiProvider())));
  }
}
