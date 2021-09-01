import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/account_info_body.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Thông tin tài khoản",
      onEdit: () {
        Get.toNamed("/accountEdit");
      },
      body: AccountInfoBody(),
    );
  }
}
