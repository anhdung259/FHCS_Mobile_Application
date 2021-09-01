import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_switch_setting.dart';

class SettingMainScreenBody extends StatefulWidget {
  @override
  _SettingMainScreenBodyState createState() => _SettingMainScreenBodyState();
}

class _SettingMainScreenBodyState extends State<SettingMainScreenBody> {
  final SettingController sc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Thay đổi các danh sách hiển thị trên màn hình chính",
              style: AppTheme.normalText,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          ListSwitchSetting()
        ],
      ),
    );
  }
}
