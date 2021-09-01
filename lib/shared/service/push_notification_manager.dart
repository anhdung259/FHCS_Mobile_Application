import 'dart:convert';

import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/controller/batches/importMedicineController.dart';
import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/controller/notification/notificationController.dart';
import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/data_notification/data_notification.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/import_batch_repository.dart';
import 'package:fhcs_mobile_application/data/repository/import_medicine_repository.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_inventory_repository.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_repository.dart';
import 'package:fhcs_mobile_application/data/repository/notification_repository.dart';
import 'package:fhcs_mobile_application/data/repository/setting_repository.dart';
import 'package:fhcs_mobile_application/data/repository/treatment_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String data) async {
      print(data);
      var dataNotification = DataNotification.fromJson(jsonDecode(data));
      navigartorNotication(
          dataNotification, true, false, dataNotification.notificationId);
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "fhcs",
        "FPT HCM Clinic Support",
        "FHCS Notification",
        importance: Importance.max,
        priority: Priority.max,
      ));

      await _notificationsPlugin.show(
        id,
        message.notification.title,
        message.notification.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static void displayButton(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "fhcs",
        "FPT HCM Clinic Support",
        "FHCS Notification",
        importance: Importance.max,
        priority: Priority.max,
      ));

      await _notificationsPlugin.show(
        id,
        message.notification.title,
        message.notification.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static void navigartorNotication(DataNotification dataNotifi,
      bool onSelectNotifi, bool statusNotifi, String notifiId) {
    final MedicineController mc = Get.put(MedicineController(
        repository: MedicineRepository(apiClient: ApiProvider())));
    final TreatmentInfoController tic = Get.put(TreatmentInfoController(
        repository: TreatmentInfoRepository(apiClient: ApiProvider())));
    final BatchesMedicineController bmc = Get.put(BatchesMedicineController(
        importBatchRepository:
            ImportBatchRepository(apiClient: ApiProvider())));
    final MedicineInventoryController mic = Get.put(MedicineInventoryController(
        repository: MedicineInventoryRepository(apiClient: ApiProvider())));
    final NotificationController nc = Get.put(NotificationController(
        repository: NotificationRepository(apiClient: ApiProvider())));
    final ImportMedicineController imc = Get.put(ImportMedicineController(
        importMedicineRepository:
            ImportMedicineRepository(apiClient: ApiProvider())));
    final SettingController sc = Get.put(SettingController(
        repository: SettingRepository(apiClient: ApiProvider())));
    Get.lazyPut(() => MedicineInventoryController(
        repository: MedicineInventoryRepository(apiClient: ApiProvider())));
    var enitity = dataNotifi.entity;
    var action = dataNotifi.action;
    var obj = jsonDecode(dataNotifi.data);

    var currentRoute = Get.currentRoute;
    print("route :" + currentRoute);
    if (statusNotifi != true && onSelectNotifi != false) {
      nc.notificationClick(notifiId);
      // nc.fetchNotifiList();

    }
    switch (enitity) {
      case "Medicine":
        if (action != "Remove" && onSelectNotifi != false) {
          mc.medicineId = obj["id"];
          mc.getDetail();
        } else if (currentRoute == "/medicineManage" &&
            onSelectNotifi != true) {
          mc.fetchMedicine();
          print(sc.valueSettingMain.value);
          if (sc.valueSettingMain.value == 1) {
            mc.fetchMedicineRecently();
          }
        } else if (currentRoute == "/home" &&
            sc.valueSettingMain.value == 1 &&
            onSelectNotifi != true) {
          print(sc.valueSettingMain.value);
          mc.fetchMedicineRecently();
        }
        break;
//
      case "ImportBatch":
        if (action != "Remove" && onSelectNotifi != false) {
          bmc.importBatchId = obj["id"];
          bmc.getDetailImportBatch();
        } else if (currentRoute == "/batchesMedicineManage" &&
            onSelectNotifi != true) {
          bmc.fetchImportBatch();
          if (sc.valueSettingMain.value == 2) {
            bmc.fetchImportBatchesRecently();
          }
        } else if (currentRoute == "/home" &&
            sc.valueSettingMain.value == 2 &&
            onSelectNotifi != true) {
          bmc.fetchImportBatchesRecently();
        }
        break;
      //
      case "ImportMedicine":
        if (action != "Remove" && onSelectNotifi != false) {
          bmc.importMedicineId = obj["id"];
          bmc.getDetailImportMedicine();
        } else if (currentRoute == "/batchesMedicineManage" &&
            onSelectNotifi != true) {
          imc.fetchImportMedicine();
          if (sc.valueSettingMain.value == 3) {
            imc.fetchImportMedicineRecently();
          }
        } else if (currentRoute == "/home" &&
            sc.valueSettingMain.value == 3 &&
            onSelectNotifi != true) {
          imc.fetchImportMedicineRecently();
        }
        break;
      case "MedicineInInventoryDetail":
        if (onSelectNotifi != false) {
          mic.medicineInventoryDetailId = obj["id"];
          mic.getDetailMeicineInventory();
        }
        break;
      //
      case "EliminateMedicine":
        if (onSelectNotifi != false) {
          mic.medicineInventoryDetailId = obj["medicineInInventoryDetailId"];
          mic.getDetailMeicineInventory();
        } else if (currentRoute == "/medicineInventoryDetail" &&
            onSelectNotifi != true) {
          var id = obj["medicineInInventoryDetailId"];
          if (mic.medicineInventoryDetailId == id) {
            mic.getDetailMeicineInventory();
            mic.fetchMedicineInventory();
            if (sc.valueSettingMain.value == 4) {
              mic.fetchMedicineInventoryRecently();
            }
          }
        } else if (currentRoute == "/home" &&
            sc.valueSettingMain.value == 4 &&
            onSelectNotifi != true) {
          mic.fetchMedicineInventoryRecently();
        }
        break;
      //
      case "Treatment":
        if (onSelectNotifi != false) {
          tic.treatmentId = obj["id"];
          tic.getTreatmentDetail();
        } else if (currentRoute == "/treatmentInfoManage" &&
            onSelectNotifi != true) {
          tic.fetchTreatmentInfo();
          if (sc.valueSettingMain.value == 0) {
            tic.fetchTreatmentInfoRecently();
          }
        } else if (currentRoute == "/home" &&
            sc.valueSettingMain.value == 0 &&
            onSelectNotifi != true) {
          tic.fetchTreatmentInfoRecently();
        }
        break;
      //
      case "MobileAppVersion":
        if (onSelectNotifi != false) {
          String url = obj["urlDownload"];
          String version = obj["version"];
          sc.urlDownloadApp = url;
          sc.checkInstallNotification(versionNotifi: version);
        }
        break;
      default:
    }
  }
}
