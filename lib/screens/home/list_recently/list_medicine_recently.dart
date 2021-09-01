import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/medicine_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMedicineRecently extends StatefulWidget {
  const ListMedicineRecently({
    Key key,
    this.cardList,
  }) : super(key: key);
  final Widget cardList;

  @override
  _ListMedicineRecentlyState createState() => _ListMedicineRecentlyState();
}

class _ListMedicineRecentlyState extends State<ListMedicineRecently> {
  final MedicineController mc = Get.find();
  @override
  void initState() {
    mc.fetchMedicineRecently();
    super.initState();
  }

  Future<void> onEdit(String id) async {
    mc.medicineId = id;
    mc.getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.7,
        child: Obx(() {
          if (mc.isLoadingRecent.value)
            return Center(child: CircularProgressIndicator());
          if (mc.listRecently.length == 0) {
            return ListEmpty();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleList(
                title: "Danh sách dược phẩm",
                showMore: true,
                optionText: true,
                press: () {
                  Get.toNamed("/medicineManage");
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: mc.listRecently.length,
                    itemBuilder: (context, index) {
                      return MedicineCard(
                        medicine: mc.listRecently[index],
                        press: () {
                          onEdit(mc.listRecently[index].id);
                        },
                      );
                    }),
              ),
            ],
          );
        }));
  }
}
