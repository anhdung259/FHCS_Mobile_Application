import 'package:fhcs_mobile_application/screens/account/components/account_body.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Tài khoản",
      body: AccountBody(),
    );
  }
}
