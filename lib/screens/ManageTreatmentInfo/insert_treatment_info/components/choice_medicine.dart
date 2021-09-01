import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/medicine_inventory_result_search/medicine_inventory_result_search.dart';
import 'package:fhcs_mobile_application/data/model/treatment_information_details/treatment_information_details.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/filter_button.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChoiceMedicinePrescription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoiceMedicinePrescription();
}

class _ChoiceMedicinePrescription extends State<ChoiceMedicinePrescription> {
  final TreatmentInfoController tic = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //block app from quitting when selecting
        // tic.listMedicineInventorySelected.clear();
        tic.listMedicineInventorySelected.removeWhere((e) => e.quantity == 0);

        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Bảng chọn thuốc"),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedInputField(
                      sizeWidth: getProportionateScreenWidth(257),
                      controller: tic.textSearchMedicineController,
                      hintText: SEARCHFIELD,
                      onSearch: true,
                      icon: Icon(LineIcons.search),
                      //textInputAction: TextInputAction.search,
                      onChanged: (value) => tic.fetchMedicineChoice(),
                      press: () {
                        tic.textSearchMedicineController.clear();
                        tic.fetchMedicineChoice();
                      },
                    ),
                    FilterButton(
                      onPress: tic.showDialogFilterChoiceMedicine,
                    ),
                  ],
                ),
              ),
              Expanded(child: ListMedicineChoice()),
              Container(
                height: tic.pagingloading.isTrue ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: RoundedButton(
            text: "Chọn",
            press: () {
              tic.addToPrescription();
            },
          )),
    );
  }
}

class ListMedicineChoice extends StatefulWidget {
  @override
  _ListMedicineChoiceState createState() => _ListMedicineChoiceState();
}

class _ListMedicineChoiceState extends State<ListMedicineChoice> {
  final TreatmentInfoController tic = Get.find();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    if (tic.isMoreTreatmentInfoAvailable.isTrue) {
      tic.paginateMedicineChoiceList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!tic.isFound.value) {
        return ListEmpty(
          text: NOTFOUND,
        );
      }
      if (tic.listPaginationMedicineChoice.length == 0) {
        return ListEmpty();
      }
      return SmartRefresher(
        enablePullDown: false,
        enablePullUp: tic.isMoreDataMedicineAvailable.value,
        controller: _refreshController,
        onLoading: _onLoading,
        child: ListView.builder(
            cacheExtent: 99999,
            shrinkWrap: true,
            itemCount: tic.listPaginationMedicineChoice.length,
            itemBuilder: (BuildContext context, int index) {
              return new MedicineInventoryExpansionTile(
                  tic.listPaginationMedicineChoice[index]);
            }),
      );
    });
  }
}

class MedicineInventoryExpansionTile extends StatefulWidget {
  final MedicineInventoryResultSearch medicineInventory;
  MedicineInventoryExpansionTile(this.medicineInventory);
  @override
  State createState() => new MedicineInventoryExpansionTileState();
}

