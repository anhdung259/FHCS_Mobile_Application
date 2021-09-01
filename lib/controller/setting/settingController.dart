import 'dart:async';

import 'package:fhcs_mobile_application/data/model/app_version/app_version.dart';
import 'package:fhcs_mobile_application/data/repository/setting_repository.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';

class SettingController extends GetxController {
  final SettingRepository repository;
  SettingController({@required this.repository}) : assert(repository != null);
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  String urlDownloadApp;
  bool showChangePassWord;
  var appVersion = AppVersion().obs;
  RxInt valueSettingMain = 0.obs;
  void onInit() async {
    checkShowChangePassword();
    await initSettingScreenMain();
    getValueSetting();
    initPackageInfo();
    super.onInit();
  }

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
    //print(packageInfo.version + "||" + packageInfo.appName);
  }

  void checkNewVersion({bool showMsgNewVersion}) async {
    try {
      var result = await repository.getNewVersionApp();
      if (result.statusCode == 200) {
        appVersion.value = result.data;
        urlDownloadApp = appVersion.value.urlDownload;
        print(urlDownloadApp);
        if (int.parse(packageInfo.version.numericOnly()) <
            int.parse(appVersion.value.version.numericOnly())) {
          GeneralHelper.showConfirm(
              title:
                  "Hiện tại đã có bản cập nhật mới,bạn có muốn cập nhật ngay?",
              msg: "",
              textOk: "Cập nhật ngay",
              textCancel: "Hủy",
              pressOk: tryOtaUpdate,
              pressCancel: () {});
        } else {
          if (showMsgNewVersion == true) {
            GeneralHelper.showMessage(msg: "Bạn đang có phiên bản mới nhất");
          }
        }
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void checkInstallNotification({String versionNotifi}) async {
    if (int.parse(packageInfo.version.numericOnly()) <
        int.parse(versionNotifi.numericOnly())) {
      await tryOtaUpdate();
    } else {
      GeneralHelper.showMessage(msg: "Bạn đang có phiên bản mới nhất");
    }
  }

  void checkShowChangePassword() async {
    showChangePassWord =
        await GeneralHelper.getValueSharedPreferences("loginWith") != "google";
  }

  Future<void> tryOtaUpdate() async {
    CustomProgressDialog pd =
        CustomProgressDialog(Get.context, dismissable: false);

    pd.setLoadingWidget(Center(
      child: Container(
        alignment: Alignment.center,
        height: getProportionateScreenHeight(120),
        width: getProportionateScreenWidth(270),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[1],
          color: white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Đang tải bản cập nhật...",
              style: AppTheme.titleDetail,
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(KPrimaryColor)),
          ],
        ),
      ),
    ));
    try {
      pd.show();
      OtaUpdate()
          .execute(
        urlDownloadApp,
      )
          .listen(
        (OtaEvent event) {
          print(event.status);
          if (event.status.toString() == "OtaStatus.INSTALLING") {
            pd.dismiss();
          } else if (event.status.toString() == "OtaStatus.DOWNLOAD_ERROR") {
            pd.dismiss();
            GeneralHelper.showMessage(msg: "Lỗi tải apk!");
          }
          //setState(() => currentEvent = event);
        },
      );
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      pd.dismiss();
      print('Failed to make OTA update. Details: $e');
    }
  }

  initSettingScreenMain() async {
    var check = await GeneralHelper.getValueSharedPreferences("listDisplay");
    if (check == null) {
      GeneralHelper.saveToSharedPreferences("listDisplay", 0);
    }
  }

  Future getValueSetting() async {
    valueSettingMain.value =
        await GeneralHelper.getValueSharedPreferences("listDisplay");
  }
}
