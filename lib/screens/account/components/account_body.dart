import 'package:fhcs_mobile_application/controller/login/login_controller.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/login_repository.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_menu.dart';

class AccountBody extends StatelessWidget {
  final LoginController lc = Get.put(LoginController(
      loginRepository: LoginRepository(apiClient: ApiProvider())));
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "Thông tin tài khoản",
            icon: Icon(
              Icons.person,
              color: KPrimaryColor,
            ),
            press: () => Get.toNamed("/accountInfo"),
          ),
          ProfileMenu(
            text: "Lịch sử hoạt động",
            icon: Icon(
              Icons.notifications_active,
              color: KPrimaryColor,
            ),
            press: () => Get.toNamed("/notificationHistoryAction"),
          ),
          ProfileMenu(
            text: "Cài đặt",
            icon: Icon(
              Icons.settings,
              color: KPrimaryColor,
            ),
            press: () => Get.toNamed("/setting"),
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: Icon(
              Icons.logout_sharp,
              color: KPrimaryColor,
            ),
            press: () {
              lc.showConfirmLogOut();
            },
          ),
        ],
      ),
    );
  }
}
