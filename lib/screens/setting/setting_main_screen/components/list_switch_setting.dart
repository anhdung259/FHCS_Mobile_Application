import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListSwitchSetting extends StatefulWidget {
  ListSwitchSetting({Key key}) : super(key: key);

  @override
  _ListSwitchSettingState createState() => _ListSwitchSettingState();
}

class _ListSwitchSettingState extends State<ListSwitchSetting> {
  final SettingController sc = Get.find();
  static List<bool> choice = [false, false, false, false, false];
  static List<String> title = [
    "Danh sách cấp phát",
    "Danh sách dược phẩm",
    "Danh sách lô nhập",
    "Danh sách dược phẩm nhập",
    "Danh sách dược phẩm tồn"
  ];
  @override
  void initState() {
    choice.asMap().forEach((i, element) {
      if (i == sc.valueSettingMain.value) {
        choice[i] = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          itemCount: choice.length,
          itemBuilder: (context, index) {
            return BackGroundCard(
              child: SwitchListTile(
                activeColor: KPrimaryColor,
                title: Text(
                  title[index],
                  style: AppTheme.selectBox,
                ),
                value: choice[index],
                onChanged: (bool value) {
                  switchCallback(true, index);
                },
              ),
            );
          })
    ]);
  }

  void switchCallback(bool value, int index) async {
    setState(() {
      for (var i = 0; i < choice.length; i++) {
        choice[i] = false;
      }
      choice[index] = value;
      switch (index) {
        case 0:
          GeneralHelper.saveToSharedPreferences("listDisplay", 0);
          sc.valueSettingMain.value = 0;
          break;
        case 1:
          GeneralHelper.saveToSharedPreferences("listDisplay", 1);
          sc.valueSettingMain.value = 1;
          break;
        case 2:
          GeneralHelper.saveToSharedPreferences("listDisplay", 2);
          sc.valueSettingMain.value = 2;
          break;
        case 3:
          GeneralHelper.saveToSharedPreferences("listDisplay", 3);
          sc.valueSettingMain.value = 3;
          break;
        case 4:
          GeneralHelper.saveToSharedPreferences("listDisplay", 4);
          sc.valueSettingMain.value = 4;
          break;
      }
      // _finalSelection = ' index ${index}  {$value}';
      // print(' final selection ${_finalSelection}');
    });
    print(sc.valueSettingMain.value);
    //var s = await GeneralHelper.getValueSharedPreferences("listDisplay");
    // print("save" + s.toString());
  }
}
