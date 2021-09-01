import 'package:fhcs_mobile_application/data/model/patient/patient.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';

import 'info_line.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({Key key, this.press, this.patient}) : super(key: key);

  final Function press;
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        press();
      },
      child: BackGroundCard(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DisplayInfo(
                  widthSize: SizeConfig.screenWidth * 0.55,
                  title: NAMEPATIENT,
                  info: patient.name,
                  textStyle: AppTheme.titleName,
                ),
                Row(
                  children: [
                    DisplayInfo(
                      widthSize: getProportionateScreenWidth(150),
                      title: CODEPATIENT,
                      info: patient.internalCode,
                    ),
                    DisplayInfo(
                      widthSize: getProportionateScreenWidth(150),
                      title: DEPARTMENT,
                      info: patient.department.name,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
