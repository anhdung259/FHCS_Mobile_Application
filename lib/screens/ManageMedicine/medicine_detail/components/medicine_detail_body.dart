import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/screens/ManageMedicine/medicine_detail/components/medicine_export_import_inventory_list.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line_detail.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineDetailBody extends StatefulWidget {
  @override
  _MedicineDetailBodyState createState() => _MedicineDetailBodyState();
}

class _MedicineDetailBodyState extends State<MedicineDetailBody> {
  final MedicineController mc = Get.find();
  @override
  void initState() {
    if (mc.createNew == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GeneralHelper.showMessage(
            msg: "Thêm dược phẩm thành công",
            press: () => mc.createNew = false);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.03,
          horizontal: SizeConfig.screenWidth * 0.08,
        ),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              DisplayDetails(
                title: NAME_MEDICINE,
                info: mc.medicineDetail.value.name ?? NOINFO,
              ),
              DisplayDetails(
                title: DESCRIPTION_MEDICINE,
                info: mc.medicineDetail.value.description == "" ||
                        mc.medicineDetail.value.description == null
                    ? NOINFO
                    : mc.medicineDetail.value.description,
              ),
              DisplayDetails(
                title: DISEASESTATUSMEDICINE,
                info: mc.listDiagnosticDisplay,
              ),
              DisplayDetails(
                title: CONTRAINDICATION,
                info: mc.listContraindicationDisplay,
              ),
              DisplayDetails(
                title: UNIT_MEDICINE,
                info: mc.medicineDetail.value.nameUnit ?? NOINFO,
              ),
              DisplayDetails(
                title: CLASSIFICATION_MEDICINE,
                info: mc.medicineDetail.value.nameClassification ?? NOINFO,
              ),
              DisplayDetails(
                title: SUBGROUP_MEDICINE,
                info: mc.medicineDetail.value.nameSubgroup ?? NOINFO,
              ),
              DisplayDetails(
                title: DATA_CREATE,
                info: GeneralHelper.formatDateText(
                    mc.medicineDetail.value.createDate, true),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              TitleList(
                title: "Xuất nhập tồn kỳ ${mc.month}/${mc.year}",
              ),
              ListExportImportInventoryMedicince()
            ],
          ),
        ),
      ),
    );
  }
}
