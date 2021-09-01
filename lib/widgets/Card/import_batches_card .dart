import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';

class ImportBatchesCard extends StatelessWidget {
  const ImportBatchesCard(
      {Key key,
      this.press,
      this.textStyle,
      this.insertDate,
      this.numberOfMedicine,
      this.totalPrice,
      this.periodicMonth,
      this.periodicYear})
      : super(key: key);
  final String insertDate;
  final Function press;
  final String numberOfMedicine;
  final String totalPrice;
  final String periodicMonth;
  final String periodicYear;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        press();
      },
      child: BackGroundCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(1),
              horizontal: getProportionateScreenWidth(5)),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Image.network(
                BATCH_MEDICINE_MANAGER,
                height: getProportionateScreenHeight(35),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayInfo(
                    title: "Ngày: ",
                    info: insertDate,
                    textStyle: AppTheme.titleName,
                  ),
                  Row(
                    children: [
                      DisplayInfo(
                        title: "Kỳ nhập(tháng/năm): ",
                        info: periodicMonth + "/" + periodicYear,
                      ),
                    ],
                  ),
                  DisplayInfo(title: "Số dược phẩm: ", info: numberOfMedicine),
                  DisplayInfo(title: "Tổng giá: ", info: totalPrice)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
