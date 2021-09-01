import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'verify_code_account_body.dart';

class VerifyCodeAccount extends StatelessWidget {
  const VerifyCodeAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Email xác thực",
      body: VerifyCodeAccountBody(),
    );
  }
}
