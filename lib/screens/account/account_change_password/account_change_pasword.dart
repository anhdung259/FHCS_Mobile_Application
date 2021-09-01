import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'components/account_change_pasword_body.dart';

class ChangeNewPassword extends StatelessWidget {
  const ChangeNewPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Đổi mật khẩu",
      body: ChangeNewPasswordBody(),
    );
  }
}
