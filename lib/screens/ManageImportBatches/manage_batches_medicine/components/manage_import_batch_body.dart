import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/manage_batches_medicine/components/list_import_medicine.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/widgets/Button/create_new_button.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'list_import_batch.dart';

class BatchesMedicineManagerBody extends StatefulWidget {
  BatchesMedicineManagerBody({Key key}) : super(key: key);

  @override
  _BatchesMedicineManagerBodyState createState() =>
      _BatchesMedicineManagerBodyState();
}

class _BatchesMedicineManagerBodyState
    extends State<BatchesMedicineManagerBody> {
  final BatchesMedicineController bmc = Get.find();

  Widget _page(int index) {
    switch (index) {
      case 0:
        return ListImportBatches();
        break;
      case 1:
        return ListImportMedicine();
        break;
    }
    throw "Invalid index $index";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.02,
          horizontal: SizeConfig.screenWidth * 0.08,
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Obx(() => Column(
                children: [
                  ToggleSwitch(
                    initialLabelIndex: bmc.currentIndex.value == 0 ? 0 : 1,
                    totalSwitches: 2,
                    minWidth: getProportionateScreenWidth(150),
                    inactiveBgColor: KColorBackground,
                    labels: ['Lô dược phẩm nhập', 'Dược phẩm nhập'],
                    onToggle: (index) {
                      print('switched to: ');
                      setState(() {
                        bmc.currentIndex.value = index;
                      });
                    },
                  ),
                  _page(bmc.currentIndex.value)
                ],
              )),
        ),
      ),
      floatingActionButton: CreatNewButton(
        onPress: () {
          bmc.showUpdate = false;
          bmc.cleanData();
          bmc.numberMedicineInBatch.value = 0;
          bmc.totalPrice.value = 0;
          Get.toNamed("/insertBatchesMedicine");
        },
      ),
    );
  }
}
