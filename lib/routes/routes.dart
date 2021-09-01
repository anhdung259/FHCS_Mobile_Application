import 'package:fhcs_mobile_application/bindings/account_controller_binding.dart';
import 'package:fhcs_mobile_application/bindings/batches_binding.dart';
import 'package:fhcs_mobile_application/bindings/forgot_account_binding.dart';
import 'package:fhcs_mobile_application/bindings/history_controller_binding.dart';
import 'package:fhcs_mobile_application/bindings/import_medicine_binding.dart';
import 'package:fhcs_mobile_application/bindings/login_controller_binding.dart';
import 'package:fhcs_mobile_application/bindings/medicineInventory_controller_binding.dart';
import 'package:fhcs_mobile_application/bindings/medicine_controller_binding.dart';
import 'package:fhcs_mobile_application/bindings/notification_controller_binding.dart';
import 'package:fhcs_mobile_application/bindings/setting_controller_binding.dart';
import 'package:fhcs_mobile_application/bindings/treament_info_controller_binding.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/batches_medicine_detail/batches_medicine_detail.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/batches_medicine_detail/update_medicine_in_batch/update_record_medicine_server.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/insert_import_batches/components/update_insert_record_medicine_local.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/insert_import_batches/insert_import_batches.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/insert_import_batches/insert_medicine_to_batch/insert_medicine_to_batch.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/manage_batches_medicine/manage_import_batch.dart';

import 'package:fhcs_mobile_application/screens/ManageMedicine/insert_medicine/insert_medicine.dart';
import 'package:fhcs_mobile_application/screens/ManageMedicine/medicine_detail/medicine_detail.dart';
import 'package:fhcs_mobile_application/screens/ManageMedicine/medicine_manage/medicine_manage.dart';

import 'package:fhcs_mobile_application/screens/ManageMedicineInventory/medicine_medicine_inventory_detail/medicine_medicine_inventory_detail.dart';

import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/insert_treatment_info.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/treatment_info_details/components/screen_confirm_treatment_info.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/treatment_info_details/treament_info_details.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/treatment_info_manage/treatment_info_manage.dart';
import 'package:fhcs_mobile_application/screens/account/account.dart';
import 'package:fhcs_mobile_application/screens/account/account_change_password/account_change_pasword.dart';
import 'package:fhcs_mobile_application/screens/account/account_edit/account_edit.dart';
import 'package:fhcs_mobile_application/screens/account/account_info/account_info.dart';
import 'package:fhcs_mobile_application/screens/forgotAccount/inputAccountVerify/input_account_verify.dart';
import 'package:fhcs_mobile_application/screens/forgotAccount/settingNewPass/setting_new_pass.dart';
import 'package:fhcs_mobile_application/screens/forgotAccount/verifyCodeAccount/verify_code_account.dart';

import 'package:fhcs_mobile_application/screens/history/history_patient_detail/history_patient_detail.dart';
import 'package:fhcs_mobile_application/screens/home/home_screen.dart';

import 'package:fhcs_mobile_application/screens/login/login_screen.dart';

import 'package:fhcs_mobile_application/screens/notification/notification_history_action/notification_history_action.dart';
import 'package:fhcs_mobile_application/screens/notification/notification_show/notification_show.dart';
import 'package:fhcs_mobile_application/screens/setting/setting.dart';
import 'package:fhcs_mobile_application/screens/setting/setting_main_screen/setting_main_screen.dart';
import 'package:fhcs_mobile_application/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

