import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/widgets/Button/filter_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'list_medicine_inventory.dart';

class MedicineInventoryManageBody extends StatefulWidget {
  MedicineInventoryManageBody({Key key}) : super(key: key);

  @override
  _MedicineInventoryManageBodyState createState() =>
      _MedicineInventoryManageBodyState();
}

class _MedicineInventoryManageBodyState
    extends State<MedicineInventoryManageBody> {
  final MedicineInventoryController mic = Get.find();
  @override
  void initState() {
    mic.resetTextFilter();
    mic.fetchMedicineInventory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.02,
          horizontal: SizeConfig.screenWidth * 0.07,
        ),
        child: Column(
          children: [
            Row(
              children: [
                RoundedInputField(
                  sizeWidth: getProportionateScreenWidth(257),
                  controller: mic.textSearchController,
                  hintText: SEARCHFIELD,
                  icon: Icon(LineIcons.search),
                  // textInputAction: TextInputAction.search,
                  onChanged: (value) => mic.fetchMedicineInventory(),
                  onSearch: true,
                  press: () {
                    mic.textSearchController.clear();
                    mic.fetchMedicineInventory();
                  },
                ),
                FilterButton(
                  onPress: mic.showDialogFilter,
                ),
              ],
            ),
            TitleList(
              title: "Danh sách dược phẩm tồn",
              press: () {
                mic.showDialogFilter();
              },
            ),
            ListMedicineInventory(),
          ],
        ),
      ),
    );
  }
}
