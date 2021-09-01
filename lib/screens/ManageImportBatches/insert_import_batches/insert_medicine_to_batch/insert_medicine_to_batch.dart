import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'components/insert_medicine_to_batch_body.dart';

class InsertBatchRecordMedicine extends StatelessWidget {
  const InsertBatchRecordMedicine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Nhập dược phẩm",
      body: InsertBatchRecordMedicineBody(),
    );
  }
}
