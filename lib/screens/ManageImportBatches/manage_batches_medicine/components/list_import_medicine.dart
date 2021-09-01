// import 'package:fhcs_mobile_application/screens/ManagerMedicine/controller/medicine_controller.dart';
import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/controller/batches/importMedicineController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/filter_button.dart';
import 'package:fhcs_mobile_application/widgets/Card/batches_medicine_record.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListImportMedicine extends StatefulWidget {
  @override
  _ListImportMedicineState createState() => _ListImportMedicineState();
}

class _ListImportMedicineState extends State<ListImportMedicine> {
  final BatchesMedicineController bmc = Get.find();
  final ImportMedicineController imc = Get.find();
  @override
  void initState() {
    super.initState();
    imc.resetTextFilter();
    imc.fetchImportMedicine();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> onEdit(String id) async {
    bmc.importMedicineId = id;
    bmc.inBatches = false;
    bmc.getDetailImportMedicine();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    imc.refreshList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (imc.isMoreImportMedicineAvailable.isTrue) {
      imc.paginateImportMedicine();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
      child: Column(
        children: [
          Row(
            children: [
              RoundedInputField(
                sizeWidth: getProportionateScreenWidth(240),
                controller: imc.textSearchController,
                hintText: SEARCHFIELD,
                icon: Icon(LineIcons.search),
                // textInputAction: TextInputAction.search,
                onChanged: (value) => imc.fetchImportMedicine(),
                onSearch: true,
                press: () {
                  imc.textSearchController.clear();
                  imc.fetchImportMedicine();
                },
              ),
              FilterButton(
                onPress: imc.showDialogFilter,
              ),
            ],
          ),
          TitleList(
            title: "Danh sách dược phẩm nhập",
            showMore: false,
            // press: () {
            //   imc.showDialogFilter();
            // },
          ),
          Container(
            height: SizeConfig.screenHeight * 0.64,
            child: Obx(() {
              if (imc.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else if (!imc.isFound.value) {
                return ListEmpty(
                  text: NOTFOUND,
                );
              } else if (imc.listImportMedicine.length == 0) {
                return ListEmpty();
              }
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: imc.isMoreImportMedicineAvailable.value,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                    itemCount: imc.listImportMedicine.length,
                    itemBuilder: (context, index) {
                      return BatchesMedicineRecordCard(
                          medicineName: imc.listImportMedicine[index].name,
                          price: GeneralHelper.formatCurrencyText(
                              imc.listImportMedicine[index].price.toString()),
                          quantity:
                              imc.listImportMedicine[index].quantity.toString(),
                          unit: imc.listImportMedicine[index].medicineUnit.name,
                          status: imc.listImportMedicine[index]
                              .importMedicineStatus.statusImportMedicine,
                          statusId: imc.listImportMedicine[index]
                              .importMedicineStatus.id,
                          dateExpiration: GeneralHelper.formatDateText(
                              imc.listImportMedicine[index].expirationDate,
                              true),
                          press: () {
                            onEdit(imc.listImportMedicine[index].id);
                          });
                    }),
              );
            }),
          ),
        ],
      ),
    );
  }
}
