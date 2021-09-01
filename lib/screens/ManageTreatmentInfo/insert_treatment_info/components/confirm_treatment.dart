import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:signature/signature.dart';

// void main() => runApp(MyApp());

/// example widget showing how to use signature widget
class ConfirmTreatment extends StatefulWidget {
  @override
  _ConfirmTreatmentState createState() => _ConfirmTreatmentState();
}

class _ConfirmTreatmentState extends State<ConfirmTreatment> {
  final TreatmentInfoController tic = Get.find();
  SignatureController _controller = SignatureController();

  @override
  void initState() {
    super.initState();
    _controller = tic.signatureController;
    _controller.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundComponent(
      child: Container(
        height: SizeConfig.screenHeight * 0.64,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(5),
                    horizontal: getProportionateScreenWidth(10)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Bảng ký", style: AppTheme.titleTable),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      setState(() => _controller.clear());
                    },
                    child: Icon(
                      LineIcons.eraser,
                      size: 35,
                    ),
                  ),
                ])),
            Divider(
              thickness: 1,
            ),
            Signature(
              controller: _controller,
              height: SizeConfig.screenHeight * 0.57,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
    //SIGNATURE CANVAS
  }
}
