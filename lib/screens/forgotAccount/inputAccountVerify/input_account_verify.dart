import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'input_account_verify_body.dart';

class InputAccountVerify extends StatelessWidget {
  const InputAccountVerify({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Quên mật khẩu?",
      body: InputAccountVerifyBody(),
    );
  }
}
