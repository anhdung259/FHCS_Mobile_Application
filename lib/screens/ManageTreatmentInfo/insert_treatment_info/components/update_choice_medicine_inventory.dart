import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/treatment_information_details/treatment_information_details.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_select_item/multi_select_item.dart';

class UpdateChoiceMedicineInventory extends StatefulWidget {
  @override
  _UpdateChoiceMedicineInventoryState createState() =>
      new _UpdateChoiceMedicineInventoryState();
}

class _UpdateChoiceMedicineInventoryState
    extends State<UpdateChoiceMedicineInventory> {
  final TreatmentInfoController tic = Get.find();
  List<TextEditingController> textController = [];
  MultiSelectController controller = new MultiSelectController();
  @override
  void initState() {
    tic.listMedicineInventorySelected.removeWhere((e) =>
        tic.medicineInventorySearchList
            .every((a) => a.id != e.medicineInInventoryDetailId) &&
        e.medicineId == tic.medicineId);
    tic.medicineInventorySearchList.asMap().forEach((i, value) {
      if (tic.medicineInventorySearchList[i].groupByCheck == true) {
        for (var item in tic.listPrescriptionDetailsUpdate) {
          if (item.medicineInInventoryDetailId ==
              tic.medicineInventorySearchList[i].id) {
            item.quantity = tic.getGroupedTreatmentDetailsQuantity(
                tic.medicineInventorySearchList[i].groupByChoiceMedicine);
            item.groupByCheck = tic.medicineInventorySearchList[i].groupByCheck;
            item.groupByChoiceMedicine = tic.createNewGroupMedicine(
                tic.medicineInventorySearchList[i].groupByChoiceMedicine);
          }
        }
      } else {
        for (var item in tic.listPrescriptionDetailsUpdate) {
          if (item.medicineInInventoryDetailId ==
              tic.medicineInventorySearchList[i].id) {
            item.quantity = item.quantity;
          }
        }
      }
    });
    for (var i = 0; i < tic.medicineInventorySearchList.length; i++) {
      if (tic.listPrescriptionDetails
              .where((e) =>
                  e.medicineInInventoryDetailId ==
                  tic.medicineInventorySearchList[i].id)
              .toList()
              .length >
          0) {
        controller.select(i);
      }
    }
    textController = List.generate(
        tic.medicineInventorySearchList.length,
        (i) => TextEditingController(
            text: tic.listPrescriptionDetailsUpdate.firstWhere(
                        (e) =>
                            e.medicineInInventoryDetailId ==
                            tic.medicineInventorySearchList[i].id,
                        orElse: () => null) !=
                    null
                ? tic.medicineInventorySearchList[i].groupByCheck == true
                    ? tic
                        .getGroupedTreatmentDetailsQuantity(tic
                            .medicineInventorySearchList[i]
                            .groupByChoiceMedicine)
                        .toString()
                    : tic.listPrescriptionDetailsUpdate
                        .firstWhere((e) =>
                            e.medicineInInventoryDetailId ==
                            tic.medicineInventorySearchList[i].id)
                        .quantity
                        .toString()
                : ""));

    // getTotalMedicineSelected();

    super.initState();
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: new AppBar(
          title: new Text("Cập nhật số lượng"),
        ),
        body: ListView.builder(
          itemCount: tic.medicineInventorySearchList.length,
          itemBuilder: (context, index) {
            return MultiSelectItem(
                isSelecting: controller.isSelecting,
                onSelected: () {},
                child: InkWell(
                    onTap: () {
                      setState(() {
                        controller.toggle(index);
                      });
                      if (controller.isSelected(index)) {
                        tic.listPrescriptionDetailsUpdate.add(
                            TreatmentInfoDetail(
                                medicineInInventoryDetailId: tic
                                    .medicineInventorySearchList[index].id,
                                medicineId: tic
                                    .medicineInventorySearchList[index]
                                    .medicineId,
                                groupByCheck: tic
                                        .medicineInventorySearchList[index]
                                        .groupByCheck ??
                                    false,
                                groupByChoiceMedicine:
                                    tic.medicineInventorySearchList[index]
                                                .groupByChoiceMedicine ==
                                            null
                                        ? null
                                        : tic.medicineInventorySearchList[index]
                                            .groupByChoiceMedicine,
                                medicineName:
                                    tic.medicineInventorySearchList[index].name,
                                unitName: tic.medicineInventorySearchList[index]
                                    .unitName,
                                quantity: textController[index].text.isNotEmpty
                                    ? int.parse(textController[index].text)
                                    : 0));
                      } else {
                        tic.listPrescriptionDetailsUpdate.removeWhere((e) =>
                            e.medicineInInventoryDetailId ==
                            tic.medicineInventorySearchList[index].id);
                        tic.getTotalMedicineSelected();
                      }
                      for (var item in tic.listPrescriptionDetailsUpdate) {
                        print(index.toString() +
                            "|" +
                            item.medicineInInventoryDetailId +
                            "|" +
                            item.quantity.toString());
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(5),
                          horizontal: getProportionateScreenWidth(20)),
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(2),
                          horizontal: getProportionateScreenWidth(5)),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: new BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 0.5, color: grey),
                              ),
                              child: Opacity(
                                opacity: controller.isSelected(index) ? 1 : 0,
                                child: Icon(
                                  LineIcons.check,
                                  color: KPrimaryColor,
                                  size: 25,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth * 0.65,
                                  child: BoxInput(
                                    align: false,
                                    title: "Dược phẩm:",
                                    child: Flexible(
                                      child: Text(
                                        tic.medicineInventorySearchList[index]
                                            .name,
                                        style: AppTheme.titleName,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                ),
                                BoxInput(
                                  align: false,
                                  title: "Ngày hết hạn:",
                                  child: Text(
                                      GeneralHelper.formatDateText(
                                          tic.medicineInventorySearchList[index]
                                              .expirationDate,
                                          true),
                                      style: AppTheme.titleDetail),
                                ),
                                BoxInput(
                                  align: false,
                                  title: "Số lượng:",
                                  child: Row(
                                    children: [
                                      RoundedInputField(
                                        applyBoxShadow: false,
                                        borderColor: textController[index]
                                                .text
                                                .isNotEmpty
                                            ? tic
                                                        .medicineInventorySearchList[
                                                            index]
                                                        .quantity <
                                                    int.parse(
                                                        textController[index]
                                                            .text)
                                                ? error
                                                : grey
                                            : grey,
                                        sizeWidth:
                                            getProportionateScreenWidth(60),
                                        sizeHeight:
                                            getProportionateScreenHeight(35),
                                        onChanged: (value) {
                                          if (controller.isSelected(index) &&
                                              textController[index]
                                                  .text
                                                  .isNotEmpty) {
                                            tic.listPrescriptionDetailsUpdate
                                                .where((e) =>
                                                    e.medicineInInventoryDetailId ==
                                                    tic
                                                        .medicineInventorySearchList[
                                                            index]
                                                        .id)
                                                .first
                                                .quantity = int.parse(textController[
                                                    index]
                                                .text);
                                            tic.getTotalMedicineSelected();
                                          }
                                        },
                                        controller: textController[index],
                                        textInputFormat: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]+')),
                                          NumericalRangeFormatter(
                                              max: tic
                                                  .medicineInventorySearchList[
                                                      index]
                                                  .quantity)
                                        ],
                                        isNumber: true,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: getProportionateScreenHeight(
                                                5)),
                                        child: Text(
                                          "/${tic.medicineInventorySearchList[index].quantity} " +
                                              "${tic.medicineInventorySearchList[index].unitName}",
                                          style: AppTheme.normalText,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      decoration: new BoxDecoration(
                        color: white,
                        border: Border(
                          bottom: BorderSide(color: grey, width: 0.5),
                        ),
                        // color: Theme.of(context).bottomAppBarColor,
                      ),
                    )));
          },
        ),
        bottomNavigationBar: RoundedButton(
          text: "Cập nhật",
          press: () async {
            await tic.updatePrescription();
          },
        ));
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final int max;
  NumericalRangeFormatter({this.max});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return newValue;
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > max
        ? TextEditingValue().copyWith(text: max.toString())
        : newValue;
  }
}