routes() => [
      GetPage(name: "/splash", page: () => SplashScreen()),
      GetPage(
          name: "/inputAccountVerify",
          page: () => InputAccountVerify(),
          binding: ForgotAccountBinding()),
      GetPage(
          name: "/verifyCodeAccount",
          page: () => VerifyCodeAccount(),
          binding: ForgotAccountBinding()),
      GetPage(
          name: "/settingNewPass",
          page: () => SettingNewPass(),
          binding: ForgotAccountBinding()),
      GetPage(
          name: "/inputAccountVerify",
          page: () => InputAccountVerify(),
          binding: ForgotAccountBinding()),
      GetPage(
          name: "/login",
          page: () => LoginScreen(),
          binding: LoginControllerBinding()),
      GetPage(
        name: "/home",
        page: () => HomeScreen(),
        bindings: [
          TreatmentInfoControllerBinding(),
          HistoryControllerBinding(),
          NotificationControllerBinding(),
          SettingControllerBinding(),
          LoginControllerBinding(),
          AccountControllerBinding(),
          MedicineControllerBinding(),
          BatchMedicineControllerBinding(),
          MedicineInventoryControllerBinding(),
          ImportMedicineControllerBinding(),
        ],
      ),
      GetPage(
          name: "/medicineDetail",
          page: () => MedicineDetail(),
          binding: MedicineControllerBinding()),
      GetPage(
          name: "/medicineManage",
          page: () => MedicineManage(),
          binding: MedicineControllerBinding()),
      GetPage(
        name: "/insertMedicine",
        page: () => InsertMedicine(),
        binding: MedicineControllerBinding(),
      ),
      GetPage(
          name: "/account",
          page: () => AccountScreen(),
          binding: LoginControllerBinding()),
      GetPage(
        name: "/accountInfo",
        page: () => AccountInfo(),
        bindings: [AccountControllerBinding(), LoginControllerBinding()],
      ),
      GetPage(
        name: "/changNewPassword",
        page: () => ChangeNewPassword(),
        bindings: [AccountControllerBinding()],
      ),
      GetPage(
          name: "/accountEdit",
          page: () => AccountEdit(),
          binding: AccountControllerBinding()),
      GetPage(
          name: "/batchesMedicineManage",
          page: () => BatchesMedicineManage(),
          bindings: [
            BatchMedicineControllerBinding(),
            MedicineInventoryControllerBinding(),
            ImportMedicineControllerBinding()
          ]),
      GetPage(
          name: "/importBatchMedicineDetail",
          page: () => ImportBatchMedicineDetail(),
          binding: BatchMedicineControllerBinding()),
      GetPage(
          name: "/insertBatchesMedicine",
          page: () => InsertBatchesMedicine(),
          binding: BatchMedicineControllerBinding()),
      GetPage(
          name: "/insertBatchesMedicineRecord",
          page: () => InsertBatchRecordMedicine(),
          binding: BatchMedicineControllerBinding()),
      GetPage(
          name: "/updateBatchesMedicineRecord",
          page: () => UpdateBatchesRecordMedicine(),
          binding: BatchMedicineControllerBinding()),
      GetPage(
          name: "/updateInsertMedicineRecordLocal",
          page: () => UpdateInsertRecordLocalMedicine(),
          binding: BatchMedicineControllerBinding()),
      GetPage(
          name: "/medicineInventoryDetail",
          page: () => MedicineInventoryDetail(),
          binding: MedicineInventoryControllerBinding()),
      GetPage(
          name: "/treatmentInfoManage",
          page: () => TreatmentInfoManage(),
          binding: TreatmentInfoControllerBinding()),
      GetPage(
          name: "/insertTreatmentInfo",
          page: () => InsertTreatmentInfo(),
          binding: TreatmentInfoControllerBinding()),
      GetPage(
          name: "/treatmentInfoDetail",
          page: () => TreatmentInfoDetail(),
          binding: TreatmentInfoControllerBinding()),
      GetPage(
          name: "/makePrescription",
          page: () => TreatmentInfoDetail(),
          binding: TreatmentInfoControllerBinding()),
      GetPage(
          name: "/patientDetail",
          page: () => PatientDetail(),
          binding: HistoryControllerBinding()),
      GetPage(
        name: "/signature",
        page: () => ConfirmTreatmentInformation(),
      ),
      GetPage(
          name: "/notificationShow",
          page: () => NotificationShow(),
          binding: NotificationControllerBinding()),
      GetPage(
          name: "/notificationHistoryAction",
          page: () => NotificationHistoryAction(),
          binding: NotificationControllerBinding()),
      GetPage(name: "/setting", page: () => Setting(), bindings: [
        AccountControllerBinding(),
        SettingControllerBinding(),
      ]),
      GetPage(
          name: "/settingMainScreen",
          page: () => SettingMainScreen(),
          bindings: [
            SettingControllerBinding(),
          ]),
    ];
