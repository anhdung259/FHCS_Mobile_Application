import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/insert_medicine_body.dart';

class InsertMedicine extends StatelessWidget {
  const InsertMedicine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MedicineController mc = Get.find();
    return WillPopScope(
      onWillPop: mc.backScreen,
      child: ScreenWithoutTabBar(
        loadingCall: mc.isLoadingWait.value,
        title: mc.showUpdate != true ? "Thêm dược phẩm" : "Cập nhật dược phẩm",
        body: Column(
          children: [
            Expanded(child: InsertMedicineBody()),
            Obx(() => Padding(
                  // this is new
                  padding: EdgeInsets.only(
                      bottom: mc.pushBottom.isFalse
                          ? Get.context.mediaQueryViewInsets.bottom
                          : Get.context.mediaQueryViewInsets.bottom +
                              getProportionateScreenHeight(210)),
                )),
          ],
        ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterFloat,
        // showFloatingButton: true,
        // button: RoundedButton(
        //   sizeWidth: Get.width,
        //   text: mc.showUpdate != true ? "Thêm" : "Cập nhật",
        //   press: () {
        //     mc.showUpdate != true
        //         ? mc.insertNewMedicine()
        //         : mc.updateMedicineDetail();
        //   },
        // ),
      ),
    );
  }
}
