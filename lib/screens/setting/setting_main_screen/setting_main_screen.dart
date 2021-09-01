import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'components/setting_main_screen_body.dart';

class SettingMainScreen extends StatefulWidget {
  const SettingMainScreen({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Đặt màn hình chính",
      body: SettingMainScreenBody(),
    );
  }
}
