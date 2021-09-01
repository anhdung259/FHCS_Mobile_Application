import 'package:badges/badges.dart';
import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/controller/login/login_controller.dart';
import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/controller/notification/notificationController.dart';
import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/screens/home/list_recently/list_import_batches_recently.dart';
import 'package:fhcs_mobile_application/screens/home/list_recently/list_import_medicine_recently.dart';
import 'package:fhcs_mobile_application/screens/home/list_recently/list_medicine_inventory_recently.dart';
import 'package:fhcs_mobile_application/screens/home/list_recently/list_medicine_recently.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_appbar.dart';
import 'icon_manager_button.dart';
import '../list_recently/list_treatment_recently.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TreatmentInfoController tic = Get.find();
  final BatchesMedicineController bmc = Get.find();
  final MedicineInventoryController mic = Get.find();
  final MedicineController mc = Get.find();
  final SettingController sc = Get.find();
  final LoginController lc = Get.find();
  @override
  void initState() {
    super.initState();
  }

  Widget listRecentlyDisplay(int index) {
    switch (index) {
      case 0:
        return ListTreatmentInfoRecently();
        break;
      case 1:
        return ListMedicineRecently();
        break;
      case 2:
        return ListImportBatchesRecently();
        break;
      case 3:
        return ListImportMedicineRecently();
        break;
      case 4:
        return ListMedicineInventoryRecently();
        break;
      default:
        return ListTreatmentInfoRecently();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Stack(children: [
        Appbar(),
        OptionManager(),
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.21,
              horizontal: SizeConfig.screenWidth * 0.07,
            ),
            child: Obx(() => Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(20)),
                  child: listRecentlyDisplay(sc.valueSettingMain.value),
                ))),
      ]),
    );
  }
}

class OptionManager extends StatelessWidget {
  final BatchesMedicineController bmc = Get.find();
  OptionManager({
    Key key,
  }) : super(key: key);
  final TreatmentInfoController tic = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconManagerButton(
            imgUrl: MEDICINE_RECORD,
            text: "Đơn Cấp Phát",
            press: () {
              Get.toNamed("/treatmentInfoManage");
            },
          ),
          IconManagerButton(
            imgUrl: MEDICINE_MANAGER,
            text: "Dược Phẩm",
            press: () {
              Get.toNamed("/medicineManage");
            },
          ),
          IconManagerButton(
            imgUrl: BATCH_MEDICINE_MANAGER,
            text: "Lô Dược Phẩm",
            press: () {
              bmc.currentIndex.value = 0;
              Get.toNamed("/batchesMedicineManage");
            },
          ),
        ],
      ),
    );
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController nc = Get.find();
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: new CustomAppBar(
        height: SizeConfig.screenHeight * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(26),
                    horizontal: getProportionateScreenHeight(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: getProportionateScreenWidth(32),
                            height: getProportionateScreenHeight(32),
                            decoration: new BoxDecoration(
                                border: Border.all(color: white, width: 0.3),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(LOGOCRICLE)))),
                        SizedBox(
                          width: getProportionateScreenWidth(5),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("FHCS", style: AppTheme.nameApp),
                            // Text("CLINIC SUPPORT", style: AppTheme.nameApp),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        nc.currentIndex.value = 4;
                        nc.fetchNotifiList();
                        // Get.toNamed("/notificationShow");
                      },
                      child: Obx(() => Badge(
                            badgeContent: Text(
                              nc.numNotificationNotSeen.value > 10
                                  ? "9+"
                                  : nc.numNotificationNotSeen.value.toString(),
                              style: TextStyle(color: white, fontSize: 9),
                            ),
                            position: BadgePosition.topEnd(top: 0, end: -3),
                            elevation: 0,
                            shape: BadgeShape.circle,
                            badgeColor: Colors.red,
                            animationType: BadgeAnimationType.slide,
                            showBadge: nc.numNotificationNotSeen.value == 0
                                ? false
                                : true,
                            child: Icon(
                              Icons.notifications,
                              color: white,
                              size: getProportionateScreenHeight(30),
                            ),
                          )),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
