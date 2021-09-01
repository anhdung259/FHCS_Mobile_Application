import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_details.dart';
import 'package:flutter/material.dart';

import 'components/history_patient_detail_body.dart';

class PatientDetail extends StatelessWidget {
  const PatientDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDetails(
      title: "Lịch sử cấp phát",
      showDelete: false,
      showEdit: false,
      body: PatientDetailBody(),
    );
  }
}
