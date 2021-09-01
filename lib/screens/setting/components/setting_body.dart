import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/screens/account/components/profile_menu.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SettingBody extends StatelessWidget {
  final SettingController sc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // ProfilePic(
          //   imgUrl: ac.accountInfo.value.photoUrl,
          // ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Kiểm tra cập nhật",
            icon: Icon(
              Icons.update,
              color: KPrimaryColor,
            ),
            press: () {
              sc.checkNewVersion(showMsgNewVersion: true);
            },
          ),
          sc.showChangePassWord
              ? ProfileMenu(
                  text: "Đổi mật khẩu",
                  icon: Icon(
                    Icons.lock,
                    color: KPrimaryColor,
                  ),
                  press: () {
                    Get.toNamed("/changNewPassword");
                  },
                )
              : Container(),
          ProfileMenu(
            text: "Đặt màn hình chính",
            icon: Icon(
              LineIcons.list,
              color: KPrimaryColor,
            ),
            press: () {
              sc
                  .getValueSetting()
                  .then((value) => Get.toNamed("/settingMainScreen"));
            },
          ),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text(
                  "Phiên bản hiện tại: ${sc.packageInfo.version}",
                  style: AppTheme.normalText,
                )),
          )
          // Obx(() => Text("Tải bản cập nhật: " + sc.currentEvent.value))
        ],
      ),
    );
  }
}
