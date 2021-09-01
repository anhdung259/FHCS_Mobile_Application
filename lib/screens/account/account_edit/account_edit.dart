import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';

import 'components/account_edit_body.dart';

class AccountEdit extends StatelessWidget {
  const AccountEdit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Sửa thông tin tài khoản",
      body: AccountEditBody(),
    );
  }
}
