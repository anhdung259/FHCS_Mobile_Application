import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/widgets/Button/create_new_button.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/medicine_manage_body.dart';

class MedicineManage extends StatefulWidget {
  const MedicineManage({Key key}) : super(key: key);

  @override
  _MedicineManageState createState() => _MedicineManageState();
}

class _MedicineManageState extends State<MedicineManage> {
  final MedicineController mc = Get.find();
  @override
  void initState() {
    mc.refreshList();
    mc.fetchClassifications("");
    mc.fetchUnit("");
    mc.fetchSubgroup("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MedicineController mc = Get.find();
    return ScreenWithoutTabBar(
      showFloatingButton: true,
      button: CreatNewButton(
        onPress: () {
          FocusScope.of(context).unfocus();
          mc.navigatorInsertMedicine();
        },
      ),
      function: mc.fetchMedicine,
      title: "Quản lý dược phẩm",
      body: MedicineManagerBody(),
    );
  }
}
