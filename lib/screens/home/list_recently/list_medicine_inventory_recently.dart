import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/medicine_inventory_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMedicineInventoryRecently extends StatefulWidget {
  @override
  _ListMedicineInventoryRecentlyState createState() =>
      _ListMedicineInventoryRecentlyState();
}

class _ListMedicineInventoryRecentlyState
    extends State<ListMedicineInventoryRecently> {
  final MedicineInventoryController mic = Get.find();
  @override
  void initState() {
    mic.fetchMedicineInventoryRecently();
    super.initState();
  }

  Future<void> onEdit(String id) async {
    mic.medicineInventoryDetailId = id;
    mic.getDetailMeicineInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.7,
        child: Obx(() {
          if (mic.isLoadingRecent.value)
            return Center(child: CircularProgressIndicator());
          if (mic.listRecently.length == 0) {
            return ListEmpty();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleList(
                title: "Danh sách dược phẩm tồn",
                showMore: true,
                optionText: true,
                press: () {
                  Get.toNamed("/batchesMedicineManage", arguments: 1);
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: mic.listRecently.length,
                    itemBuilder: (context, index) {
                      return MedicineInventoryCard(
                          medicineInventorySearch: mic.listRecently[index],
                          press: () {
                            onEdit(mic.listRecently[index].id);
                            // Get.toNamed("/importBatchMedicineDetail");
                          });
                    }),
              ),
            ],
          );
        }));
  }
}
