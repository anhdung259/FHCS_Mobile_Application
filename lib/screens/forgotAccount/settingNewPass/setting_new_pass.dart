import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'setting_new_pass_body.dart';

class SettingNewPass extends StatelessWidget {
  const SettingNewPass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Đặt lại mật khẩu",
      body: SettingNewPassBody(),
    );
  }
}