class MedicineInventoryExpansionTileState
    extends State<MedicineInventoryExpansionTile> {
  PageStorageKey _key;
  final TreatmentInfoController tic = Get.find();
  bool open = false;
  var listMedicineInventoryDetail = <MedicineInventoryResultSearch>[].obs;
  List<TextEditingController> textController = [];
  MultiSelectController controller = new MultiSelectController();
  @override
  void initState() {
    for (var itemSelected in tic.listPrescription) {
      if (itemSelected.medicineId == widget.medicineInventory.medicineId) {
        open = true;
        listMedicineInventoryDetail.addAll(tic.listUpdate
            .where((e) => e.medicineId == widget.medicineInventory.medicineId));
        tic.listMedicineInventorySelected.removeWhere((e) =>
            listMedicineInventoryDetail
                .every((a) => a.id != e.medicineInInventoryDetailId) &&
            e.medicineId == widget.medicineInventory.medicineId);
        listMedicineInventoryDetail.asMap().forEach((i, value) {
          if (listMedicineInventoryDetail[i].groupByCheck == true) {
            for (var item in tic.listMedicineInventorySelected) {
              if (item.medicineInInventoryDetailId ==
                  listMedicineInventoryDetail[i].id) {
                item.quantity = tic.getGroupedTreatmentDetailsQuantity(
                    listMedicineInventoryDetail[i].groupByChoiceMedicine);
                item.groupByCheck = listMedicineInventoryDetail[i].groupByCheck;
                item.groupByChoiceMedicine = tic.createNewGroupMedicine(
                    listMedicineInventoryDetail[i].groupByChoiceMedicine);
              }
            }
          } else {
            for (var item in tic.listMedicineInventorySelected) {
              if (item.medicineInInventoryDetailId ==
                  listMedicineInventoryDetail[i].id) {
                item.quantity = item.quantity;
              }
            }
          }
        });
        textController.addAll(List.generate(
            listMedicineInventoryDetail.length,
            (i) => TextEditingController(
                text: tic.listPrescriptionDetails.firstWhere(
                            (e) =>
                                e.medicineInInventoryDetailId ==
                                listMedicineInventoryDetail[i].id,
                            orElse: () => null) !=
                        null
                    ? listMedicineInventoryDetail[i].groupByCheck == true
                        ? tic
                            .getGroupedTreatmentDetailsQuantity(
                                listMedicineInventoryDetail[i]
                                    .groupByChoiceMedicine)
                            .toString()
                        : tic.listPrescriptionDetails
                            .firstWhere((e) =>
                                e.medicineInInventoryDetailId ==
                                listMedicineInventoryDetail[i].id)
                            .quantity
                            .toString()
                    : "")));
        listMedicineInventoryDetail.asMap().forEach((index, element) {
          if (tic.listPrescriptionDetails
                  .where((e) =>
                      e.medicineInInventoryDetailId ==
                      listMedicineInventoryDetail[index].id)
                  .toList()
                  .length >
              0) {
            print("check");
            controller.select(index);
          }
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
            horizontal: getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
            horizontal: getProportionateScreenWidth(5)),
        decoration: new BoxDecoration(
          color: white,
          boxShadow: <BoxShadow>[
            BoxShadow(color: grey, offset: Offset(0.0, 0.5))
          ],
        ),
        child: new ExpansionTile(
          iconColor: KPrimaryColor,
          initiallyExpanded: open,
          key: _key,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.medicineInventory.name,
                style: AppTheme.titleDetail,
              ),
              Text(
                "Số lượng:" + widget.medicineInventory.quantity.toString(),
                style: AppTheme.message,
              ),
            ],
          ),
          onExpansionChanged: (isExpanding) {
            if (isExpanding == true) {
              tic
                  .fetchMedicineInventoryDetail(
                      widget.medicineInventory.medicineId)
                  .then((value) {
                listMedicineInventoryDetail.value = value;
                print(listMedicineInventoryDetail.length);
                textController.addAll(List.generate(
                    listMedicineInventoryDetail.length,
                    (i) => TextEditingController()));
              });
            }
          },
          children: <Widget>[
            Obx(() {
              if (listMedicineInventoryDetail != null) {
                return LimitedBox(
                    maxHeight:
                        listMedicineInventoryDetail.length * 200.toDouble(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listMedicineInventoryDetail.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MultiSelectItem(
                            isSelecting: controller.isSelecting,
                            onSelected: () {},
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  controller.toggle(index);
                                });
                                if (controller.isSelected(index)) {
                                  tic.listMedicineInventorySelected.add(
                                    TreatmentInfoDetail(
                                        medicineInInventoryDetailId:
                                            listMedicineInventoryDetail[index]
                                                .id,
                                        medicineId:
                                            listMedicineInventoryDetail[index]
                                                .medicineId,
                                        groupByCheck:
                                            listMedicineInventoryDetail[index]
                                                    .groupByCheck ??
                                                false,
                                        groupByChoiceMedicine:
                                            listMedicineInventoryDetail[index]
                                                        .groupByChoiceMedicine ==
                                                    null
                                                ? null
                                                : listMedicineInventoryDetail[index]
                                                    .groupByChoiceMedicine,
                                        medicineName:
                                            listMedicineInventoryDetail[index]
                                                .name,
                                        unitName:
                                            listMedicineInventoryDetail[index]
                                                .unitName,
                                        quantity: textController[index]
                                                .text
                                                .isNotEmpty
                                            ? int.parse(textController[index].text)
                                            : 0),
                                  );
                                } else {
                                  tic.listMedicineInventorySelected.removeWhere(
                                      (e) =>
                                          e.medicineInInventoryDetailId ==
                                          listMedicineInventoryDetail[index]
                                              .id);
                                }
                                for (var item
                                    in tic.listMedicineInventorySelected) {
                                  print(item.medicineInInventoryDetailId +
                                      "|" +
                                      item.quantity.toString() +
                                      "|" +
                                      item.groupByCheck.toString());
                                }
                              },
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: white,
                                  border: Border(
                                    bottom: BorderSide(color: grey, width: 0.5),
                                  ),
                                  // color: Theme.of(context).bottomAppBarColor,
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(5),
                                    horizontal: getProportionateScreenWidth(5)),
                                padding: EdgeInsets.only(
                                    bottom: getProportionateScreenWidth(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: new BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(width: 0.5, color: grey),
                                      ),
                                      child: Opacity(
                                        opacity: controller.isSelected(index)
                                            ? 1
                                            : 0,
                                        child: Icon(
                                          LineIcons.check,
                                          color: KPrimaryColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: SizeConfig.screenWidth * 0.65,
                                          child: BoxInput(
                                            align: false,
                                            child: Flexible(
                                              child: Text(
                                                listMedicineInventoryDetail[
                                                        index]
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
                                                  listMedicineInventoryDetail[
                                                          index]
                                                      .expirationDate,
                                                  true),
                                              style: AppTheme.titleDetail),
                                        ),
                                        BoxInput(
                                          align: false,
                                          title: "Đơn giá:",
                                          child: Text(
                                              GeneralHelper.formatCurrencyText(
                                                  listMedicineInventoryDetail[
                                                          index]
                                                      .price
                                                      .toString()),
                                              style: AppTheme.titleDetail),
                                        ),
                                        BoxInput(
                                          align: false,
                                          title: "Số lượng:",
                                          child: Row(
                                            children: [
                                              RoundedInputField(
                                                borderColor: textController[
                                                            index]
                                                        .text
                                                        .isNotEmpty
                                                    ? listMedicineInventoryDetail[
                                                                    index]
                                                                .quantity <
                                                            int.parse(
                                                                textController[
                                                                        index]
                                                                    .text)
                                                        ? error
                                                        : grey
                                                    : grey,
                                                applyBoxShadow: false,
                                                sizeWidth:
                                                    getProportionateScreenWidth(
                                                        60),
                                                sizeHeight:
                                                    getProportionateScreenHeight(
                                                        35),
                                                onChanged: (value) {
                                                  if (controller
                                                          .isSelected(index) &&
                                                      textController[index]
                                                          .text
                                                          .isNotEmpty) {
                                                    tic.listMedicineInventorySelected
                                                            .where((e) =>
                                                                e.medicineInInventoryDetailId ==
                                                                listMedicineInventoryDetail[
                                                                        index]
                                                                    .id)
                                                            .first
                                                            .quantity =
                                                        int.parse(
                                                            textController[
                                                                    index]
                                                                .text);

                                                    // tic.getTotalMedicineSelected();
                                                    for (var item in tic
                                                        .listMedicineInventorySelected) {
                                                      print(index.toString() +
                                                          "|" +
                                                          item
                                                              .medicineInInventoryDetailId +
                                                          "|" +
                                                          item.quantity
                                                              .toString());
                                                    }
                                                  }
                                                },
                                                controller:
                                                    textController[index],
                                                textInputFormat: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp('[0-9]+')),
                                                  NumericalRangeFormatter(
                                                      max:
                                                          listMedicineInventoryDetail[
                                                                  index]
                                                              .quantity)
                                                ],
                                                isNumber: true,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top:
                                                        getProportionateScreenHeight(
                                                            5)),
                                                child: Text(
                                                  " /${listMedicineInventoryDetail[index].quantity} " +
                                                      "${listMedicineInventoryDetail[index].unitName}",
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
                            ),
                          );
                        }));
              } else {
                return ListEmpty();
              }
            })
          ],
        ),
      ),
    );
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
